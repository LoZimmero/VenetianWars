import SpriteKit
import GameplayKit
import PlaygroundSupport
import CoreMotion

let fontUrl = Bundle.main.url(forResource: "myFont", withExtension: "ttf")
CTFontManagerRegisterFontsForURL(fontUrl! as CFURL, CTFontManagerScope.process, nil)
let font = UIFont(name: "PressStart2P-Regular", size: 13)

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let scoreToWin = 60

    var wallNode : SKSpriteNode!
    var spritzNode : SKSpriteNode!
    
    var scoreLabel : SKLabelNode!
    var score : Int = 0 {
        didSet {    // Computed property so that it refresh scoreLabel every time this property is updated
            scoreLabel.text = "Score:\(score)"
        }
    }
    
    var gameTimer : Timer!
    var inGameTimer: Timer!
    var seconds = 20
    var timeLabel : SKLabelNode!
    
    var backgroundMusic: SKAudioNode!
    var resultLabel : SKLabelNode!


    
    var possibleIngredients = ["ice", "prosecco", "redPotion"]
    
    let ingredientCategory : UInt32 = 0x1 << 1 // 2
    let spritzCategory : UInt32 = 0x1 << 0 // 1
    
    
    override func didMove(to view: SKView) {
        self.size = CGSize(width: 375, height: 667)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // Starfield node
        wallNode = SKSpriteNode(imageNamed: "gameBackground")
        wallNode.position = CGPoint(x: wallNode.frame.width / 2, y: wallNode.frame.height / 2) // Make it start from the upper left corner on an iPhone 8 Plus
        self.addChild(wallNode)
        
        wallNode.zPosition = -1    // Starfield stays on the back of other nodes
        
        // Player node
        spritzNode = SKSpriteNode(imageNamed: "SpritzGood")
        spritzNode.position = CGPoint(x: self.frame.size.width / 2, y: 60)
        spritzNode.size = CGSize(width: 110, height: 120)
        spritzNode.physicsBody = SKPhysicsBody(rectangleOf: spritzNode.size)
        spritzNode.physicsBody?.restitution = 0.0
        spritzNode.physicsBody?.isDynamic = false
        spritzNode.physicsBody?.categoryBitMask = spritzCategory
        spritzNode.physicsBody?.contactTestBitMask = ingredientCategory
        self.addChild(spritzNode)
        
        // Physics world property - no gravity and initialize contactDelegate for collision detection
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)  // No gravity pulling us down or horizontally
        self.physicsWorld.contactDelegate = self    // Allow us to implement contact between nodes
        
        // Score label node
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 60)   // Upper left corner
        scoreLabel.fontName = "PressStart2P-Regular"
        scoreLabel.fontSize = 20
        score = 0
        self.addChild(scoreLabel)
        
        // Time label node
        timeLabel = SKLabelNode(text: "Time: \(seconds)")
        timeLabel.position = CGPoint(x: 270, y: self.frame.size.height - 60)   // Upper left corner
        timeLabel.fontName = "PressStart2P-Regular"
        timeLabel.fontSize = 20
        self.addChild(timeLabel)
        
        // Setting background sound
        if let musicURL = Bundle.main.url(forResource: "gameSong", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            self.addChild(backgroundMusic)
        }
        
        
        //Setting In game Timer
        inGameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        // Setting gameTimer
        gameTimer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(addIngredient), userInfo: nil, repeats: true)
        
        // Allow user to move the player
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveSpritz))
        self.view?.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func moveSpritz(_ recognizer: UIPanGestureRecognizer) {
        let lastPosition = recognizer.location(in: self.view)
        
        let moveAction = SKAction.move(to: CGPoint(x: lastPosition.x, y: spritzNode.position.y), duration: 0.01)
        spritzNode.run(moveAction)
    }

    
    @objc func addIngredient() {
        possibleIngredients = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleIngredients) as! [String]
        
        let ingredient = SKSpriteNode(imageNamed: possibleIngredients[0])
        ingredient.size = CGSize(width: 50, height: 50)
        
        let randomIngredientPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomIngredientPosition.nextInt())
        
        // Set position and property on physics body
        ingredient.position = CGPoint(x: position, y: self.frame.size.height + ingredient.size.height)
        
        ingredient.physicsBody = SKPhysicsBody(rectangleOf: ingredient.size)
        ingredient.physicsBody?.isDynamic = true
        ingredient.physicsBody?.restitution = 0.0
        ingredient.physicsBody?.categoryBitMask = ingredientCategory
        ingredient.physicsBody?.contactTestBitMask = spritzCategory
        ingredient.physicsBody?.usesPreciseCollisionDetection = true
        ingredient.physicsBody?.collisionBitMask = 0
        
        self.addChild(ingredient)
        
        let animationDuration : TimeInterval = 6
        
        // Create a series of SKActiona nd execute them
        var actionArray = [SKAction]()
        
        // Move the alien previously generated from up to down
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -ingredient.size.height), duration: animationDuration))
        // Remove the alien from parent when done
        actionArray.append(SKAction.removeFromParent())
        
        ingredient.run(SKAction.sequence(actionArray))
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & spritzCategory) != 0 && (secondBody.categoryBitMask & ingredientCategory) != 0 {
            ingredientCollide(spritzNode: firstBody.node as! SKSpriteNode, ingredientNode: secondBody.node as! SKSpriteNode)
        }
    }
    
    func ingredientCollide(spritzNode : SKSpriteNode, ingredientNode : SKSpriteNode) {
        ingredientNode.removeFromParent()
        score += 5
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func updateTimer() {
        if (seconds <= 1) {
            // Invalidate timers - no more ingredients spawned
            gameTimer.invalidate()
            inGameTimer.invalidate()
            backgroundMusic.run(SKAction.removeFromParent())
            
            self.endGame()
        }
        seconds -= 1
        timeLabel.text = "Time:\(seconds)"
    }
    
    func endGame() {
        // TODO: Move score label in center
        var arrayActions = [SKAction]()
        arrayActions.append(SKAction.run {
            self.timeLabel.run(SKAction.fadeOut(withDuration: 2))
        })
        // TODO: Add a label that says you win or not
        timeLabel.run(SKAction.sequence(arrayActions))
        arrayActions = [SKAction]()
        arrayActions.append(SKAction.run {
            if let view = self.view {
                self.scoreLabel.run(SKAction.move(to: CGPoint(x: view.center.x - 20, y: view.center.y), duration: 2))
                self.scoreLabel.run(SKAction.scale(by: 1.4, duration: 2))
            }
        })
        
        scoreLabel.run(SKAction.sequence(arrayActions)) {
            let resultText = self.score >= self.scoreToWin ? " YOU WIN" : "YOU LOSE"
            self.resultLabel = SKLabelNode(text: resultText)
            self.resultLabel.fontName = "PressStart2P-Regular"
            self.resultLabel.fontSize = 30
            self.resultLabel.position = CGPoint(x: self.anchorPoint.x + 178, y: self.anchorPoint.y + 270)
            self.addChild(self.resultLabel)
        }
    }
}


class ViewController : UIViewController {
       
       override func loadView() {
           
           let view = SKView()
           view.presentScene(GameScene())
                   
           self.view = view
       }
   }

PlaygroundPage.current.liveView = ViewController()

