import Foundation
import FirebaseCore
import FirebaseStorage

@MainActor
class FirebaseService {
    static let shared = FirebaseService()
    private let storage = Storage.storage()
    
    private init() {
        print("🔥 Initializing FirebaseService")
        print("📦 Storage instance initialized")
    }
    
    /// Upload audio file to Firebase Storage and return the download URL
    func uploadAudio(
        audioURL: URL,
        userId: String,
        dreamId: String
    ) async throws -> URL {
        print("\n📤 ==================== UPLOAD PROCESS ====================")
        print("📤 Starting audio upload for dream: \(dreamId)")
        print("📤 Audio URL: \(audioURL)")
        
        // Upload audio file to Firebase Storage
        let audioRef = storage.reference().child("users/\(userId)/audio/\(dreamId).m4a")
        print("📤 Uploading audio to: \(audioRef.fullPath)")
        
        _ = try await audioRef.putFile(from: audioURL)
        let audioDownloadURL = try await audioRef.downloadURL()
        print("✅ Audio uploaded successfully")
        print("📤 ==================== END UPLOAD ====================\n")
        
        return audioDownloadURL
    }
} 
