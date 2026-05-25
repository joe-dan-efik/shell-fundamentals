#!/bin/bash

TODO_FILE="$HOME/todo.txt"
touch "$TODO_FILE"

while true; do
    echo "============================="
    echo "    TO-DO LIST MANAGER       "
    echo "============================="
    echo "1. View all tasks"
    echo "2. Add a new task"
    echo "3. Delete a task"
    echo "4. Exit"
    echo "============================="
    read -p "Choose an option (1-4): " choice

    case $choice in
        1)
            echo -e "\n--- Your Current Tasks ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "Your to-do list is empty!"
            else
                nl -w2 -s". " "$TODO_FILE"
            fi
            echo -e "--------------------------\n"
            ;;
        2)
            read -p "Enter the new task: " new_task
            if [ -z "$new_task" ]; then
                echo -e "\n❌ Task cannot be empty!\n"
            else
                echo "$new_task" >> "$TODO_FILE"
                echo -e "\n✅ Task added successfully!\n"
            fi
            ;;
        3)
            echo -e "\n--- Current Tasks ---"
            if [ ! -s "$TODO_FILE" ]; then
                echo "No tasks available to delete."
            else
                nl -w2 -s". " "$TODO_FILE"
                echo "--------------------"
                read -p "Enter the task number to delete: " task_num
                
                total_lines=$(wc -l < "$TODO_FILE")
                if [[ "$task_num" =~ ^[0-9]+$ ]] && [ "$task_num" -le "$total_lines" ] && [ "$task_num" -gt 0 ]; then
                    sed -i "${task_num}d" "$TODO_FILE"
                    echo -e "\n🗑️  Task #$task_num deleted successfully!\n"
                else
                    echo -e "\n❌ Invalid task number!\n"
                fi
            fi
            ;;
        4)
            echo -e "\nGoodbye! 👋"
            exit 0
            ;;
        *)
            echo -e "\n❌ Invalid choice!\n"
            ;;
    esac
done
