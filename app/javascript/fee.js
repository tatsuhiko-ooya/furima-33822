function fee () {
  const itemPrice = document.getElementById("item-price")
  itemPrice.addEventListener("input", () => {
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    var tax = parseInt(itemPrice.value * 0.1);
    addTaxPrice.innerHTML = tax.toLocaleString();
    profit.innerHTML = (itemPrice.value - tax).toLocaleString();
  });
}
window.addEventListener("load", fee) 