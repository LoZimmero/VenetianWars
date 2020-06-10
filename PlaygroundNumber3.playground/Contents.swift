//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import AVFoundation

let fontUrl = Bundle.main.url(forResource: "myFont", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontUrl! as CFURL, CTFontManagerScope.process, nil)
let font = UIFont(name: "PressStart2P-Regular", size: 30)
let fontSubtitle = UIFont(name: "PressStart2P-Regular", size: 12)


/**
 Songs
 */
var player: AVAudioPlayer?

func playSoundVictory() {
    guard let url = Bundle.main.url(forResource: "victory", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}

func playSoundDefeat() {
    guard let url = Bundle.main.url(forResource: "defeat", withExtension: "mp3") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}


/**
 VenetiansWinViewController
    This view controller appears if venetians win
        It shoud be created if the user
 */
class VenetiansWinViewController : UIViewController {
    
    var backgroundImageView: UIImageView!
    var leonardoImageView : UIImageView!
    var potImageView : UIImageView!
    var tableImageView : UIImageView!
    var spritzImageView : UIImageView!
    var twoVenetiansImageView : UIImageView!
    var threeVenetiansImageView: UIImageView!
    var sunImageView : UIImageView!
    var venetiansWinLabel : UILabel!
    var joinPartyWinLabel : UILabel!
    
    
    override func loadView() {
        let view = UIView (frame: CGRect(x: 0, y: 0, width: 667.0, height: 375.0))
        
        //Background
        backgroundImageView = UIImageView(image: UIImage(named: "cityBackground"))
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 667.0, height: 375.0)
        backgroundImageView.center = view.center
        
        //Leonardo
        leonardoImageView = UIImageView(image: UIImage(named: "leonardo"))
        leonardoImageView.frame = CGRect(x: 270, y: 250, width: 100, height: 100)
        
        //2 Venetians
        twoVenetiansImageView = UIImageView(image: UIImage(named: "twoVenetians"))
        twoVenetiansImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        
        //2 Venetians
        threeVenetiansImageView = UIImageView(image: UIImage(named: "threeVenetians"))
        threeVenetiansImageView.frame = CGRect(x: -400, y: 0, width: 667, height: 375)
        
        // Table
        tableImageView = UIImageView(image: UIImage(named: "tableGood"))
        tableImageView.frame = CGRect(x: 220, y: 290, width: 140, height: 70)
        
        // Spritz
        spritzImageView = UIImageView(image: UIImage(named: "SpritzGood"))
        spritzImageView.frame = CGRect(x: 230, y: 270, width: 47, height: 47)
        
        // Venetians Win Label
        venetiansWinLabel = UILabel(frame: CGRect(x: view.center.x - 430 / 2, y: view.center.y - 120, width: 430, height: 100))
        venetiansWinLabel.text = "VENETIANS WIN!"
        venetiansWinLabel.font = font
        venetiansWinLabel.textColor = .white
        
        // Join party Label
        joinPartyWinLabel = UILabel(frame: CGRect(x: view.center.x - 550 / 2, y: view.center.y - 50, width: 550, height: 100))
        joinPartyWinLabel.text = "Let's party with them for their independence!"
        joinPartyWinLabel.font = fontSubtitle
        joinPartyWinLabel.textAlignment = .center
        joinPartyWinLabel.textColor = .white
        
        // Sun
        sunImageView = UIImageView(image: UIImage(named: "sun1"))
        sunImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        sunImageView.center = CGPoint(x: spritzImageView.center.x, y: spritzImageView.center.y)
        sunImageView.alpha = 0.2

        view.addSubview(backgroundImageView)
        view.addSubview(sunImageView)
        view.addSubview(leonardoImageView)
        view.addSubview(twoVenetiansImageView)
        view.addSubview(threeVenetiansImageView)
        view.addSubview(tableImageView)
        view.addSubview(spritzImageView)
        view.addSubview(venetiansWinLabel)
        view.addSubview(joinPartyWinLabel)
        view.addSubview(sunImageView)

        
        self.view = view
    }
    
    //Animations
    func winTextAnimation() {
        UIView.animate(withDuration: 3.0, delay: 3.0, options: [.repeat, .autoreverse], animations: {
            self.venetiansWinLabel.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
            self.joinPartyWinLabel.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
        })
    }
    
    func sunAnimation() {
        UIView.animate(withDuration: 1, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.sunImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    func twoVenetiansAnimation() {
        UIView.animate(withDuration: 1, delay: 1, options: [.autoreverse, .curveLinear, .repeat], animations: {
            let twoVenetianAnimation = CGAffineTransform(translationX: -20, y: 0)
            self.twoVenetiansImageView.transform = twoVenetianAnimation
        }, completion: nil)
    }
    
    func threeVenetiansAnimation() {
        UIView.animate(withDuration: 1, delay: 1, options: [.autoreverse, .curveLinear, .repeat], animations: {
            self.threeVenetiansImageView.transform = CGAffineTransform(translationX: 20, y: 0)
        }, completion: nil)
    }
    
    
    // View lifecycle views
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Start animations
        threeVenetiansAnimation()
        twoVenetiansAnimation()
        winTextAnimation()
        sunAnimation()
        playSoundVictory()
    }
    
}




/**
 VenetiansLostViewController
 This view controller appears if venetians loose
 */

class VenetiansLostViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var austriansImageView : UIImageView!
    var venetiansLostLabel: UILabel!
    var lostMessageLabel : UILabel!


    override func loadView() {
        let view = UIView (frame: CGRect(x: 0, y: 0, width: 667.0, height: 375.0))

        //Background
        backgroundImageView = UIImageView(image: UIImage(named: "Defeat"))
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 667.0, height: 375.0)
        backgroundImageView.center = view.center
        
        // Austriacs
        austriansImageView = UIImageView(image: UIImage(named: "austrians1"))
        austriansImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        austriansImageView.center = CGPoint(x: view.center.x + 130, y: view.center.y - 30)
        
        // Lost label
        venetiansLostLabel = UILabel(frame: CGRect(x: view.center.x - 430 / 2, y: view.center.y - 120, width: 460, height: 100))
        venetiansLostLabel.text = "VENETIANS LOST!"
        venetiansLostLabel.font = font
        venetiansLostLabel.textColor = .white
        
        //TODO: Fix subtitle position!
        let lostMessageLabelWidth = CGFloat(350)
        lostMessageLabel = UILabel(frame: CGRect(x: view.center.x - lostMessageLabelWidth / 2, y: view.center.y - 50, width: lostMessageLabelWidth, height: 100))
        lostMessageLabel.textAlignment = .center
        lostMessageLabel.text = "Let's take a REVENGE!"
        lostMessageLabel.numberOfLines = 0
        lostMessageLabel.font = fontSubtitle
        lostMessageLabel.textColor = .white
        
        
        view.addSubview(backgroundImageView)
        view.addSubview(austriansImageView)
        view.addSubview(venetiansLostLabel)
        view.addSubview(lostMessageLabel)
        
        self.view = view
    }
    
    //Animations
    
    
    // View lifecycle view
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Start animation
        threeVenetiansAnimation()
        playSoundDefeat()
    }
    
    func lostTextAnimation() {
        UIView.animate(withDuration: 3.0, delay: 3.0, options: [.repeat, .autoreverse], animations: {
            self.venetiansLostLabel.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
            self.lostMessageLabel.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
        })
    }
    
    func threeVenetiansAnimation() {
        UIView.animate(withDuration: 1, delay: 1, options: [.autoreverse, .curveLinear, .repeat], animations: {
            self.austriansImageView.transform = CGAffineTransform(translationX: 3, y: 7)
        }, completion: nil)
    }
}


/**
 USE THE RIGHT CONTROLLER FOR THE SCENE THAT YOU WANT TO SEE
 */

// Present the view controller in the Live View window
//MARK: - Select the one you want to see
PlaygroundPage.current.liveView = VenetiansWinViewController().view
//PlaygroundPage.current.liveView = VenetiansLostViewController().view
