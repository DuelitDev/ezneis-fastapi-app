import {JSX} from "react";
import MealModel, {Dish, MealTime} from "../models/meal";
import styles from "./UIMealCard.module.css";

export default function UIMealCard(
  { params: { data }, }: { params: { data: MealModel }; }
) :JSX.Element {

  return (
    <div className={styles.card}>
      <div className={styles.title_container}>
        <h3 className={styles.title}>
          {
            {
              [MealTime.BREAKFAST]: "조식",
              [MealTime.LUNCH]:     "중식",
              [MealTime.DINNER]:    "석식"
            }[data.time]
          }
        </h3>
        <span className="material-symbols-rounded"
              style={{fontSize: "36px"}}>
          {
            {
              [MealTime.BREAKFAST]: "wb_twilight",
              [MealTime.LUNCH]:     "light_mode",
              [MealTime.DINNER]:    "dark_mode"
            }[data.time]
          }
        </span>
      </div>
      <div className={styles.content_container}>
        {data.dishes.map((dish :Dish, index :number) :JSX.Element => (
          <div key={index} className={styles.content}>
            {dish.name}
          </div>
        ))}
      </div>
    </div>
  );
}