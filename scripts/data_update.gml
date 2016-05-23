var s_a;
for (i = 0; i < instance_number(obj_player_ship); i++)
{
    s_a = instance_find(obj_player_ship, i);
    ini_open("data.ini");
    ini_write_real(s_a.name, "image_angle", s_a.image_angle);
    ini_write_real(s_a.name, "x", s_a.x);
    ini_write_real(s_a.name, "y", s_a.y);
    ini_close();
}
