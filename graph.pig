Graph = LOAD '$G' USING PigStorage(',') AS (vertex:long, neighbour:long);
GroupByVertex = GROUP Graph BY vertex;
CountByNeighbour = FOREACH GroupByVertex GENERATE group as V, COUNT(Graph.neighbour) as noOfNeighbours;
GroupByNeighbours = GROUP CountByNeighbour BY noOfNeighbours;
FinalOutput = FOREACH GroupByNeighbours GENERATE group, COUNT(CountByNeighbour.V);
STORE FinalOutput INTO '$O' USING PigStorage (',');
