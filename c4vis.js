d3 = require("d3");
d3.selectAll("svg > *").remove();

const rows = 6;
const cols = 7;
const side = 65;
const radius = 24;
const offsetX = 30;
const offsetY = 50;
const lineWeight = 6;
const background = "teal";
const p1 = "#D0312D";
const p2 = "#FCD12A";
const lineColor = "black";

function printValue(row, col, value) {
  if (value == "R0") {
    d3.select(svg)
      .append("circle")
      .attr("stroke-width", lineWeight)
      .attr("stroke", lineColor)
      .style("fill", p1)
      .attr("cx", (cols - col - 1) * side + offsetX + side / 2)
      .attr("cy", (rows - row - 1) * side + offsetY + side / 2)
      .attr("r", radius);
  } else if (value == "Y0") {
    d3.select(svg)
      .append("circle")
      .attr("stroke-width", lineWeight)
      .attr("stroke", lineColor)
      .style("fill", p2)
      .attr("cx", (cols - col - 1) * side + offsetX + side / 2)
      .attr("cy", (rows - row - 1) * side + offsetY + side / 2)
      .attr("r", radius);
  } else {
    d3.select(svg)
      .append("circle")
      .attr("stroke-width", lineWeight)
      .attr("stroke", lineColor)
      .style("fill", background)
      .attr("cx", (cols - col - 1) * side + offsetX + side / 2)
      .attr("cy", (rows - row - 1) * side + offsetY + side / 2)
      .attr("r", radius);
  }
}

function printBoard(boardAtom) {
  d3.select(svg)
    .append("rect")

    .attr("x", offsetX)
    .attr("y", offsetY)
    .attr("width", cols * side)
    .attr("height", rows * side)
    .attr("stroke-width", lineWeight)
    .attr("stroke", lineColor)
    .attr("fill", background);

  for (r = 0; r < rows; r++) {
    for (c = 0; c < cols; c++) {
      printValue(r, c, boardAtom.board[r][c].toString());
    }
  }
}

printBoard(Board);
