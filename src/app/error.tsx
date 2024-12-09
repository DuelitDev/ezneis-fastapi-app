"use client";

import { JSX } from "react";
import {Metadata} from "next";

export const metadata :Metadata = {
  title: 'Internal Server Error',
}

export default function InternalServerError() :JSX.Element {
  return <h1>500 Internal Server Error</h1>;
}
