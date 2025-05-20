'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import styles from './MenuNav.module.css';

export default function MenuNav() {
  const pathname = usePathname();
  
  return (
    <nav className={styles.nav}>
      <ul className={styles.navList}>
        <li className={pathname === '/' ? styles.active : ''}>
          <Link href="/">Home</Link>
        </li>
        <li className={pathname === '/about' ? styles.active : ''}>
          <Link href="/about">Sobre</Link>
        </li>
      </ul>
    </nav>
  );
}
