//
//  ChatRoomViewController-Trevor.swift
//  RandomChat
//
//  Created by Trevor on 7/6/18.
//  Copyright © 2018 toantt. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatRoomViewControllerTrevor: JSQMessagesViewController {
    
    let defaults = UserDefaults.standard
    
    var messages = [JSQMessage]()
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // set up messages
        let roomId = defaults.string(forKey: "roomId")
        Constants.refs.databaseRoom.child(roomId!).observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let roomName = value?["roomName"] as? String
            self.navigationItem.title = roomName
        })
        
        let user = Auth.auth().currentUser!
        
        let userID = user.uid
        
        senderId = userID
        senderDisplayName = "userName"
        
        Constants.refs.databaseUser.child(userID).observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let currentUserName = value?["name"] as? String
            
            let changeRequest = user.createProfileChangeRequest()
            
            changeRequest.displayName = currentUserName
            changeRequest.commitChanges { (error) in
                print(error?.localizedDescription as Any)
            }
            
            self.senderDisplayName = currentUserName
        }) { (error) in
            print(error.localizedDescription)
        }
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        let query = Constants.refs.databaseRoom.child(roomId!).child("messages").queryLimited(toLast: 10)
        
        _ = query.observe(.childAdded, with: {[weak self] snapshot in
            if let data = snapshot.value as? [String : String], let id = data["sender_id"], let name = data["name"], let text = data["text"], !text.isEmpty {
                if let message = JSQMessage(senderId: id, displayName: name, text: text) {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let roomId = defaults.string(forKey: "roomId")
        
        let ref = Constants.refs.databaseRoom.child(roomId!).child("messages").childByAutoId()
        
        let message = ["sender_id" : senderId, "name" : senderDisplayName, "text" : text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let currentUserId = Auth.auth().currentUser?.uid
        let roomId = defaults.string(forKey: "roomId")
        var myRoomsId = defaults.array(forKey: "myRoomsId") as! [String]
        
        if let i = myRoomsId.index(of: roomId!) {
            myRoomsId.remove(at: i)
            defaults.set(myRoomsId, forKey: "myRoomsId")
        }
        
        Constants.refs.databaseRoom.child(roomId!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var roomUsers = value?["users"] as? [String]
            var numOfUsers = Int(value?["numOfUsers"] as? String ?? "0")!
            
            if let i = roomUsers?.index(of: currentUserId!) {
                roomUsers?.remove(at: i)
                numOfUsers = (roomUsers?.count)!
                
                Constants.refs.databaseRoom.child(roomId!).updateChildValues(["users" : roomUsers!])
                Constants.refs.databaseRoom.child(roomId!).updateChildValues(["numOfUsers" : "\(numOfUsers)"])
            }
        })
        
        defaults.set("", forKey: "roomId")
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
