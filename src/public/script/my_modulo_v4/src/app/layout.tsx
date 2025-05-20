'use client';

import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import 'bootstrap/dist/css/bootstrap.min.css';  // CSS do Bootstrap
import { useEffect } from 'react';
import Header from '@/components/Header/Header';
import MenuNav from '@/components/MenuNav/MenuNav';
import Footer from '@/components/Footer/Footer';
import { ThemeProvider } from '@/context/ThemeContext';

// Mantendo as fontes Geist do projeto original
const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

// Comentario: Definicao de metadata esta no arquivo separado metadata.ts

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {

  useEffect(() => {
    // Importação dinâmica correta (retorna uma Promise)
    import('bootstrap/dist/js/bootstrap.bundle.min.js')
      .then(() => {
        console.log('Bootstrap JS carregado');
      })
      .catch(err => {
        console.error('Erro ao carregar Bootstrap JS:', err);
      });
  }, []);
  
  return (
    <html lang="pt-BR">
      <body className={geistSans.variable + " " + geistMono.variable + " antialiased"}>
        <ThemeProvider>
          <div className="d-flex flex-column min-vh-100">
            <Header />
            <MenuNav />
            
            <main className="container py-4 flex-grow-1">
              {children}
            </main>
            
            <Footer />
          </div>
        </ThemeProvider>
      </body>
    </html>
  );
}
