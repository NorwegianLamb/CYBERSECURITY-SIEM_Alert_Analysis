import React from 'react';
import './style/Navbar.css';
import logo from '../assets/images/nav_logo.png'

function Navbar() {
  return (
    <>
      <img className="logo" src={logo} alt="logo" />
      <nav className="navbar">
        <ul className="nav_links">
          <li><a href="#">SIEM analysis</a></li>
          <li><a href="#">Alerts Visualizer</a></li>
          <li><a href="#">Map Visualizer</a></li>
        </ul>
      </nav>
      <a className="cta" href="#"><button>Login</button></a>
    </>
  );
}

export default Navbar;