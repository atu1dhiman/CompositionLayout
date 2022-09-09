//
//  MovieViewModel.swift
//  CompositionLayout
//
//  Created by Atul Dhiman on 05/09/22.
//


import Foundation

struct MovieViewModel{
    
    func parse(comp: @escaping ([ResultModel]) -> () ){
         
        let api = URL(string: "https://itunes.apple.com/search?media=music&term=bollywood")
        
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            do{
              let res = try JSONDecoder().decode(MovieModel.self, from: data!)
                print(res)
                comp(res.results!)
            }catch{
                
            }
            
        }.resume()
    }
}
