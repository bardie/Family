����  - 6 (Ljava/lang/Object;)Z
 # 
 , & * % Parser com.ms.vm.loader.URLClassLoader ()V 	 "   %(Ljava/lang/String;)Ljava/lang/Class; #com/ms/security/SecurityClassLoader
 + ! Ljava/lang/Class; java/lang/SecurityException  0 java/lang/ClassLoader	 "  )(Ljava/lang/String;[BII)Ljava/lang/Class; myDefineClass
 #     &(Ljava/lang/String;Z)Ljava/lang/Class; -  dummy_class equals UCL_definition   	loadClass resolveClass [B   *    java/lang/String (I)V   
SourceFile
 # .
 "  <init>  $ defineClass 1 

 "  (Ljava/lang/Class;)V findSystemClass Code Dummy Parser.j 3 ! " +                *   2        * � /�         * %  2        *� �         2   E 
 
   9+5� � *� 	�+� � **� *� �� )�*+� (N� *-� -�         2    
 
   **+,� YL� +�      '    4