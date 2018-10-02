package com.example.demo;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
public class WordCloud {

   public void byRuntime(String[] command) throws IOException, InterruptedException {
      
      Runtime runtime = Runtime.getRuntime();
      Process process = runtime.exec(command);
      printStream(process);
   }

   public void byProcessBuilder(String[] command) throws IOException, InterruptedException {
      ProcessBuilder builder = new ProcessBuilder(command);
      System.out.println("=========================byProcessor 실행중");
      Process process = builder.start();
      System.out.println("종료");
      printStream(process);
   }

   public void printStream(Process process) throws IOException, InterruptedException {
      //process.waitFor();
      try (InputStream psout = process.getInputStream()) {
         System.out.println("=========================여기 실행됰");
         copy(psout, System.out);
         //BufferedReader in = new BufferedReader(new InputStreamReader(psout));
           //String ret = in.readLine();
           //System.out.println(ret);
      }
   }

   public void copy(InputStream input, OutputStream output) throws IOException {
        byte[] buffer = new byte[1024];
        int n = 0;
        System.out.println(n);
        while ((n = input.read(buffer)) != -1) {
            output.write(buffer, 0, n);
        }
        System.out.println(n);
    }

   public static void main(String[] args) throws IOException, InterruptedException {
       WordCloud runner = new WordCloud();
           //runner.byRuntime(command);
           runner.byProcessBuilder(args);
          // runner.byProcessBuilderRedirect(command);
   }
}