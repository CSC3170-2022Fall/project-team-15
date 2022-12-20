from sys import maxsize
from itertools import permutations
import networkx as nx
import matplotlib.pyplot as plt

inf = 1e8

def TSP(graph,S,V,coordinate):
    vertex = []
    for i in range(V):
        if i != S:
            vertex.append(i)
        minPath = maxsize
        nextPermutation = permutations(vertex)
        for i in nextPermutation:
            currentPathweight = 0
            k = S
            for j in i:
                currentPathweight += gragh[k][j]
                k = j
            currentPathweight += gragh[k][S]
            minPath = min(minPath, currentPathweight)
            if minPath == currentPathweight:
                optimalpath = list(i)
                optimalpath.append(S)
    drawNetwork(coordinate,graph,optimalpath)
    return minPath

def isMinpath(optimalpath,i,j):
    idx = optimalpath.index(i)
    if idx != 0:
        preidx = idx - 1 
    else:
        preidx = len(optimalpath) - 1
    if idx != len(optimalpath) - 1:
        nextidx = idx + 1
    else:
        nextidx = 0
    if optimalpath[preidx] == j or optimalpath[nextidx] == j:
        return True
    return False

def drawNetwork(coordinate,graph,optimalpath,*args):

    G_min = nx.Graph() 
    G = nx.Graph()
    edges = []
    for i in range(len(coordinate)):
        m = i + 1
        G_min.add_node(m, pos=coordinate[i])
        G.add_node(m, pos=coordinate[i])
        for j in range(i + 1, len(coordinate)):
            if graph[i][j] != inf:
                if isMinpath(optimalpath,i,j):
                    G_min.add_edge(i + 1, j + 1, weight=int(graph[i][j]), color='r')
                G.add_edge(i + 1, j + 1, weight=int(graph[i][j]))
    tmp_edges = nx.get_edge_attributes(G_min, 'color')
    for key in tmp_edges:
        edges.append(tmp_edges[key])
    pos = pos_min = nx.get_node_attributes(G_min, 'pos')
    labels = nx.get_edge_attributes(G_min, 'weight')
    label = nx.get_edge_attributes(G, 'weight')
    plt.subplot(121)
    plt.title("Plant Network")
    nx.draw(G, pos, with_labels=True, font_weight='bold', node_color='y')
    nx.draw_networkx_edge_labels(G, pos, edge_labels=label)
    plt.subplot(122)
    plt.title("Optimal solution")
    nx.draw(G_min, pos_min, with_labels=True, font_weight='bold', node_color='g', edge_color=edges)
    nx.draw_networkx_edge_labels(G_min, pos_min, edge_labels=labels)
    plt.show()

if __name__ == "__main__":
    gragh = ([[0, 6, 2, 1, inf, inf], [6, 0, 6, inf, 3, inf], [2, 6, 0, 2, 2, 4],
    [1, inf, 2, 0, inf, 5], [inf, 3, 2, inf, 0, 3], [inf, inf, 4, 5, 3, 0]])
    S = 0
    V = 6
    coordinate = [(4, 7.5), (0, 5.5), (5, 4), (10, 5.5), (1.5, 1), (11, 0)]
    print(TSP(gragh,S,V,coordinate))
