import Foundation

// This is a simple, observable object that will manage our purchase state.
// In a real app, this would be a much more complex class using StoreKit.
class StoreManager: ObservableObject {
    // We can change this value to 'true' to test the pro user flow.
    @Published var isProUser: Bool = false
}
