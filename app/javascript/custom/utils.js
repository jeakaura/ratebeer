const BEERS = {};
const BREWERIES = {};

const handleResponse = (beers) => {
  BEERS.list = beers;
  BEERS.show();
};

const handleBrewResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.showbrew();
};

const createTableRow = (beer) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const beername = tr.appendChild(document.createElement("td"));
  beername.innerHTML = beer.name;
  const style = tr.appendChild(document.createElement("td"));
  style.innerHTML = beer.style.name;
  const brewery = tr.appendChild(document.createElement("td"));
  brewery.innerHTML = beer.brewery.name;

  return tr;
};

const createBrewTableRow = (brewery) => {
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

BEERS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("beertable").getElementsByTagName('tbody')[0];

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer);
    table.appendChild(tr);
  });
};

BREWERIES.showbrew = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable").getElementsByTagName('tbody')[0];

  BREWERIES.list.forEach((brew) => {
    const tr = createBrewTableRow(brew);
    table.appendChild(tr);
  });
};

BEERS.sortByName = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortBrewByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BEERS.sortByStyle = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
  });
};

BREWERIES.sortBrewByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year > b.year;
  });
};

BEERS.sortByBrewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name
      .toUpperCase()
      .localeCompare(b.brewery.name.toUpperCase());
  });
};

BREWERIES.sortBrewByBeers = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers.length > b.beers.length;
  });
};

const beers = () => {
  if (document.querySelectorAll("#beertable").length < 1) return;
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByName();
    BEERS.show();
  });

  document.getElementById("style").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByStyle();
    BEERS.show();
  });

  document.getElementById("brewery").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByBrewery();
    BEERS.show();
  });

  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse);
};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBrewByName();
    BREWERIES.showbrew();
  });

  document.getElementById("year").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBrewByYear();
    BREWERIES.showbrew();
  });

  document.getElementById("beerslkm").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortBrewByBeers();
    BREWERIES.showbrew();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleBrewResponse);
};

export { beers };
export { breweries };