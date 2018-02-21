//
//  ViewController.swift
//  tutorial20180219
//
//  Created by mac on 2018/02/19.
//  Copyright © 2018年 ttake. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelX:UILabel!
    @IBOutlet var labelStatus:UILabel!

    @IBOutlet var imagePerson:UIImageView!
    @IBOutlet var goalSquare:UIImageView!

    var startX:CGFloat = 0
    var startY:CGFloat = 0
    var isImageInside :Bool? = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Screen Size の取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height

        // 画像を設定
        imagePerson.image = UIImage(named: "ttakemoto1.jpg")
        // 画像のフレームを設定
        //imagePerson.frame = CGRect(x:0, y:0, width:128, height:128)

        // 画像をスクリーン中央に設定
        imagePerson.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        //枠の位置を設定
        goalSquare.center = CGPoint(x:screenWidth/2, y:200)

        // タッチ操作を enable
        imagePerson.isUserInteractionEnabled = true

        self.view.addSubview(imagePerson)

        labelX.text = "画像を上の枠に入れてください"
        labelStatus.text = ""

        // 画面背景を設定
//        self.view.backgroundColor = UIColor(red:0.85,green:1.0,blue:0.95,alpha:1.0)

        //ゴール範囲を枠線で囲う
        self.goalSquare.layer.borderColor = UIColor.black.cgColor
        self.goalSquare.layer.borderWidth = 5

    }

    // 画面にタッチで呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!

        // ドラッグ後の座標
        startX = touchEvent.location(in: self.view).x
        startY = touchEvent.location(in: self.view).y

        //ドラッグされたのは画像か？
        if let r = touchEvent.view {
            isImageInside = r.isKind(of: UIImageView.self) ? true : false
        } else {
            isImageInside = false
        }

    }

    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 画像のみをドラッグ
        if !isImageInside! {
            return
        }

        // タッチイベントを取得
        let touchEvent = touches.first!

        // ドラッグ前の座標,
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y

        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y

        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
        print("x:\(dx)")

        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        print("y:\(dy)")

        // 画像のフレーム
        var viewFrame: CGRect = imagePerson.frame

        // 移動分を反映させる
        viewFrame.origin.x += dx
        viewFrame.origin.y += dy

        imagePerson.frame = viewFrame

        self.view.addSubview(imagePerson)

        // 小数点以下２桁のみ表示
        labelX.text = "画像を上の枠に入れてください"

    }

    //　ドラッグ終了時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended")
        if !isImageInside! {
            return
        }

//        // タッチイベントを取得
//        let touchEvent = touches.first!

        //移動後の画像の座標
        let nowDx = imagePerson.frame.origin.x
        let nowDy = imagePerson.frame.origin.y
        //スクエアの左上座標
        let goalSquareX = goalSquare.frame.origin.x
        let goalSquareY = goalSquare.frame.origin.y
        //スクエアの辺の長さ
        let goalSquareWidth = goalSquare.frame.size.width
        let goalSquareHeight = goalSquare.frame.size.height
        //画像の辺の長さ
        let imagePersonWidth = imagePerson.frame.size.width
        let imagePersonHeight = imagePerson.frame.size.height

        //移動後の正否出力
        if(goalSquareX < nowDx
            && goalSquareX + (goalSquareWidth - imagePersonWidth) > nowDx
            && goalSquareY < nowDy
            && goalSquareY + goalSquareHeight - imagePersonHeight > nowDy
            ) {
            //ポップアップ画面表示
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            let popupView: PopupViewController = storyBoard.instantiateViewController(withIdentifier: "popupView") as! PopupViewController
            popupView.modalPresentationStyle = .overFullScreen
            popupView.modalTransitionStyle = .crossDissolve
            
            self.present(popupView, animated: false, completion: nil)

        } else {
            labelStatus.text = "画像を枠内におさめてください！！"

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

