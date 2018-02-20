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
    @IBOutlet var labelY:UILabel!
    @IBOutlet var labelStatus:UILabel!
    @IBOutlet weak var dropPoint: UILabel!
    @IBOutlet weak var widthDiff: UILabel!
    
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
        
        // ハンドバッグの画像を設定
        imagePerson.image = UIImage(named: "Image")
        // 画像のフレームを設定
        imagePerson.frame = CGRect(x:0, y:0, width:128, height:128)
        
        // 画像をスクリーン中央に設定
        imagePerson.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        goalSquare.center = CGPoint(x:screenWidth/2, y:150)

        // タッチ操作を enable
        imagePerson.isUserInteractionEnabled = true
        
        self.view.addSubview(imagePerson)
        
        // 小数点以下２桁のみ表示
        labelX.text = "x: ".appendingFormat("%.2f", screenWidth/2)
        labelY.text = "y: ".appendingFormat("%.2f", screenHeight/2)
        labelStatus.text = "NO MOVED."
        
        // 画面背景を設定
        self.view.backgroundColor = UIColor(red:0.85,green:1.0,blue:0.95,alpha:1.0)
        
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
        print("touchesBegan")
        
    }
    
    //　ドラッグ時に呼ばれる
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 画像のみをドラッグ
        if !isImageInside! {
            return
        }
        
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        // ドラッグ前の座標, Swift 1.2 から
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
        labelX.text = "x: ".appendingFormat("%.2f", newDx)
        labelY.text = "y: ".appendingFormat("%.2f", newDy)
        labelStatus.text = "Moving..."
    }

    //　ドラッグ終了時に呼ばれる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended")
        if !isImageInside! {
            return
        }
        
//        // タッチイベントを取得
//        let touchEvent = touches.first!

        // ドラッグ後の4座標
//        let nowDx = touchEvent.location(in: self.view).x
//        let nowDy = touchEvent.location(in: self.view).y
//        let nowRightDx = nowDx + imagePerson.frame.size.width
//        let nowBottomDy = nowDy + imagePerson.frame.size.height
        
        //
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
            labelX.text = "x: ".appendingFormat("%.2f", nowDx)
            labelY.text = "y: ".appendingFormat("%.2f", nowDy)
            labelStatus.text = "Success!"

        } else {
            labelX.text = "x: ".appendingFormat("%.2f", nowDx)
            labelY.text = "y: ".appendingFormat("%.2f", nowDy)
            labelStatus.text = "Wrong!"

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

