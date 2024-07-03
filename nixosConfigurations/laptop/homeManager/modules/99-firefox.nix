{pkgs, ...}: {
  programs.firefox = let
    set = v: {
      Value = v;
      Status = "locked";
    };
  in {
    enable = true;
    package = pkgs.firefox-esr;

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = false;
      DisableSetDesktopBackground = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      DisableProfileImport = true; # For purity
      DisableProfileRefresh = true;
      ExtensionUpdate = false;
      # Websites are reasonable nowadays.
      PopupBlocking.Default = true;

      SearchEngines = {
        PreventInstalls = true;
        Default = "Kagi";
        Add = [
          {
            Name = "Kagi";
            URLTemplate = "https://kagi.com/search?q={searchTerms}";
            Alias = "kagi";
            SuggestURLTemplate = "https://kagi.com/api/autosuggest?q={searchTerms}";
            Description = "Kagi Search Engine";
            IconURL = "https://kagi.com/favicon.ico";
          }
          {
            Name = "Github Code";
            Alias = "gc";
            URLTemplate = "https://github.com/search?type=code&q={searchTerms}";
            Description = "Github Code Search";
            IconURL = "https://github.com/favicon.ico";
          }
        ];
        Remove = [
          "Google"
          "Wikipedia (en)"
          "Bing"
        ];
      };

      ShowHomeButton = false;
      PromptForDownloadLocation = true;
      StartDownloadsInTempDirectory = false;
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

      DisplayMenuBar = "default-off";

      ExtensionSettings =
        builtins.mapAttrs (
          _name: value: {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${value}/latest.xpi";
          }
        ) {
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "sponsorBlocker@ajay.app" = "sponsorblock";
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = "localcdn-fork-of-decentraleyes";
        };

      SanitizeOnShutdown = {
        Cache = false;
        Cookies = false;
        Downloads = false;
        FormData = true;
        History = false;
        Sessions = false;
        SiteSettings = false;
        OfflineApps = false;
        Locked = true;
      };

      HttpsOnlyMode = "enabled";

      DownloadDirectory = "/home/default/Downloads";
      GoToIntranetSiteForSingleWordEntryInAddressBar = true;

      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Locked = true;
      };

      Preferences = {
        "browser.translations.automaticallyPopup" = set false;
        "general.autoScroll" = set true;
        "nglayout.initialpaint.delay" = set "0";
        "browser.aboutConfig.showWarning" = set false;
        "browser.startup.page" = set 1;
        "browser.translations.enable" = set false;
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

  home.file.".mozilla/managed-storage/uBlock0@raymondhill.net.json".text = builtins.toJSON {
    name = "uBlock0@raymondhill.net";
    description = "ignored";
    type = "storage";
    data = {
      userSettings = [
        ["advancedUserEnabled" "true"]
        ["autoUpdate" "true"]
      ];
      toOverwrite = {
        filterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "easylist"
          "easyprivacy"
          "urlhaus-1"
          "plowe-0"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "adguard-cookies"
          "ublock-cookies-adguard"
          "fanboy-social"
          "adguard-social"
          "fanboy-thirdparty_social"
          "easylist-chat"
          "easylist-newsletters"
          "easylist-notifications"
          "easylist-annoyances"
          "adguard-mobile-app-banners"
          "adguard-other-annoyances"
          "adguard-popup-overlays"
          "adguard-widgets"
          "ublock-annoyances"
          "FRA-0"
          "https://raw.githubusercontent.com/mchangrh/yt-neuter/main/yt-neuter.txt"
        ];
      };
    };
  };
}
