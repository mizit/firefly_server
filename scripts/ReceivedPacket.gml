var buffer = argument[ 0 ];
var socket = argument[ 1 ];
var msgid = buffer_read( buffer , buffer_u8 );
switch( msgid ) 
{
    case NET_GOOD_DAY:
    {
        var login, password, t;
        login = buffer_read(buffer, buffer_string);
        password = buffer_read(buffer, buffer_string);
        var a, bp;
        a = find_ship(login);
        bp = a.password;
        if (a)
        {
            if (bp == password)
            {
                t = 1;
            }
            else
            {
                //show_message(ini_read_string(login, "password", "wrong"));
                t = 0;
            }
        }
        else
        {
            t = 0;
        }
        if (t)
        {
            global.max_players+=1
            buffer_seek(Buffer, buffer_seek_start, 0);
            buffer_write(Buffer, buffer_u8, 1);
            buffer_write(Buffer, buffer_u16, global.max_players);
            buffer_write(Buffer, buffer_f32, a.image_angle);
            buffer_write(Buffer, buffer_f32, a.x);
            buffer_write(Buffer, buffer_f32, a.y);
            network_send_packet(socket, Buffer, buffer_tell(Buffer));
            a.pl_id = global.max_players;
            a.name = login;
            for (i = 0; i < instance_number(obj_player_ship); i++)
            {
                Send_ship_data(instance_find(obj_player_ship, i));
            }
        }
        else
        {
            buffer_seek( Buffer , buffer_seek_start , 0 );
            buffer_write( Buffer , buffer_u8 , 1 );
            buffer_write( Buffer , buffer_u16,  0);
            network_send_packet( socket , Buffer , buffer_tell( Buffer ) );
        }
        break;
    }
    case NET_BASE_DATA:
    {
        var pid;
        pid = buffer_read(buffer , buffer_s32 );
        var bship = noone;
        for (i = 0; i < instance_number(obj_player_ship); i++)
        {
            if (instance_find(obj_player_ship, i).pl_id == pid)
            {
                bship = instance_find(obj_player_ship, i);
            }
        }
        if (bship)
        {
            buffer_read(buffer, buffer_string);
            bship.image_angle = buffer_read(buffer, buffer_f32 );
            bship.x = buffer_read(buffer, buffer_f32 );
            bship.y = buffer_read(buffer, buffer_f32 );  
            Send_ship_data(bship);
            /*buffer_seek(Buffer , buffer_seek_start , 0 );
            buffer_write(Buffer, buffer_u8, NET_BASE_DATA);
            buffer_write(Buffer, buffer_s32, bship.pl_id);
            buffer_write(Buffer, buffer_f32, bship.image_angle);
            buffer_write(Buffer, buffer_f32, bship.x);
            buffer_write(Buffer, buffer_f32, bship.y);
            Send_to_all();*/
        }
        break;
    }
    case NET_ALL_DATA:
    {
        var pid;
        pid = buffer_read(buffer , buffer_s32 );
        var bship = noone;
        for (i = 0; i < instance_number(obj_player_ship); i++)
        {
            if (instance_find(obj_player_ship, i).pl_id == pid)
            {
                bship = instance_find(obj_player_ship, i);
            }
        }
        if (bship)
        {
            Send_all_ship_data(bship, socket);
        }
        break;
    }
}
