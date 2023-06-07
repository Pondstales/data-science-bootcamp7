chatbot <- function() {
  
  print("Let's order pizza!")
  print("Instruction: type 'exit' to exit the program")
  
  pizza_menu <- data.frame(id = 1:3,
                           pizza_name = c("Margherita Pizza", "Pepperoni Pizza", "Cheese Pizza"),
                           price = c(240, 300, 280))
  
  while (TRUE) {
    text = readline("What's your name?: ")
    
    if (text == 'exit') {
      print("Thank you for using our chatbot.")
      break
    }   else {
      print(paste("Hello! ", text, ". Here's the menu."))
      print(pizza_menu) 
      
      order = readline("What would you like to have? (type 'id'): ")
      order <- as.numeric(order)
      
      if (order %in% c(1,2,3)) {
        print(paste("Your order is ", pizza_menu[order, "pizza_name"]))
        user_draw = readline("We have a special promotion. Pick a number from 1-10 to win a voucher: ")
        
        lucky_num <- sample(x=1:10, size=1)
        user_draw <- as.numeric(user_draw)
        total <- as.numeric(pizza_menu[order, "price"])
        
        if (user_draw == lucky_num) {
          print("Congratulations! You won a 10% discount.")
          final_total = total*(90/100)
        } else {
          print("Sorry, you were so close. I will give you one more chance.")
          user_draw = readline("Pick a number from 1-10: ")
          if (user_draw == lucky_num) {
            print("Congratulations! You won a 10% discount.")
            final_total = total*(90/100)
          } else {
            print("Sorry, you missed it.")
            final_total = total
          }
        }  
        
        print(paste("Your total is ฿", final_total))
        
        payment_opt = readline("How would you like to pay? (options: cash/card): ")
        if (payment_opt %in% c("cash", "card")) {
          print("Thank you. Your order will be ready in 15 minutes.")
          break
        } else {
          print("Invalid input. Please try again.")
        }
      } else {
        print("Invalid input. Please try again.")
      } 
    }
  }
}

chatbot()
