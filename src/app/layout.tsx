import React, { JSX } from 'react';
import { Metadata, Viewport } from 'next';
import './global.css';
import styles from './layout.module.css';

export const metadata :Metadata = {
  title: {
    template: '%s | 전자급식표',
    default: '전자급식표'
  }
}

export const viewport :Viewport = {
  initialScale: 1,
  minimumScale: 1,
  maximumScale: 1,
  userScalable: false
}

export default function Layout(
  {children,}: {children: React.ReactNode}
): JSX.Element {
  return (
    <html lang="ko">
      <body>
        <div className={styles.layout_content_container}>
          {children}
        </div>
        <span className={styles.layout_version_container}>
          v0.1.2
        </span>
      </body>
    </html>
  );
}
