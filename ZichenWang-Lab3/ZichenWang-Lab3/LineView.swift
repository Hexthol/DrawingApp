//
//  LineView.swift
//  ZichenWang-Lab3
//
//  Created by 王梓辰 on 6/30/20.
//  Copyright © 2020 Zichen Wang. All rights reserved.
//

import UIKit

//LineView with a structure similar to CircleView in the demo video
class LineView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var theLine:Line?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var lines:[Line] = []{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        for line in lines {
            drawLine(line)
        }
        
        if theLine != nil {
            drawLine(theLine!)
        }
    }
    
    func drawLine(_ line:Line){
        let path = createQuadPath(points: line.points)
        if(line.points.count == 1){
            //if the user merely touch the screen, the app will draw a dot on Canvas
            let dot: CGPoint = line.points[0]
            path.addArc(withCenter: dot, radius: line.thickness*0.5, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
            line.color.setFill()
            path.fill()
        }
        else{
            //otherwise, draw a line
            path.lineWidth = line.thickness
            line.color.setStroke()
            path.stroke()
        }
    }
    
    //Code from Course web page
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        return CGPoint(x: (first.x+second.x)/2.0, y: (first.y+second.y)/2.0)
        
    }
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath() //Create the path object
        if(points.count < 2){
            //There are no points to add to this path
            return path
        }
        path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
            let firstMidpoint = midpoint(first: path.currentPoint, second: points[i]) //Get midpoint between the path's last point and the next one in the array
            let secondMidpoint = midpoint(first: points[i], second: points[i+1]) //Get midpoint between the next point in the array and the one after it
            path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint, controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
        }
        return path
    }
}
