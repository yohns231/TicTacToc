
import Foundation

//var
var Status_Game : Bool = true

//enum

/// player enum
enum players : String {
    case player1 = "o"
    case player2 = "x"
    case player3 = "ㅁ"
}

//protocol
protocol PTocol_GameStatus{
    var Var_CurrentPlayer: players {get}
    func Func_ReplaceGameStatus(_ index : String)
}

//class

/// Main class
class Main_TicTacToc : PTocol_GameStatus {
    //Class_Var
    var Var_CurrentPlayer : players
    var List_GameStatus : [Any]
    var List_PlayerList : [players]
    var List_ViewPointer : [[Any]]
    let Int_GameArea : Int
    let Int_PlayerNumber : Int
    var Int_PlayerIndex : Int
    
    //Class_Init
    init(_ Player_number : Int, _ Game_Area : Int){
        Int_PlayerNumber = Player_number
        Int_GameArea = Game_Area * Game_Area
        List_GameStatus = Array(1...Int_GameArea)
        Var_CurrentPlayer = .player1
        List_PlayerList = []
        Int_PlayerIndex = 0
        List_ViewPointer = Array(repeating: Array(repeating: " ", count: Int(Game_Area)), count: Int(Game_Area))
    }
    
    //Class_Fuction
    
    func Func_ViewPointer(){
        var StateString = String(repeating: "-", count: Int_GameArea / 2) + "\n"
        var viewString : String = StateString
        var row_String : String = ""
        
        for row in List_ViewPointer{
            for col in row{
                row_String += "\(col)|"
            }
            
            row_String += "\n" + StateString
        }
        
        viewString += row_String
        print(viewString)
    }
    
    /// Replace GameStatus
    func Func_ReplaceGameStatus(_ index : String){
        if let Int_SelectedIndex = Int(index),
           0 < Int_SelectedIndex,
           Int_SelectedIndex < Int_GameArea+1{
            if List_GameStatus[Int_SelectedIndex-1] is Int{
                List_GameStatus[Int_SelectedIndex-1] = Var_CurrentPlayer.rawValue
            }
            else {print("이미 입력된 곳입니다.")}
        }
        else {
            print("잘못된 입력입니다.")
        }
    }
    
    func Func_InsertList_ViewPointer() {
        var for_index = 0
        for i in 0..<Int(sqrt(Double(Int_GameArea))){
            for j in 0..<Int(sqrt(Double(Int_GameArea))){
                if let value = List_GameStatus[for_index] as? String {
                    List_ViewPointer[i][j] = value
                }
                else if let value = List_GameStatus[for_index] as? Int {
                    List_ViewPointer[i][j] = String(value)
                }
                for_index += 1
            }
        }
        Func_ChangePlayer()
        
    }
    
    func Func_MakePlayerList(_ index : Int){
        if index == 2 {List_PlayerList = [.player1, .player2]}
        else if index == 3 {List_PlayerList = [.player1, .player2, .player3]}
        else {List_PlayerList = [.player1]}
    }
    
    func Func_ChangePlayer(){
        Int_PlayerIndex = (Int_PlayerIndex + 1) % Int_PlayerNumber
        Var_CurrentPlayer = List_PlayerList[Int_PlayerIndex]
    }
    
    func Func_CheckWin(){
        var value1 = List_ViewPointer[0][0] as! String
        var value2 = List_ViewPointer[0][0] as! String
        var value3 = List_ViewPointer[0][0] as! String
        var value4 = List_ViewPointer[0][0] as! String
        var value5 = List_ViewPointer[0][0] as! String
        var value6 = List_ViewPointer[0][0] as! String
        let Int_GridSize = Int(sqrt(Double(Int_GameArea))) - 1
        var MaxiumValue1 : Int = 0
        var MaxiumValue2 : Int = 0
        var MaxiumValue3 : Int = 0
        
        for i in 0...Int_GridSize{
            for j in 0...Int_GridSize{
                value2 = List_ViewPointer[i][j] as! String
                value4 = List_ViewPointer[j][i] as! String
                value6 = List_ViewPointer[j][i] as! String
                if i == j && value5 == value6{
                    value5 = value6
                    MaxiumValue3 += 1
                    if MaxiumValue3 == Int_GridSize + 1{
                        MaxiumValue3 = 0
                        print("win")
                        Func_quit()
                        break
                    }
                }
                
                if value1 == value2{
                    value1 = value2
                    MaxiumValue1 += 1
                    if MaxiumValue1 == Int_GridSize + 1{
                        MaxiumValue1 = 0
                        print("win")
                        Func_quit()
                        break
                    }
                }
                else {
                    value1 = List_ViewPointer[0][0] as! String
                    value2 = List_ViewPointer[0][0] as! String
                    MaxiumValue1 = 0
                    
                }
                    
                if value3 == value4{
                    value3 = value4
                    MaxiumValue2 += 1
                    if MaxiumValue2 == Int_GridSize + 1{
                        MaxiumValue2 = 0
                        print("win")
                        Func_quit()
                        break
                    }
                }
                else {
                    value3 = List_ViewPointer[0][0] as! String
                    value4 = List_ViewPointer[0][0] as! String
                    MaxiumValue2 = 0
                    
                }
//                if i
            }
        }
    }
    func Func_quit(){
        Status_Game = false
    }
}

//function




//excute
print("안녕하세요. 사용자 설정에 들어가갰습니다.\n먼저, 사용자 수를 입력해주세요.(최대 3)")
let conf_player_number = readLine()
print("\n\n\(conf_player_number!)명을 입력하셨습니다.\n다음은 틱택톡의 크기를 정하겠습니다. 크기를 입력해주세요.")
let conf_TicTacToc_Area = readLine()
print("\n\n맵의 크기를\(conf_TicTacToc_Area!)로 설정하셨습니다.")
let excute_TicTacToc = Main_TicTacToc(Int(conf_player_number!)!,Int(conf_TicTacToc_Area!)!)
excute_TicTacToc.Func_MakePlayerList(Int(conf_player_number!)!)
print("\n\n모든 설정이 끝났습니다. 이제 게임을 즐겨주시면 됩니다.")


while Status_Game {
    print("\n번호를 입력해주세요.")
    if let Input_String_GameNumber = readLine(){
        excute_TicTacToc.Func_ReplaceGameStatus(Input_String_GameNumber)
        excute_TicTacToc.Func_InsertList_ViewPointer()
        excute_TicTacToc.Func_ViewPointer()
        excute_TicTacToc.Func_CheckWin()
        
        if Input_String_GameNumber.lowercased() == "exit"{
            Status_Game = false
            print("게임을 종료합니다. 감사합니다.")
        }
    }
    
}
