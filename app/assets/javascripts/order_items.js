//Order item js
function outputOrderItems() {
    let order_item_section = document.getElementById("order_items");
    let total_price = document.getElementById("total_price");
    let url = "api/order_items";
    
    if (order_item_section) {
        let xhttp = new XMLHttpRequest();
        
        xhttp.onreadystatechange = function() {
            
            if (this.readyState == 4 && this.status == 200) {
                let order_items = JSON.parse(this.responseText);
                let output_order_items = "";
                let sub_total, grand_total = 0.00;
                
                for(let i = 0; i < order_items.length; i++) {
                    sub_total = parseFloat(order_items[i].menu.price * order_items[i].quantity).toFixed(2);
                    grand_total = grand_total + parseFloat(sub_total);
                    // console.log(grand_total)
                    
                    output_order_items += `<tr>
                                            <td style="width: 8%">
                                              <ul>
                                                <li><span class="plus_btn" data-order_item_id=${order_items[i].id}><i class="fa fa-plus"></i></span></li>
                                                <li class="font-weight-bold text-center pl-1">${order_items[i].quantity}</li>
                                                <li><span class="minus_btn"><i class="fa fa-minus"></i></span></li>
                                              </ul>      
                                            </td>
                                            <td style="width:13%"><img src="${order_items[i].menu.photo_url}" width="50" height="50"></td>
                                            <td style="width:44%; font-size: 14px">${order_items[i].menu.item}<br>- RM ${ (order_items[i].menu.price * 1).toFixed(2) }</span></td>
                                            <td style="width:35%">
                                              <span class="font-weight-bold float-right", style="font-size: 14px">RM ${sub_total} </span><br>
                                              <span class="delete_btn"><i class="fa fa-times"></i></span>
                                            </td>
                                            </tr>`;
                }
                
                order_item_section.innerHTML = output_order_items;
                total_price.innerHTML = `<div class="font-weight-bold text-center" style="font-size: 18px">Total Price = RM ${ grand_total.toFixed(2) } <br>` 
                                        // <button class="font-weight-bold mb-4 btn btn-checkout mt-4" style="font-size: 18px">Checkout</button></div>`;
                addEventListenerToButtons();
                                         
            } 
        };
        
        xhttp.open("GET", url, true);
        xhttp.send();
    }
}

function addEventListenerToButtons() {
    let plus_btn = document.getElementsByClassName("plus_btn");
    for(let i = 0; i < plus_btn.length; i++) {
        plus_btn[i].addEventListener("click", function() {
          incrementQuantity(plus_btn[i]) 
        });
    }
}

// function addEventListenerToButtons() {
//     let order_item_section = document.getElementById("order_items");

//                 order_item_section.addEventListener("click", function(event) {
//                     let element = event.target;
//                     if (element.classList.contains("plus_btn")) {
//                         let order_item_id = element.getAttribute("data-order_item_id");
//                         incrementQuantity(order_item_id);
//                     }

//                 })
// }

function incrementQuantity(ele) {
    
    let order_item_id = ele.getAttribute("data-order_item_id");
    console.log(order_item_id)
    let url = `api/order_items?id=${order_item_id}`
    let data = {order_item: order_item_id};
    // let target = ele.parentElement.nextElementSibling.firstElementChild;
    // let quantity = target.value;
    // console.log(quantity)
    
    
    // if (order_item_id) {
    //   data.append('quantity', quantity);
    //   data.append('order_item', order_item_id);
      var xhr = new XMLHttpRequest();
      xhr.open('PATCH', url, true);
       
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
      xhr.onload = function () {
        //   console.log(this.status)
          
          let message_section = document.getElementById("flash_messages");
          
          if (this.status == 200) {
            let result = JSON.parse(this.responseText);
            message_section.innerHTML = `<div class="text-center alert alert-success" style="font-size: 15px">${result.message}
                                         <button type="button" class="close" data-dismiss="alert">&times;</button></div>`;
            window.scrollTo(0, 0);
            // target.value = "";
            outputOrderItems();
            
          } 
          else if (this.status == 401) {
              let result = JSON.parse(this.responseText);
              message_section.innerHTML = `<div class="text-center alert alert-danger" style="font-size: 15px">${result.message}
                                          <button type="button" class="close" data-dismiss="alert">&times;</button></div>`;
              window.scrollTo(0, 0);
          }
      };
      xhr.send(data);
       
    // }
}

document.addEventListener("DOMContentLoaded", function(event) {
    outputOrderItems();
});