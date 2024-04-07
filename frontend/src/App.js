// import logo from './logo.png';
import {useState} from 'react';
import Papa from 'papaparse';
import './App.css';
import DataTable from './components/DataTable';
import Navbar from './components/Navbar';

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
      <header>
        <Navbar />
      </header>
      <body className="App-body">
        {/*<img src={logo} className="App-logo" alt="logo" />*/}
        <p>
          SIEM/SOAR Test
        </p>
        <input type="file" accept=".csv" onChange={handleFileChange} />
        <DataTable data={data} />
      </body>
    </div>
  );
}

export default App;
