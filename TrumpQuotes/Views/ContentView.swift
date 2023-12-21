//
//  ContentView.swift
//  TrumpQuotes
//
//  Created by Marvin John on 06.06.23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
   
    var body: some View {
        ZStack {
            Color.brown
                .ignoresSafeArea()
           
            
            
            VStack{
                
                
               Text("Random Donald Trump Quotes")
                    .font(.headline)
                    .padding(.top)
                Divider()
                
               
                Text(viewModel.quote?.message ?? "")
                    .padding(.bottom, 100)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)

            
               
                
                VStack {
                    Button {
                        getQuote()
                        viewModel.isLoading = true
                    } label: {
                        Text("Generate a new quote")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 6)
                            .background(Color.red)
                            .cornerRadius(10)
                            
                }
                    
                    Button {
                       
                    } label: {
                        Link(destination: URL(string: "https://twitter.com/intent/tweet?text=")!) {
                            Text("Tweet it!")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal, 82)
                                .padding(.vertical, 6)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                       
                            
                    }
                }
                .padding(.bottom)

            }
            .background(
                Color.white
                    
                  
            )
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(color: .black, radius: 10)
        }
      
      
    }
 
    
    func getQuote() {
      
        Task{
            await viewModel.fetchData()
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


