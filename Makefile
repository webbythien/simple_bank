postgres:
	sudo docker run --name postgres15-3 -p 5432:5432  -e POSTGRES_USER=root -e   POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	sudo docker exec -it postgres15-3 createdb --username=root --owner=root simple_bank

dropdb:
	sudo  docker exec -it postgres15-3 dropdb  simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migratedown migrateup generate test
