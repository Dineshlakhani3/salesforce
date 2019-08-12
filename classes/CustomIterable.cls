global class CustomIterable implements Iterator<list<wrapper>> { 
    list<wrapper> ListRequested{get; set;}    
    list<wrapper> InnerList{get; set;}    
    Integer i {get; set;}    
    public Integer setPageSize {get; set;}    
    public CustomIterable(List<wrapper> lstAccWr)    {        
        InnerList = new list<wrapper>();         
        ListRequested = new list<wrapper>();           
        InnerList = lstAccWr;       
        setPageSize = 2;       
        i = 0;    
    }       
    global boolean hasNext(){        
        if(i >= InnerList.size()) 
        {           
            return false;        
        } else {            
            return true;         
        }    
    }         
    global boolean hasPrevious(){  
        if(i <= setPageSize) {            
            return false;         
        } else {            
            return true;        
        }    
    }       
    global list<wrapper> next(){               
        system.debug('i value is ' + i);      
        ListRequested = new list<wrapper>();         
        integer startNumber;       
        integer size = InnerList.size();       
        if(hasNext())        {             
            if(size <= (i + setPageSize))  {                
                startNumber = i;               
                i = size;            
            }  else  {               
                i = (i + setPageSize);                
                startNumber = (i - setPageSize);           
            }                       
            system.debug('i value is =====' + i);           
            system.debug('i value is 2==== ' + (i - setPageSize));                        
            for(integer start = startNumber; start < i; start++)    
            {               
                ListRequested.add(InnerList[start]);           
            }        
        }  
        return ListRequested;    
    }         
    global list<wrapper> previous(){            
        ListRequested = new list<wrapper>();        
        system.debug('i value is previous before =====' + i);       
        integer size = InnerList.size();         
        if(i == size)   {            
            if(math.mod(size, setPageSize) > 0)            
            {                   
                i = size - math.mod(size, setPageSize);          
            }  else  {                
                i = (size - setPageSize);          
            }         
        } else  {          
            i = (i - setPageSize);       
        }               
        system.debug('i value is previous =====' + i);        
        system.debug('i value is 2previous ==== ' + (i - setPageSize));                
        for(integer start = (i - setPageSize); start < i; ++start)        
        {            
            ListRequested.add(InnerList[start]);       
        }         
        return ListRequested;   
    }   
}