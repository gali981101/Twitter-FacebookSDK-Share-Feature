//
//  FeedTableViewController.swift
//  Twitter-FacebookSDK
//
//  Created by Terry Jason on 2024/1/1.
//

import UIKit
import FacebookShare
import TwitterKit

class FeedTableViewController: UITableViewController {
    
    var girlNames: [String] = ["Girl-1", "Girl-2", "Girl-3", "Girl-4", "Girl-5", "Girl-6", "Girl-7", "Girl-8", "Girl-9", "Girl-10", "Girl-11", "Girl-12", "Girl-13", "Girl-14", "Girl-15", "Girl-16", "Girl-17", "Girl-18", "Girl-19", "Girl-20", "Girl-21", "Girl-22"]
    
    var girlImages: [String] = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8", "img9", "img10", "img11", "img12", "img13", "img14", "img15", "img16", "img17", "img18", "img19", "img20", "img21", "img22"]
    
    var arrIndexPath: [IndexPath] = []
    
}

// MARK: - Life cycle

extension FeedTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - UITableViewDataSource

extension FeedTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girlNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        cell.girlImageView.image = UIImage(named: girlImages[indexPath.row])
        cell.nameLabel.text = girlNames[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension FeedTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !(arrIndexPath.contains(indexPath)) else { return }
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 200, 0)
        
        cell.alpha = 0
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 1.0, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        })
        
        arrIndexPath.append(indexPath)
    }
    
}

// MARK: - Action Methods

extension FeedTableViewController {
    
    @IBAction func share(_ sender: AnyObject) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: buttonPosition) else { return }
        
        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
        
        let facebookAction = UIAlertAction(title: "Facebook", style: .default) { _ in
            self.fbActionHandle(i: indexPath)
        }
        
        let twitterAction = UIAlertAction(title: "Twitter", style: .default) { _ in
            self.twitterActionHandle(i: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(twitterAction)
        
        shareMenu.addAction(cancelAction)
        
        self.present(shareMenu, animated: true)
        
    }
    
}

// MARK: - Action Handler

extension FeedTableViewController {
    
    private func fbActionHandle(i: IndexPath) {
        let selectedImageName = self.girlImages[i.row]
        
        guard let selectedImage = UIImage(named: selectedImageName) else { return }
        
        let content = SharePhotoContent()
        let photo = SharePhoto(image: selectedImage, userGenerated: false)
        
        content.photos = [photo]
        
        let shareDialog = ShareDialog(fromViewController: self, content: content, delegate: nil)
        shareDialog.show()
    }
    
    private func twitterActionHandle(i: IndexPath) {
        let selectedImageName = self.girlImages[i.row]
        
        guard let selectedImage = UIImage(named: selectedImageName) else { return }
        
        let composer = TWTRComposer()
        
        composer.setText("Like this girl!")
        composer.setImage(selectedImage)
        
        composer.show(from: self) { $0 == .done ? print("Successfully composed Tweet") : print("Cancelled composing") }
    }
    
}
