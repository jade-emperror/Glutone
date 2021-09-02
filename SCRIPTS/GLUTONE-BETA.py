'''
PENDING WORKS::
1.AUTOMATE THE WEB SCRAPING OF DATA FROM GOBLIN
'''

#libraries for Machine Learning
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression,Lasso,Ridge,ElasticNet
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import train_test_split
#libraries for NSE historical data
from nsepy import get_history
from datetime import date,timedelta
#libraries for sql
import pyodbc

class value:
    data=[]
    ElasticNet_rmse=Linear_rmse=Lasso_rmse=Ridge_rmse=0
    
    
    def __init__(self,name):
        self.name=name
        today = date.today()-timedelta(1)
        one_year_before=today-timedelta(365)
        self.data = get_history(symbol=name, start=one_year_before, end=today)

    def validate(self):
        if(len(self.data)>3):
            return True
        print(self.name," contains no data")
        return False
    
    def feed(self):
        requirements=self.data[['Open','Prev Close','Last']];target=target=self.data['High']
        x_train,x_test,y_train,y_test=train_test_split(requirements,target,test_size=.0005,shuffle=False)
        self.elastic=ElasticNet()
        self.elastic.fit(x_train,y_train)
        ElasticNet_high=self.elastic.predict(x_test)
        ElasticNet_rmse = mean_squared_error(y_test,ElasticNet_high)
        #final=[ElasticNet_high,ElasticNet_rmse,ElasticNet_r2,y_test]
        self.lass=Lasso()
        self.lass.fit(x_train,y_train)
        Lasso_high=self.lass.predict(x_test)
        Lasso_rmse = mean_squared_error(y_test,Lasso_high)
        self.linear=LinearRegression()
        self.linear.fit(x_train,y_train)
        Linear_high=self.linear.predict(x_test)
        Linear_rmse = mean_squared_error(y_test,Linear_high)
        self.ridge=Ridge()
        self.ridge.fit(x_train,y_train)
        Ridge_high=self.ridge.predict(x_test)
        Ridge_rmse = mean_squared_error(y_test,Ridge_high)
        avg=(ElasticNet_rmse+Linear_rmse+Lasso_rmse+Ridge_rmse)/4
        return avg
    def showhigh(self,querey):
        self.querey=querey
        high=(self.linear.predict(self.querey)+self.lass.predict(self.querey)+self.ridge.predict(self.querey)+self.elastic.predict(self.querey))/4
        return high
    
    def lowfeed(self):
        lorequirements=self.data[['Open','Prev Close','Last','High']];lotarget=self.data['Low']
        lox_train,lox_test,loy_train,loy_test=train_test_split(lorequirements,lotarget,test_size=.0005,shuffle=False)
        self.loelastic=ElasticNet()
        self.loelastic.fit(lox_train,loy_train)
        loElasticNet_high=self.loelastic.predict(lox_test)
        loElasticNet_rmse = mean_squared_error(loy_test,loElasticNet_high)
        #final=[ElasticNet_high,ElasticNet_rmse,ElasticNet_r2,y_test]
        self.lolass=Lasso()
        self.lolass.fit(lox_train,loy_train)
        loLasso_high=self.lolass.predict(lox_test)
        loLasso_rmse = mean_squared_error(loy_test,loLasso_high)
        self.lolinear=LinearRegression()
        self.lolinear.fit(lox_train,loy_train)
        loLinear_high=self.lolinear.predict(lox_test)
        loLinear_rmse = mean_squared_error(loy_test,loLinear_high)
        self.loridge=Ridge()
        self.loridge.fit(lox_train,loy_train)
        loRidge_high=self.loridge.predict(lox_test)
        loRidge_rmse = mean_squared_error(loy_test,loRidge_high)
        loavg=(  loElasticNet_rmse + loLinear_rmse + loLasso_rmse + loRidge_rmse ) / 4
        return loavg

    def showlow(self,querey):
        self.querey=querey
        low=(self.lolinear.predict(self.querey)+self.lolass.predict(self.querey)+self.loridge.predict(self.querey)+self.loelastic.predict(self.querey))/4
        return low
    
def loadsql(symbol,percent,open_price,high_rmse,high,low_rmse,low):
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=LAPTOP-2DUPO7GK\SQLEXPRESS;'
                      'Database=magic_db;'
                      'Trusted_Connection=yes;')
    cursor = conn.cursor()    
    querey="INSERT INTO show_time VALUES ('"+symbol+"',"+str(percent)+","+str(open_price)+","+str(high_rmse)+","+str(high)+","+str(low_rmse)+","+str(low)+")"
    cursor.execute(querey)
    cursor.commit()
    conn.close()

def gen_querey(symbol):
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=LAPTOP-2DUPO7GK\SQLEXPRESS;'
                      'Database=magic_db;'
                      'Trusted_Connection=yes;')
    cursor = conn.cursor()
    querey="select open_price,prev_close,last_9_30 from api_data where symbol='"+symbol+"'"
    cursor.execute(querey)
    for row in cursor:
        open_price=row[0]
        prev_close=row[1]
        last_9_30=row[2]
    val=[open_price,prev_close,last_9_30]
    cursor.commit()
    conn.close()
    return val

def delete_tbl_show_time_in_magic_db():
    conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=LAPTOP-2DUPO7GK\SQLEXPRESS;'
                      'Database=magic_db;'
                      'Trusted_Connection=yes;')
    cursor = conn.cursor()
    querey="truncate table show_time"
    cursor.execute(querey)
    cursor.commit()
    conn.close()

if __name__ == '__main__':

    delete_tbl_show_time_in_magic_db()#deleting the show_Time table to avoid convergence and elegant look of the server

    candidates=['AUROPHARMA','BEL','BPCL','CIPLA','ITC','SBIN','SUNPHARMA','TATAGLOBAL','TATAMOTORS','TATASTEEL','WIPRO','ZEEL','MOTHERSUMI','GAIL','ICICIBANK','AXISBANK','JINDALSTEL','LUPIN','BHARTIARTL','CANBK','UPL','BIOCON','SUNTV','TECHM','PFC','INDIANB','UJJIVAN','JUSTDIAL','IBULHSGFIN']#CURRENTLY 30 ELEMENTS IN THE LIST
    cnt=0
    for symbol in candidates:
        obj=value(symbol)

        if(obj.validate()):
            high_rmse=obj.feed()

            if high_rmse<1.2:

                #generation of high value here
                val=gen_querey(symbol)
                querey=val
                querey=[querey]
                high=obj.showhigh(querey)
                high=high[0]
                high=float("{0:.2f}".format(high))
                high_rmse=float("{0:.7f}".format(high_rmse))

                #generation of low value here
                low_rmse=obj.lowfeed()
                val.append(high)
                loquerey=[val]
                low=obj.showlow(loquerey)
                low=low[0]
                low=float("{0:.2f}".format(low))
                low_rmse=float("{0:.7f}".format(low_rmse))

                #generation of percentage
                percent=((high-low)/high)*100
                percent=float("{0:.2f}".format(percent))

                #loading the sql server here
                loadsql(symbol,percent,val[0],high_rmse,high,low_rmse,low)
                print(symbol,"DONE");cnt+=1
    
    #process is done
    print("\nsql server is loaded \n\nYou're Good to GO,",cnt," Symbols are added")
    #invoke webpage