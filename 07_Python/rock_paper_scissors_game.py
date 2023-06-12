import random

def play_game():

    user_pts = 0
    com_pts = 0
    options = ["R", "P", "S"]

    name = input("What's your name?: ")
    print(f"Hello! {name}. Let's play rock-paper-scissors.")
    print("""Instruction: Type 'R' for rock, 'P' for paper, and 'S' for scissors.
If you want to end the game, type 'exit'.""")
    
    while True:
        user_select = input("Choose one: ")
        user_select = user_select.upper()
        com_select = random.choice(options)

        if user_select == com_select:
            user_pts += 0
            com_pts += 0
            print(f"{user_select} vs {com_select}... Tie!")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "R" and com_select == "P":
            user_pts += 0
            com_pts += 1
            print(f"{user_select} vs {com_select}... You lost.")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "R" and com_select == "S":
            user_pts += 1
            com_pts += 0
            print(f"{user_select} vs {com_select}... You won!")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "P" and com_select == "S":
            user_pts += 0
            com_pts += 1
            print(f"{user_select} vs {com_select}... You lost.")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "P" and com_select == "R":
            user_pts += 1
            com_pts += 0
            print(f"{user_select} vs {com_select}... You won!")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "S" and com_select == "R":
            user_pts += 0
            com_pts += 1
            print(f"{user_select} vs {com_select}... You lost.")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "S" and com_select == "P":
            user_pts += 1
            com_pts += 0
            print(f"{user_select} vs {com_select}... You won!")
            print(f"Your score: {user_pts}  Computer score: {com_pts}")

        elif user_select == "EXIT":
            if user_pts == com_pts:
                return(f"Tie! Good game. Your score: {user_pts}  Computer score: {com_pts}")
            elif user_pts > com_pts:
                return(f"Congrats! You won. Your score: {user_pts}  Computer score: {com_pts}")
            else:
                return(f"You lost. Let's play again next time. Your score: {user_pts}  Computer score: {com_pts}")
        
        else:
            print("Invalid input. Please try again.")

play_game()
