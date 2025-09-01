package main

import (
	"github.com/golang-jwt/jwt/v5"
	"time"
)

var fakeKey = []byte("TEST_KEY_NOT_REAL")

func GenerateFakeJWT() string {
	claims := jwt.MapClaims{
		"sub":    "test-user",
		"groups": []string{"admin", "dev-team"},
		"user":   "test-user",
		"exp":    time.Now().Add(time.Minute * 5).Unix(),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signed, _ := token.SignedString(fakeKey)
	return signed
}
