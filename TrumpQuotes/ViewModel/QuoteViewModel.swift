//
//  QuoteViewModel.swift
//  TrumpQuotes
//
//  Created by Marvin John on 06.06.23.
//

import Foundation

class ViewModel: ObservableObject{
    @Published private(set) var quote: Quote?
    @Published  var isLoading: Bool = false

    
    init(){
        Task{
            await fetchData()
        }
    }
    
    func fetchData() async{
        do {
            guard let url = URL(string: "https://api.whatdoestrumpthink.com/api/v1/quotes/random") else { fatalError("Missing URL")}
            
            let urlRequest = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                      fatalError("Invalid response")
                  }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error while fetching data. Status code: \(httpResponse.statusCode)")
                
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Quote.self, from: data)
            
            DispatchQueue.main.async {
                self.quote = decodedData
            }
            
            
        } catch {
            print("Error fetching data\(error)")
        }
        
    }
    
}
