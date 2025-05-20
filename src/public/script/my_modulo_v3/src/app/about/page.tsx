import styles from './page.module.css';

export default function About() {
  return (
    <div className={styles.about}>
      <h1 className={styles.title}>Sobre Nos</h1>
      <p className={styles.description}>
        Esta e a pagina Sobre, que demonstra como criar multiplas paginas no Next.js
        usando o App Router. Cada pagina tem seu proprio arquivo CSS modular.
      </p>
    </div>
  );
}
