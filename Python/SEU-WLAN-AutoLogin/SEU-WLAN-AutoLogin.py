import base64
from selenium import webdriver
from time import sleep

# You can get GeckoDriver at
# https://mirrors.huaweicloud.com/geckodriver/
driver = webdriver.Firefox(geckodriver地址)
#driver.implicitly_wait(30)

try:
    driver.get('https://w.seu.edu.cn/')
    sleep(2)
    driver.find_element_by_xpath('//input[@placeholder="账号"]').send_keys(一卡通)
    driver.find_element_by_xpath('//input[@placeholder="密码"]').send_keys(密码)
    driver.find_element_by_xpath('//input[@value="登录"]').click()
    sleep(2)    
    driver.quit()
except:
    driver.quit()
