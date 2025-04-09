import './App.css'
import { useState } from "react";
import axios from "axios";

interface ApiResponse {
  [key: string]: any; // You can refine this based on the actual response structure
}

interface RequestBody {
  action: string;
  tfcall: string;
  parameters: Map<string, string>;
}

function App() {

  const [loading, setLoading] = useState<boolean>(false);
  const [responseData, setResponseData] = useState<ApiResponse | null>(null);

  const handleClick = (buttonType: string) => {
    setLoading(true);

    // depending on the type of button, create a different request body. Generally I think I might do a map of possible buttons and requests.
    // I guess its more logical to just create two different handlers..
    if(buttonType == "createAWS") {
      const requestBody: RequestBody = {
        action: "AWS/testAWSVMIaC",
        tfcall: "apply",
        parameters: new Map([
          ["tags", "{\"Owner\"=\"User\"}"]
        ])
      }

      axios
        .post<ApiResponse>("http://localhost:9090/v1/tf/", requestBody)
        .then((res) => {
          setResponseData(res.data); 
          setLoading(false); 
        })
        .catch((err) => {
          console.error("Error:", err);
          setLoading(false); 
        });
      }
      else if(buttonType == "destroyAWS") {
        const requestBody: RequestBody = {
          action: "AWS/testAWSVMIaC",
          tfcall: "destroy",
          parameters: new Map([
            ["tags", "{\"Owner\"=\"User\"}"]
          ])
        }
  
        axios
          .post<ApiResponse>("http://localhost:9090/v1/tf/", requestBody)
          .then((res) => {
            setResponseData(res.data); 
            setLoading(false); 
          })
          .catch((err) => {
            console.error("Error:", err);
            setLoading(false); 
          });
      }
  };

  return (
    <>
    <div className='app-container'>
      <div className='btn-container'>
        <button onClick={() => handleClick("createAWS")}>Create AWS VM</button>
        <button onClick={() => handleClick("destroyAWS")}>Destroy AWS VM</button>
      </div>
      <div className='result-container'>
        {loading && <div className="loading-spinner">Loading...</div>}
        {responseData && <h1>{JSON.stringify(responseData)}</h1>}
      </div>
    </div>
    </>
  )
}

export default App
