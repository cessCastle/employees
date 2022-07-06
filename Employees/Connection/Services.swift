//
//  Services.swift
//  Employees
//
//  Created by Cesar Castillo on 05/07/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

enum LoginError: String, Error {
    case unableToLogin = "No fue posible realizar el inicio de sesión. Verifique que sus datos sean correctos."
    case unableToLogOut = "No fue posible realizar el cierre de sesión. Verifique que sus datos sean correctos."
}

enum GetAllEmployeesError: String, Error {
    case unableToGetAllEmployees = "No fue posible traer todos los empleados, intente más tarde"
    
}
enum GetDetailEmployeeError: String, Error {
    case unableToGetEmployeeDetail = "No fue posible traer el detalle del empleado"
}

enum RegistryError: String, Error {
    case unableToSavePicture = "No fue posible guardar la imagen del usuario. Verifique su conexión a internet o inténtelo más tarde."
    case invalidURL = "No fue posible obtener la dirección de su imagen de perfil. Verifique su conexión a internet o inténtelo más tarde."
    case unableToUpdateUser = "No fue posible actualizar los datos del usuario. Verifique la información de su perfil o inténtelo más tarde."
   
}

 var endPoint: EndPoints?
 enum EndPoints: String {
    case allEmployees = "employees"
    case employeeDetail = "employee/"
  
}

enum Collections: String {

    case users
    case profilePicture
    
}

class Services {
    
    static let shared = Services()
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    private init() {}
    
    var url: String{
        let url = Constants.shared.baseUrl + endPoint!.rawValue
        return url
    }
}

extension Services {
    
    typealias logOutHandler = (Result<Void, LoginError>) -> Void
    typealias loginHandler = (Result<AuthDataResult, LoginError>) -> Void
    typealias getAllEmployeesHandler = (Result<EmployeesResponse, GetAllEmployeesError>) -> Void
    typealias getEmployeeDetailHandler = (Result<EmployeesResponseById, GetDetailEmployeeError>) -> Void
    typealias registryHandler = (Result<String, RegistryError>) -> Void
}

extension Services {
    
    func loginFirebase(email: String, password: String, completed: @escaping loginHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, _ in
            guard let authResult = authResult else {
                completed(.failure(.unableToLogin))
                return
            }
            UserDefaults.standard.set(authResult.user.uid, forKey: "userId")
            UserDefaults.standard.set(authResult.user.displayName, forKey: "userName")
            UserDefaults.standard.set(authResult.user.photoURL?.absoluteString, forKey: "profileImageUrl")
            completed(.success(authResult))
        }
    }
    
    func logOutUserFirebase(completed: @escaping logOutHandler) {
        let firebaseAuth = Auth.auth()
          do {
            try firebaseAuth.signOut()
            completed(.success(()))
          } catch let signOutError as NSError {
            completed(.failure(.unableToLogOut))
            print ("Error signing out: %@", signOutError)
          }
          
    }

    func uploadImage(photo: UIImage,completed: @escaping registryHandler) {
        let imageName: String = "\(authUser!.uid).png"
        let collection = Collections.profilePicture.rawValue
        let storageRef = Storage.storage().reference().child("\(authUser!.uid)").child(collection).child(imageName)

        if let uploadData = photo.jpegData(compressionQuality: 0.5) {
            storageRef.putData(uploadData, metadata: nil) { metadata, _ in
                guard let _ = metadata else {
                    completed(.failure(.unableToSavePicture))
                    return
                }

                storageRef.downloadURL { url, _ in
                    guard let url = url else {
                        completed(.failure(.invalidURL))
                        return
                    }

                    self.updateUserFirebaseImage(url: url.absoluteString, completed: completed)
                }
            }
        }
    }
    
    
    func updateUserFirebaseImage(url : String,completed: @escaping registryHandler) {
        let changeRequest = authUser!.createProfileChangeRequest()
        changeRequest.photoURL = URL(string: url)
        changeRequest.commitChanges { error in
            if let _ = error {
                completed(.failure(.unableToUpdateUser))
            } else {
                UserDefaults.standard.set(url, forKey: "profileImageUrl")
                completed(.success(url))
            }
        }
    }
    
    
    func getAllEmployees(completed: @escaping getAllEmployeesHandler) {
        
        endPoint = .allEmployees
        let url = URL(string: self.url)!

           let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
             if let error = error {
               print("Error with fetching employees: \(error)")
               return
             }
             
             guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                 print("Error with the response, unexpected status code: \(String(describing: response))")
                 completed(.failure(.unableToGetAllEmployees))
               return
             }

               if let data = data,
               let employees = try? JSONDecoder().decode(EmployeesResponse.self, from: data) {
                 completed(.success(employees))
             }
           })
           task.resume()
        
    }
    
    
    func getEmployeeDetail(employeeId: Int,completed: @escaping getEmployeeDetailHandler) {

        endPoint = .employeeDetail
        let url = URL(string: self.url + "\(employeeId)")!
        print(url)

           let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
             if let error = error {
               print("Error with fetching movies: \(error)")
               return
             }

             guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                 print("Error with the response, unexpected status code: \(String(describing: response))")
                 completed(.failure(.unableToGetEmployeeDetail))
               return
             }

               if let data = data,
               let employeeDetail = try? JSONDecoder().decode(EmployeesResponseById.self, from: data) {
                 completed(.success(employeeDetail))
             }
           })
           task.resume()

    }
    
}
