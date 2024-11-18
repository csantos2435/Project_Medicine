import Header from "../header/Header";
import Sidebar from "../sidebar/Sidebar";
import styles from './Resultado.module.css';

import { useLocation } from 'react-router-dom';

function Resultado() {
    const location = useLocation();
    const { 
        nome, 
        imagem, 
        diagnostico 
    } = location.state || { 
        nome: "Usuário", 
        imagem: "https://img.freepik.com/vetores-premium/ilustracao-plana-vetorial-em-escala-de-cinza-avatar-perfil-de-usuario-pessoa-icone-imagem-de-perfil-perfil-de-negocio-de-uma-mulher-adequado-para-perfis-de-midia-social-icones-protetores-de-tela-e-como-um-modelox9_719432-1351.jpg?ga=GA1.1.1974532293.1682703455&semt=ais_hybrid", 
        diagnostico: {} 
    };

    return (
        <div className={styles.wrapper}>
            <Sidebar nome={nome} imagem={imagem} />
            <div className={styles.main}>
                <Header title="Diagnóstico" />
                <div className={styles.dados_pessoais}>
                    <span>{diagnostico.nomePaciente}</span>
                    <p>
                        <strong>Diagnóstico: </strong>Anemia
                    </p>
                </div>

                <hr />

                <div className={styles.resultados}>
                    {Object.entries(diagnostico.sintomas).map(([nome, valor], index) => (
                        <div key={index} className={styles.resultado}>
                            <strong>{nome}:</strong> 
                            <span>{valor === 1 ? 'sim' : 'não'}</span>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}

export default Resultado;
