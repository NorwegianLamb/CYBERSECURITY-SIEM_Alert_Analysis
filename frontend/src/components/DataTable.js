import React from 'react';

function DataTable({ data, handleFileChange }) {
  return (
    <>
    <input type="file" accept=".csv" onChange={handleFileChange} />
    
    <div>
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
    </div>
    </>
  );
}

export default DataTable;
