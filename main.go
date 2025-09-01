package main

import "fmt"
import "test-gitleaks/secrets"

func main() {
	fmt.Println("Hello, World!")
	secretToken := secrets.SecretToken
	fmt.Println("Secret Token:", secretToken)
}
