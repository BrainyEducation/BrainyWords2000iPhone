//
//  QuizPictureView.swift
//  BrainyWords2k
//
//  Created by Khoi Nguyen on 10/5/18.
//  Copyright © 2018 HMD Avengers. All rights reserved.
//

import UIKit

enum AnswerRewardType {
    case gold
    case silver
    case failed
}
struct QuizObject {
    var questionSound: URL!
    var correctImage: String!
    
    var rightAnswerIndex: Int
    var answers: [DisplayItemObject]
    
    var rightAnswer: DisplayItemObject?{
        return answers[rightAnswerIndex]
    }
    
    init(rightAnswerIndex: Int, answers: [DisplayItemObject]) {
        self.rightAnswerIndex = rightAnswerIndex
        self.answers = answers
    }
}


class QuizPictureView: UIView {

    var items = [DisplayItemObject]()
    var holdingItems = [DisplayItemObject]()
    var listAdditionQuestions = [DisplayItemObject]()
    var listAdditionAnswers = [DisplayItemObject]()
    var specialPath: String?
    
    var rightAnswer: DisplayItemObject?
    
    var quiz: QuizObject!
    var numberOfAttemptions = 0
    var resultHandler: ((AnswerRewardType) -> ())?
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private var imgViews: [UIImageView]!

    var isPlaying = false
    //var correctSounds = [String]()
    var incorrectSound: String!
    var correctSound: String!
    var parentController: QuizViewController?
    
    var startDate : Date?
    var endDate:Date?
    var correctOn:Int = -1
    var timeSpent:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        incorrectSound = "incorrect_answer.mp3"
        correctSound = "correct_answer.mp3"
    }
    
    @IBAction func imgPressed(sender: UIButton){
        let tag = sender.tag
        endDate = Date()
        self.handleUserSelection(tag: tag)
        
    }
    
    func caculatorTime()->Int?{
        if let startdate = startDate, let enddate = endDate {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.second], from: startdate, to: enddate)
            
           return dateComponents.second
        }
        return nil
    }
    
    func playAudio(isCorrect: Bool, completionHandler: (() -> ())?){
        if isCorrect{
            RootAudioPlayer.shared.url = Utility.assets.root.appendingPathComponent("Quiz_Sounds/"+correctSound)
            RootAudioPlayer.shared.play()
            if numberOfAttemptions != 0 {
                Utility.perform(after: RootAudioPlayer.shared.duration) {
                    completionHandler?()
                }
                return
            }
            
            Utility.perform(after: RootAudioPlayer.shared.duration) {
               
                RootAudioPlayer.shared.url = Utility.assets.root.appendingPathComponent("Quiz_Sounds/correct/"+Utility.shared.getPraiseSoundCorect())
                RootAudioPlayer.shared.play()

                Utility.perform(after: RootAudioPlayer.shared.duration) {
                    completionHandler?()
                }
            }
        }else{
            RootAudioPlayer.shared.url = Utility.assets.root.appendingPathComponent("Quiz_Sounds/"+incorrectSound)
            RootAudioPlayer.shared.play()
            Utility.perform(after: RootAudioPlayer.shared.duration) {
                completionHandler?()
                
            }
        }

        
    }
    
    func handleUserSelection(tag: Int){
        var isCorrected = false
        if self.specialPath?.contains("addition") == true{
            let selectedItem = quiz.answers[tag]
            var answerString = self.quiz.questionSound.deletingPathExtension().lastPathComponent.substringFrom(index: 3)
 
            answerString = answerString.appending(selectedItem.title)
            answerString = answerString.replace(target: ".png", withString: "")
            isCorrected = self.quiz.correctImage.contains(answerString)
        }else{
            isCorrected = tag == self.quiz.rightAnswerIndex
        }
        
        // right
        if isCorrected{

            guard let specialPath = self.specialPath else{
                return
            }
            self.isUserInteractionEnabled = false
            playAudio(isCorrect: true){
                // at first time
                if self.numberOfAttemptions == 0{
                    self.correctOn = 1
                    if QuizModel.shared.isHaveAnimateScreenTotalCoin() {
                        self.animationTotalCoin(typeReward: .gold)
                        return
                    }
       
                    if QuizModel.shared.isHaveAnimate(key: specialPath){
                        self.animationTopicCoin(typeReward: .gold)
                        return
                    }
                    
                    self.addCoinAndPassQuestion(typeReward: .gold)
                    return
                }
                
                // at second time
                self.correctOn = 2
                if QuizModel.shared.isHaveAnimateScreenTotalCoin(isGold: false) {
                    self.animationTotalCoin(typeReward: .silver)
                    return
                }
                
                if QuizModel.shared.isHaveAnimate(key: specialPath, isGold: false) {
                    self.animationTopicCoin(typeReward: .silver)
                    return
                }
                
                self.addCoinAndPassQuestion(typeReward: .silver)
                return
            }
            return
        }
        
        // wrong
        playAudio(isCorrect: false) {
            self.numberOfAttemptions += 1
            // failed & end this time
            if self.numberOfAttemptions == 2{
                 self.isUserInteractionEnabled = false
                self.correctOn = 0
                self.generateQuiz()
            }
        }
    }
    
    //post anatylic
    func postAnatilics(){
        guard let spentTime = caculatorTime() else {return}
        guard let student_id = RootConstants.student_id else {return}
        guard let rightAnswer = quiz.rightAnswer else {
            return
        }
        if correctOn < 1 {
            print("no post")
            return
        }
        timeSpent = spentTime
        if  timeSpent < 0 {timeSpent = 0}
        
        let analytic = AnalyticDataResponse()
        analytic.correct_on = correctOn
        analytic.time_spent = timeSpent
        analytic.student_id = student_id
        
        if rightAnswer.focus_Item == "none" {
            let titleItem = lblTitle.text! + rightAnswer.title.replace(target: ".png", withString: "")
            
            let _ = holdingItems.map({ (item)  in
                if item.title == titleItem {
                    analytic.focus_item_id = item.focus_Item
                }
            })
            
        }else if rightAnswer.focus_Item == "letters" {
            let titleItem = lblTitle.text!
            let _ = holdingItems.map({ (item)  in
                if item.title == titleItem {
                    analytic.focus_item_id = item.focus_Item
                }
            })
        }
        else{
           analytic.focus_item_id = rightAnswer.focus_Item
            
        }
        Network.shared.analyticsStudents(data: analytic) { (analyticData) in
            if let analytic = analyticData {
                if analytic.statusResponse == "ok" {
                    print("analytic success")
                    return
                }
            }
             print("analytic fail")
        }

       
    }
    
    //Add coind
    func addCoinAndPassQuestion(typeReward:AnswerRewardType){
        QuizModel.shared.add(type: typeReward, specialPath: specialPath!)
        self.generateQuiz()
    }
    
    func animationTopicCoin(typeReward:AnswerRewardType){
            self.parentController?.animationAction(key: self.specialPath!) {
                self.addCoinAndPassQuestion(typeReward: typeReward)
            }
    }
    
    func animationTotalCoin(typeReward:AnswerRewardType){
        self.parentController?.animationTotalScreenCoinAction(completionHandler: {
            if QuizModel.shared.isHaveAnimate(key: self.specialPath!){
                self.animationTopicCoin(typeReward: typeReward)
                return
            }
            self.addCoinAndPassQuestion(typeReward: typeReward)
        })
    }
    
    func repeatAnswer(){
        RootAudioPlayer.shared.playSound(from: self.quiz.answers[self.quiz.rightAnswerIndex].soundPath)
    }
    
    func generateQuiz(){
        postAnatilics()
        
        numberOfAttemptions = 0
       self.isUserInteractionEnabled = true
        playTransitionForView(self, duration: 0.5, transition: kCATransitionPush, subtype: kCATransitionFromTop,
                              timingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        if self.specialPath?.contains("addition") == true{
            // list images
            var correctAnswers = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent("School/addition"))!
            correctAnswers = correctAnswers.filter{
                $0.contains(".png")
            }
            for (idx, item) in correctAnswers.enumerated(){
                var string = item
                string = item.replace(target: "_", withString: "")
                string = item.replace(target: ".png", withString: "")
                string = item.substringFrom(index: 1)
                correctAnswers[idx] = string
            }
            
            var answerImage = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent("School/addition/addition_quiz"))!
            answerImage = answerImage.filter{
                $0.contains(".png")
            }
        
            var listSounds = Utility.getContents(fromURL: Utility.assets.root.appendingPathComponent("School/addition/addition_quiz/sounds"))!
           
            //shuffled
            var answers = [DisplayItemObject]()

            self.quiz = QuizObject(rightAnswerIndex: -1, answers: answers)
            let randomIndex = self.randomNumber(range: listSounds.count)
            self.quiz.questionSound = Utility.assets.root.appendingPathComponent("School/addition/addition_quiz/sounds/\(listSounds[randomIndex])")
            let question = self.quiz.questionSound.deletingPathExtension().lastPathComponent.substringFrom(index: 3)
            self.quiz.correctImage = correctAnswers.first{ $0.contains(question) }!
            
            var correctAnswer = correctAnswers.first{
                $0.contains(question)
            }
            
            if correctAnswer != nil{
                correctAnswer = correctAnswer!.replace(target: "_", withString: "")

                var title = correctAnswer!
                let range = title.rangeOfAString(string: "=")
                title = title.substringFrom(index: range.location+1)
                let item = DisplayItemObject(title: title, imagePath: Utility.assets.root.appendingPathComponent("School/addition/addition_quiz/\(title)"), soundPath: self.quiz.questionSound, focusItem: "none")
                answers.append(item)
            }
            
            var shuffled = answerImage.shuffled()
            repeat{
                let randomIndex = self.randomNumber(range: shuffled.count)
                let title = shuffled[randomIndex]
                if !correctAnswer!.contains(title){
                    shuffled.remove(at: randomIndex)
                    let item = DisplayItemObject(title: title, imagePath: Utility.assets.root.appendingPathComponent("School/addition/addition_quiz/\(title)"), soundPath: Utility.assets.root.appendingPathComponent("School/addition/addition_quiz/sounds/\(listSounds[randomIndex])"), focusItem: "none")
                    answers.append(item)
                }
               
            } while answers.count < 4
            
            self.quiz.answers = answers.shuffled()
            let index = self.quiz.answers.index{
                correctAnswer!.contains($0.title)
            }
            
            self.quiz.rightAnswerIndex = index ?? -1
            
            
            if self.quiz.rightAnswer?.title == self.rightAnswer?.title{
                self.generateQuiz()
                return
            }
            
            self.rightAnswer = self.quiz.rightAnswer
            
            lblTitle.text = question
            for (index, answer) in quiz.answers.enumerated(){
                imgViews[index].image = UIImage(named: answer.imagePath.path)
            }
            
            Utility.perform(after: 0.5) {
                self.startDate = Date()
               
                RootAudioPlayer.shared.playSound(from: self.quiz.questionSound)
            }
            
            return
        }
        
        var answers = [DisplayItemObject]()

        var shuffled = self.items.shuffled()
        repeat{
            let randomIndex = self.randomNumber(range: shuffled.count)
            let item = shuffled[randomIndex]
            shuffled.remove(at: randomIndex)
            answers.append(item)
        } while answers.count < 4
        
        answers = answers.shuffled()
        let randomIndex = self.randomNumber(range: answers.count)
        self.quiz = QuizObject(rightAnswerIndex: randomIndex, answers: answers)

        if self.quiz.rightAnswer?.title == self.rightAnswer?.title{
            self.generateQuiz()
            return
        }
        
        self.rightAnswer = self.quiz.rightAnswer
        
        lblTitle.text = quiz.answers[quiz.rightAnswerIndex].title
        for (index, answer) in quiz.answers.enumerated(){
            imgViews[index].image = UIImage(named: answer.imagePath.path)
        }
        
        Utility.perform(after: 0.5) {
            self.startDate = Date()
            RootAudioPlayer.shared.playSound(from: self.quiz.answers[self.quiz.rightAnswerIndex].soundPath)
        }
        
    }
    

    func randomNumber(range: Int) -> Int{
        return Int(arc4random_uniform(UInt32(range)))
    }
}
