let g:db_ui_execute_on_save = 0
let g:db_ui_force_echo_notifications = 1

let g:db_ui_icons = {
\ 'expanded': '+',
\ 'collapsed': '-',
\ }

let g:db_ui_table_helpers = {
\   'postgresql': {
\     'List': 'SELECT * FROM {table} LIMIT 200',
\     'Columns': "SELECT * FROM information_schema.columns WHERE table_name = '{table}' AND table_schema = 'public'",
\     'Primary Keys': "SELECT * FROM information_schema.table_constraints WHERE constraint_type = 'PRIMARY KEY' AND table_schema = 'public' AND table_name = '{table}'",
\     'Indexes': "SELECT * FROM pg_indexes WHERE tablename='{table}' AND schemaname='public'",
\   }
\ }
