package main

import "fmt"

const token = "REMOVED_TOKEN"

func main() {
	fmt.Println("Hello, World!")
	//secretToken := GenerateFakeJWT()
	secretToken := token
	fmt.Println("Secret Token:", secretToken)
}
