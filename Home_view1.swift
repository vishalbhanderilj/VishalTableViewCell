//
//  Home_view1.swift
//  pubpulse
//
//  Created by mac on 2/26/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire



class menucell: UITableViewCell {
    @IBOutlet weak var icon_image: UIImageView!
    @IBOutlet weak var icon_lable: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

class Home_view1: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    var imagesend = ""
    var isProfile = ""
    var selectedMenuItem : Int = 0
    @IBOutlet weak var Menu: UIView!
    @IBOutlet weak var tableview: UITableView!
    //var imagepicker = UIImagePickerController()
//    imagepicker.isEditing = true
//    imagepicker.allowsEditing = true
//    imagepicker.delegate = self
//    let imagepicker = UIImagePickerController()
    
    let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
    let usertoken = UserDefaults.standard.object(forKey: "user_token") as! String
    var id1 = ""   
    var id2 = ""
    var id3 = ""
    var id4 = ""
    var id5 = ""
    
    
    var menuhide = true
    var sender = ["1","2","3","4","5"]
    //var menu_icon1 = [#imageLiteral(resourceName: "home.png"),#imageLiteral(resourceName: "message.png"),#imageLiteral(resourceName: "friend.png"),#imageLiteral(resourceName: "group.png"),#imageLiteral(resourceName: "my-profile.png"),#imageLiteral(resourceName: "establishment.png"),#imageLiteral(resourceName: "setting.png"),#imageLiteral(resourceName: "drink-request.png"),#imageLiteral(resourceName: "location1x.png"),#imageLiteral(resourceName: "about.png"),#imageLiteral(resourceName: "support.png"),#imageLiteral(resourceName: "map.png"),#imageLiteral(resourceName: "cheers.png"),#imageLiteral(resourceName: "logout.png")]
        //var menu_icons = [#imageLiteral(resourceName: "home.png"),#imageLiteral(resourceName: "message.png"),#imageLiteral(resourceName: "friend.png"),#imageLiteral(resourceName: "group.png"),#imageLiteral(resourceName: "my-profile.png"),#imageLiteral(resourceName: "establishment.png"),#imageLiteral(resourceName: "setting.png"),#imageLiteral(resourceName: "drink-request.png"),#imageLiteral(resourceName: "claim-location.png"),#imageLiteral(resourceName: "about.png"),#imageLiteral(resourceName: "support.png"),#imageLiteral(resourceName: "map.png"),#imageLiteral(resourceName: "cheers.png"),#imageLiteral(resourceName: "logout.png")]
     var menu_icons = [#imageLiteral(resourceName: "home.png"),#imageLiteral(resourceName: "message.png"),#imageLiteral(resourceName: "friend.png"),#imageLiteral(resourceName: "group.png"),#imageLiteral(resourceName: "my-profile.png"),#imageLiteral(resourceName: "establishment.png"),#imageLiteral(resourceName: "setting.png"),#imageLiteral(resourceName: "drink-request.png"),#imageLiteral(resourceName: "claim-location.png"),#imageLiteral(resourceName: "about.png"),#imageLiteral(resourceName: "support.png"),#imageLiteral(resourceName: "map.png"),#imageLiteral(resourceName: "cheers.png"),#imageLiteral(resourceName: "logout.png")]
    var menuname = ["Home","Message","Friends","Group","Friend's Statistics","Establishment Statistics","Setting",
                    "Drink Request","Steps To Claim Your Location","About Us","Support","Establishment Map","Establishment Activity","Logout"]
    
    @IBOutlet weak var btn_facebook: UIButton!
    @IBOutlet weak var btn_instagram: UIButton!
    @IBOutlet weak var imgView_1: UIImageView!
    @IBOutlet weak var imgView_2: UIImageView!
    @IBOutlet weak var imgView_3: UIImageView!
    @IBOutlet weak var imgView_4: UIImageView!
    @IBOutlet weak var imgView_5: UIImageView!
    @IBOutlet weak var btn_img3: UIButton!
    
    @IBOutlet weak var btn_img1: UIButton!
    @IBOutlet weak var btn_img2: UIButton!
    @IBOutlet weak var btn_img4: UIButton!
    @IBOutlet weak var btn_img5: UIButton!
   // var picker:UIImagePickerController?=UIImagePickerController()
    var imageview = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
        //SVProgressHUD.setBackgroundColor(UIColor.clear)
        
        homeDetail_webservice1()
        print("GOT HOME Detail")
        
        
        
       //Menu.backgroundColor = UIColor(white: 1, alpha: 0.0)
       self.Menu.frame = CGRect(x: -self.Menu.frame.width, y: 54, width: self.Menu.frame.width, height: self.Menu.frame.height)
         tableview.backgroundColor = nil
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondtogesture))
        swiperight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swiperight)
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondtogesture))
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeleft)

        
       // picker?.delegate = self
        
        // facebook view button
        
        btn_facebook.backgroundColor = .clear
        btn_facebook.layer.cornerRadius = self.btn_facebook.frame.height/2
        btn_facebook.layer.borderWidth = 0.80
        btn_facebook.layer.borderColor = UIColor.white.cgColor
        
        // upload from instagram button view
        btn_instagram.backgroundColor = .clear
        btn_instagram.layer.cornerRadius = self.btn_instagram.frame.height/2
        btn_instagram.layer.borderWidth = 0.80
        btn_instagram.layer.borderColor = UIColor.white.cgColor
        
        // image buttons

        imgView_1.layer.cornerRadius = self.imgView_1.frame.height/2
        imgView_1.layer.borderWidth = 0
        imgView_1.layer.borderColor = UIColor.white.cgColor
        imgView_1.clipsToBounds = true
        
        imgView_2.layer.cornerRadius = self.imgView_2.frame.height/2
        imgView_2.layer.borderWidth = 0
        imgView_2.layer.borderColor = UIColor.white.cgColor
        imgView_2.clipsToBounds = true
        imgView_3.layer.cornerRadius = imgView_3.frame.height/2
        imgView_3.layer.borderWidth = 2
        imgView_3.clipsToBounds = true
        imgView_3.layer.borderColor = UIColor.white.cgColor
     
        imgView_4.layer.cornerRadius = self.imgView_4.frame.height/2
        imgView_4.layer.borderWidth = 0
        imgView_4.clipsToBounds = true
        imgView_4.layer.borderColor = UIColor.white.cgColor
        imgView_5.layer.cornerRadius = self.imgView_5.frame.height/2
        imgView_5.layer.borderWidth = 0
        imgView_5.clipsToBounds = true
        imgView_5.layer.borderColor = UIColor.white.cgColor
        
        //button corner radius
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 1/255, green: 192/255, blue: 248/255, alpha: 1)
        //let statusBarColor = UIColor.black
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        tableview.tableFooterView = UIView()
        //disable buttons
        if (imgView_3.image == nil){
//         imgView_1.isEnabled = false
//         imgView_2.isEnabled = false
//         btn_img4.isEnabled = false
//         btn_img5.isEnabled = false
           
        }
        //btn_img3.layer.cornerRadius = self.btn_img3.frame.height/2
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuname.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "menucell", for: indexPath) as! menucell
        // cell.icon_image.image = menu_icons[indexPath.row]
        // cell.icon_lable.text = menuname[indexPath.row]
        //cell.icon_lable?.text = menu1[indexPath.row]
        cell.icon_lable.text = menuname[indexPath.row]
        cell.icon_image.image = menu_icons[indexPath.row]
        //cell.cellImage.image = UIImage(named: "side_menu_select.png")
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! menucell
        
        print("did select row: \(indexPath.row)")
        
        
        switch indexPath.row
        {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Home_view1") as! Home_view1
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Message") as! Messagae
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Friends") as! Friends
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Group") as! Group
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            break
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Friends") as! Friends
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Friends") as! Friends
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 6:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Setting") as! Setting
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 7:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Friends") as! Friends
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 8:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "StepToClaimYourLoaction") as! StepToClaimYourLoaction
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 9:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "AboutUs") as! AboutUs
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 10:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Support") as! Support
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 11:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "MapView") as! MapView
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            cell.cellImage.image = UIImage(named: "side_menu_select.png")
            break
        case 12:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Friends") as! Friends
            navigationController?.pushViewController(destination, animated: true)
            print(indexPath.row)
            break
        case 13:
            
            SVProgressHUD.show()
            SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
            SVProgressHUD.setBackgroundColor(UIColor.clear)
           
          
            
            
            
            self.view.isUserInteractionEnabled = false
            
            logout_webservice()
            
            
           
            break
            
        default:
            
            break
            
            
        }
        
    }



    @IBAction func select_imageCamera(_ sender: Any) {
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Select Media Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Image From Gallery", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            imagepicker.sourceType = .photoLibrary
            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Click The Photo", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagepicker.sourceType = .camera
                
            }
            else{
                let alert = UIAlertController(title: " PubPulse ", message: "Camera Not Found", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
            
            

            
            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
       
    @IBAction func btn_image3(_ sender: Any) {
//       openGallary()
        imagesend = "3"
        imageview = "3"
           let imagepicker = UIImagePickerController()
            imagepicker.isEditing = true
            imagepicker.allowsEditing = true
            imagepicker.delegate = self
        
            let alert = UIAlertController(title: "", message: "Image Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Set image As Profile Picture", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            
            
            
            //imagepicker.sourceType = .photoLibrary
            //self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Update Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.updateImage()
//            imagepicker.sourceType = .photoLibrary
//            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "View Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.viewImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))

        
//        alert.addAction(UIAlertAction(title: "Image From Gallery", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
//                imagepicker.sourceType = .photoLibrary
//                self.present(imagepicker, animated: true, completion: nil)
//            }))
//        alert.addAction(UIAlertAction(title: "Click Photo", style: UIAlertActionStyle.default, handler: nil))
        
        
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    func updateImage(){
        let alert = UIAlertController(title: "PubPulse", message: "Are you sure want to Update this image?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.subUpdateImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func subUpdateImage(){
    
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Select Media Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Image From Gallery", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            imagepicker.sourceType = .photoLibrary
            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Click The Photo", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagepicker.sourceType = .camera
                
            }
            else{
                let alert = UIAlertController(title: " PubPulse ", message: "Camera Not Found", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
            
            
            
            
            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    func viewImage(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ViewImage") as! ViewImage
        destination.imageNumber = self.imagesend
//        self.present(destination, animated:true, completion:nil)
        self.navigationController?.pushViewController(destination, animated: true)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
    if (imgView_1.image != nil && imgView_2.image != nil && imgView_3.image != nil && imgView_4.image != nil && imgView_5.image != nil) && imageview != "1" && imageview != "2" && imageview != "3" && imageview != "4" && imageview != "5"{
                    self.isProfile = "Yes"
                    imgView_3.image = image
                    imgView_3.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)

        
                    imageupdate(imageview: imgView_3, image_id: id3)
        
        
        print("vishal image is updated")
        
        
                    
                }
                    
                    
                    
                else   if imgView_3.image == nil
                {
                    self.isProfile = "Yes"
                    imgView_3.image = image
                    imgView_3.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)
                    
                    imageupload(imageview: imgView_3)
                    //imgView_3.contentMode = .scaleAspectFill
                    print("image 3 is uploaded")
                }
                else if (imgView_1.image == nil)  {
                    self.isProfile = "No"
                    imgView_1.image = image
                    imgView_1.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)
                    imageupload(imageview: imgView_1)
                    //imgView_1.contentMode = .scaleAspectFill
                    print("image 1 is uploaded")
                }
                else if (imgView_2.image == nil)
                {
                    self.isProfile = "No"
                    imgView_2.image = image
                    imgView_2.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)
                    
                    
                    imageupload(imageview: imgView_2)
                    //imgView_2.contentMode = .scaleAspectFill
                    print("image 2 is uploaded")
                }
                else if (imgView_4.image == nil)
                {
                    self.isProfile = "No"
                    imgView_4.image = image
                    imgView_4.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)
                    
                    imageupload(imageview: imgView_4)
                    //imgView_4.contentMode = .scaleAspectFill
                    print("image 4 is uploaded")
                }
                else if (imgView_5.image == nil)
                {
                   self.isProfile = "No"
                    imgView_5.image = image
                    imgView_5.contentMode = .scaleAspectFill
                    SVProgressHUD.show()
                    SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                    SVProgressHUD.setBackgroundColor(UIColor.clear)
                    imageupload(imageview: imgView_5)
                    //imgView_5.contentMode = .scaleAspectFill
                    print("image 5 is uploaded")
                    
                }
                    
                    
                    
                else if (imgView_1.image != nil && imgView_2.image != nil && imgView_3.image != nil && imgView_4.image != nil && imgView_5.image != nil){
                    
                    
                    if (imageview == "1") && (imgView_1.image != nil)
                    {
                        self.isProfile = "No"
                        imageview="8"
                        imgView_1.image = image
                        imgView_1.contentMode = .scaleAspectFill
                        SVProgressHUD.show()
                        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                        SVProgressHUD.setBackgroundColor(.clear)
                         imageupdate(imageview: imgView_1, image_id: id1)
                       // imgView_1.contentMode = .scaleAspectFill
                        print("Image 1 is updated")
                    }
                        
                    else if (imageview == "2") && (imgView_2.image != nil)
                    {
                        self.isProfile = "No"
                        imageview="8"
                        imgView_2.image = image
                        imgView_2.contentMode = .scaleAspectFill
                        SVProgressHUD.show()
                        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                        SVProgressHUD.setBackgroundColor(.clear)
                        imageupdate(imageview: imgView_2, image_id: id2)
                        //imgView_2.contentMode = .scaleAspectFill
                        print("Image 2 is updated")
                        
                    }
                        
                    else if (imageview == "3" && imgView_3.image != nil)
                    {
                        self.isProfile = "Yes"
                        imageview="8"
                        imgView_3.image = image
                        imgView_3.contentMode = .scaleAspectFill
                        SVProgressHUD.show()
                        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                        SVProgressHUD.setBackgroundColor(.clear)
                        imageupdate(imageview: imgView_3, image_id: id3)
                        //imgView_3.contentMode = .scaleAspectFill
                        
                        print("Image 3 is updated")
                    }
                        
                    else if (imageview == "4" && imgView_4.image != nil)
                    {
                        self.isProfile = "No"
                        imageview="8"
                        imgView_4.image = image
                        imgView_4.contentMode = .scaleAspectFill
                        SVProgressHUD.show()
                        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                        SVProgressHUD.setBackgroundColor(.clear)
                        imageupdate(imageview: imgView_4, image_id: id4)
                        //imgView_4.contentMode = .scaleAspectFill
                        
                        print("Image 4 is updated")
                    }
                        
                    else if (imageview == "5" && imgView_5.image != nil)
                    {
                        self.isProfile = "No"
                        imageview="8"
                        imgView_5.image = image
                        //imgView_5.contentMode = .scaleAspectFit
                        imgView_5.contentMode = .scaleAspectFill
                        SVProgressHUD.show()
                        SVProgressHUD.setForegroundColor(UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 248.0/255.0, alpha: 1.0))
                        SVProgressHUD.setBackgroundColor(.clear)
                        imageupdate(imageview: imgView_5, image_id: id5)
                        //imgView_5.contentMode = .scaleAspectFill
                        
                        print("Image 5 is updated")
                    }
                    else{
                        print("vishal vishal image is uploaded")
                    }
                    
                }
            
            
        }
                self.dismiss(animated: true, completion: nil)
    }
    func imageupload(imageview : UIImageView)
    {
        var params = [String:AnyObject]()
        let usertoken = UserDefaults.standard.object(forKey: "user_token") as? String
        let user_id = UserDefaults.standard.object(forKey: "user_id") as? String
        params["user_id"] = user_id as AnyObject?
        params["is_social"] = "0" as AnyObject?
        params["is_profile"] = isProfile as AnyObject
        
        let url1 = "http://mbdbtechnology.com/projects/pubpulse/ws/Webservice/image_upload"
        if let profileImageData = imageview.image {
            
            if let imageData = UIImageJPEGRepresentation(profileImageData, 0.2) {
                params["image_name"] = imageData as AnyObject?
                print(params)
                Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
                    for (key, value) in params {
                        if key == "image_name" {
                            multipartFormData.append(
                                value as! Data,
                                withName: key,
                                fileName: "swift_file.jpeg",
                                mimeType: "image/jpeg"
                            )
                        } else {
                            //Data other than image
                            multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                        }
                    }
                }, usingThreshold: 1, to: url1, method: .post, headers: ["Authorization":"delta141forceSEAL8PARA9MARCOSBRAHMOS","UserAuth":usertoken! ])
                { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
                    switch encodingResult{
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            
                            print(response.request!)
                            print(response.response!)
                            //print(response.data!)
                            print(response.result)
                            
                            SVProgressHUD.dismiss()
                            if let JSON = response.result.value {
                                print("JSON: \(JSON)")
                            }
                        }
                        
                    case .failure(let encodingError):
                        SVProgressHUD.dismiss()
                        print(encodingError)
                        
                    }
                }
                
            }
            else {
                print("Image problem")
            }
            
        }
    }
    func imageupdate(imageview : UIImageView, image_id : String)
    {
        var params = [String:AnyObject]()
        let usertoken = UserDefaults.standard.object(forKey: "user_token") as? String
        let user_id = UserDefaults.standard.object(forKey: "user_id") as? String
        params["user_id"] = user_id as AnyObject?
        params["is_social"] = "0" as AnyObject?
        params["image_id"] = image_id as AnyObject?
        params["is_profile"] = isProfile as AnyObject
        
        let url1 = "http://mbdbtechnology.com/projects/pubpulse/ws/Webservice/update_image_upload"
        if let profileImageData = imageview.image {
            
            if let imageData = UIImageJPEGRepresentation(profileImageData, 0.2) {
                params["image_name"] = imageData as AnyObject?
                print(params)
                Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
                    for (key, value) in params {
                        if key == "image_name" {
                            multipartFormData.append(
                                value as! Data,
                                withName: key,
                                fileName: "swift_file.jpeg",
                                mimeType: "image/jpeg"
                            )
                        } else {
                            //Data other than image
                            multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                        }
                    }
                }, usingThreshold: 1, to: url1, method: .post, headers: ["Authorization":"delta141forceSEAL8PARA9MARCOSBRAHMOS","UserAuth":usertoken! ])
                { (encodingResult:SessionManager.MultipartFormDataEncodingResult) in
                    switch encodingResult{
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            
                            print(response.request!)
                            print(response.response!)
                            //print(response.data!)
                            print(response.result)
                            
                            SVProgressHUD.dismiss()
                            if let JSON = response.result.value {
                                print("JSON: \(JSON)")
                            }
                        }
                        
                    case .failure(let encodingError):
                        SVProgressHUD.dismiss()
                        print(encodingError)
                        
                    }
                }
                
            }
            else {
                print("Image problem")
            }
            
        }
    }
    

    

    @IBAction func btn_img1(_ sender: Any) {
        
        imagesend = "1"
        imageview = "1"
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Image Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Set image As Profile Picture", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            
            
            
            //imagepicker.sourceType = .photoLibrary
            //self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Update Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.updateImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "View Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.viewImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_img2(_ sender: Any) {
        imagesend = "2"
        imageview = "2"
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Image Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Set image As Profile Picture", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            
            
            
            //imagepicker.sourceType = .photoLibrary
            //self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Update Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.updateImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "View Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.viewImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_img4(_ sender: Any) {
        imagesend = "4"
        imageview = "4"
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Image Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Set image As Profile Picture", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            
            
            
            //imagepicker.sourceType = .photoLibrary
            //self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Update Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.updateImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "View Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.viewImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_img5(_ sender: Any) {
        imagesend = "5"
        imageview = "5"
        let imagepicker = UIImagePickerController()
        imagepicker.isEditing = true
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        
        let alert = UIAlertController(title: "", message: "Image Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Set image As Profile Picture", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            
            
            
            //imagepicker.sourceType = .photoLibrary
            //self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Update Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.updateImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "View Image", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            self.viewImage()
            //            imagepicker.sourceType = .photoLibrary
            //            self.present(imagepicker, animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)    }
    
    @IBAction func btn_menu(_ sender: Any) {
        if menuhide{
            UIView.animate(withDuration: 0.3){ void in
                self.Menu.frame = CGRect(x: 0, y: 50, width: self.Menu.frame.width, height: self.Menu.frame.height)
                self.menuhide = false
            }
        }
        else{
            UIView.animate(withDuration: 0.3){ void in
                self.Menu.frame = CGRect(x: -self.Menu.frame.width, y: 50, width: self.Menu.frame.width, height: self.Menu.frame.height)
                self.menuhide = true
            }
        }
        
        
    }
    func respondtogesture(gesture:UISwipeGestureRecognizer){
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            UIView.animate(withDuration: 0.3){ void in
                self.Menu.frame = CGRect(x: 0, y: 50, width: self.Menu.frame.width, height: self.Menu.frame.height)
                self.menuhide = false
            }
        case UISwipeGestureRecognizerDirection.left:
            UIView.animate(withDuration: 0.3){ void in
                self.Menu.frame = CGRect(x: -self.Menu.frame.width, y: 50, width: self.Menu.frame.width, height: self.Menu.frame.height)
                self.menuhide = true
            }
        default:
            break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.Menu.frame = CGRect(x: -self.Menu.frame.width, y: 54, width: self.Menu.frame.width, height: self.Menu.frame.height)
        super.viewWillAppear(animated) // No need for semicolon
    }
    func homeDetail_webservice(){
        
        
        //                 SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskTypeBlack)
        
        if Reachability2.isConnectedToNetwork() == false
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: " PubPulse ", message: "Internet connection FAILED" as String, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }
            
        else
        {
            
            
            print("Internet connection DONE")
            
            let login = main_url + "get_home_detail"
            print(login)
            
            var request = URLRequest(url: URL(string: login)!)
            
            request.httpMethod = "POST"
            //            print("user_id:::",user_id3)
            
            let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
            let usertoken = UserDefaults.standard.object(forKey: "user_token") as! String
            print(user_id)
            print(usertoken)
            
            //            let postString =  String(format: "email=shreya@mxicoders.com&password=mxi123&device_id=123456&user_type=user")
            
            let postString =  String(format: "user_id=%@", arguments: [user_id])
            print("Post string",postString)
            
            request.httpBody = postString.data(using: .utf8)
            
            
            request.addValue("delta141forceSEAL8PARA9MARCOSBRAHMOS", forHTTPHeaderField: "Authorization")
            request.addValue(usertoken, forHTTPHeaderField: "UserAuth")
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
                    //                  let user_id = (dictionary.value(forKey: "user_id"))
                    //self.user_token1 = [user_id as! String]
                    //self.Status = status as! String
                    print(status)
                    
                    DispatchQueue.main.async() {
                        if status == "200"
                        {
                            SVProgressHUD.dismiss()
                            let userdata = dictionary["user_images"] as! [NSDictionary]
                            
                            for  i in 0..<(userdata.count){
                                
                                
                                if let imageurl1 = userdata[i]["image"] as? String{
                                    let url = URL(string: imageurl1)
                                    
                                    
                                    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                                        guard let data = data, error == nil else { return }
                                        
//                                        OperationQueue.main.addOperation {
//                                            if self.imgView_3.image == nil{
//                                                self.id1 = userdata[i]["id"] as! String
//                                                self.imgView_3.image = UIImage(data: data)
//                                                
//                                                
//                                                print("ID3::::",self.id1)
//                                                
//                                                
//                                                
//                                            }
//                                            else if self.imgView_1.image == nil{
//                                                self.id2 = userdata[i]["id"] as! String
//                                                self.imgView_1.image = UIImage(data: data)
//                                                print("ID1:::",self.id2)
//                                                
//                                            }
//                                            else if self.imgView_2.image == nil{
//                                                self.id3 = userdata[i]["id"] as! String
//                                                self.imgView_2.image = UIImage(data: data)
//                                                print("ID2::::",self.id3)
//                                                
//                                            }
//                                            else if self.imgView_4.image == nil{
//                                                self.id4 = userdata[i]["id"] as! String
//                                                self.imgView_4.image = UIImage(data: data)
//                                                print("ID4::::",self.id4)
//                                                
//                                            }
//                                            else if self.imgView_5.image == nil{
//                                                self.id5 = userdata[i]["id"] as! String
//                                                self.imgView_5.image = UIImage(data: data)
//                                                print("ID5::::",self.id5)
//                                                
////                                                self.btn_centerimage.isUserInteractionEnabled = true
////                                                self.btn_leftimage.isUserInteractionEnabled = true
////                                                self.btn_midleftimage.isUserInteractionEnabled = true
////                                                self.btn_midrightimage.isUserInteractionEnabled = true
////                                                self.btn_rightimage.isUserInteractionEnabled = true
//                                            }
//                                            SVProgressHUD.dismiss()
//                                        }
                                        
                                        
                                    }
                                    task.resume()
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                            
                            
                        else{
                            
                            let alert = UIAlertController(title: " PubPulse ", message: message1 as String, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alert, animated: true)
                            SVProgressHUD.dismiss()
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                    DispatchQueue.main.async() {
                        // self.displayMyAlertMessage("Wrong name or password")
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
    
    func homeDetail_webservice1()
    {
        
        
        //                 SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskTypeBlack)
        
        if Reachability2.isConnectedToNetwork() == false
        {
            SVProgressHUD.dismiss()
            print("Internet connection FAILED")
            let alert = UIAlertController(title: " PubPulse ", message: "Internet connection FAILED" as String, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }

            
        else
        {
            
            print("Internet connection DONE")
            
            let login = main_url + "get_home_detail"
            print(login)
            
            var request = URLRequest(url: URL(string: login)!)
            
            request.httpMethod = "POST"
            //            print("user_id:::",user_id3)
            
            let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
            let usertoken = UserDefaults.standard.object(forKey: "user_token") as! String
            print(user_id)
            print(usertoken)
            
            //            let postString =  String(format: "email=shreya@mxicoders.com&password=mxi123&device_id=123456&user_type=user")
            
            let postString =  String(format: "user_id=%@", arguments: [user_id])
            print("Post string",postString)
            
            request.httpBody = postString.data(using: .utf8)
            request.addValue("delta141forceSEAL8PARA9MARCOSBRAHMOS", forHTTPHeaderField: "Authorization")
            request.addValue(usertoken, forHTTPHeaderField: "UserAuth")
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
                        
                        SVProgressHUD.dismiss()
                        
                        let userdata = dictionary["user_images"] as! [NSDictionary]
                        
                         for  i in 0..<(userdata.count){
                            
                             let imageurl1 = userdata[i]["thumb_img"] as? String
                            let imageID1 = userdata[i]["id"] as? String
                            print("imageurl::",imageurl1!)
                            print("imageID::",imageID1!)
                            if i == 0
                            {
                                self.id3 = imageID1!

                                let url = URL(string: imageurl1!)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    self.imgView_3.image = UIImage(data: imageData)
                                }
                                

                            }
                            if i == 1{
                                self.id1 = imageID1!

                                let url = URL(string: imageurl1!)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    self.imgView_1.image = UIImage(data: imageData)
                                }
                            }
                            if i == 2{
                                self.id2 = imageID1!
                                let url = URL(string: imageurl1!)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    self.imgView_2.image = UIImage(data: imageData)
                                }
                            }
                            if i == 3{
                                self.id4 = imageID1!

                                let url = URL(string: imageurl1!)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    self.imgView_4.image = UIImage(data: imageData)
                                }
                            }
                            if i == 4{
                                self.id5 = imageID1!
                                let url = URL(string: imageurl1!)
                                let data = try? Data(contentsOf: url!)
                                
                                if let imageData = data {
                                    self.imgView_5.image = UIImage(data: imageData)
                                }
                            }
                        
                            
                            
                        }
                        
                        print(userdata)
                        
                        
                        
                        
                    }
                    else{
                        SVProgressHUD.dismiss()
                        
                        let alert = UIAlertController(title: " PubPulse ", message: message1 as String, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                        SVProgressHUD.dismiss()
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
    
    
    
    
    func logout_webservice(){
        
        
        //                 SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskTypeBlack)
        
        if Reachability2.isConnectedToNetwork() == false
        {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: " PubPulse ", message: "Internet connection FAILED" as String, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        }
            
        else
        {
            
            
            print("Internet connection DONE")
            
            let login = main_url + "logout"
            print(login)
            
            var request = URLRequest(url: URL(string: login)!)
            
            request.httpMethod = "POST"
            //            print("user_id:::",user_id3)
            
            let user_id = UserDefaults.standard.object(forKey: "user_id") as! String
            let usertoken = UserDefaults.standard.object(forKey: "user_token") as! String
            print(user_id)
            print(usertoken)
            
            //            let postString =  String(format: "email=shreya@mxicoders.com&password=mxi123&device_id=123456&user_type=user")
            
            let postString =  String(format: "user_id=%@", arguments: [user_id])
            print("Post string",postString)
            
            request.httpBody = postString.data(using: .utf8)
            
            
            request.addValue("delta141forceSEAL8PARA9MARCOSBRAHMOS", forHTTPHeaderField: "Authorization")
            request.addValue(usertoken, forHTTPHeaderField: "UserAuth")
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
                    //                  let user_id = (dictionary.value(forKey: "user_id"))
                    //self.user_token1 = [user_id as! String]
                    //self.Status = status as! String
                    print(status)
                    
                    DispatchQueue.main.async() {
                        if status == "200"
                        {
                            SVProgressHUD.dismiss()
                            self.view.isUserInteractionEnabled = true
                            UserDefaults.standard.removeObject(forKey: "user_id")
                            
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let destination = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                            self.navigationController?.pushViewController(destination, animated: true)
                            //alert on logout
                                                       
                            
                        }
                            
                            
                        else{
                            
                            let alert = UIAlertController(title: " PubPulse ", message: message1 as String, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                            self.present(alert, animated: true)
                            SVProgressHUD.dismiss()
                        }
                        
                        
                        
                        
                        
                    }
                    
                    DispatchQueue.main.async() {
                        // self.displayMyAlertMessage("Wrong name or password")
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
