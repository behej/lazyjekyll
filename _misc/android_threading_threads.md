---
title: Android - Threads
layout: default
icon: android.png
---
# Threads
```java
// Creating a thread
Thread myThread = new Thread() {

    // Override run method to implement code executed by the thread
    @Override
    public void run() {
    
        try {            
            // Code to executed by the thread here
        }
        catch (InterruptedException ignored) {}    // Exception raised when thread in interrupted
   
   
   
        // Views can only be modified from the threadUI. Views cannot be modified by another thread
        // If we want to modify a view from a thread, we have to use the runOnUiThread method.
        runOnUiThread(new Runnable() {    // Creation of a Runnable object that reimplements the run method.
            @Override
            public void run() {
                // Run ethode contains code that will be executed within threadUI.
                // Typically Views update
            }
        });
   
    }
};

myThread.start();    // Start Thread
```