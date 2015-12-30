//
//  ViewController.swift
//  MyDrawView
//
//  Created by 吴向东 on 15/11/28.
//  Copyright © 2015年 MIBD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum ColorTag: Int {
        case 绿tag = 101
        case 红tag, 蓝tag, 灰tag
    }

    enum 粗细Tag: Int {
        case 粗 = 201
        case 中, 细
    }

    var drawView: DrawableView {
        return self.view as! DrawableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        drawView.lineWidth = 15.0
        drawView.lineColor = UIColor.greenColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func colorSetAction(sender: AnyObject) {
        let button = sender as! UIButton
        switch button.tag {
        case ColorTag.绿tag.rawValue:
            drawView.lineColor = UIColor.greenColor()

        case ColorTag.红tag.rawValue:
            drawView.lineColor = UIColor.redColor()

        case ColorTag.蓝tag.rawValue:
            drawView.lineColor = UIColor.blueColor()

        case ColorTag.灰tag.rawValue:
            drawView.lineColor = UIColor.grayColor()

        default:
            break
        }
    }

    @IBAction func sizeSetAction(sender: AnyObject) {
        let button = sender as! UIButton
        switch button.tag {
        case 粗细Tag.粗.rawValue:
            drawView.lineWidth = 15.0

        case 粗细Tag.中.rawValue:
            drawView.lineWidth = 10.0

        case 粗细Tag.细.rawValue:
            drawView.lineWidth = 5.0

        default:
            break
        }

    }


    @IBAction func clearLastLine(sender: AnyObject) {
        drawView.clearLastLine()
    }

    @IBAction func clearAllLine(sender: AnyObject) {
        drawView.clearAllLine()
    }

    @IBAction func showShadowAction(sender: AnyObject) {
        drawView.showShadow = true
    }

    @IBAction func hideShadowAction(sender: AnyObject) {
        drawView.showShadow = false
    }


}

