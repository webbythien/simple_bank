DB_URL = postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
network:
	docker network create bank-network

postgres:
	sudo docker run --name postgres15-3 --network bank-network -p 5432:5432  -e POSTGRES_USER=root -e   POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	sudo docker exec -it postgres15-3 createdb --username=root --owner=root simple_bank

dropdb:
	sudo  docker exec -it postgres15-3 dropdb  simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/webbythien/simplebank/db/sqlc Store

evans:
	evans --host localhost --port 9090 -r repl

proto:
	rm -f pb/*.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	proto/*.proto
.PHONY: postgres createdb dropdb migratedown migrateup migratedown1 migrateup1 generate test server mock proto evans
