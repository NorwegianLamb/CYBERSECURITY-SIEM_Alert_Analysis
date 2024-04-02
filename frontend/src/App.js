// import logo from './logo.png';
import {useState} from 'react';
import Papa from 'papaparse';
import './App.css';

function App() {

  const [data,setData] = useState([]);
  const handleFileChange = (event) => {
    const file = event.target.files[0];
    parseCSV(file);
  };
  const parseCSV = (file) => {
    Papa.parse(file, {
      complete: (result) => {
        console.log('Parsed Result:', result);
        setData(result.data);
      },
      header: true,
    });
  };

  return (
    <div className="App">
      <header className="App-header">
        {/*<img src={logo} className="App-logo" alt="logo" />*/}
        <p>
          SIEM/SOAR Test
        </p>
        <input type="file" accept=".csv" onChange={handleFileChange} />
        <table>
          <thead>
            <tr>
              {data[0] && Object.keys(data[0]).map((header) => (
                <th key={header}>{header}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {data.map((row, index) => (
              <tr key={index}>
                {Object.values(row).map((value, index) => (
                  <td key={index}>{value}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </header>
    </div>
  );
}

export default App;
