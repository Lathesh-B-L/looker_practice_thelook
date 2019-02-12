connection: "thelook"

include: "*.view.lkml"                       # include all views in this project
 #include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
 explore: order_items {
   join: users {
     relationship: many_to_one
     sql_on: ${users.id} = ${order_items.user_id} ;;
   }
  join: distribution_centers {
    relationship: one_to_many
    sql_on: ${order_items.id}=${distribution_centers.id} ;;
  }
  # added to test sequence
  join: events {
    type: left_outer
    sql_on: ${order_items.id}=${events.id} ;;
    relationship: one_to_many
  }
 }
