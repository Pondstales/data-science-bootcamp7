def chatbot():
    pizzas = []
    print("Instruction: Type 'exit' to end the program")
    print("""Welcome to our pizza restaurant! Here's the menu
Pizza Menu: Pepperoni, Margherita, Hawaiian, Cheese""")
    
    while True:
        pizza = input("What pizza do you want to order? ")
        if pizza == "exit":
            print(f"Thank you! Your orders are ({len(pizzas)}):")
            return pizzas
        pizzas.append(pizza)

chatbot()
