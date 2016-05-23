var s_a, s_test;
s_test = 0;
for (i = 0; i < instance_number(obj_player_ship); i++)
{
    s_a = instance_find(obj_player_ship, i);
    if (s_a.name == argument0)
    {
        s_test = 1;
        break;
    }
}
if (s_test)
{
    return s_a;
}
else
{
    return noone;
}
