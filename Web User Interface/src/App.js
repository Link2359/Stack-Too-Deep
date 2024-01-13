import buy from "./components/buy.js";
import sell from "./components/sell.js";
import invest from "./components/invest.js";
import viewInvestors from "./components/viewInvestors.js";
import withdraw from "./components/withdraw.js";
import { HashRouter, Route, Routes } from "react-router-dom";

function App() {
  return (
    <HashRouter>
      <Routes>
        <Route path="/buy" element={buy}/>
        <Route path="/sell" element={sell}/>
        <Route path="/withdraw" element={withdraw}/>
        <Route path="/view" element={viewInvestors}/>
        <Route path="/invest" element={invest}/>
      </Routes>
    </HashRouter>
  );
}

export default App;
