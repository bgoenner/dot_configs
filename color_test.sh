
# color escape chars example \e[34;47m \e[0m

echo -e "    \e[30;m30    Black \e[31;m31    Red \e[32;m32    Green \e[33;m33    Yellow \e[34;m34    Blue \e[35;m35    Magenta \e[36;m36    Cyan \e[37;m37    White\e[0m"
echo -e "    \e[90;m90 Br Black \e[91;m91 Br Red \e[92;m92 Br Green \e[93;m93 Br Yellow \e[94;m94 Br Blue \e[95;m95 Br Magenta \e[96;m96 Br Cyan \e[97;m97 Br White\e[0m"
for n in 0 1 2 3 4 5 6 7;
do
  echo -e "4$n  \e[30;4$n;m30    Black \e[31;4$n;m31    Red \e[32;4$n;m32    Green \e[33;4$n;m33    Yellow \e[34;4$n;m34    Blue \e[35;4$n;m35    Magenta \e[36;4$n;m36    Cyan \e[37;4$n;m37    White\e[0m"
  echo -e "4$n  \e[90;4$n;m90 Br Black \e[91;4$n;m91 Br Red \e[92;4$n;m92 Br Green \e[93;4$n;m93 Br Yellow \e[94;4$n;m94 Br Blue \e[95;4$n;m95 Br Magenta \e[96;4$n;m96 Br Cyan \e[97;4$n;m97 Br White\e[0m"
  echo -e "10$n \e[30;10$n;m30    Black \e[31;10$n;m31    Red \e[32;10$n;m32    Green \e[33;10$n;m33    Yellow \e[34;10$n;m34    Blue \e[35;10$n;m35    Magenta \e[36;10$n;m36    Cyan \e[37;10$n;m37    White\e[0m"
  echo -e "10$n \e[90;10$n;m90 Br Black \e[91;10$n;m91 Br Red \e[92;10$n;m92 Br Green \e[93;10$n;m93 Br Yellow \e[94;10$n;m94 Br Blue \e[95;10$n;m95 Br Magenta \e[96;10$n;m96 Br Cyan \e[97;10$n;m97 Br White\e[0m"
done
