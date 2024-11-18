import styles from './Header.module.css';

function Header({ titulo }) {
    return (
        <header className={styles.header}>
            <span>{titulo}</span>
        </header>
    );
}

export default Header;
