-- backup, cron
-- pgcron

-- pl/pgsql
/*
DDL - definition lang (create, drop, alter)
DML - manipulation lang (insert, update, delete)
DQL - query lang (select)
DTL - transaction lang (commit, rollback, savepoint)
DCL - control lang (grant, revoke)




Section 5. Backup & Restore Databases



pg_restore -h 12.10.4.15
pg_restore –host=12.10.4.15





pg_dump -d ism_db -F tar > ism_db.tar
pg_restore -h HOST -C -d postgres < ism_db.tar


psql -h 10.10.3.161
pg_restore -h 10.10.3.161 -d testing_db < testing_db.tar


pg_dump -d testing_db -F tar > testing_db.tar
pg_restore -d sarvar_db < sarvar_db.tar


ssh sarvarbek@10.10.3.161

pg_restore -C -d postgres < testing_db.tar

scp sarvar_db.tar sarvar@10.10.2.24:/manzil


sudo apt-get install openssh-server
sudo systemctl enable ssh --now


docker run  --name postgres_container -e POSTGRES_PASSWORD=1 -p 5432:5432 -d postgres:alpine




*/




