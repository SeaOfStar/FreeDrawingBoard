//
//  DrawableView.swift
//  MyDrawView
//
//  Created by 吴向东 on 15/11/28.
//  Copyright © 2015年 MIBD. All rights reserved.
//

import UIKit

protocol DrawableViewDelegate: NSObjectProtocol {
    func drawableView(view: DrawableView, didFinishedPanAction pan:UIPanGestureRecognizer)
}


class DrawableView: UIView {

    let defaultLineWidth:CGFloat = 8.0
    let defaultLineColor:UIColor = UIColor.orangeColor()

    var showShadow: Bool = false

    weak var delegate: DrawableViewDelegate?

    var allLineLayers: [CAShapeLayer] = []

    var pan = UIPanGestureRecognizer()

    var lineLayer: CAShapeLayer?

    private func moveToPoint(point: CGPoint) {
        let aNewLineLayer = CAShapeLayer()
        aNewLineLayer.frame = self.bounds
        layer.addSublayer(aNewLineLayer)

        aNewLineLayer.backgroundColor = UIColor.clearColor().CGColor
        aNewLineLayer.fillColor = UIColor.clearColor().CGColor
        aNewLineLayer.strokeColor = lineColor.CGColor

        aNewLineLayer.lineWidth = self.lineWidth
        aNewLineLayer.lineCap = "round"
        aNewLineLayer.lineJoin = "round"

        if showShadow {
            aNewLineLayer.shadowColor = UIColor.blackColor().CGColor
            aNewLineLayer.shadowOffset = CGSize(width: 1.0, height: 5.0)
            aNewLineLayer.shadowOpacity = 0.75
            aNewLineLayer.shadowRadius = 3.0
        }

        let path = UIBezierPath()
        path.moveToPoint(point)
        aNewLineLayer.path = path.CGPath

        self.lineLayer = aNewLineLayer
        self.allLineLayers.append(aNewLineLayer)
    }

    private func addPointToLine(point: CGPoint) {
        let path = UIBezierPath(CGPath: lineLayer!.path!)
        path.addLineToPoint(point)
        lineLayer!.path = path.CGPath
    }

    func clearAllLine() {
        for subLayer in allLineLayers {
            subLayer.removeFromSuperlayer()
        }
        allLineLayers = []

        lineLayer = nil
    }

    func clearLastLine() {
        if let last = allLineLayers.last {
            last.removeFromSuperlayer()
            allLineLayers.removeLast()
        }

        lineLayer = nil
    }

    init() {
        self.lineColor = defaultLineColor
        self.lineWidth = defaultLineWidth

        super.init(frame: CGRectZero)
//        self.layer.backgroundColor = UIColor.clearColor().CGColor
        // 添加拖动手势
        addPanGestureRecognizer()

    }

    required init?(coder aDecoder: NSCoder) {
        self.lineColor = defaultLineColor
        self.lineWidth = defaultLineWidth
        super.init(coder: aDecoder)
//        layer.backgroundColor = UIColor.clearColor().CGColor

        addPanGestureRecognizer()
    }

    required override init(frame: CGRect) {
        self.lineColor = defaultLineColor
        self.lineWidth = defaultLineWidth
        super.init(frame: frame)
//        layer.backgroundColor = UIColor.clearColor().CGColor

        addPanGestureRecognizer()
    }

    func panAction(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .Began:
            moveToPoint(pan.locationInView(self))

        case .Changed:
            addPointToLine(pan.locationInView(self))

        case .Ended:
            addPointToLine(pan.locationInView(self))
            delegate?.drawableView(self, didFinishedPanAction: pan)

        default:
            break
        }
    }

    private func addPanGestureRecognizer() {
        pan.addTarget(self, action: Selector("panAction:"))
        self.addGestureRecognizer(pan)
    }

    var lineWidth: CGFloat
    var lineColor: UIColor
}
