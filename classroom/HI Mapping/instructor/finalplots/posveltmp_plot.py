############
# PLots Position v Velocity v temperature of galaxy
# Nickalas Reynolds
################

# import libraries
from __future__ import print_function
import sys
assert sys.version_info >= (2,5)
import numpy as np
import os
import glob
from astropy.table import Table
from astropy.io import ascii
import matplotlib.pyplot as plt
from matplotlib.pyplot import draw as draw
from matplotlib.ticker import ScalarFormatter
import matplotlib.ticker as ticker
from six.moves import input
import matplotlib.cm as cm

# useful filenames
_tempfile_ = 'PLOTTING_TEMPORARY_FILE'

# constants
beamsize = 2.5
velbin = 0.000000001

# load files
files = [f for f in glob.glob('*G*') if os.path.isfile(f)]
if _tempfile_ in files: files.remove(_tempfile_)
print('Running on : ' + '|'.join(files))
input('Press [RET] to continue')

temp = [f.replace('_spectra_corr.txt','').split('_') for f in files]
tempname = []
for i in temp:
    tempname.append(i[len(i)-1])

# degrees corresponding to each file
temp = [ float(x.replace('G','')) for x in tempname ]
for i,x in enumerate(temp):
    if x > 180.0: 
        temp[i]=(x-360)
        print(temp)

# for entire range of degrees mapped
indexingcol = []
for i in range(3600):
    indexingcol.append(float(i)/10.) 


# combining data together
count = 0
for i,j in enumerate(temp):
    # intelligently concat files
    try:              
        if count == 0:
            pdata = ascii.read(files[i])
            #print(data)
            count = 1
        else:
            ndata = ascii.read(files[i])
            #print(ndata)
            pdata.add_columns([ndata['vel'],ndata['Tant_corr']],rename_duplicate=True)
        count = 1
    except ValueError:
        raw_input('Press return to view file of problems.')
        os.system('cat ' + outname1)
        sys.exit('Quitting Program')

indexingrow = abs(min(pdata['vel']) - max(pdata['vel']))/len(pdata['vel'])
print(indexingrow)

ascii.write(pdata,_tempfile_)

# find the min and max temp
mintemp = 999.
maxtemp = 0.
if mintemp > min(pdata['Tant_corr']):
    mintemp = min(pdata['Tant_corr'])
if maxtemp < max(pdata['Tant_corr']):
    maxtemp = max(pdata['Tant_corr'])
for i in range(len(files[i])-2):
    if mintemp > min(pdata['Tant_corr_'+str(i)]):
        mintemp = min(pdata['Tant_corr_'+str(i)])
    if maxtemp < max(pdata['Tant_corr_'+str(i)]):
        maxtemp = max(pdata['Tant_corr_'+str(i)])

totaltempnums = (maxtemp - mintemp)/0.00000000000000001

# to map all values into pix map
# temperature vs velocity vs degrees
completemap = np.empty([totaltempnums,indexingrow,len(indexingcol)])
for i in range(len(completemap[0][0])):
    for j in range(len(completemap[0])):
        for k in range(len(completemap):
            completemap[]




'''
nrows,ncols = 600, len(indexingcol)
grid = pdata['Tant_corr'].reshape((nrows, ncols))

plt.imshow(grid, extent=(indexingcol.min(), indexingcol.max(), pdata['vel'].max(), pdata['vel'].min()),
           interpolation='nearest', cmap=cm.gist_rainbow)
'''
plt.plot(pdata['vel'],pdata['Tant_corr'])



plt.show()

#