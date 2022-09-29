//
//  TableManager.swift
//  StarWarsAPI
//
//  Created by Chetan Dhowlaghar on 9/11/22.
//

import Foundation


class TableManager{
    
    var count = 1
    var pageNumber: Int {
        if count == 8 {
            count = 1
        }
        
        return count
    }
    
    var tableList = [Result]()
    
    var isFetching = false
    
    func fetchData(){
        let url = "https://swapi.dev/api/people"
        let urlSuffix = "/?page=\(pageNumber)"
        
        let urlString = URL(string: url+urlSuffix)
        if isFetching == true {return}
        print(urlSuffix)
        
        isFetching = true
        if let url = urlString{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let result = try decoder.decode(Model.self, from: safeData)
                            //  print(result)
                            DispatchQueue.main.async {
                                
                                self.tableList.append(contentsOf: result.results ?? [])
                                self.count += 1
                                self.isFetching = false
                                NotificationCenter.default.post(name: NSNotification.Name("Reload"), object: nil)
                            }
                        }
                        catch{
                            print(error.localizedDescription)
                            self.isFetching = false
                            NotificationCenter.default.post(name: NSNotification.Name("Reload"), object: nil)
                            self.count += 1
                        }
                        
                    }
                    
                }
                
            }
            task.resume()
        }
        
    }
    
   
}

