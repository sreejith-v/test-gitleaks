package main

import "fmt"

const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmYWtlVXNlcklkIiwibmFtZSI6IkZha2UgVXNlciIsImlhdCI6MTY1MDAwMDAwMH0.ZW5kcG9pbnRfaXNfZmFrZV9zZWNyZXQ"

func main() {
	fmt.Println("Hello, World!")
	//secretToken := GenerateFakeJWT()
	secretToken := token
	fmt.Println("Secret Token:", secretToken)
}
