import React from 'react';
import './style/Navbar.css';
import logo from '../assets/images/nav_logo.png'
import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <>
      <img className="logo" src={logo} alt="logo" />
      <nav className="navbar">
        <ul className="nav_links">
          <li><a><Link to="/">SIEM analysis</Link></a></li>
          <li><a><Link to="/alerts-visualizer">Alerts Visualizer</Link></a></li>
          <li><a><Link to="/map-visualizer">Map Visualizer</Link></a></li>
        </ul>
      </nav>
      <a className="cta" href="#"><button>Login</button></a>
    </>
  );
}

export default Navbar;