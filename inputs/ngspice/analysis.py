import sys
import csv
from os.path import join
import matplotlib
import matplotlib.pyplot as plt

output_dir = sys.argv[1]

voltages = []
frequencies = []

for line in open(join(output_dir, 'freqvolt.data')):
  linearr = line.split()
  voltages.append(float(linearr[2]))
  frequencies.append(float(linearr[3]))

# plot the first graph
fig1, ax1 = plt.subplots()
ax1.plot(voltages, frequencies)
ax1.set(xlabel='voltage (V)', ylabel='frequency (GHz)',
       title='PLL voltage vs frequency')
ax1.grid()
fig1.savefig(join(output_dir,'freqvolt.png'))

times = []
sigs  = []
for line in open(join(output_dir, 'sig.data')):
  linearr = line.split()
  times.append(float(linearr[0]))
  sigs.append(float(linearr[1]))

# plot the first graph
fig2, ax2 = plt.subplots()
ax2.plot(times[:100], sigs[:100])
ax2.set(xlabel='time (s)', ylabel='signal',
       title='PLL signal timeseries')
ax2.grid()
fig2.savefig(join(output_dir, 'timeseries.png'))
