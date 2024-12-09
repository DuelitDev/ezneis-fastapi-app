/**
 * 식품 알레르기 열거형입니다.
 * @enum {number}
 */
export enum Allergy {
  /** 난류에 의한 식품 알레르기입니다. */
  EGG = 1,
  /** 우유에 의한 식품 알레르기입니다. */
  MILK = 2,
  /** 메밀에 의한 식품 알레르기입니다. */
  BUCKWHEAT = 3,
  /** 땅콩에 의한 식품 알레르기입니다. */
  PEANUT = 4,
  /** 대두에 의한 식품 알레르기입니다. */
  SOYBEAN = 5,
  /** 밀에 의한 식품 알레르기입니다. */
  WHEAT = 6,
  /** 고등어에 의한 식품 알레르기입니다. */
  MACKEREL = 7,
  /** 게에 의한 식품 알레르기입니다. */
  CRAB = 8,
  /** 새우에 의한 식품 알레르기입니다. */
  SHRIMP = 9,
  /** 돼지고기에 의한 식품 알레르기입니다. */
  PORK = 10,
  /** 복숭아에 의한 식품 알레르기입니다. */
  PEACH = 11,
  /** 토마토에 의한 식품 알레르기입니다. */
  TOMATO = 12,
  /** 아황산류에 의한 식품 알레르기입니다. */
  SULFITE = 13,
  /** 호두에 의한 식품 알레르기입니다. */
  WALNUT = 14,
  /** 닭고기에 의한 식품 알레르기입니다. */
  CHICKEN = 15,
  /** 쇠고기에 의한 식품 알레르기입니다. */
  BEEF = 16,
  /** 오징어에 의한 식품 알레르기입니다. */
  CALAMARI = 17,
  /** 조개류(굴, 전복, 홍합 포함)에 의한 식품 알레르기입니다. */
  SHELLFISH = 18,
  /** 잣에 의한 식품 알레르기입니다. */
  PINE_NUT = 19,
}

/**
 * 급식 시간 열거형입니다.
 * @enum {number}
 */
export enum MealTime {
  /** 조식입니다. */
  BREAKFAST = 1,
  /** 중식입니다. */
  LUNCH = 2,
  /** 석식입니다. */
  DINNER = 3,
}

/**
 * 요리 정보를 나타내는 데이터 모델입니다.
 */
export interface Dish {
  /** 요리의 이름입니다. */
  name: string;
  /** 요리에 의한 발생 가능성이 있는 식품 알레르기입니다. */
  allergies: Allergy[];
}

/**
 * 영양 정보를 나타내는 데이터 클래스입니다.
 */
export interface Nutrient {
  /** 영양 이름입니다. */
  name: string;
  /** 단위입니다. */
  unit: string;
  /** 양입니다. */
  value: number;
}

/**
 * 원산지 정보를 나타내는 데이터 클래스입니다.
 */
export interface Origin {
  /** 재료 이름입니다. */
  name: string;
  /** 원산지 이름입니다. */
  origin: string;
}

/**
 * 급식 식단 정보를 나타내는 데이터 클래스입니다.
 */
export default interface MealModel {
  /** 급식 시간 (식사 코드) */
  time: MealTime;
  /** 급식 일자 */
  date: Date;
  /** 급식 인원 수 */
  headcount: number;
  /** 요리명 */
  dishes: Dish[];
  /** 원산지 정보 */
  origins: Origin[];
  /** 칼로리 정보 */
  kcal: number;
  /** 영양 정보 */
  nutrients: Nutrient[];
}