//
//  tblGroup.swift
//  autolayout1
//
//  Created by mac on 4/24/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Kingfisher

class cell_TblGroup: UITableViewCell{
    
    @IBOutlet var cell_img: UIImageView!
    
    @IBOutlet var cell_GroupNAme: UILabel!
    @IBOutlet var cell_Group_id: UILabel!
}

class tblGroup: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var groupdata = NSArray()
    @IBOutlet var tbl1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupList_webService()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupdata.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell_TblGroup
        let str_Name = (groupdata[indexPath.row] as AnyObject).value(forKey: "group_name") as! String
         let group_id = (groupdata[indexPath.row] as AnyObject).value(forKey: "group_id") as! String
         let img = (groupdata[indexPath.row] as AnyObject).value(forKey: "image") as! String
        cell.cell_img.roundImage()
        
        cell.cell_GroupNAme.text? = str_Name
        cell.cell_Group_id.text? = group_id
        let image = UIImage(named: "avartar.png")
        let url = URL(string: img)
        cell.cell_img.kf.setImage(with: url, placeholder: image)
       
//        cell.cell_img.kf.setImage(with: url)

        
        
        
        return cell
        
    }
    func groupList_webService(){
        
        
        
        if Reachability2.isConnectedToNetwork() == false
        {
            self.view.isUserInteractionEnabled = true
            //SVProgressHUD.dismiss()
            print("Internet connection FAILED")
            let alert = UIAlertController(title: " PubPulse ", message: "Internet connection FAILED" as String, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }
            
            
        else
        {
            
            print("Internet connection DONE")
            
            let login = main_url + "my_group_list"
            print(login)
            
            var request = URLRequest(url: URL(string: login)!)
            
            request.httpMethod = "POST"
            //            print("user_id:::",user_id3)
            
            var user_id = "33"
           // print(user_id)
           // print(usertoken)
           
            //            let postString =  String(format: "email=shreya@mxicoders.com&password=mxi123&device_id=123456&user_type=user")
            
            let postString =  String(format: "user_id=%@", arguments: [user_id])
            print("Post string",postString)
            
            request.httpBody = postString.data(using: .utf8)
            request.addValue("delta141forceSEAL8PARA9MARCOSBRAHMOS", forHTTPHeaderField: "Authorization")
            request.addValue("152448782949511", forHTTPHeaderField: "UserAuth")
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request)
            {
                data, response, error in
                guard let data = data, error == nil
                    else
                {
                    print("error=\(String(describing: error))")
                    return
                }
                
                do
                {
                    
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    print(dictionary)
                    
                    let status = (dictionary.value(forKey: "status")!) as! NSString
                    let message1 = (dictionary.value(forKey: "message")) as! NSString
                    //                                defaults.set(status , forKey: "status")
                    
                    //                                let sts = Int(status)
                    DispatchQueue.main.async(){
                        if status == "200"{
                            self.view.isUserInteractionEnabled = true
                            
                            
                            self.groupdata = dictionary["my_group"] as! NSArray
                            
                            //print("USer_ Data:::",self.groupdata)
                            
                            self.tbl1.reloadData()
                            //SVProgressHUD.dismiss()
                            
                            
                        }
                        else{
                           // SVProgressHUD.dismiss()
                            self.view.isUserInteractionEnabled = true
                            
                            self.alertMessage(title: " PubPulse ", message: message1 as String)
                            //SVProgressHUD.dismiss()
                        }
                        
                    }
                    
                }
                catch
                {
                    
                    print(error)
                }
                
            }
            task.resume()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
