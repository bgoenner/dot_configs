
# color escape chars example \e[34;47m \e[0m

for n in 0 1 2 3 4 5 6 7;
do
  echo -e "\e[30;4$n;m   Black \e[31;4$n;m   Red \e[32;4$n;m   Green \e[33;4$n;m   Yellow \e[34;4$n;m   Blue \e[35;4$n;m   Magenta \e[36;4$n;m   Cyan \e[37;4$n;m   White\e[0m"
  echo -e "\e[90;4$n;mBr Black \e[91;4$n;mBr Red \e[92;4$n;mBr Green \e[93;4$n;mBr Yellow \e[94;4$n;mBr Blue \e[95;4$n;mBr Magenta \e[96;4$n;mBr Cyan \e[97;4$n;mBr White\e[0m"
  echo -e "\e[30;10$n;m   Black \e[31;10$n;m   Red \e[32;10$n;m   Green \e[33;10$n;m   Yellow \e[34;10$n;m   Blue \e[35;10$n;m   Magenta \e[36;10$n;m   Cyan \e[37;10$n;m   White\e[0m"
  echo -e "\e[90;10$n;mBr Black \e[91;10$n;mBr Red \e[92;10$n;mBr Green \e[93;10$n;mBr Yellow \e[94;10$n;mBr Blue \e[95;10$n;mBr Magenta \e[96;10$n;mBr Cyan \e[97;10$n;mBr White\e[0m"
done
