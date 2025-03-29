package actions

import (
	"fmt"
	"os/exec"
)

//OLD DESIGN but might be useful in the future to map string: func() pairs
// type used to invoke function with parameters in json format
// type ActionFunc func(string, map[string]string) error
// action map struct, key is action name, value is the function
// var ActionMap = map[string]ActionFunc{
// 	"create_test_az_vm": deployTf,
// }

// function definitions
func TfDeployment(action string, tfcall string, parameters map[string]string) error {
	command := fmt.Sprintf("cd ../Terraform/%s && terraform %s -auto-approve", action, tfcall)
	//append parameters to command (-var="<key>=<value>"). terraform files should have default values set for each parameter
	//if there are no parameters, just skip
	for key, value := range parameters {
		command += fmt.Sprintf(" -var='%s=%s'", key, value)
	}
	if tfcall != "destroy" {
		command += " && terraform output > response.txt"
	} else {
		command += " && echo Status = Demolished > response.txt"
	}

	//Debug
	fmt.Println(command)
	cmd := exec.Command("bash", "-c", command)
	return cmd.Run()
}

// Ansible based functions
