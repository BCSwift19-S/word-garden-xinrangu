//
//  ViewController.swift
//  Word Garden
//
//  Created by Gu Xinran on 2/3/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!//command+K for keyboard show up
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumOfWrongGuesses = 8
    var wrongGuessesRemain = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        //decrement cwrong guesses remaining changing image
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemain = wrongGuessesRemain - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemain)")
        }
        let revealedWord = userGuessLabel.text!
        //end game
        if wrongGuessesRemain == 0{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Sorry, out of guesses"
        }else if !revealedWord.contains("_"){
            //won a game
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You got it! It took you \(guessCount) guesses to guess the word"
        }else{
            //update number of guesses to show
//            var guess = "guesses"
//            if guessCount == 1{
//                guess = "guess"
//            }
            let guess = (guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
        
    }
    
    func formatUserGuessLabel(){
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord + " \(letter)"
            }else{
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    @IBAction func guessedLetterFieldChange(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last{
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        }else{
            //disable the button since the text field is empty
            guessLetterButton.isEnabled = false
        }
    }
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemain = maxNumOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
    

}

