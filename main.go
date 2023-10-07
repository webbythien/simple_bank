package main

import (
	"database/sql"
	_ "github.com/lib/pq"
	"github.com/webbythien/simplebank/api"
	db "github.com/webbythien/simplebank/db/sqlc"
	"github.com/webbythien/simplebank/util"
	"log"
)

func main() {
	config, err := util.LoadConfig(".")
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to DB", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Cannot start server: ", err)

	}
}
