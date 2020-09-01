class User:		# here's what we have so far
    def __init__(self, name, email):
        self.name = name
        self.email = email
        self.account_balance = 0


    # adding the deposit method
    def make_deposit(self, amount):	# takes an argument that is the amount of the deposit
    	self.account_balance += amount	# the specific user's account increases by the amount of the value received

    # adding the deposit method
    def make_withdrawal(self, amount):	# takes an argument that is the amount of the deposit
    	self.account_balance -= amount	# the specific user's account increases by the amount of the value received

    # adding the deposit method
    def display_user_balance(self):	# takes an argument that is the amount of the deposit
        print("User:",self.name, "Balance: $",self.account_balance)



manal = User("manal","E1")
anna = User("anna","E2")
michael = User("michael","E3")

manal.make_deposit(50)
manal.make_deposit(50)
manal.make_deposit(50)

manal.make_withdrawal(50)
manal.display_user_balance() # 100


anna.make_deposit(10)
anna.make_deposit(20)
anna.make_withdrawal(10)
anna.make_withdrawal(20)

anna.display_user_balance() # 0


michael.make_deposit(50)
michael.make_withdrawal(20)
michael.make_withdrawal(20)
michael.make_withdrawal(10)
michael.display_user_balance() # 0
