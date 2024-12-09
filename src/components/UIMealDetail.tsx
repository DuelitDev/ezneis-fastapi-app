import { JSX } from "react";
import MealModel from "../models/meal";

export default function UIMealDetail(
  { params: { data }, }: { params: { data: MealModel }; }
) :JSX.Element {
  return <div>{JSON.stringify(data)}</div>;
}