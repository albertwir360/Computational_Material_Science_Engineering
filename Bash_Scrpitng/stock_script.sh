#!/bin/bash
echo "This script will create txt files for the adjusted daily closing price in centsfor
a given company (Given ticker symbol) during a period of time (given month and year).
The application runs on a loop so press [ctrl + c] to exit. "
#Part 1- read in user input ans store in variables
#echo the terminal to prompt the user to enter a stock name
#read command to store the user input into specified variables

# the while loop below makes sure that the user is constantly promted
while true; do
  echo -n "Please enter a Stock Name (ticker symbol- example: AAPL):"
  read stock_name;

  #For Part three we want to make sure that the user inputted month is valid
  echo -n 'Enter a month in numerical form using form (01-12): ';
  read month;
  while [[ $month -gt 12 ]] || [[ $month -lt 1 ]]; do
  echo -n 'Enter a month in numerical form (1-12): ';
  read month;
  done


  echo -n 'Enter Year:'
  read year;


  #check that it is returning the input when calling the variable name
  echo $stock_name
  echo $month
  echo $year


  #Part 2 - Implement yahoo finance
  bash get-yahoo-quotes.sh ${stock_name}
  # For Part three check to make sure that the ticker symbol exists if not prompt the user to reenter
  while [ ! -f "$stock_name".csv ]; do
  read -p "Re-enter valid stock ticker symbol:" stock_name
  ./get-yahoo-quotes.sh ${stock_name}
  done

  #filter out the csv file using awk and write to a new csv file
  #NOTE: the awk command is called from the .awk file

  awk -v regex="$year"-"$month" 'BEGIN{FS=","}; {if ($1~regex) {print $1, "  "$6*100}}'   $stock_name.csv > ${stock_name}_${month}_${year}_temp.txt
  tac ${stock_name}_${month}_${year}_temp.txt > tempo.txt

  rm ${stock_name}.csv
  rm ${stock_name}_${month}_${year}_temp.txt
  awk 'BEGIN{print "Date    Adjusted Closing price"}; {print}' tempo.txt > ${stock_name}_${month}_${year}.txt
  rm tempo.txt
  #Part 3
  #TODO:
  #1. Convert the dollars of adjusted closing prices to cents by multiplying the column by 100 (multiply $6 by 100)
  #2. NR is not needed to skip over the header as the the data points are extracted by filtering through an initially
  #produced csv file using awk and regex
  #Much of the task is handled by the simplcity of the function written in awk-command. Regex proved to minimizethe amount of work
  #necesary

  # Part 4 - Make the script more robust and easier to work with user
  # a. non historic month is checked above by making sure the months are in range of 1-12
  # b. the crumb is checked to see if the ticker is valid
  # c. command below will handle if there exists no data on the specific stock by outputing a message
  # d. this check is done by prompting the user's input with an example and explanation.

  count=$(wc -l < ${stock_name}_${month}_${year}.txt)
  echo $count
  if [ $count == 1 ]; then
    echo "File is empty indicating that there is no data for the particular stock and time period"
  fi
done
# print ("Date", "\t\t adjusted closing price in cents ")
