import { BrowserRouter as Router} from 'react-router-dom';
import { Route, Routes } from 'react-router-dom';
import {useState} from 'react';
import Papa from 'papaparse';
import './App.css';
import DataTable from './components/DataTable';
import Navbar from './components/NavBar';
import Test from './components/Test';
import MapVisualizer from './components/MapVisualizer';

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
        <Routes>
          <Route path="/" element={<Test />} />
          <Route path= "/alerts-visualizer" element={<DataTable data={data} 
            handleFileChange={handleFileChange} />} />
          <Route path="/map-visualizer" element={<MapVisualizer/>} />
        </Routes>
      </body>
    </div>
  );
}

export default App;