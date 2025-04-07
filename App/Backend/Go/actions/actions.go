package actions

import (
	"fmt"
	"os/exec"
	"strings"
)

// as Ive stated earlier, this will be stored in some sort of a db once I do the research and make a choice
var Deployments = map[string][]string{}

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
		// this -raw flag will output the ip only
		command += " && terraform output -raw public_ip > response.txt"
	} else {
		command += " && echo Status = Demolished > response.txt"
	}

	// I will test what works better - single bash command and output trimming or two bash commands without output trimming
	fmt.Println(command)
	cmd := exec.Command("bash", "-c", command)
	if err := cmd.Run(); err != nil {
		return fmt.Errorf("error running command")
	}
	command = fmt.Sprintf("cd ../Terraform/%s && terraform state list", action)
	cmd = exec.Command("bash", "-c", command)
	output, err := cmd.Output()
	// need to have a way for storing the deployments, need to think again about future use cases if this map approach will suffice (ofc in a separate db)
	updateDeployments(action, string(output))
	return err
}

func GetAllTfDeployments() map[string]interface{} {
	jsonData := make(map[string]interface{})
	for key, value := range Deployments {
		jsonData[key] = value
	}
	return jsonData
}

func updateDeployments(key string, output string) {
	Deployments[key] = strings.Split(output, "\n")
}

// Ansible based functions
