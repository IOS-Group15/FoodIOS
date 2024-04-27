import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var payee = ""
    @State private var selectedCategory = "Subscription" // Default value
    @State private var description = ""
    @State private var amount = ""
    @State private var receiptImage: UIImage?
    @State private var showImagePicker = false
    
    var onSave: (Transaction) -> Void
    
    var body: some View {
        VStack {
            Text("Add a Transaction")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Transaction Details")
                .font(.title2)
                .padding(.top)
            
            TextField("Payee", text: $payee)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Category", selection: $selectedCategory) {
                Text("Subscription").tag("Subscription")
                Text("Grocery").tag("Grocery")
                Text("Entertainment").tag("Entertainment")
                // Add more categories as needed
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("---------- OR ----------")
                .padding()
            
            Button(action: {
                showImagePicker = true
            }) {
                Text("Upload your receipt here")
                    .foregroundColor(.blue)
                    .padding()
            }
            
            if let image = receiptImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .padding()
            }
            
            Button(action: {
                let newTransaction = Transaction(
                    name: payee,
                    date: getCurrentDate(),
                    amount: Double(amount) ?? 0.0,
                    category: selectedCategory,
                    color: getColorForCategory(selectedCategory)
                )
                onSave(newTransaction)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $receiptImage)
        }
    }
    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter.string(from: Date())
    }
    
    private func getColorForCategory(_ category: String) -> Color {
        switch category {
        case "Subscription":
            return .green
        case "Grocery":
            return .yellow
        case "Entertainment":
            return .blue
        default:
            return .gray
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}
