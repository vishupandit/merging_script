chmod +x $0
merg ()
{
clear
echo "\t#######################################################################################\n"
echo "\t\t\t\tMerge the files into One file\n" 
echo "\t#######################################################################################\n"

echo "\n\tInstruction to run the script: \n"
echo "\t1.The Script must be save in new folder."
echo "\t2.Only the files which we are going to merge should be in folder."
echo "\t3.The Script must be run once."
echo "\t4.While running script you need to rename the output merged file. "
sleep 3
count=`ls|tail -n+2|wc -l|tr -s ' '|cut -d ' ' -f2` 
echo "\n\tTotal no. of files to merge are : $count\n"
sleep 2
ls|tail -n+2 > ../tmp.csv 
   echo "\n\tPlease wait while your files being merged...\n"
   mkdir Merged
while read l
 do
    awk 'FNR==1{print ""}1' $l >> merged_out
    echo "\n\tFile $l has been merged. "
    sleep 2
done < ../tmp.csv
    echo "\n"  
    read -p "        Please enter the merged file output name : " userin
    mv merged_out Merged/$userin
rm -rf ../tmp.csv

echo "\t."
sleep 1
echo "\t.."
sleep 1
echo "\t..."
sleep 1
echo "\n\tYour files are merged together successfully. \n"
}

spl_moth ()
{   
   clear
   echo "\t---------------------------------------------------------------------------------------------------------------------------------"
   echo "\n\t                                 Removal of Special character and mother-name Replacement\n"
   echo "\t---------------------------------------------------------------------------------------------------------------------------------"
   
   ls|tail -n+2 > ../tmp001
   count1=`ls|tail -n+2|wc -l|tr -s ' '|cut -d ' ' -f2` 
   echo "\n\tTotal no. of files to be procecced are : $count1\n"
   mkdir Processed
   sleep 2   
   echo "\n\tPlease wait while your files being processed...\n"
   sleep 2
   while read sf
   do
      cat $sf|sed 's/[][\`.@":}{)#(;!]//g'|sed "s/\\// /g"|sed "s/'//g"|sed "s/_/ /" > file12
   
      cat file12|awk '{print $0"##"}' > ../tp1
   
      sed -i 's/,##/,Mother/g' ../tp1
      sed -i 's/,0##/,Mother/g' ../tp1
      sed -i 's/,00##/,Mother/g' ../tp1
      sed -i 's/,-##/,Mother/g' ../tp1
      sed -i 's/,--##/,Mother/g' ../tp1
   
   
      cat ../tp1 | sed 's/-/ /g'|sed 's/mother/Mother/g'|sed 's/MOTHER/Mother/g'|sed 's/,o##/,Mother/g'|sed 's/,oo##/,Mother/g'|sed 's/mther/Mother/g'|sed 's/mOTHER/Mother/g'|sed 's/mothr/Mother/g'|sed 's/##/ /g' > users\_$sf 
   
      echo "\n\tFile $sf has processed and renamed to users\_$sf"
      sleep 2
      mv users\_$sf Processed/   
   
    done < ../tmp001
      
      rm -rf file12
      rm -rf ../tp1
      rm -rf ../tmp001
      echo "\n\tDone\n\n"
}

response ()
{
   echo "\n\tDo you want to Exit : [ y | n ]" 
   read f
   if [ $f = y -o $f = Y -o $f = YES -o $f = yes -o $f = Yes ]; then
      echo "\n\tExiting .............bye\n"
      exit
   else 
      continue
   fi
}
print_menu ()
{
 clear
 echo "\n\t   MENU  "
 echo "\n\t1] Removal of Special character and mother-name Replacement"
 echo "\n\t2] Merging File Together"
 echo "\n\t3] Exit   "
 echo "\n\tEnter your choice :\n"
 read ch
 case $ch in
 1)spl_moth 
   response 
   ;;
 2)merg 
   response
   ;;
 3)echo "\n\tExiting .............bye\n"
   exit
   ;;
 *)echo "\n\tYou have entered invalid choice."  
   response
   ;;
esac
}

while [ 0 ];
  do 
    print_menu
    response
done
