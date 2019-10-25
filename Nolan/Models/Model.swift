
import UIKit
//model
class Model: NSObject {
    
    var images : [UIImage] = []
    
    //Como a collection view é orientada a imagens, a funcao buildDataSource lê as imagens presentes no XCassets e joga para dentro de um array
    func buildDataSource(){
        //images = (1...7).map { UIImage(named: "image\($0)")! }
        for i in  1...12 {
            images.append(UIImage(named: "image\(i)")!)
        }
    }
    
}
