import styles from './Diagnostico.module.css';

function Diagnostico({ cpf, nome, dataHora }) {

    const formatDate = (date) => {
        if (!date) return '';

        const parsedDate = new Date(date);
        if (isNaN(parsedDate)) return 'Data inválida';

        const options = { day: '2-digit', month: '2-digit', year: 'numeric' };
        return new Intl.DateTimeFormat('pt-BR', options).format(parsedDate);
    };

    return (
        <article className={styles.diagnostico}>
            <strong>{nome}</strong>

            <div className={styles.dados}>
                <div className={styles.dado}>
                    <span>CPF:</span>
                    <strong className={styles.strong}>{cpf}</strong>
                </div>

                <div className={styles.dado}>
                    <span>Data Lançamento:</span>
                    <strong className={styles.strong}>{formatDate(dataHora)}</strong>
                </div>

                <div className={styles.dado}>
                    <span>Diagnóstico:</span>
                    <p>{nome}</p>
                </div>
            </div>
        </article>
    );
}

export default Diagnostico;
