import { Link } from 'react-router-dom';

import styles from './Sidebar.module.css';

function Sidebar({ nome, imagem }) {
    return (
        <aside className={styles.sidebar}>
            <div className={styles.profile}>
                <img 
                    src="https://img.freepik.com/vetores-premium/ilustracao-plana-vetorial-em-escala-de-cinza-avatar-perfil-de-usuario-pessoa-icone-imagem-de-perfil-perfil-de-negocio-de-uma-mulher-adequado-para-perfis-de-midia-social-icones-protetores-de-tela-e-como-um-modelox9_719432-1351.jpg?ga=GA1.1.1974532293.1682703455&semt=ais_hybrid" 
                />
                <strong>{nome}</strong>
            </div>

            <footer>
                <Link to="/lista-diagnostico" state={{ nome, imagem }}>
                    Tela Inicial
                </Link>
                <Link to="/novo-diagnostico" state={{ nome, imagem }}>
                    Novo Diagnóstico
                </Link>
            </footer>
        </aside>
    );
}

export default Sidebar;
