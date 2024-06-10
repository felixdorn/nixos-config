{pkgs, ...}: {
  programs.firefox = let
    set = v: {
      Value = v;
      Status = "locked";
    };
  in {
    enable = true;

    profiles.default = {
      search = {
        force = true;
        default = "Kagi";
        engines = {
          "Google".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
      };
    };

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = false;
      DisableSetDesktopBackground = true;
      NoDefaultBookmarks = false;
      DisableProfileImport = true; # For purity
      DisableProfileRefresh = true;
      #ExtensionUpdate = false;

      ShowHomeButton = false;
      StartDownloadsInTempDirectory = true;
      UserMessaging = {
        WhatsNew = false;
        UrlbarInterventions = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;

        Locked = true;
      };

      UseSystemPrintDialog = true;

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      DontCheckDefaultBrowser = true;

      PictureInPicture = {
        Enabled = true;
        Locked = true;
      };

      ExtensionSettings =
        builtins.mapAttrs (
          _name: value: {
            installation_mode = "normal_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${value}/latest.xpi";
          }
        ) {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "sponsorBlocker@ajay.app" = "sponsorblock";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = "localcdn-fork-of-decentraleyes";
        };

      SanitizeOnShutdown = {
        Cookies = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Cache = false;
        Downloads = false;
        OfflineApps = false;
        Locked = true;
      };

      GoToIntranetSiteForSingleWordEntryInAddressBar = true;

      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Locked = true;
      };

      Preferences = {
        "general.autoScroll" = set true;
        "nglayout.initialpaint.delay" = set "0";
        "browser.aboutConfig.showWarning" = set false;
        "browser.startup.page" = set 1;
        "browser.translations.enable" = set false;
        "browser.urlbar.dnsResolveSingleWordsAfterSearch" = set 1;
        "browser.tabs.loadInBackground" = set true;
        "browser.urlbar.quickactions.enabled" = set false;
        "browser.urlbar.quickactions.showPrefs" = set false;
        "browser.urlbar.shortcuts.quickactions" = set false;
        "browser.urlbar.suggest.quickactions" = set false;
        "browser.uitour.enabled" = set false;
        "browser.urlbar.suggest.calculator" = set true;
        "browser.vpn_promo.enabled" = set false;

        # Print
        "print.print_footerleft" = set "";
        "print.print_footerright" = set "";
        "print.print_headerleft" = set "";
        "print.print_headerright" = set "";

        # Disable Activity Stream on new windows and tab pages
        "browser.newtabpage.enabled" = set false;
        "browser.newtab.preload" = set false;
        "browser.newtabpage.activity-stream.telemetry" = set false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = set false;
        "browser.newtabpage.activity-stream.feeds.snippets" = set false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = set false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = set false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = set false;
        "browser.newtabpage.activity-stream.showSponsored" = set false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = set false;
        "browser.newtabpage.activity-stream.default.sites" = set "";

        #  Disable addons recommendations
        "extensions.getAddons.showPane" = set false; # Hidden preference
        "extensions.htmlaboutaddons.recommendations.enabled" = set false;
        "browser.discovery.enabled" = set false;

        # Disable telemetry
        "datareporting.policy.dataSubmissionEnabled" = set false;
        "browser.ping-centre.telemetry" = set false;
        "browser.tabs.crashReporting.sendReport" = set false;

        # Safe browsing
        "browser.safebrowsing.malware.enabled" = set false;
        "browser.safebrowsing.phishing.enabled" = set false;
        "browser.safebrowsing.provider.google4.gethashURL" = set "";
        "browser.safebrowsing.provider.google4.updateURL" = set "";
        "browser.safebrowsing.provider.google4.dataSharingURL" = set "";
        "browser.safebrowsing.provider.google.gethashURL" = set "";
        "browser.safebrowsing.provider.google.updateURL" = set "";

        # Use Punycode in Internationalized Domain Names
        "network.IDN_show_punycode" = set true; # This settings saves lives.

        # Passwords
        "signon.rememberSignons" = set false;
        "signon.autofillForms" = set false;
        "signon.formlessCapture.enabled" = set false;

        # Display advanced information on Insecure Connection warning pages
        "browser.xul.error_pages.expert_bad_cert" = set true;

        # Always ask you where to save files
        "browser.download.useDownloadDir" = set true;
        "browser.download.manager.addToRecentDocs" = set false;

        # Cookies
        "browser.contentblock.category" = set "strict";

        # Disable PDFJS scripting
        "pdfjs.enableScripting" = set false;

        # Extensions
        "extensions.enabledScopes" = set 5;
        "extensions.webextensions.restrictedDomains" = set "";
        "extensions.postDownloadThirdPartyPrompt" = set false;

        # Fingerprinting
        "browser.startup.blankWindow" = set false;
        "browser.display.use_sytem_color" = set false;
      };
    };
  };
}
