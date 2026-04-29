import Foundation
import LocalAuthentication

final class BiometricAuthManager {
    
    static let shared = BiometricAuthManager()
    
    func authenticate(completion: @escaping (Bool) -> Void) {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Access your favorites securely"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
            
        } else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
