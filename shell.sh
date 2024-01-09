#!/bin/bash

echo "  Welcome to"
echo "    /\\_/\\ "
echo "   ( o.o )"
echo "    > ^ <"
echo "    Meow!"
echo "Medicine Store."
echo " "

# Add a user-specific order history file
order_history_file="order_history.txt"

# Function to generate a random transaction ID 
generate_transaction_id() {
  echo "$(date +%Y%m%d%H%M%S)-$(shuf -i 1000-9999 -n 1)"
}

# Function to register a new user
register_user() {
  echo "-------------------------------------------------------"
  echo "Enter your desired username:"
  read username
  echo "Enter your password:"
  read -s password
  echo "$username:$password" >> user_credentials.txt
  echo "Registration successful!"
  echo "-------------------------------------------------------"
}

# Function to authenticate a user
authenticate_user() {
  echo "-------------------------------------------------------"
  echo "Enter your username:"
  read username
  echo "Enter your password:"
  read -s password
  if grep -q "$username:$password" user_credentials.txt; then
    echo "Login successful!"
  else
    echo "Invalid username or password. Please try again."
    authenticate_user
  fi
}

# Function to collect user information before payment
collect_user_info() {
  echo "-------------------------------------------------------"
  echo "Enter your full name:"
  read full_name

  echo "Enter your address:"
  read address

  echo "Enter your phone number:"
  read phone_number
  
  echo "Enter your OTP:"
  read otp
  echo "-------------------------------------------------------"
  
  # Save user information in a file
  echo "User Information:" > user_info.txt
  echo "Full Name: $full_name" >> user_info.txt
  echo "Address: $address" >> user_info.txt
  echo "Phone Number: $phone_number" >> user_info.txt
  echo "OTP: $otp" >> user_info.txt
}

# Function to process payment
process_payment() {
  local transaction_id="$1"
  local total_price="$2"

  # Collect user information
  collect_user_info

  echo "-------------------------------------------------------"
  echo "Select a payment method:"
  echo "1. bKash"
  echo "2. Nagad"
  read payment_method
  echo "-------------------------------------------------------"

  case $payment_method in
    1)
      echo "Please make the payment using bKash to phone number 01954615817"  
      ;;

    2)
      echo "Please make the payment using Nagad to phone number 01954615817" 
      ;;

    *)
      echo "Your order is in pending. You will get an email after approval! Thanks for your order."
      ;;
  esac

  # Ask for payment transaction ID (Assuming manual verification)
  echo "Enter the payment transaction ID (manual verification):"
  read entered_transaction_id

  # Display a message indicating that the order is in pending
  echo "Your order is in pending. You will get an email after approval! Thanks for your order."

  # Save the transaction details for manual verification
  save_transaction_details "$transaction_id" "Payment Method: $payment_method, Transaction ID: $entered_transaction_id"
}

# Function to save transaction details to a log file
save_transaction_details() {
  local transaction_id="$1"
  local order="$2"
  echo "$transaction_id: $order" >> transaction_log.txt
}

# Function to check if a transaction ID exists in the text file
is_valid_transaction_id() {
  local id="$1"
  if grep -q "$id" transaction_log.txt; then
    return 0  # Found
  else
    return 1  # Not found
  fi
}

# Function to display the fever and gas medicine menu
display_fever_and_gas() {
  echo "Fever & Gastrology Medicine"
  echo "1. Napa (10 tk)"
  echo "2. Napa Extra (15 tk)"
  echo "3. Xpac (10 tk)"
  echo "4. Rab 20 mg (65 tk)"
  echo "5. Aciphex (40 tk)"
  echo "6. NIMSE 199 mg (40 tk)"
}

# Function to display the cold medicine menu
display_cold() {
  echo "Cold"
  echo "7. Acrivastine (50 tk)"
  echo "8. Aspirin (40 tk)"
  echo "9. Benz (50 tk)"
  echo "10. Dopy 10 mg (30 tk)"
  echo "11. Eaze 10 mg (40 tk)"
}

# Function to display the pain killer and slipping medicine menu
display_pain_killer_and_slipping() {
  echo "Pain killer & Slipping"
  echo "12. Tapenda 20 mg (40 tk)"
  echo "13. Toltrazoril 10 mg (40 tk)"
  echo "14. Sedil 2.5 mg (40 tk)"
  echo "15. Sedil 5 mg (40 tk)"
}

# Function to display the menu based on user selection
display_menu() {
  local menu_choice="$1"

  case $menu_choice in
    1)
      display_fever_and_gas
      ;;
    2)
      display_cold
      ;;
    3)
      display_pain_killer_and_slipping
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit
      ;;
  esac
}

# Function to display the menu and handle orders
display_menu_and_order() {
  while true; do
    echo "Select a menu:"
    echo "1. Fever & Gastrology Medicine"
    echo "2. Cold"
    echo "3. Pain killer & Slipping"
    echo "4. Order History"
    echo "5. Exit"
    read menu_choice

    case $menu_choice in
      1 | 2 | 3)
        display_menu "$menu_choice"
        cart=()  # Initialize the cart

        while true; do
          echo "Add items to your cart or enter 'done' to proceed to payment."
          read choice

          if [ "$choice" == "done" ]; then
            break
          elif [ $choice -ge 1 ] && [ $choice -le 15 ]; then
            item_name=""
            case $choice in
              1)
                item_name="Napa"
                price=10
                ;;
              2)
                item_name="Napa Extra"
                price=15
                ;;
              3)
                item_name="Xpac"
                price=10
                ;;
              4)
                item_name="Rab 20 mg"
                price=65
                ;;
              5)
                item_name="Aciphex"
                price=40
                ;;
              6)
                item_name="NIMSE 199 mg"
                price=40
                ;;
              7)
                item_name="Acrivastine"
                price=50
                ;;
              8)
                item_name="Aspirin"
                price=40
                ;;
              9)
                item_name="Benz"
                price=50
                ;;
              10)
                item_name="Dopy 10 mg"
                price=30
                ;;
              11)
                item_name="Eaze 10 mg"
                price=40
                ;;
              12)
                item_name="Tapenda 20 mg"
                price=40
                ;;
              13)
                item_name="Toltrazoril 10 mg"
                price=40
                ;;
              14)
                item_name="Sedil 2.5 mg"
                price=40
                ;;
              15)
                item_name="Sedil 5 mg"
                price=40
                ;;

              *)
                echo "Invalid choice. Please choose a valid option."
                continue
                ;;
            esac

            echo "How many $item_name do you want to add to your cart?"
            read item_quantity
            item_total_price=$((item_quantity * price))
            cart+=("$item_name x $item_quantity ($item_total_price tk)")
            echo "$item_name x $item_quantity added to cart."
          else
            echo "Invalid choice. Please choose a valid option."
          fi
        done

        if [ ${#cart[@]} -eq 0 ]; then
          echo "Your cart is empty. Goodbye!"
          continue
        fi

        # Display the items in the cart
        echo "Items in Your Cart:"
        for item in "${cart[@]}"; do
          echo "$item"
        done

        # Display the order total
        echo "Calculating Your Total Bill..."
        total_price=0
        for item in "${cart[@]}"; do
          item_price=$(echo "$item" | grep -o -P '\d+(?=\s*tk)')
          total_price=$((total_price + item_price))
        done
        echo "Your Total Bill is: $total_price tk"

        # Save the user's current order to order history
        save_user_order "$username" "$transaction_id" "Cart: ${cart[*]} (Total: $total_price tk)"

        # Process payment
        process_payment "$transaction_id" "$total_price"
        ;;
      4)
        display_order_history "$username"
        ;;
      5)
        echo "Goodbye!"
        exit
        ;;
      *)
        echo "Invalid choice. Please choose a valid option."
        ;;
    esac
  done
}

# Function to save user-specific order details to a file
save_user_order() {
  local username="$1"
  local transaction_id="$2"
  local order="$3"
  echo "$username: $transaction_id: $order" >> $order_history_file
}

# Function to display order history for a user
display_order_history() {
  local username="$1"
  if [ -e "$order_history_file" ]; then
    echo "Order History for $username:"
    grep "$username" $order_history_file | cut -d' ' -f2-  # Displaying only transaction details
  else
    echo "No order history found for $username."
  fi
}

# Main script

echo "1. Register"
echo "2. Login"
read login_choice

case $login_choice in
  1)
    register_user
    authenticate_user
    display_menu_and_order
    ;;
  2)
    authenticate_user
    display_menu_and_order
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit
    ;;
esac

