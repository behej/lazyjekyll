---
title: Android - Async task
layout: default
icon: android.png
---
# Asynchronous task

Inherits AsyncTask class. Template that specifies 3 types
* 1st: input data type (given to runInBackground methode when calling the execute method)
* 2nd: intermediate data type (cyclically updated by the task, for progress indication for example). Void if no intermediate data
* 3rd: output data type (return by runInBackground method. Given as parameter to the onPostExecute method)

```java
public class MyAsyncTask extends AsyncTask<Integer, Integer, String> {

    public MyAsyncTask() {
        // Constructor 
    }
   
    @Override
    protected String doInBackGround(Integer... params) {
        params[0];  // Paramètre en entrée
        
        try {
            //do long stuff
        }
        catch (InterruptedException ignored) {} // Exception raised when cancel method is called
        catch (Exception ex)  {} // Other exceptions
       
       
        return ret; // output parameter
    }
   
    // Method called once doInBackground is terminated (if asyncTask is not interrupted)
    // This method is called within threadUI
    @Override
    protected void onPostExecute(String result) {
        // Do stuff
        // As this method is called within ThreadUI, it can directly modify Views
    }
}
```

Dans une activité

```java
MyAsyncTask task = new MyAsyncTask();
task.execute(value);    // Value should be of type indicated as input data type in the template
```

Dans une activité
```java
// Override method onDestroy of the activity to manually cancel task (otherwise, task continues to perform)
@Override
protected void onDestroy() {
    super.onDestroy();  // We call the method of the parent class
    
    if (task != null)
        task.cancel(true);  // task is stopped. true parameter will raise an InterruptedException within AsyncTask
}
```