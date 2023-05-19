//
//  IMC.swift
//  IMCApp
//
//  Created by Lidiane Ferreira on 17/05/23.
//

import UIKit

struct IMCCalculator {
    
    var imc: CalculatorModel?
    
    func getImcValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", imc?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    func getImcCategory() -> String {
        return imc?.category ?? ""
    }
    
    func getAdvice() -> String {
        return imc?.advice ?? ""
    }
    func getColor() -> UIColor {
        return imc?.color ?? .systemBackground
    }
    
    mutating func calculateIMC(height: Float, weight: Float) {
        let underweightCategory = "Baixo Peso"
        let healthCategory = "Peso Normal"
        let overweightCategory = "Sobrepeso"
        let ObesityCategory = "Obesidade"
        
        let underweightColor = UIColor.systemBlue
        let healthColor = UIColor.systemGreen
        let overweightColor = UIColor.systemYellow
        let ObesityColor = UIColor.systemRed
        
        let underweightAdvice = "Cuidado: Seu IMC indica que você está abaixo do peso recomendado. É importante consultar um médico ou nutricionista para avaliar sua saúde e desenvolver um plano alimentar adequado."
        let healthAdvice = "Parabéns! Seu IMC está dentro da faixa considerada saudável. Continue mantendo uma alimentação balanceada e praticando exercícios físicos regularmente para manter sua saúde."
        let overweightAdvice = "Atenção: Seu IMC indica que você está na faixa de sobrepeso. É importante adotar hábitos saudáveis, como uma alimentação equilibrada e a prática regular de exercícios, para evitar o avanço para a obesidade."
        let obesityAdvice = "Cuidado: Seu IMC indica que você está na faixa de obesidade. Recomendamos buscar orientação médica ou nutricional para desenvolver um plano de cuidados adequado, que inclua mudanças na alimentação e atividade física regular."

        
        let heightInMeters = height / 100
        let imcValue = weight / (heightInMeters * heightInMeters)

        if imcValue < 18.5 {
            imc = CalculatorModel(value: imcValue, category: underweightCategory, advice: underweightAdvice, color: underweightColor)
        }else if imcValue < 24.9{
            imc = CalculatorModel(value: imcValue, category: healthCategory, advice: healthAdvice, color: healthColor)
        }else if imcValue < 29.9{
            imc = CalculatorModel(value: imcValue, category: overweightCategory, advice: obesityAdvice, color: overweightColor)
        }else if imcValue > 29.9{
            imc = CalculatorModel(value: imcValue, category: ObesityCategory, advice: overweightAdvice, color: ObesityColor)
        }
    }
}



