//
//  PopupViewController.swift
//  tutorial20180219
//
//  Created by mac on 2018/02/20.
//  Copyright © 2018年 ttake. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var imagePerson: UIImageView!
    
    @IBOutlet weak var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePerson.image = UIImage(named: "ttakemoto2.jpg")
        name.text = "竹本晃理"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    // 閉じるボタンがタップされた時
//    @IBAction func onTapCancel(_ sender: UIButton) {
//        self.dismiss(animated: false, completion: nil)
//    }
    
    // ポップアップの外側をタップした時にポップアップを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var tapLocation: CGPoint = CGPoint()
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        
        let popUpView: UIView = self.view.viewWithTag(1)! as UIView
        
        if !popUpView.frame.contains(tapLocation) {
            self.dismiss(animated: false, completion: nil)
        }
    }


}
