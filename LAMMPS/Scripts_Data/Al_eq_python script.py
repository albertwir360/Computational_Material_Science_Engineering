import numpy as np
matrix = np.loadtxt('Al_eq.txt',usecols=range(10))
time = matrix[:,0]
boxSide = matrix[:,1:4]
vol = matrix[:,4]
pzz = matrix[:,5]
pe = matrix[:,6]
ke = matrix[:,7]
te = matrix[:,8]
temp = matrix[:,9]
import matplotlib.pyplot as plt
fig,axs=plt.subplots(2,2)
axs[0,0].plot(time, boxSide[:,1])
axs[0,1].plot(time, pzz)
axs[1,0].plot(time, temp)
axs[1,1].plot(time,pe,label='PE')
axs[1,1].plot(time,ke,label='KE')
axs[1,1].plot(time,te,label='E')
axs[0,0].set(xlabel='time / ps',ylabel='box side_{y} / Angstroms')
axs[0,1].set(xlabel='time / ps',ylabel='P_z / bar')
axs[1,0].set(xlabel='time / ps',ylabel='T / K')
axs[1,1].set(xlabel='time / ps',ylabel='energy / eV')
plt.legend()
plt.show()
