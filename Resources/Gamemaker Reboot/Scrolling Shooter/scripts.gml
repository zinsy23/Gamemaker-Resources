#define highscore
//Boundaries
x1 = room_width / 4;
x2 = room_width / 2 + room_width / 4;
y1 = room_height / 8;
y2 = room_height - room_height / 8;
offset = 15;
spacing = 35;

//Draw highscore table
draw_background_stretched(argument1, x1, y1, x2 - x1, y2 - y1);
if(argument2){
    draw_set_color(c_black);
    draw_rectangle(x1, y1, x2, y2, true);
}

if string_length(keyboard_string) < 20{
    name = keyboard_string;
} else keyboard_string = name;


ds_list_replace(names, place, name);
ds_list_replace(scores, place, argument0);

draw_set_font(highscore_font);

//Draw statistics
for(i = 0; i < 10; i++){
    draw_set_halign(fa_right);
    draw_set_color(argument4);
    if i == place draw_set_color(argument3);
    draw_text(x1 + 35, y1 + (offset + spacing * i), string(i + 1) + ")");
    draw_text(x2 - 15, y1 + (offset + spacing * i), scores[|i]);
    
    draw_set_halign(fa_left);
    draw_text(x1 + spacing + 10, y1 + (offset + spacing * i), names[|i]);
    if place != -1{
        draw_set_color(argument3);
        draw_text(x1 + spacing + 10, y1 + (offset + spacing * place), name+"|");
    }
}

if keyboard_check(vk_enter) && global.hi{
    ini_open("scores.ini");
    for(i = 0; i < 10; i++){
        ini_write_string("Names", i + 1, names[|i]);
        ini_write_string("Scores", i + 1, scores[|i]);
    }
    ini_close();
    game_restart();
}

#define getScores
//Load our arrays
names = ds_list_create();
scores = ds_list_create();

ini_open("scores.ini");

//Load our data
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

if place != -1{
    ds_list_insert(names, place, name);
    ds_list_insert(scores, place, argument0);
}

ini_close();
keyboard_string = "";
global.loaded = true;

#define pause
if global.hi || controller_life.counter > 0{
    speed = 0;
    background_vspeed[0] = 0;
    image_speed = 0;
    exit;
}

