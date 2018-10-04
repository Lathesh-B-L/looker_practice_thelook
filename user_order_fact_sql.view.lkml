view: user_order_fact_sql {
  derived_table: {
    sql: select
        order_items.user_id as user_id,
        count(distinct order_id) as lifetime_orders,
        count(order_items.sale_price) as lifetime_revenue,
        min(order_items.created_at) as first_order,
        max(order_items.created_at) as last_order,
        count(distinct date_trunc("month", order_items.created_at)) as number_of_distinct_month_with_orders
      FROM order_items
      GROUP BY user_id
       ;;

  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}."LIFETIME_ORDERS" ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}."LIFETIME_REVENUE" ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}."FIRST_ORDER" ;;
  }

  dimension_group: last_order {
    type: time
    sql: ${TABLE}."LAST_ORDER" ;;
  }

  dimension: number_of_distinct_month_with_orders {
    type: number
    sql: ${TABLE}."NUMBER_OF_DISTINCT_MONTH_WITH_ORDERS" ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_month_with_order {
    type: average
    sql: ${number_of_distinct_month_with_orders} ;;
    drill_fields: [detail*]
    value_format_name: decimal_1
  }

  set: detail {
    fields: [
      user_id,
      lifetime_orders,
      lifetime_revenue,
      first_order_time,
      last_order_time,
      number_of_distinct_month_with_orders
    ]
  }
}
