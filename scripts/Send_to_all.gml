for(ii = 0; ii < ds_list_size(obj_general.SocketList); ii++)
{
    var result = ds_list_find_value(obj_general.SocketList,ii);
    network_send_packet(result, obj_general.Buffer, buffer_tell(obj_general.Buffer));
}
