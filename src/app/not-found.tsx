import { JSX } from 'react';
import { Metadata } from 'next';

export const metadata: Metadata = {
    title: 'Not Found',
}

export default function NotFound(): JSX.Element {
    return <h1>404 Not Found</h1>;
}
