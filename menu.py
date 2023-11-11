def main_menu():
    while True:
        print("\n==============================")
        print("     My Program Menu")
        print("==============================")
        print("1. Option 1")
        print("2. Option 2")
        print("3. Option 3")
        print("4. Exit")

        choice = input("Enter your choice: ")

        if choice == "1":
            option1()
        elif choice == "2":
            option2()
        elif choice == "3":
            option3()
        elif choice == "4":
            break
        else:
            print("Invalid choice. Please try again.")

def option1():
    print("You chose option 1")
    # Insert your code for option 1 here

def option2():
    print("You chose option 2")
    # Insert your code for option 2 here

def option3():
    print("You chose option 3")
    # Insert your code for option 3 here

if __name__ == "__main__":
    main_menu()