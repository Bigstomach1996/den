//
//  ViewController.swift
//  JSON-stage1
//
//  Created by yunweichen on 7/7/19.
//  Copyright © 2019 yunweichen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var location = [fetchLocation]()
    
    var lattitude:Double = 0.0
    var longtitude:Double = 0.0
    var coordinate_string = [fetchLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //print out location's name with "Location Search" method
        if let url = URL(string:"https://www.metaweather.com/api/location/search/?query=london"){
            URLSession.shared.dataTask(with: url){ data,response,error in
                if let data = data{
                    do{
                        let location = try JSONDecoder().decode([fetchLocation].self,from: data)
                        print(location[0].title+": \(location[0].woeid)")
                    }catch let error{
                        print(error)
                    }
                }
                }.resume()
        }
        
        //print out location's 5 day forecast in one line with "Location" method
        if let url = URL(string:"https://www.metaweather.com/api/location/44418/"){
            URLSession.shared.dataTask(with: url){ data,response,error in
                guard let data = data else{
                    print("No data")
                    return
                }
                guard let location_a = try? JSONDecoder().decode(Detail.self, from: data) else {
                    print("Error: Couldn't decode data into location")
                    return
                }
                for info in location_a.consolidated_weather{
                    print("-id: \(info.id),weather:\(info.weather_state_name),time:\(info.created)")
                }
        
                }.resume()
        }
        //print out formated Date
        if let url = URL(string:"https://www.metaweather.com/api/location/44418/"){
            URLSession.shared.dataTask(with: url){ data,response,error in
                guard let data = data else{
                    print("No data")
                    return
                }
                guard let location_a = try? JSONDecoder().decode(Detail.self, from: data) else {
                    print("Error: Couldn't decode data into location")
                    return
                }
                for info in location_a.consolidated_weather{
                    //print(info.created)
                    print(self.DateFormating(theDate: info.created))
                }
                
                }.resume()
        }
        //respectively, print out lattitude and longtitude in Double type
        if let url = URL(string:"https://www.metaweather.com/api/location/search/?query=london"){
            URLSession.shared.dataTask(with: url){ data,response,error in
                if let data = data{
                    do{
                        let coordinate_string = try JSONDecoder().decode([fetchLocation].self,from: data)
                        let strArr = coordinate_string[0].latt_long.split(separator: ",")
                        self.lattitude = Double(strArr[0])!
                        self.longtitude = Double(strArr[1])!
                        print(self.lattitude)
                        print(self.longtitude)
                    }catch let error{
                        print(error)
                    }
                }
                }.resume()
        }
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    func DateFormating(theDate: String)->String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date = dateFormatterGet.date(from: theDate) {
            return(dateFormatterPrint.string(from: date))
        } else {
            return("There was an error decoding the string")
            
        }
    }

}

