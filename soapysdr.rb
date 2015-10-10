class Soapysdr < Formula
  homepage "https://github.com/pothosware/SoapySDR/wiki"
  head "https://github.com/pothosware/SoapySDR.git"

  depends_on "cmake" => :build
  depends_on "swig" => :build

  #This patch forces SoapySDR to search the /usr/local prefix for modules.
  #This patch is needed because the CMAKE_INSTALL_PREFIX is not /usr/local.
  #Another solution would be to set SOAPY_SDR_ROOT environment variable.
  patch :DATA

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end
end

__END__
diff --git a/lib/Modules.in.cpp b/lib/Modules.in.cpp
index 8965f85..09e1b83 100644
--- a/lib/Modules.in.cpp
+++ b/lib/Modules.in.cpp
@@ -95,7 +95,7 @@ std::vector<std::string> SoapySDR::listModules(void)
     searchPaths.push_back(SoapySDR::getRootPath() + "/lib@LIB_SUFFIX@/SoapySDR/modules");
 
     //support /usr/local module installs when the install prefix is /usr
-    if (SoapySDR::getRootPath() == "/usr")
+    //if (SoapySDR::getRootPath() == "/usr")
     {
         searchPaths.push_back("/usr/local/lib@LIB_SUFFIX@/SoapySDR/modules");
         //when using a multi-arch directory, support single-arch path as well