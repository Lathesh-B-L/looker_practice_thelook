view: user_order_fact {
  derived_table: {
    sql: select
        ORDER_ITEMS.USER_ID as User_ID,
        min(ORDER_ITEMS.CREATED_AT) as First_Order_Date,
        max(ORDER_ITEMS.CREATED_AT) as Last_Order_Date,
        sum(ORDER_ITEMS.SALE_PRICE) as life_Time_Revenue,
        count(distinct ORDER_ITEMS.ORDER_ID) as Life_Time_Order_Count
      from ORDER_ITEMS
      group by USER_ID
       ;;
  }


  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [raw, date, time, week, month, quarter, year]
    sql: ${TABLE}."FIRST_ORDER_DATE" ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [raw, date, time, week, month, quarter, year]
    sql: ${TABLE}."LAST_ORDER_DATE" ;;
  }

  dimension: life_time_revenue {
    type: number
    sql: ${TABLE}."LIFE_TIME_REVENUE" ;;
  }

  dimension: life_time_order_count {
    type: number
    sql: ${TABLE}."LIFE_TIME_ORDER_COUNT" ;;
  }

  measure: Total_Life_Time_Revenue {
    type: sum
    sql: ${life_time_revenue} ;;
    value_format_name: usd_0
    drill_fields: [detail*]
  }

  measure: Total_Life_Time_Order_Count {
    type: sum
    sql: ${life_time_order_count} ;;
    value_format_name: usd_0
    drill_fields: [detail*]
  }

  set: detail {
    fields: [user_id, first_order_date, last_order_date, life_time_revenue, life_time_order_count]
  }
}
