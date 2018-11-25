function outputMenuItems(category_id) {
    let menu_item_section = document.getElementById("menu_items");
    let url = "api/menu_items";
    if (menu_item_section) {
        if (category_id) {
          url = `api/menu_items?category_id=${category_id}`;
        } 
        
        let xhttp = new XMLHttpRequest();
        
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                let menu_items = JSON.parse(this.responseText);
                let output = "";
                
                for(let i = 0; i < menu_items.length; i++) {
                    output += `<tr>
                                 <td style="width: 30%; text-align: center"><img src="${menu_items[i].photo_url}" width="150" height="150"></td>
                                 <td style="width: 30%">${menu_items[i].item}</td>
                                 <td style="width: 10%; text-align: center">${ (menu_items[i].price * 1).toFixed(2) }</td>
                                 <td style="width: 15%"><input type="number" min="1" max="100" data-menu_item_id="${menu_items[i].id}" class="quantity-input" value="1"></td>
                                 <td style="width: 15%"><button class="btn-add">Add</button></td>
                               </tr>`;
                }
                
                menu_item_section.innerHTML = output;
                addEventToButtons();
            }
        };
        
        xhttp.open("GET", url, true);
        xhttp.send();
    }
}

// function addToCart(ele) {
//     let data = new FormData();
//     let target = ele.parentElement.previousElementSibling.firstElementChild
//     let quantity = target.value
//     let menu_item_id = target.getAttribute("data-menu_item_id")
//     if (quantity) {
//       data.append('quantity', quantity);
//       data.append('menu_id', menu_item_id);
//       var xhr = new XMLHttpRequest();
//       xhr.open('POST', 'api/menu_items', true);
       
//       // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
//       xhr.onload = function () {
//           console.log(this.status)
//           let result = JSON.parse(this.responseText);
          
//           if (this.status == 200) {
//             var node = document.createElement("P");     
//             node.classList = ["alert-success"]
//             var textnode = document.createTextNode(result.message); 
//             node.appendChild(textnode);
//             document.getElementById("flash_messages").appendChild(node); 
//             window.scrollTo(0, 0);
//             target.value = "";
//             outputOrderItems();
//           } else if (this.status == 401) {
//               var node = document.createElement("P");     
//               node.classList = ["alert-danger"]
//               var textnode = document.createTextNode(result.message); 
//               node.appendChild(textnode);
//               document.getElementById("flash_messages").appendChild(node); 
//               window.scrollTo(0, 0);
//           }
//       };
//       xhr.send(data);
       
//     }
// }

function addToCart(ele) {
    let data = new FormData();
    let target = ele.parentElement.previousElementSibling.firstElementChild;
    let quantity = target.value;
    let menu_item_id = target.getAttribute("data-menu_item_id");
    
    if (quantity) {
      data.append('quantity', quantity);
      data.append('menu_id', menu_item_id);
      var xhr = new XMLHttpRequest();
      xhr.open('POST', 'api/menu_items', true);
       
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
      xhr.onload = function () {
        //   console.log(this.status)
          let result = JSON.parse(this.responseText);
          let message_section = document.getElementById("flash_messages");
          
          if (this.status == 200) {
            message_section.innerHTML = `<div class="text-center alert alert-success" style="font-size: 15px">${result.message}
                                         <button type="button" class="close" data-dismiss="alert">&times;</button></div>`;
            
            window.scrollTo(0, 0);
            target.value = "";
            outputOrderItems();
            
          } else if (this.status == 401) {
              message_section.innerHTML = `<div class="text-center alert alert-danger" style="font-size: 15px">${result.message}
                                           <button type="button" class="close" data-dismiss="alert">&times;</button></div>`;
              window.scrollTo(0, 0);
          }
      };
      xhr.send(data);
       
    }
}

function addEventToButtons() {
    let buttons = document.getElementsByClassName("btn-add");
    for(let i=0; i < buttons.length; i++) {
        buttons[i].addEventListener("click", function() {
            addToCart(buttons[i]);
        });
    }
}

function addEventToLinks() {
    let links = document.getElementsByClassName("filtering_by_category");
    for(let i = 0; i < links.length; i++) {
        links[i].addEventListener("click", function() {
            filterMenuItemsByCategory(links[i]);
        });
    }
}

function filterMenuItemsByCategory(ele) {
    let category_id = ele.getAttribute("data-category-id");
    outputMenuItems(category_id);
}

document.addEventListener("DOMContentLoaded", function(event) {
    outputMenuItems(0);
    addEventToLinks();
});