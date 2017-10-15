RubyGem Signing Research
========================

This is a repository containing scripts to analyze the certificates of signed Gems.

* `fetch.sh` will fetch Gems from RubyGems and create a directory structure of `gems/<gemname>/<gemname>.gem`.
* `extract_certs.sh` will extract the certificates from the downloaded Gem files and create a file named `cert.cer`
    in the `gems/<gemname>` directory.
