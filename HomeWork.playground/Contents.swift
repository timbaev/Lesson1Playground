import UIKit

/////////////////////////Задание номер 1 (метод trim)/////////////////////////////
extension String {
    func trim(with trimString: String) -> String {
        var string = self
        
        while let range = string.range(of: trimString) {
            var characters = Array(string.characters)
            let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
            for _ in 0 ..< trimString.characters.count {
                characters.remove(at: index)
            }
            string = String(characters)
        }
        return string
    }
}

let testString = "Hello, World, Hello!"
let trimmedString = testString.trim(with: "llo")

////////////////////////Задание номер 2 (ООП игра)////////////////////////////////

class Unit {
    
    var health: Int = 100
    var damage: Int
    var armor: Int
    var agility: Int
    var nick: String
    let armorSave = 47 / 100
    
    init(damage: Int, armor: Int, agility: Int, nick: String) {
        self.damage = damage
        self.armor = armor
        self.agility = agility
        self.nick = nick
    }
    
    func attack(to enemy: Unit) {
        enemy.health -= self.damage + (enemy.armor * armorSave)
    }
    
}

class Wizard: Unit {
    
    var fireDamage: Int
    let fireSave = 28 / 100
    
    init(damage: Int, armor: Int, agility: Int, nick: String, fireDamage: Int) {
        self.fireDamage = fireDamage
        super.init(damage: damage, armor: armor, agility: agility, nick: nick)
    }
    
    override func attack(to enemy: Unit) {
        super.attack(to: enemy)
        enemy.health -= fireDamage + (enemy.armor * fireSave)
    }

}

class Knight: Unit {
    
    var shieldArmor: Int
    var healthValue = 0
    let shieldSave = 71 / 100
    override var health: Int {
        set {
            healthValue = newValue + (shieldArmor * shieldSave)
        }
        get {
            return healthValue
        }
    }
    
    init(damage: Int, armor: Int, agility: Int, nick: String, shieldArmor: Int) {
        self.shieldArmor = shieldArmor
        super.init(damage: damage, armor: armor, agility: agility, nick: nick)
        self.health = 100
    }
    
}

class Assassin: Unit {
    
    var cloakAgility: Int
    let cloakDamage = 43 / 100
    
    init(damage: Int, armor: Int, agility: Int, nick: String, cloakAgility: Int) {
        self.cloakAgility = cloakAgility
        super.init(damage: damage, armor: armor, agility: agility, nick: nick)
    }
    
    override func attack(to enemy: Unit) {
        super.attack(to: enemy)
        enemy.health -= (cloakAgility * cloakDamage)
    }
    
}

class Battlefield {
    
    var players = [Unit]()
    var logger = false //Debug mode (set true, if you want see the process game)
    var battleListener: BattleListener
    
    init(battleListener: BattleListener) {
        self.battleListener = battleListener
    }
    
    func beginBattle(with units: [Unit]) {
        self.players = units
        var currentPosition = 0
        
        if logger {print("------------------------------------------")}
        if logger {print("logger start!")}
        
        while players.count != 1 {
            
            if logger {print("currentPosition = \(currentPosition)")}
            var hasFallen = false
            
            for i in currentPosition ..< players.count - 1 {
                
                players[i].attack(to: players[i + 1])
                if logger {print("\(players[i].nick) attack \(players[i + 1].nick)")}

                if (players[i + 1].health < 0) {
                    if logger {print("\(players[i + 1].nick) has fallen")}
                    players.remove(at: i + 1)
                    if (i + 1 == players.count) {
                        currentPosition = 0
                    } else {
                        currentPosition = i + 1
                    }
                    hasFallen = true
                    break
                }
                
            }
            
            if (!hasFallen) {
                if logger {
                    print("last attack!")
                    print("\(players.last!.nick) attack \(players.first!.nick)")
                }
                
                if let lastPlayer = players.last, let firstPlayer = players.first {
                    lastPlayer.attack(to: firstPlayer)
                    if firstPlayer.health < 0 {
                        if logger {print("\(firstPlayer.nick) has fallen")}
                        players.remove(at: 0)
                    }
                    currentPosition = 0
                }
            }
        }
        if logger {print("logger end!")}
        if logger {print("____________________________________________")}
        battleListener.battleEnd(winner: players[0].nick)
    }
    
}

protocol BattleListener {
    func battleEnd(winner: String)
}

class Game: BattleListener {
    
    private init() {}
    
    static let initGame = Game()
    
    var units = [Unit]()
    var victoriesTable = [String : Int]()
    var lossTable = [String : Int]()
    let stopFor = 2
    
    func join(as unit: Unit) {
        units.append(unit)
    }
    
    func logout(_ unit: Unit) {
        let index = units.index { (unitInArray) -> Bool in
            unit === unitInArray
        }
        if let currentIndex = index {
            units.remove(at: currentIndex)
        } else {
            print("Unit not found :(")
        }
    }
    
    func startGame() {
        let battlefield = Battlefield(battleListener: self)
        battlefield.beginBattle(with: units)
    }
    
    func battleEnd(winner: String) {
        units.forEach { $0.health = 100 }
        
        victoriesTable[winner] = 1 + ((victoriesTable[winner] != nil) ? victoriesTable[winner]! : 0)
        let losers = units.filter { $0.nick != winner }
        for loser in losers {
            lossTable[loser.nick] = 1 + ((lossTable[loser.nick] != nil) ? lossTable[loser.nick]! : 0)
        }
        
        print("Players played: ")
        units.forEach { print($0.nick) }
        
        print("Winner: \(winner)")
        print("----------------------------------------")
        print("TOP 3 Players (Nick, Victories, Losses):")
        let sortedWinners = victoriesTable.sorted { $0.value > $1.value }
        for i in 0 ..< sortedWinners.count {
            
            let nick = sortedWinners[i].key
            let victories = sortedWinners[i].value
            let losses = lossTable[nick] != nil ? lossTable[nick]! : 0
            print("\(nick) \(victories) \(losses)")
            
            
            if (i == stopFor) {
                break
            }
        }
        print("-----------------------------------------")
    }
}

//methods for testing
func generatePlayer(with nick: String) -> Unit {
    let typeNumber = arc4random_uniform(2)
    let damage = Int(arc4random_uniform(99) + 1)
    let armor = Int(arc4random_uniform(99) + 1)
    let agility = Int(arc4random_uniform(99) + 1)
    let skill = Int(arc4random_uniform(99) + 1)
    switch typeNumber {
    case 0:
        return Wizard(damage: damage, armor: armor, agility: agility, nick: nick, fireDamage: skill)
    case 1:
        return Knight(damage: damage, armor: armor, agility: agility, nick: nick, shieldArmor: skill)
    default:
        return Assassin(damage: damage, armor: armor, agility: agility, nick: nick, cloakAgility: skill)
    }
}

func updatePlayer(_ unit: Unit) {
    let damage = Int(arc4random_uniform(99) + 1)
    let armor = Int(arc4random_uniform(99) + 1)
    let agility = Int(arc4random_uniform(99) + 1)
    let skill = Int(arc4random_uniform(99) + 1)
    
    unit.damage = damage
    unit.armor = armor
    unit.agility = agility
    if let wizard = unit as? Wizard {
        wizard.fireDamage = skill
        return
    }
    if let knight = unit as? Knight {
        knight.shieldArmor = skill
        return
    }
    if let assassin = unit as? Assassin {
        assassin.cloakAgility = skill
        return //для красоты кода :3
    }
}

//Test methods
let game = Game.initGame
game.join(as: generatePlayer(with: "Player1"))
game.join(as: generatePlayer(with: "Player2"))
game.join(as: generatePlayer(with: "Player3"))
game.join(as: generatePlayer(with: "Player4"))
game.join(as: generatePlayer(with: "Player5"))
game.join(as: generatePlayer(with: "Player6"))

game.startGame()
for i in 0 ..< 9 {
    for unit in game.units {
        updatePlayer(unit)
    }
    game.startGame()
}









