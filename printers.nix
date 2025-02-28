{
  # Enable CUPS to print documents.
  services.printing.enable = true;


  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  hardware.printers.ensurePrinters = [
    {
      description = "HP Color LaserJet CP5225dn";
      deviceUri = "dnssd://HP%20Color%20LaserJet%20CP5225dn%20(CE4B57)._pdl-datastream._tcp.local/";
      model = "drv:///sample.drv/generic.ppd";
      name = "HP_Color_LaserJet_CP5225dn";
      ppdOptions = {
        PageSize = "A4";
        Option1 = "True";
      };
    }
    {
      description = "Roland CAMM-1 GS-24";
      deviceUri = "http://schneidplotter.local:631/printers/Roland_GS-24";
      model = "raw";
      name = "GS-24";
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
}
