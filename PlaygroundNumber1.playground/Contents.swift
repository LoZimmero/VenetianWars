import UIKit
import PlaygroundSupport
import AVFoundation

/**
 Fonts for labels
 */

let fontUrl = Bundle.main.url(forResource: "myFont", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontUrl! as CFURL, CTFontManagerScope.process, nil)
let font = UIFont(name: "PressStart2P-Regular", size: 13)

let fontUrl2 = Bundle.main.url(forResource: "myFont", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontUrl2! as CFURL, CTFontManagerScope.process, nil)
let font2 = UIFont(name: "PressStart2P-Regular", size: 25)


/**
 Songs
 */
var player: AVAudioPlayer?

func playSoundStart() {
    guard let url = Bundle.main.url(forResource: "startTheme", withExtension: "mp3") else { return }

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

func playSoundBattle() {
    guard let url = Bundle.main.url(forResource: "battle", withExtension: "mp3") else { return }

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
 Start view controller - start the story
 */
class StartViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var leonardoImageView : UIImageView!
    var potImageView : UIImageView!
    var crowdImageview : UIImageView!
    var startButton: UIButton!
    var labelstart: UILabel!
    
    override func loadView() {
        
        // View
        let view = UIView (frame: CGRect(x: 0, y: 0, width: 667.0, height: 375.0))
        view.backgroundColor = UIColor(red: (210/255), green: (247/255), blue: (253/255), alpha: 1.0)
        
        // Title
        labelstart = UILabel(frame: CGRect(x: 125, y: 20, width: 500, height: 100))
        labelstart.alpha = 0
        labelstart.text = "SPRITZ CHRONICLES"
        labelstart.font = font2
        view.addSubview(labelstart)
        
        
        // Background
        backgroundImageView = UIImageView(image: UIImage(named: "montagnefighe"))
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        backgroundImageView.center = view.center

        // Start button
        let startImage = UIImage(named: "startButton")
        startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
        startButton.setImage(startImage, for: UIControl.State.normal)
        startButton.center = view.center
        let startTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startStory(recognizer:)))
        
        startButton.addGestureRecognizer(startTapRecognizer)
        
        // Leonardo
        leonardoImageView = UIImageView(image: UIImage(named: "leonardo"))
        leonardoImageView.frame = CGRect(x: 555, y: 265, width: 100, height: 100)
        
        // Pot
        potImageView = UIImageView(image: UIImage(named: "potGood"))
        potImageView.frame = CGRect(x: 544, y: 307, width: 70, height: 70)
        
        // Crowd
        let crowdImage = UIImage(named: "crowd")
        crowdImageview = UIImageView(image: crowdImage)
        crowdImageview.frame = CGRect(x: -200, y: 0, width: 667, height: 375)
        

        view.addSubview(backgroundImageView)
        view.addSubview(leonardoImageView)
        view.addSubview(potImageView)
        view.addSubview(crowdImageview)
        view.addSubview(startButton)
        
        self.view = view
        
    }
    
    @objc func startStory(recognizer : UITapGestureRecognizer) {
        let firstChapterViewController = FirstChapterViewController()
        firstChapterViewController.modalPresentationStyle = .fullScreen
        firstChapterViewController.modalTransitionStyle = .partialCurl
        self.present(firstChapterViewController, animated: true, completion: nil)
    }
    
    func fadeInTitle (){
        UIView.animateKeyframes(withDuration: 5.5, delay: 0, animations:{
            self.labelstart.alpha = 1
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playSoundStart()
        fadeInTitle()
    }
}


/**
First View Controller - implement the first chapter
*/
class FirstChapterViewController: UIViewController {
    
    var mountainsImageView : UIImageView!
    var sunImageView : UIImageView!
    var austriansImageView : UIImageView!
    var venetiansImageView : UIImageView!
    var storyLabel : UILabel!
    var nextButton : UIButton!
    
    var storyTramaPart1 = """
    Once upon a time there was a clan of Venetian warriors, who struggled to gain independency from from Habsburg Empire, that in that period was ruling Veneto.
    Every day the members of the clan tried to break free from the mistreatment of the Empire, without any results.
    """
    
    override func loadView() {
        
        // View
        let view = UIView (frame: CGRect(x: 0, y: 0, width: 667.0, height: 375.0))
        view.backgroundColor = UIColor(red: (210/255), green: (247/255), blue: (253/255), alpha: 1.0)
        
        // Mountains
        let mountains = UIImage (named: "montagnefighe")
        mountainsImageView = UIImageView(image: mountains)
        mountainsImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        mountainsImageView.center = view.center
        
        // Sun
        let sun = UIImage (named: "sun")
        sunImageView = UIImageView(image: sun)
        sunImageView.frame = CGRect(x: 580, y: -60, width: 150, height: 150)
        
        // Austrians
        let austrians = UIImage (named: "austriaci")
        austriansImageView = UIImageView(image: austrians)
        austriansImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        
        // Venetians
        let venetians = UIImage (named: "veneziani")
        venetiansImageView = UIImageView(image: venetians)
        venetiansImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        
        // Story label
        storyLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 430, height: 200))
        storyLabel.numberOfLines = 0
        storyLabel.font = font
        storyLabel.text = storyTramaPart1
        
        
        // Object Button ahead
        let rightArrow = UIImage(named: "arrow")
        nextButton = UIButton(frame: CGRect(x: 580, y:330, width: 100, height: 40))
        nextButton.setImage(rightArrow, for: UIControl.State.normal)
        let oneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextChapter(recognizer:)))
        
        nextButton.addGestureRecognizer(oneTapRecognizer)
        
        // Adding layers
        view.addSubview(sunImageView)
        view.addSubview(mountainsImageView)
        view.addSubview(austriansImageView)
        view.addSubview(venetiansImageView)
        view.addSubview(storyLabel)
        view.addSubview(nextButton)
        
        self.view = view
        
    }
    
    // Animations
    @objc func nextChapter(recognizer : UITapGestureRecognizer){
        let secondChapterViewController = SecondChapterViewController()
        secondChapterViewController.modalPresentationStyle = .fullScreen
        secondChapterViewController.modalTransitionStyle = .partialCurl
        self.present(secondChapterViewController, animated: true, completion: nil)
    }
    
    // View lifecycle views
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Start animations
        sunAnimation()
        soldiersAnimation()
        playSoundBattle()
    }
    
    
    // Animations
    func sunAnimation(){
        UIView.animate(withDuration: 5.0, delay: 0, options: [.repeat, .autoreverse], animations:  {
            let scaleTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.sunImageView.transform = scaleTransform
        })
    }
    
    func soldiersAnimation(){
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations:  {
            let fightAnimation = CGAffineTransform(translationX: 50, y:-5)
            let fightAnimation2 = CGAffineTransform(translationX: -50, y:-5)
            
            self.austriansImageView.transform = fightAnimation
            self.venetiansImageView.transform = fightAnimation2
        })
    }
}

/**
 Second Chapter - implementing the first chapter
 */
class SecondChapterViewController: UIViewController {
    var backgroundImageView : UIImageView!
    var leonardoImageView : UIImageView!
    var potImageView : UIImageView!
    var crowdImageview : UIImageView!
    
    var storyLabel : UILabel!
    
    var previousButton: UIButton!
    var nextButton : UIButton!
    
    var storyTramaPart2 = """
     But one day, a famous local scientist, Leonardo Da Vinci, introduced himself to the clan with a miraculous potion made of Prosecco, soda water and Apero apéritif. This magical potion, that was called “Spritz”, had the power to make a man stronger than a tornado and faster than a cheetah.
     """
    
    override func loadView() {
        
        // View
        let view = UIView (frame: CGRect(x: 0, y: 0, width: 667.0, height: 375.0))
        view.backgroundColor = UIColor(red: (210/255), green: (247/255), blue: (253/255), alpha: 1.0)
        
        // Background
        let backgroundImage = UIImage(named: "sfondoSudato")
        backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
        backgroundImageView.center = view.center
        
        // Leonardo
        leonardoImageView = UIImageView(image: UIImage(named: "leonardo"))
        leonardoImageView.frame = CGRect(x: 585, y: 65, width: 100, height: 100)
        
        // Pot
        potImageView = UIImageView(image: UIImage(named: "potGood"))
        potImageView.frame = CGRect(x: 574, y: 107, width: 70, height: 70)
        
        // Crowd
        let crowdImage = UIImage(named: "crowd")
        crowdImageview = UIImageView(image: crowdImage)
        crowdImageview.frame = CGRect(x: -300, y: 0, width: 667, height: 375)
        
        // Story label
        storyLabel = UILabel(frame: CGRect(x: 30, y: -10, width: 500, height: 200))
        storyLabel.numberOfLines = 0
        storyLabel.font = font
        storyLabel.text = storyTramaPart2
        
        
        
        
        
        // Next Chapter Button configuration
        let rightArrow = UIImage(named: "createPotArrow")
        nextButton = UIButton(frame: CGRect(x: 500, y:280, width: 150, height: 80))
        nextButton.setImage(rightArrow, for: UIControl.State.normal)
        let nextChapterTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextChapter(recognizer:)))
        
        nextButton.addGestureRecognizer(nextChapterTapRecognizer)
        
        
        // Previous chapter configuration
        let leftArrow = UIImage(named: "arrow2")
        previousButton = UIButton(frame: CGRect(x: 0, y: 330, width: 100, height: 40))
        previousButton.setImage(leftArrow, for: UIControl.State.normal)
        let previousChapterTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(previousChapter(recognizer:)))
        previousButton.addGestureRecognizer(previousChapterTapRecognizer)
        
        // Adding layers
        view.addSubview(backgroundImageView)
        view.addSubview(leonardoImageView)
        view.addSubview(potImageView)
        view.addSubview(storyLabel)
        view.addSubview(crowdImageview)
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        self.view = view
        
    }
    
    
    // Transition methods
    @objc func nextChapter(recognizer : UITapGestureRecognizer){
        // Go to game
    }
    
    @objc func previousChapter(recognizer : UITapGestureRecognizer){
        let firstChapterViewController = FirstChapterViewController()
        firstChapterViewController.modalPresentationStyle = .fullScreen
        firstChapterViewController.modalTransitionStyle = .partialCurl
        self.present(firstChapterViewController, animated: true, completion: nil)
    }
    
    // View lifecycle views
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        crowdArrivalAnimation()
        leonardoMixAnimation()
        playSoundBattle()
    }
    
    
    // Animations
    func crowdArrivalAnimation() {
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [], animations: {
            self.crowdImageview.transform = CGAffineTransform(translationX: 300, y: 0)
        }) { _ in
            self.crowdImageview.transform = CGAffineTransform.identity
            self.crowdImageview.frame = CGRect(x: 0, y: 0, width: 667, height: 375)
            UIView.animate(withDuration: 1.0, delay: 5.0, options: [.repeat, .autoreverse], animations: {
                let fightAnimation = CGAffineTransform(translationX: 25, y:-5)
                self.crowdImageview.transform = fightAnimation
            })
        }
    }
    
    func leonardoMixAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.leonardoImageView.transform = CGAffineTransform(translationX: -10, y: 0)
        }, completion: nil)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
let viewController = StartViewController()
PlaygroundPage.current.liveView = viewController.view
