connection: "thelook"

# include all the views
include: "*.view"

# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: order_items{
view_label: "Order Inventory and products"
  join : users {
    type : left_outer
    sql_on: ${order_items.user_id}=${users.id} ;;
    relationship: many_to_one
  }

join : inventory_items {
  type : left_outer
  sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
  relationship: :many_to_one

 }

  join : products {
    type: left_outer
    sql_on: ${inventory_items.product_id}=${inventory_items.product_id} ;;
    relationship: many_to_one


  }
}
