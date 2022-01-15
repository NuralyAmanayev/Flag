//
//  ContentView.swift
//  praktika_2_ugaday_flag
//
//  Created by Nuraly Amanayev on 8/28/21.
//

import SwiftUI


struct ContentView: View {
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Argentina", "Brrazil", "Canada", "Greece", "Russia", "Sweeden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all) // заливка градиентом всего экрана включая даже места где показывается сеть и времья
            VStack (spacing: 30) {
                VStack{
                    Text("Выбери флаг: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black) // жирность шрифта
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 125)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                        .stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("Общий счёт: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счёт: \(score)"), dismissButton: .default(Text("Продолжить")) {
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number:Int ) {
        if number == correctAnswer{
            scoreTitle = "Правильный ответ!"
            score += 1
        }else{
            scoreTitle = "Неправильно! Этот флаг \(countries[number])"
            score -= 1
            
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
