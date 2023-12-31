package db

import (
	"database/sql"
	_ "github.com/lib/pq"
	"github.com/webbythien/simplebank/util"
	"log"
	"os"
	"testing"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("Cannot load env", err)
	}

	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to DB", err)
	}

	testQueries = New(testDB)

	os.Exit(m.Run())

}
