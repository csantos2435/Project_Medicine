import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import NovoDiagnostico from './Components/diagnostico/novo/NovoDiagnostico';
import Resultado from './Components/diagnostico/resultado/Resultado';
import FormLogin from './Components/login/form/FormLogin';
import FormCadastro from './Components/cadastro/form/FormCadastro';
import ListaDiagnostico from './Components/diagnostico/lista/ListaDiagnostico';

import './global.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<FormLogin />} />
        <Route path="/cadastro" element={<FormCadastro />} />
        <Route path="/novo-diagnostico" element={<NovoDiagnostico />} />
        <Route path="/resultado/:id" element={<Resultado />} />
        <Route path="/lista-diagnostico" element={<ListaDiagnostico />} />
      </Routes>
    </Router>
  );
}

export default App;
