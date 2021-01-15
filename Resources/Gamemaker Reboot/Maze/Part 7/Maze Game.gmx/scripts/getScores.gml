//Initialize our data
names = ds_list_create();
scores = ds_list_create();

ini_open("scores.ini");
for(i = 0; i < 10; i++){
    currentName = ini_read_string("Names", i + 1, "<nobody>");
    currentScore = ini_read_string("Scores", i + 1, 0);
    ds_list_add(names, currentName);
    ds_list_add(scores, real(currentScore));
}

//Determine our place value
place = -1;
for(i = 0; i < 10; i++){
    if argument0 > scores[|i]{
        place = i;
        break;
    }
}

//Update our array
if place != -1{
    ds_list_insert(names, place, name);
    ds_list_insert(scores, place, argument0);
}

ini_close();
