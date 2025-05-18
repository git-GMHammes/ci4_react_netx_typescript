import styles from './page.module.css';

export default function About() {
  return (
    <div className={styles.about}>
      <h1 className={styles.title}>Sobre N�s</h1>
      <p className={styles.description}>
        Esta � a p�gina Sobre, que demonstra como criar m�ltiplas p�ginas no Next.js
        usando o App Router. Cada p�gina tem seu pr�prio arquivo CSS modular.
      </p>
    </div>
  );
}
