import {JSX} from 'react';
import { DateTime } from 'luxon';
import MealModel from '../../models/meal';
import UIMealCard from '../../components/UIMealCard';
import UIMealDetail from '../../components/UIMealDetail';
import styles from './page.module.css';
import Link from "next/link";

const url = 'http://ezneis_fastapi:63149/v1/meals/auto/';

async function getTodayMeals() :Promise<MealModel[]> {
  try {
    const response: Response = await fetch(url, { next: { revalidate: 0 } });
    if (!response.ok) {
      return [];
    }
    const json: JSON[] = await response.json();
    return json.map((meal: any): MealModel => meal as MealModel);
  } catch (error) {
    return [];
  }
}

export default async function Page() :Promise<JSX.Element> {

  const today = DateTime.now();
  const meals :MealModel[] = await getTodayMeals();

  return (
    <div className={styles.container}>
      <h1 className={styles.title}>
        {today.toFormat('MM월 dd일 급식')}
      </h1>
      {meals.length === 0 ? (
        <div className={styles.card_container}>
          <span className={styles.error_content}>
            아니 왜 오류? (진짜 모름)<br></br>
            <Link className={styles.error_link} href={""}>재시도</Link>
          </span>
        </div>
      ) : (
        <div className={styles.card_container}>
          {
            meals.map((meal: MealModel, index: number): JSX.Element =>
              <UIMealCard key={index} params={{data: meal}}/>
            )
          }
        </div>
      )}

    </div>
  );
}
