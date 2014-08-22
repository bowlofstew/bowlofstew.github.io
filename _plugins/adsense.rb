# Use <!--adsense1--> or <!--adsense2--> in markdown content files
module Jekyll
  module AdsenseFilter
    ADSENSE = {
      :banner => %Q{
        <div style="margin:20px 0;">
        <script type="text/javascript"><!--
        google_ad_client = "ca-pub-4593390900259285";
        /* github-banner */
        google_ad_slot = "4037718654";
        google_ad_width = 468;
        google_ad_height = 60;
        //-->
        </script>
        <script type="text/javascript"
        src="//pagead2.googlesyndication.com/pagead/show_ads.js">
        </script>
        </div>
      },
      :box => %Q{
        <div style="margin:20px 0;">
        <script type="text/javascript"><!--
        google_ad_client = "ca-pub-4593390900259285";
        /* github-box */
        google_ad_slot = "5514451854";
        google_ad_width = 336;
        google_ad_height = 280;
        //-->
        </script>
        <script type="text/javascript"
        src="//pagead2.googlesyndication.com/pagead/show_ads.js">
        </script>
        </div>
      }
    }

    def adsense_replace(input)
      output = input
        .gsub(/<!--adsense1-->/, ADSENSE[:banner])
        .gsub(/<!--adsense2-->/, ADSENSE[:box])
      output
    end

  end
end

Liquid::Template.register_filter(Jekyll::AdsenseFilter)
