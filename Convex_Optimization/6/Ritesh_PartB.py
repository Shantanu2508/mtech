#Ritesh Kumar
##  Part B ###
import cvxpy as cp
import numpy as np
y1=cp.Variable()
y2=cp.Variable()
y3=cp.Variable()
Net_cost=4*y1 + 6*y2 + 10*y3
Objective=cp.Maximize(Net_cost)
Constraints=[0.04*y1 + 0.045*y2 + 0.21*y3<= 6000, y1 >=5000, y1 <= 10000, y2>=0, y2 <=15000,y3 >= 4000, y3 <= 8000]
Prob=cp.Problem(Objective, Constraints)
Prob.solve()
print(y1.value,y2.value,y3.value)
