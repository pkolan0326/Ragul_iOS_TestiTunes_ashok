//
//  HomeVC.swift
//  TestiTunes
//
//  Created by Ragul kts on 17/04/20.
//  Copyright © 2020 Ragul kts. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tblView = UITableView()
    var activity = UIActivityIndicatorView()
    var tblData = [Album]()
    let isDelegate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        addControls()
        self.title = "Top 100 Albums"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTopAlbums()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func addControls() {
        tblView.frame = self.view.bounds;
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = 65
        self.view.addSubview(tblView)
        tblView.backgroundColor = UIColor.white
        
        // Adding activity indicator
        activity.style = .medium
        activity.color = UIColor.appTheme()
        let barItem = UIBarButtonItem.init(customView: activity)
        self.navigationItem.setRightBarButton(barItem, animated: true)
        activity.startAnimating()
    }
    
    
    //MARK:- Tableview data methods
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          return tblData.count
      }
      
      
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MyTestCell")
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let obj = tblData[indexPath.row]
        
        var iconImageView : UIImageView?
        var nameLbl : UILabel?
        var artist : UILabel?
        var artistLbl : UILabel?
        var x = CGFloat(5.0)
        var y = CGFloat(5.0)
        
        if let img = cell.contentView.viewWithTag(1001) as? UIImageView {
            iconImageView = img
            x = img.frame.maxX + CGFloat(5.0)
        }
        else {
            let img = UIImageView.init(frame: CGRect(x: x, y: y, width: 60 , height: 60))
            cell.contentView.addSubview(img)
            img.contentMode = .scaleAspectFit
            img.tag = 1001
            iconImageView = img
            x = img.frame.maxX + CGFloat(5.0)
        }
        
        if let lbl = cell.contentView.viewWithTag(1002) as? UILabel {
            nameLbl = lbl
        }
        else {
            let lbl = UILabel.init(frame: CGRect(x: x, y: y, width: (tableView.frame.width - x - 10)  , height: 20))
            lbl.accessibilityIdentifier = "Name of the Ablum"
            cell.contentView.addSubview(lbl)
            lbl.tag = 1002
            lbl.font = UIFont.boldSystemFont(ofSize: 11)
            nameLbl = lbl
            y = (lbl.frame.maxY) + CGFloat(5.0)
        }
        
        if let lbl = cell.contentView.viewWithTag(1003) as? UILabel {
            artist = lbl
        }
        else {
            let lbl = UILabel.init(frame: CGRect(x: x, y: y, width: 35  , height: 15))
            cell.contentView.addSubview(lbl)
            lbl.accessibilityIdentifier = "Name of the Artist"
            lbl.text = "Artist : "
            lbl.font = UIFont.systemFont(ofSize: 9)
            lbl.tag = 1003
            artist = lbl
             x = (lbl.frame.maxX) + CGFloat(5.0)
        }
        
        if let lbl = cell.contentView.viewWithTag(1004) as? UILabel {
            artistLbl = lbl
        }
        else {
           
            let lbl = UILabel.init(frame: CGRect(x: x, y: y, width: 130  , height: 15))
            cell.contentView.addSubview(lbl)
            lbl.font = UIFont.boldSystemFont(ofSize: 9)
            lbl.tag = 1004
            artistLbl = lbl
        }
        nameLbl?.text = obj.name//obj ["name"] as? String ?? ""
        artistLbl?.text = obj.artistName//obj ["artistName"] as? String ?? ""
        let albumID = obj.albumID//obj["id"] as? String ?? "abc"
//        if let imgURL = obj["artworkUrl100"] as? String, let url = URL.init(string: imgURL) {
//            iconImageView?.downloadImage(from: url, UIImage.init(named: "audio"), albumID)
//        }
        if  let url = URL.init(string: obj.artworkUrl100!) {
            iconImageView?.downloadImage(from: url, UIImage.init(named: "audio"), albumID!)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //AlbumDetailsVC
        let vc = AlbumDetailsVC()
        vc.selectedAlbum = self.tblData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
     
    //MARK:- API CALL Related
    func getTopAlbums()
    {
        DispatchQueue.main.async {
            self.activity.startAnimating()
        }
        let apiObj = APICall.instance

        apiObj.performAPIcallWith(type: ITunesAlbum.self, url: .getTop100, method: .get, param: [:]) { [weak self](success, error) in
            guard let wSelf = self else {
                return
            }
            DispatchQueue.main.async {
                wSelf.activity.stopAnimating()
            }
            if error == nil,let Albums = success?.feed?.results {
                
                wSelf.tblData = Albums
                DispatchQueue.main.async {
                    wSelf.tblView.reloadData()
                }
            }else{
                print(error ?? "")
            }
        }
    }
    

    
    //MARK:- Image Downloader Related
   
    
}
extension UIImageView {
    func downloadImage(from url: URL, _ placeHolder: UIImage?, _ albumId: String) {
        //Assigning place holder image
        if let placeHolderIcon = placeHolder {
            self.image = placeHolderIcon
        }
        else {
            self.image = UIImage.init(named: "audio")
        }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
}

//class Album : NSObject {
//    var name = ""
//    var artistName = ""
//    var artworkUrl100 = ""
//    var albumID = ""
//    var genres = ""
//    var copyright = ""
//    var releaseDate = ""
//    var artistUrl = ""
//    class func initAlbum(_ dict: [String : Any]) -> Album {
//        let obj = Album()
//        obj.name = dict ["name"] as? String ?? ""
//        obj.artistName = dict ["artistName"] as? String ?? ""
//        obj.artworkUrl100 = dict ["artworkUrl100"] as? String ?? ""
//        obj.albumID = dict ["id"] as? String ?? "123"
//        if let geners = dict["genres"] as? [[String : Any]]
//        {
//            if let genNames = geners.map({$0["name"]}) as? [String] {
//                let info = genNames.joined(separator: ", ")
//                obj.genres = info
//            }
//        }
//        obj.copyright = dict ["copyright"] as? String ?? ""
//        obj.releaseDate = dict ["releaseDate"] as? String ?? ""
//        obj.artistUrl = dict ["artistUrl"] as? String ?? ""
//        return obj
//    }
//
//}
