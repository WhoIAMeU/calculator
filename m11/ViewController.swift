
import UIKit
import AVFoundation
import AudioToolbox

extension Double {
    var formate : Double {
        Double(String(format: "%3.3f", self)) ?? 0
    }
}

class ViewController: UIViewController {
    var isNewValue = true
    var operation: MathOperation? = nil
    var previousOperation: MathOperation? = nil
    var result: Double? = nil
    var newValue: Double? = nil
    var player: AVAudioPlayer?
    var soundUrl = Sound(.yamete_kudasai)
    
   
    
    @IBAction func onOne(_ sender: CustomButton) { //custom
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
       
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
        AudioServicesPlaySystemSound(1109)
        switch sender.tag {
        case 1: addDigit("1")
        case 2: addDigit("2")
        case 3: addDigit("3")
        case 4: addDigit("4")
        case 5: addDigit("5")
        case 6: addDigit("6")
        case 7: addDigit("7")
        case 8: addDigit("8")
        case 9: addDigit("9")
        case 10: addDigitZero("0")
        default:
            break
        }
    }

    @IBAction func onPlus(_ sender: CustomButton) { //custom
        if result != nil && isNewValue == false{
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(0.6),
                           options: UIView.AnimationOptions.allowUserInteraction,
                           animations:{
                sender.transform = CGAffineTransform.identity
            },
                           completion: {Void in()})  //добавление анимации
//            soundUrl = Sound(.yamete_kudasai)
//            AudioServicesPlaySystemSound(1100)  //добавление звуков
            newValue = getDouble()
            result = operation?.makeOperation(result: result!, newValue: newValue!)
            resultLabel.text = "\(result!.formate)"
            doubleToInt()
            result = getDouble()
            newValue = 0
        }
            result = getDouble()
        
        switch sender.tag {
        case 13: operation = .sum
        case 14: operation = .subtract
        case 15: operation = .multiply
        case 16: if result!.formate == 0{
        }else{
            operation = .divided
        }
        default:
            break
        }
        isNewValue = true
}
    @IBAction func onReset(_ sender: CustomButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
        isNewValue = true
        result = nil
        newValue = nil
        operation = nil
        previousOperation = nil
        resultLabel.text = "0"
    }

    @IBAction func onPlusOrMinus(_ sender: CustomButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
        newValue = getDouble()
        if let minus = resultLabel.text?.contains("-"){
            if minus {
                resultLabel.text?.removeFirst()
            }
        }
        if let minusOrNot = resultLabel.text?.contains(" "){
            if !minusOrNot{
                resultLabel.text = "\(-newValue!)"
            }
        }
        isNewValue = false
    }
    @IBAction func onPercent(_ sender: CustomButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
       percentResult()
    }
    @IBAction func onPoint(_ sender: CustomButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
        addDigitPoint(".")
    }
    func percentResult(){
        if operation != nil && result != nil{
            if operation == MathOperation.sum || operation == MathOperation.subtract {
            newValue = getDouble()
            newValue = (result! / 100) * newValue!
            resultLabel.text = String(newValue!.formate)
            }
            if operation == MathOperation.divided || operation == MathOperation.multiply {
                newValue = getDouble()
                newValue = newValue! / 100
                resultLabel.text = "\(newValue!.formate)"
            }
        } else {
            result = getDouble()
            result = result! / 100
            resultLabel.text = String(result!.formate)
        }
        isNewValue = true
        previousOperation = nil
    }
    
    @IBAction func calculate(_ sender: CustomButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.6),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations:{
            sender.transform = CGAffineTransform.identity
        },
                       completion: {Void in()})
        soundUrl = Sound(.yamete_kudasai)
        calculate()
    }
    
    func doubleToInt(){
        if result!.truncatingRemainder(dividingBy: 2) == 0 {
            if result! < 1{
                resultLabel.text = "\(Int(result!))"
            }
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ConstantStrings.Calculator.title
    }
    
    func addDigit(_ digit: String) {
        if isNewValue {
            resultLabel.text = ""
            isNewValue = false
        }
        if let minus = resultLabel.text?.contains("-0"){
            if minus {
                resultLabel.text?.removeLast()
            }
        }
        var digits = resultLabel.text
        digits?.append(digit)
        resultLabel.text = digits
    }
    
    func addDigitZero(_ digit: String) {
        if isNewValue {
            resultLabel.text = ""
            isNewValue = true
        }
        var digits = resultLabel.text
        digits?.append(digit)
        resultLabel.text = digits
    }
    func addDigitPoint(_ digit: String) {
        if isNewValue {
            resultLabel.text = "0"
            isNewValue = false
        }
        var digits = resultLabel.text
        if let x = digits?.contains(".") {
            if !x {
        digits?.append(digit)
        resultLabel.text = digits
            }
        }
    }
    
    func getDouble() -> Double {
        return Double(resultLabel.text ?? "0") ?? 0
    }
    
    func playSound(url:URL?) {

        do {
            guard let url = url else {return }
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func calculate() {
        guard let operation = operation else {
            return
        }
        if newValue == nil{
            newValue = result
        }
        if previousOperation != operation {
            doubleToInt()
            newValue = getDouble()
        }
        result = operation.makeOperation(result: result!, newValue: newValue!)
        previousOperation = operation
        resultLabel.text = "\(result!.formate)"
        doubleToInt()
        isNewValue = true
}

enum MathOperation {
    case sum, subtract, multiply, divided
    
    func makeOperation(result: Double, newValue: Double) -> Double {
        switch self {
        case .sum:
            return (result.formate + newValue.formate)
        case .subtract:
            return (result.formate - newValue.formate)
        case .multiply:
            return (result.formate * newValue.formate)
        case .divided:
            return (result.formate / newValue.formate)
      }
    }
  }
}

struct Sound {
  
    enum Sounds: String {
    
        case yamete_kudasai
        
        var resource: String {
            "\(self.rawValue).\(type)"
        }
        
        var type: String { "mp3" }
    }
    
    var sound: Sounds
  
    var url: URL {
    
        let path = Bundle.main.path(forResource: sound.resource, ofType: nil)!
        return URL(fileURLWithPath: path)
    }
    init(_ sound: Sounds) {
        self.sound = sound
    }
}

