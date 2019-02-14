//
//  ViewController.swift
//  02-dices
//
//  Created by Erik Felipe Gacitua Arenas on 2/14/19.
//  Copyright © 2019 Erik Felipe Gacitua Arenas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Captura de imagenes de dados
    @IBOutlet weak var imageViewDiceLeft: UIImageView!
    @IBOutlet weak var imageViewDiceRight: UIImageView!
    
    //Variables random de los dados (Left y Right)
    var randomDiceIndexLeft : Int = 0
    var randomDiceIndexRight : Int = 0
    
    //Arreglo que guarda los dados (Se declara let ya que el valor nunca cambia ni su posición)
    let diceImages : [String] = ["dice1","dcie2","dice3","dice4","dice5","dice6"]
    
    let nFaces : UInt32// Se declara como variable global
    
    //Declaración de variable de las caras del dado (Se inicializa)
    required init?(coder aDecoder: NSCoder) {
        nFaces = UInt32(diceImages.count)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateRandomDices()
    }

    //Acción del botón
    @IBAction func rollPressed(_ sender: UIButton) {
        generateRandomDices()
    }
    
    func generateRandomDices() {
        //Generar aleatoriamente y cambiar el dado izquierdo
        randomDiceIndexLeft = Int(arc4random_uniform(nFaces))
        let nameImageDiceLeft = diceImages[randomDiceIndexLeft]
        
        //Generar aleatoriamente y cambiar el dado derecho
        randomDiceIndexRight = Int(arc4random_uniform(nFaces))
        let nameImageDiceRight = diceImages[randomDiceIndexRight]
        
        //Se agrega animación en los dados
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: {
                
                self.imageViewDiceLeft.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: -100, y: 100))
                
                self.imageViewDiceRight.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).concatenating(CGAffineTransform(rotationAngle: CGFloat.pi/2)).concatenating(CGAffineTransform(translationX: 100, y: 100))
                
                //Codigo para efecto de desaparecer los dados
                self.imageViewDiceLeft.alpha = 0.0
                self.imageViewDiceRight.alpha = 0.0
                
        }) { (completed) in
            self.imageViewDiceLeft.transform = CGAffineTransform.identity
            self.imageViewDiceRight.transform = CGAffineTransform.identity
            
            //Codigo para que aparezcan los dados
            self.imageViewDiceLeft.alpha = 1.0
            self.imageViewDiceRight.alpha = 1.0
            
            //Codigo para reemplazar la imagen de la panatalla por la que genera el random al presionar el botón
            self.imageViewDiceLeft.image = UIImage(named: nameImageDiceLeft)
            self.imageViewDiceRight.image = UIImage(named: nameImageDiceRight)
        }
    }
    //Codigo para movimiento de mi dispositivo (Acelerometro o shake)
    override func becomeFirstResponder() -> Bool {
        return true
    }
    //Motion metodo que hace que al mover o agitar el dispocitivo se ejecuta la función de generateRandomDices
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake{
            generateRandomDices()
        }
    }
}

