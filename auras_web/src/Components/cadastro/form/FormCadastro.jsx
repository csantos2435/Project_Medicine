import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

import facebookIcon from "../../../assets/facebook.svg";
import googleIcon from "../../../assets/google.svg";

import Header from '../../../header/Header';

import api from '../../../services/api';

import styles from './FormCadastro.module.css';


function FormCadastro() {
  const [nome, setNome] = useState("");
  const [email, setEmail] = useState("");
  const [imagem, setImagem] = useState("");
  const [senha, setSenha] = useState("");
  const [confirmacao, setConfirmacao] = useState("");
  const [usuarios, setUsuario] = useState([]);

  const navigate = useNavigate();

  async function handleAddUsuario() {
    const response = await api.post('usuarios', {
      nome: nome,
      imagem: imagem,
      email: email,
      senha: senha,
    });

    const usuario = response.data;

    setUsuario([...usuarios, usuario]);
  }

  const handleLogin = (e) => {
    e.preventDefault();

    if (!nome || !email || !senha || !confirmacao) {
      alert("Por favor, preencha todos os campos!");
      return;
    }

    if (senha !== confirmacao) {
      alert("As senhas não conferem. Por favor, tente novamente.");
      return;
    }

    navigate("/");
  };

  return (
    <>
      <Header titulo="Cadastro de Usuário" />

      <div className={styles.container}>
        <form onSubmit={handleLogin} className={styles.form}>
          <div className={styles.dados}>
            <label className={styles.label}>Nome do Usuário</label>
            <input
              type="text"
              placeholder="Nome"
              value={nome}
              onChange={(e) => setNome(e.target.value)}
              className={styles.input}
              required
            />
          </div>

          <div className={styles.dados}>
            <label className={styles.label}>E-mail</label>
            <input
              type="email"
              placeholder="e-mail"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className={styles.input}
              required
            />
          </div>

          <div className={styles.dados}>
            <label className={styles.label}>Link para a imagem</label>
            <input
              type="text"
              placeholder="Exemplo: https://avatars.githubusercontent.com/u/164575006?v=4&size=64"
              value={imagem}
              onChange={(e) => setImagem(e.target.value)}
              className={styles.input}
            />
          </div>

          <div className={styles.dados}>
            <label className={styles.label}>Senha</label>
            <input
              type="password"
              placeholder="senha"
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              className={styles.input}
              required
            />
          </div>

          <div className={styles.dados}>
            <label className={styles.label}>Confirmar senha</label>
            <input
              type="password"
              placeholder="Confirmar senha"
              value={confirmacao}
              onChange={(e) => setConfirmacao(e.target.value)}
              className={styles.input}
              required
            />
          </div>

          <p>ou</p>

          <div className={styles.links}>
            <img src={facebookIcon} alt="Facebook Icon" className={styles.icon} />
            <img src={googleIcon} alt="Google Icon" className={styles.icon} />
          </div>

          <button
            type="submit"
            onClick={handleAddUsuario}
            className={styles.button}
          >
            Inscreva-se
          </button>
        </form>
      </div>
    </>
  );
}

export default FormCadastro;
