function price (){
  if (document.getElementById("item-price")){  //⭕️書き方
    const item_price = document.getElementById("item-price");
    item_price.addEventListener("keyup", () => {
      const add_tax_price = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      add_tax_price.innerHTML = Math.floor(item_price.value * 0.1);
      profit.innerHTML = Math.floor(item_price.value - add_tax_price.innerHTML);
    });
  }
};

window.addEventListener('load', price);