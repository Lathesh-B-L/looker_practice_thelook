connection: "thelook"

include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

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
explore: distribution_centers{
  always_join: [products,inventory_items]
  join: products {
    foreign_key: distribution_centers.id
#    type: left_outer
#    sql_on: ${distribution_centers.id} = ${products.distribution_center_id} ;;
    relationship: many_to_one
  }
  join: inventory_items {
    foreign_key: distribution_centers.id
#    type: left_outer
#    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
  }
}
