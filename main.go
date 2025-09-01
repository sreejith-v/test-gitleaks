package main

import "fmt"

func main() {
	fmt.Println("Hello, World!")
	secretToken := GenerateFakeJWT()
	fmt.Println("Secret Token:", secretToken)
}
