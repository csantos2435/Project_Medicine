import styles from './Header.module.css'

function Header({title}) {
    return (
        <>
            <header className={styles.header}>
                <strong>{title}</strong>
            </header>
        </>
    )
}

export default Header;