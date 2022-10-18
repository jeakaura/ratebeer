const BREWERIES = {};

const handleResponse = (breweries) => {
    BREWERIES.list = breweries;
    BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active;
  const beerlkm = tr.appendChild(document.createElement("td"));
  beerlkm.innerHTML = brewery.beers.length;

  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable").getElementsByTagName('tbody')[0];

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortByName = () => {
    BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse);

    var request = new XMLHttpRequest();

    request.onload = handleResponse;
  
    request.open("get", "breweries.json", true);
    request.send();
};

export { breweries };