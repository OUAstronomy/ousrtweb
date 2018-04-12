//Load in character data
d3.json("./classroom.json", function(data) {
  grid = d3.select("#startGrid")
    .append("div")
    .attr("id", "grid")
    .attr("class", "grid")
  ;
  chars = grid
    .selectAll("div")
    .data(data.modules)
    .enter()
    .append("div")
    .attr("class", "char")
  ;
  chars
    .style("background-image", function(d){
      return 'url("./classroom/'+d.name+'/bkgnd.jpg")';
    })
  ;
  content = chars
     .append("div")
     .attr("class", "charContent")
  ;
  content
     .append("h2")
     .text(function(d,i){
        return d.name;
     })
  ;
  chars
    .filter(function(d){ return true; })
        .classed("size1", true)
  ;
  
  chars
    .on("click", function(d, i) {
      if(this.className.split(' ').indexOf('open') > -1 ){
        d3.select(this).classed("open", false);
      }else{
        gridColumns = window.getComputedStyle(this.parentElement).gridTemplateColumns.split(" ");
        gridRows = window.getComputedStyle(this.parentElement).gridTemplateRows.split(" ");
        numColumns = gridColumns.length;
        numRows = gridRows.length;
        xPosInGrid = this.getBoundingClientRect().left - this.parentElement.getBoundingClientRect().left;
        yPosInGrid = this.getBoundingClientRect().top - this.parentElement.getBoundingClientRect().top;
        gridRowHeight = parseFloat(gridRows[0]) + parseFloat(window.getComputedStyle(this.parentElement).gridRowGap);
        gridColumnWidth = parseFloat(gridColumns[0]) + parseFloat(window.getComputedStyle(this.parentElement).gridColumnGap);
        thisRow = Math.round(yPosInGrid/gridRowHeight) +1;
        thisColumn = Math.round(xPosInGrid/gridColumnWidth) +1;
        thisPortrait = this.getElementsByClassName("portrait")[0];
        if(thisPortrait)thisPortrait.setAttribute("src",thisPortrait.getAttribute("data-src"));
        chars.classed("open", false);
        chars.style("grid-row-start", "auto");
        chars.style("grid-column-start", "auto");
        d3.select(this).classed("open", true);
        divWidth = parseFloat(window.getComputedStyle(this).gridColumnEnd.split(" ")[1]);
        divHeight = parseFloat(window.getComputedStyle(this).gridRowEnd.split(" ")[1]);
        if(thisRow+divHeight>numRows)thisRow = 1 + numRows-divHeight;
        if(thisColumn+divWidth>numColumns)thisColumn = 1 + numColumns-divWidth;
        d3.select(this).style("grid-row-start", thisRow)
        d3.select(this).style("grid-column-start", thisColumn)
      }
    })
  ;

  details = content
     .append("div")
     .attr("class", "details")
  ;
 
  imageHolder = details
   .filter(function(d){ return d.charThumb != ""; })
   .append("div")
   .attr("class", "imageHolder")
  ;
  imageHolder 
   .append("img")
   .attr("class","portrait")
   .attr("data-src", function(d,i){
      return './classroom/'+d.name+'/expanded.png';
   })
  ;
bio = details
    .append("div")
    .attr("class", "bio")
  ;
  bio
    .append("h3")
    .text(function(d,i){
      return d.name;
    })
  ;
  bio
    .filter(function(d){ return d.desc != ""; })
    .append("h4")
    .text("Description:")
  ;
  bio
    .filter(function(d){ return d.desc != ""; })
    .append("span")
    .text(function(d,i){
      return d.desc;
   })
  ;
  bio
    .filter(function(d){ return d.data != "" && d.name != "Slides"; })
    .append("h4")
    .text("Example Data:")
  ;
  bio
    .filter(function(d){ return d.data != "" && d.name != "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.data })
    .attr("target", "_blank")
    .text("Download Package >>")
  ;
  bio
    .filter(function(d){ return d.instructor != "" && d.name != "Slides"; })
    .append("h4")
    .text("Instructor:")
  ;
  bio
    .filter(function(d){ return d.instructor != "" && d.name != "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.instructor })
    .attr("target", "_blank")
    .text("Download Package >>")
  ;
  bio
    .filter(function(d){ return d.directions != ""; })
    .append("h4")
    .text("README:")
  ;
  bio
    .filter(function(d){ return d.directions != ""; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.directions })
    .attr("target", "_blank")
    .text("Download Package >>")
  ;
  bio
    .filter(function(d){ return d.srtintroou != "" && d.name == "Slides"; })
    .append("h4")
    .text("Slides:")
  ;
  bio
    .filter(function(d){ return d.srtintroou != "" && d.name == "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.srtintroou })
    .attr("target", "_blank")
    .text("Intro to SRT (OU) >>")
  ;
  bio
    .filter(function(d){ return d.srtintro != "" && d.name == "Slides"; })
    .append("h4")
    .text("")
  ;
  bio
    .filter(function(d){ return d.srtintro != "" && d.name == "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.srtintro })
    .attr("target", "_blank")
    .text("Intro to SRT (external) >>")
  ;
  bio
    .filter(function(d){ return d.srtcontrol != "" && d.name == "Slides"; })
    .append("h4")
    .text("")
  ;
  bio
    .filter(function(d){ return d.srtcontrol != "" && d.name == "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.srtcontrol })
    .attr("target", "_blank")
    .text("Control the SRT >>")
  ;
  bio
    .filter(function(d){ return d.srtreduc != "" && d.name == "Slides"; })
    .append("h4")
    .text("")
  ;
  bio
    .filter(function(d){ return d.srtreduc != "" && d.name == "Slides"; })
    .append("span")
    .append("a")
    .attr("href", function(d){ return d.srtreduc })
    .attr("target", "_blank")
    .text("Reduce data >>")
  ;
  d3
    .select("#orderName")
    .on("click", function () {
      chars
        .sort(function(a, b) { 
        return d3.ascending(a["name"], b["name"]);
      })
    ;
        chars.classed("open", false);
        chars.style("grid-row-start", "auto");
        chars.style("grid-column-start", "auto");
   })
  ;
  
})
