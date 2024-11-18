import { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';

import facebookIcon from "../../../assets/facebook.svg";
import googleIcon from "../../../assets/google.svg";

import Header from '../../../header/Header';

import api from '../../../services/api';

import styles from './FormLogin.module.css';

function FormLogin() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const navigate = useNavigate();

    const [usuarios, setUsuarios] = useState([]);

    useEffect(() => {
        api.get('usuarios').then((response) => {
            setUsuarios(response.data);
        });
    }, []);

    const handleLogin = (e) => {
        e.preventDefault();

        if (!email || !password) {
            alert("Por favor, preencha todos os campos!");
            return;
        }

        const usuarioEncontrado = usuarios.find(
            (usuario) => usuario.email === email && usuario.senha === password
        );

        if (usuarioEncontrado) {
            navigate("/lista-diagnostico", { 
                state: { 
                    nome: usuarioEncontrado.nome, 
                    imagem: usuarioEncontrado.imagem 
                } 
            });
        } else {
            alert("Usuário não encontrado. Verifique suas credenciais.");
        }
    };

    return (
        <>
            <Header titulo="Bem Vindo" />
            <div className={styles.container}>
                <form onSubmit={handleLogin} className={styles.form}>
                    <div className={styles.dados}>
                        <label className={styles.label}>E-mail</label>
                        <input
                            type="email"
                            placeholder="Informe seu e-mail"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            className={styles.input}
                            required
                        />
                    </div>

                    <div className={styles.dados}>
                        <label className={styles.label}>Senha</label>
                        <input
                            type="password"
                            placeholder="Informe sua senha"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            className={styles.input}
                            required
                        />
                        <a href="/esqueceu-senha">Esqueceu a senha?</a>
                    </div>

                    <p>ou</p>

                    <div className={styles.links}>
                        <img src={facebookIcon} alt="Facebook Icon" className={styles.icon} />
                        <img src={googleIcon} alt="Google Icon" className={styles.icon} />
                    </div>

                    <button type="submit" className={styles.button}>Entrar</button>
                </form>

                <p className={styles.signupText}>
                    Não possui cadastro? <Link className={styles.a} to="/cadastro">Cadastrar</Link>
                </p>
            </div>
        </>
    );
}

export default FormLogin;
