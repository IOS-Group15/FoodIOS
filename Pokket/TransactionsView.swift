import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let amount: Double
    let category: String
    let color: Color
}

struct TransactionsView: View {
    @State private var transactions = [
        Transaction(name: "Spotify", date: "3/7/2024", amount: 5.99, category: "Subscription", color: .green),
        Transaction(name: "Ralph's", date: "3/7/2024", amount: 53.99, category: "Grocery", color: .yellow),
        Transaction(name: "Lowe's", date: "3/7/2024", amount: 59.99, category: "Entertainment", color: .blue)
    ]
    
    @State private var showAddTransaction = false
    
    var body: some View {
        VStack {
            Text("Your Transactions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            HStack {
                Text("Transaction")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Amount")
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .trailing)
                
                Spacer()
                    .frame(width: 20)
                
                Text("Category")
                    .fontWeight(.bold)
                    .frame(width: 120, alignment: .leading)
            }
            .padding(.horizontal)
            .padding(.top)
            
            ForEach(transactions) { transaction in
                HStack {
                    HStack {
                        Circle()
                            .fill(transaction.color)
                            .frame(width: 30, height: 30)
                        
                        VStack(alignment: .leading) {
                            Text(transaction.name)
                            Text(transaction.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Text("$\(transaction.amount, specifier: "%.2f")")
                        .foregroundColor(.red)
                        .frame(width: 80, alignment: .trailing)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    HStack {
                        Text(transaction.category)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Image(systemName: "chevron.down")
                    }
                    .frame(width: 120, alignment: .leading)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                
                Divider()
            }
            
            Spacer()
            
            Button(action: {
                showAddTransaction = true
            }) {
                Text("Add a Transaction")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showAddTransaction) {
                AddTransactionView { newTransaction in
                    transactions.append(newTransaction)
                }
            }
        }
    }
}
