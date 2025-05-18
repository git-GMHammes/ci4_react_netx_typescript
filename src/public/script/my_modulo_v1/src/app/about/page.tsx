import styles from './page.module.css';

export default function About() {
  return (
    <div className={styles.about}>
      <h1 className={styles.title}>Sobre Nós</h1>
      <p className={styles.description}>
        Esta é a página Sobre, que demonstra como criar múltiplas páginas no Next.js
        usando o App Router. Cada página tem seu próprio arquivo CSS modular.
      </p>
    </div>
  );
}
