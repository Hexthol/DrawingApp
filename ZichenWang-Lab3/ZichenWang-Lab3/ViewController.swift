//
//  ViewController.swift
//  ZichenWang-Lab3
//
//  Created by 王梓辰 on 6/30/20.
//  Copyright © 2020 Zichen Wang. All rights reserved.
//

import UIKit

/*
 This extension which converts a UIView to a UIImage credits to
 the answer with the hights vote from
 https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
 */
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


class ViewController: UIViewController {
    
    var currentLine:Line?
    var lineCanvas:LineView!
    //The essential array to store what the user draws so as to achieve the redo function
    var backup:[Line] = []
    
    //the height of both five bottons above and color buttons below to avoid hard-coding
    let aboveElementsHeight = CGFloat(132)
    let belowButtonsHeight = CGFloat(100)
    
    var currColor = UIColor.black
    var currThickness = CGFloat(10)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let frame = CGRect(x: 0, y: aboveElementsHeight, width: view.frame.width, height: view.frame.height-aboveElementsHeight-belowButtonsHeight)
        lineCanvas = LineView(frame: frame)
        view.addSubview(lineCanvas)
    }
    
    //Creative Portion 1: Save what the user draws to an image
    @IBAction func saveImage(_ sender: Any) {
        let image = lineCanvas.asImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    //clear function
    @IBAction func clearCanvas(_ sender: Any) {
        lineCanvas.lines = []
        lineCanvas.theLine = nil
    }
    
    //change the size thickness of pen
    @IBAction func changeThickness(_ sender: UISlider) {
        currThickness = CGFloat(sender.value)
    }
    
    //Undo function
    @IBAction func undo(_ sender: Any) {
        lineCanvas.theLine = nil
        if lineCanvas.lines.count >= 1 {
            backup.append(lineCanvas.lines[lineCanvas.lines.count-1])
            lineCanvas.lines.remove(at: lineCanvas.lines.count-1)
        }
    }
    
    //Creative Portion 2: Redo function as opposed to undo function
    @IBAction func redo(_ sender: Any) {
        if backup.count >= 1 {
            lineCanvas.lines.append(backup[backup.count-1])
            backup.remove(at: backup.count-1)
        }
    }
    
    //Color buttons to change the color of pen
    @IBAction func redColor(_ sender: Any) {
        currColor = .red
    }
    
    @IBAction func orangeColor(_ sender: Any) {
        currColor = .orange
    }
    
    @IBAction func yellowColor(_ sender: Any) {
        currColor = .yellow
    }
    
    @IBAction func greenColor(_ sender: Any) {
        currColor = .green
    }
    
    @IBAction func blueColor(_ sender: Any) {
        currColor = .blue
    }
    
    @IBAction func purpleColor(_ sender: Any) {
        currColor = .purple
    }
    
    @IBAction func blackColor(_ sender: Any) {
        currColor = .black
    }
    
    //Touch function trilogy
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        currentLine = Line(color: currColor, thickness: currThickness, points: [CGPoint(x: touchPoint.x, y: touchPoint.y-aboveElementsHeight)])
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: view) else { return }
        currentLine?.points.append(CGPoint(x: touchPoint.x, y: touchPoint.y-aboveElementsHeight))
        lineCanvas.theLine = currentLine
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let newLine = currentLine {
            lineCanvas.lines.append(newLine)
        }
        currentLine = nil
    }
    

}

