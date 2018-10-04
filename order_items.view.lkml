view: order_items {
  sql_table_name: PUBLIC.ORDER_ITEMS ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      day_of_month,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}."SALE_PRICE" ;;
  }

  dimension: gross_margin {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: is_returened {
    type: yesno
    sql: ${TABLE}."RETURNED_AT" is NOT NULL;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }

  measure: count {
     type: count
     drill_fields: [detail*]
   }


  measure:total_sale_price  {
    type: sum
    sql: ${TABLE}.sale_price ;;
    drill_fields: [detail*]
    value_format_name: usd_0
  }

  measure: total_returend_price  {
    type: sum
    sql: ${sale_price};;
    drill_fields: [detail*]
    value_format_name: usd_0
    filters: {field: is_returened
              value: "YES"}
  }

  measure: prev_month_sale {
    type:  sum
    sql: ${sale_price} ;;
    drill_fields: [detail*]
    value_format_name: usd_0
    filters: {field: created_month
              value: "last month"}
  }

  measure: curr_month_sale {
    type: sum
    sql: ${sale_price} ;;
    drill_fields: [detail*]
    value_format_name: usd_0
    filters: {field: created_date
              value: "this month"}
  }

  measure:  total_gross_margin {
    type: sum
    sql: ${gross_margin} ;;
    drill_fields: [detail*]
    value_format_name: usd_0
  }

  measure: average_gross_margin {
    type: average
    sql: ${gross_margin} ;;
    drill_fields: [detail*]
    value_format_name: usd_0
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
