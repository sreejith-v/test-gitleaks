package main

import "fmt"

func main() {
	token := "REMOVED_TOKEN"
	fmt.Println("Hello, World!")
	fmt.Println(token)
	secretToken := GenerateFakeJWT()
	fmt.Println("Secret Token:", secretToken)
}
