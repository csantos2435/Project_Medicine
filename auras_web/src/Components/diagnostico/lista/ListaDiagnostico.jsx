import Diagnostico from "../diagnosticoItem/Diagnostico";
import Sidebar from "../sidebar/Sidebar";
import styles from './ListaDiagnostico.module.css';
import { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import api from '../../../services/api';

function ListaDiagnostico() {  
    const [diagnosticos, setDiagnosticos] = useState([]);
    const [searchTerm, setSearchTerm] = useState("");
    
    const location = useLocation();
    const { nome, imagem } = location.state || { 
        nome: "Usuário", 
        imagem: "https://img.freepik.com/vetores-premium/ilustracao-plana-vetorial-em-escala-de-cinza-avatar-perfil-de-usuario-pessoa-icone-imagem-de-perfil-perfil-de-negocio-de-uma-mulher-adequado-para-perfis-de-midia-social-icones-protetores-de-tela-e-como-um-modelox9_719432-1351.jpg?ga=GA1.1.1974532293.1682703455&semt=ais_hybrid" 
    };

    useEffect(() => {
        api.get('diagnosticos').then((response) => {
            setDiagnosticos(response.data);
        });
    }, []);

    const filteredDiagnosticos = diagnosticos.filter((diagnostico) => {
        return diagnostico.nomePaciente.toLowerCase().includes(searchTerm.toLowerCase()) || 
               diagnostico.cpf.includes(searchTerm) ||
               diagnostico.dataHora.includes(searchTerm);
    });

    return (
        <div className={styles.wrapper}>
            <Sidebar className={styles.sidebar} nome={nome} imagem={imagem} />
            <div className={styles.main}>
                <header className={styles.header}>Diagnósticos</header>
                <div className={styles.searchWrapper}>
                <input 
                    type="text" 
                    className={styles.pesquisa} 
                    placeholder="Buscar Diagnóstico" 
                    value={searchTerm} 
                    onChange={(e) => setSearchTerm(e.target.value)} 
                />
                </div>
                <div className={styles.resultado}>
                    {filteredDiagnosticos.map((diagnostico) => (
                        <Link 
                            to={`/resultado/${diagnostico.id}`} 
                            state={{ nome, imagem, diagnostico }}
                            key={diagnostico.id}
                        >
                            <Diagnostico 
                                nome={diagnostico.nomePaciente} 
                                cpf={diagnostico.cpf} 
                                dataHora={diagnostico.dataHora} 
                            />
                        </Link>
                    ))}
                </div>
            </div>
        </div>
    );
}

export default ListaDiagnostico;
