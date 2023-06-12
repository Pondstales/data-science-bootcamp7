play_game <- function() {
  
  print("Instruction: type 'exit' to exit the program")
  
  options <- c("rock", "paper", "scissors")
  print(options)
  
  user_score <- 0
  computer_score <- 0
  
  while (TRUE) {
    
    user_select <- readline("Choose one: ")
    computer_select <- sample(options, 1)
    
    if (user_select == computer_select ) {
      print(computer_select)
      print("Tie!")
      user_score = user_score + 0
      computer_score = computer_score + 0
    } else if ((user_select == 'rock' & computer_select == 'paper') |
               (user_select == 'paper' & computer_select == 'scissors') |
               (user_select == 'scissors' & computer_select == 'rock')) {
      print(computer_select)
      print("You lost. Don't give up!")
      user_score = user_score + 0
      computer_score = computer_score + 1
    } else if ((user_select == 'rock' & computer_select == 'scissors')|
               (user_select == 'paper' & computer_select == 'rock') |
               (user_select == 'scissors' & computer_select == 'paper')) {
      print(computer_select)
      print("You won. Way to go!")
      user_score = user_score + 1
      computer_score = computer_score + 0
    } else if (user_select == 'exit') {
      print("Good game! Thanks for playing.")
      
        if (user_score == computer_score) {
          print(paste("Tie. You scored ", user_score, " and I scored ", computer_score))
        } else if (user_score < computer_score) {
          print(paste("You lost. You scored ", user_score, " and I scored ", computer_score))
        } else {
          print (paste("Congrats, you won!. You scored ", user_score, " and I scored ", computer_score))
        }
        break
    } else {
      print("Invalid iput. Please try again.")
    }
  } 
}
