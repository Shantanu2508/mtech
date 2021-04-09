#Ritesh Kumar
import numpy as np
import cvxpy as cp
item = np.array([6000, 5000, 3000])
store = np.array([.04, .045, .210])
x1 = cp.Variable()
x2 = cp.Variable()
x3 = cp.Variable()
x = np.array([x1,x2,x3])
Profit = np.array([4,6,10])
days = 5 
#objective function for problem
profit1 = Profit[0]*item[0]*x1*days 
profit2 = Profit[1]*item[1]*x2*days 
profit3 = Profit[2]*item[2]*x3*days 
Net_profit = profit1+profit2 +profit3
objective = cp.Maximize(Net_profit)
# constraints for the problem
constraints = [x1+x2+x3<=1, 1200*x1 +1125*x2 + 3150*x3 <= 6000, 30000*x1 >=5000, 6000*x1<= 10000, 25000*x2 <= 15000, 15000*x3 <= 8000,x1>=0,x2>=0,x3>=0 ]
#problem for the optimization
prob = cp.Problem(objective, constraints) 
prob.solve()
print( "Value of net profit is", prob.solve())
print("proportion values are", x1.value, x2.value, x3.value)
