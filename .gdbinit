set print static-members off
set print pretty on
macro define offsetof(t, f) &((t *) 0)->f)  # https://stackoverflow.com/questions/1768620/how-do-i-show-what-fields-a-struct-has-in-gdb#comment78715348_1770422
