//
//  ContentView.swift
//  BucketListSwiftUI
//
//  Created by Александр Павелко on 30.09.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = BuketListViewModel()
    @State var listItemName = ""
    var body: some View {
        VStack {
            TextField("", text: $listItemName)
                .onSubmit {
                    viewModel.createItem(name: listItemName)
                }
                .padding(.all)
                .border(Color(uiColor: .orange))
            // Bucket list
            List {
                ForEach(viewModel.listItem) { item in
                    HStack(spacing: 20) {
                        Button {
                            viewModel.toggleIsCompleted(item: item)
                        } label: {
                            Image(systemName: item.isComplited ? "pin.circle.fill" : "pin.circle")
                                .foregroundColor(Color(uiColor: .orange))
                                .font(.system(size: 30))
                        }
                        Text(item.name)
                    }
                }
                .onDelete(perform: viewModel.deleteItem(index:))
            }
        }
        .padding()
        .onAppear {
            viewModel.loadFromPersistenceStore()
        }
    }
}

#Preview {
    ContentView()
}
