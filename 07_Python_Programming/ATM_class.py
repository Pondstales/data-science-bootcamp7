class ATM:
    def __init__(self, name, bank, balance):
        self.name = name
        self.bank = bank
        self.balance = balance
    
    def otp(self, otp):
        print(f"Authentication complete. Hello, {self.name}. How can I help you today?")

    def deposit(self, amount):
        self.balance += amount
        print(f"You have just deposited ฿{amount}. Your current balance: ฿{self.balance}")

    def withdraw(self, amount):
        self.balance -= amount
        print(f"You have just withdrawn ฿{amount}. Your current balance: ฿{self.balance}")

    def exchange_aud(self, aud_amount):
        self.balance -= 22.54*aud_amount
        print(f"Successfully exchanged ฿{round(22.54*aud_amount, 2)} for A${aud_amount}.")
        print(f"Your current balance: ฿{round(self.balance, 2)}")

    def change_username(self, new_username):
        self.name = new_username
        print(f"Your username has been changed to '{self.name}'.")
