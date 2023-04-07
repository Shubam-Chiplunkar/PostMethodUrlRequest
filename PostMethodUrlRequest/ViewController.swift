//
//  ViewController.swift
//  PostMethodUrlRequest
//
//  Created by mayank ranka on 03/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtBody: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func postButton(_ sender: Any) {
        postData()
    }
    func postData(){
        guard let uid = self.txtUser.text else {return}
        guard let title = self.txtTitle.text else {return}
        guard let body = self.txtBody.text else {return}
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parametre : [String : Any] = [
                "userId" : uid,
                "title"  : title,
                "body"   : body
            ]
            request.httpBody = parametre.description.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error != nil {
                        print(error?.localizedDescription ?? "Unknown error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard (200...299) ~= response.statusCode else {
                        print("Status Code:-\(response.statusCode)")
                        print(response)
                        return
                    }
                }
                do{
                    let json = try JSONSerialization.jsonObject(with: data , options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

