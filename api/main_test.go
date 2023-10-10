package api

import (
	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/require"
	db "github.com/webbythien/simplebank/db/sqlc"
	"github.com/webbythien/simplebank/util"
	"os"
	"testing"
	"time"
)

func newTestServer(t *testing.T, store db.Store) *Server {
	config := util.Config{
		TokenSymmetricKey:   util.RandomString(32),
		AccessTokenDuration: time.Minute,
	}

	server, err := NewServer(config, store)
	require.NoError(t, err)

	return server
}

func TestMain(m *testing.M) {
	gin.SetMode(gin.TestMode)
	os.Exit(m.Run())

}
