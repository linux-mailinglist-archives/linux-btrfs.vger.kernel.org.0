Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845474AB332
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 02:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbiBGBxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 20:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbiBGBxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 20:53:06 -0500
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:53:04 PST
Received: from smtp-pro1.mana.pf (smtp-pro1.mana.pf [202.3.225.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AEE2C043180
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 17:53:04 -0800 (PST)
Received: from tiare.sysnux.pf (unknown [43.249.178.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: courrier@sysnux.pf)
        by smtp-pro1.mana.pf (Postfix) with ESMTPSA id 046DF541FC;
        Sun,  6 Feb 2022 15:45:19 -1000 (-10)
Received: from [192.168.0.200] (tiare.sysnux.pf [192.168.0.200])
        by tiare.sysnux.pf (Postfix) with ESMTP id 616A43015C64;
        Sun,  6 Feb 2022 15:45:18 -1000 (-10)
DKIM-Filter: OpenDKIM Filter v2.11.0 tiare.sysnux.pf 616A43015C64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysnux.pf; s=202012;
        t=1644198318; bh=wJLpimtSImhNprclmDPtn8DzNm6DD0pOzEAwXqmBw3g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OtxTDpfXaYxiyZrUC73Xnz7z2sZlf5YY/a6ohxbYAj1mGLcKpXzKShSCLbIL49W8s
         hm6fjJkBb4O7BNIT55mM9ic/FWsJYHGyTE6Nn7hu92ks1Xq1gfR9UiQgKcAAiHxNi1
         B4WEs1gjajDRMl5eS3rjv51Aj1NSgtJ1UQWr8Q2g=
Message-ID: <b2bc8d87-d8e1-8417-17ce-08764c5aef55@sysnux.pf>
Date:   Sun, 6 Feb 2022 15:45:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com> <stp1bs$l94$1@ciao.gmane.io>
 <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
In-Reply-To: <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060406060609030403030708"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060406060609030403030708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/02/2022 à 15:16, Qu Wenruo a écrit :
> And what are the mount options?

Here are the mount options:

/dev/nvme0n1p2 on / type btrfs 
(rw,noatime,nodiratime,seclabel,compress-force=zstd:3,ssd,discard=async,space_cache,autodefrag,skip_balance,subvolid=5,subvol=/)
/dev/sdb on /home/Partage type btrfs 
(rw,noatime,nodiratime,seclabel,compress-force=zstd:3,space_cache=v2,autodefrag,skip_balance,subvolid=1061,subvol=/Partage)
/dev/sdb on /home/Photos type btrfs 
(rw,noatime,nodiratime,seclabel,compress-force=zstd:3,space_cache=v2,autodefrag,skip_balance,subvolid=1062,subvol=/Photos)
  ...

I have 13 subvolumes on /dev/sdb.

> Mind to apply attached `debug.diff`?

I can't try that immediately, but will do.


Thanks,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527

--------------ms060406060609030403030708
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Signature cryptographique S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CywwggUUMIID/KADAgECAhEA7Jgu4N5QMMu4fC2n2nowUTANBgkqhkiG9w0BAQsFADCBljEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xOTA1MDEwMDAw
MDBaFw0yMjA0MzAyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2pkLmdpcmFyZEBzeXNudXgu
cGYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDN/fQ8TAGvTBOFn6qxE7ZN8b0b
aKR3haVfP9gGFNK6XIkS88UkgMnRJI+boWd2SEdEBMpCrdMlvFHGkP1Xu7Rl/e1rw/63IIDq
ehhFP0eRetG7WQASH7LoZ4VwkU0NAgLbCpUxvAgGWvVQTKQXkk0+lvYOOtWyaXUOyHtK1/Wv
04FRR4PRpvh/Lzm32EVw/U0TtVgmlrIbVp+I3woF0H2UaXCMnwQCVjmJQtjwNQjz1/D57Iw5
/hbVDylDvF7mzXzYbO9isp7Yq3egJV+bhRnytsianodDKw2pT0yB/0I/0bNnpEQ2ti/TNnfD
dmgVKT7j9RR6ma24XoGqd6+6MoHvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU
21/+K9+omULPyeCtADAdBgNVHQ4EFgQUnBqbHNhJ5TcKYH213C0fXKiqlHUwDgYDVR0PAQH/
BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAG
A1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2Vj
dGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsG
AQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdv
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcw
AYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETamQuZ2lyYXJkQHN5c251
eC5wZjANBgkqhkiG9w0BAQsFAAOCAQEAqlsrTWwz05LtzG75zWpJ65W2vWfuS0hWeydRbBG3
CcYAvJoxppGqUqoN4tgjon0Q+FPyzpnkrusjycUb5cGBg13I8kPwGk4OYzKjwSSLIy+fq6dm
GWbU19fJMXhinTlGtnvzrVFKTLhluMIQTsPbQMPw/8s0Hf3hhdZIjtuDomQzEAXhZMVpM4Oe
k+7IerCjywL1VYB3nHQgHU/dwwhA/2CC3mb5S8vLN+gkhv/xfn0Wzp3b6fQfXrXQIFJyzN/w
WaUQhGzI+vQtwb/lZTrha6EusKpWLP/7IrGbtJr7gtlWLBuIarShIBRP3T0RBCjBIvOEWOWX
FNZY5kgWT/+IvTCCBhAwggP4oAMCAQICEE2ULBDUO+CUCcWBLTorBk8wDQYJKoZIhvcNAQEM
BQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJz
ZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VS
VHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMw
MTIzMTIzNTk1OVowgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0
ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UE
AxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKPO2UCkH/3vlGuejWO+bakr8r
EE6qGryCvb4mHCkqKtLNnFCBP22ULvOXqGfV9eNKjkypdR8i0yW2sxpepwRIm4rx20rno0JK
uriIMpoqr03E5cWapdfbM3wccaNDZvZe/S/Uvk2TUxA8oDX3F5ZBykYQYVRR3SQ36gejH4v1
pXWuN82IKPdsmTqQlo49ps+LbnTeef8hNfl7xZ8+cbDhW5nv0qGPVgGt/biTkR7WwtMewu2m
Ir06MbiJBEF2rpn9OVXH+EYB7PmHfpsEkzGp0cul3AhSROpPyx7d53Q97ANyH/yQc+jl9mXm
7UHR5ymr+wM3/mwIbnYOz5BTk7kTAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBRTeb9aqitK
z1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUCcDy/AvalNtf/ivfqJlCz8ngrQAwDgYDVR0PAQH/
BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUF
BwMEMBEGA1UdIAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVz
ZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYI
KwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNF
UlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0
cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAEFEdQCrOcIV9d6OlW0ycWiMAN0X13ocEDiQ
yOOxvRcxkfO244K0oX7GzCGHYaqRbklCszzNWVT4DZU/vYrLaeVEDUbCYg+Ci7vhNn9dNqsc
bzN0xKBoOuRVjPPWDechU70geT3pXCxpwi8EXwl+oiz7xpYfY99JSs3E/piztTSxljHitcPr
5yoWr9lbkFR8KU3+uGTZ11BfKfuSSaRrZFBv133SeY0d2AqvB9Dj2ZDaFZA0OQkkhfAqNgDp
VRH99lQV4JSKx0N7/QAEtMj6OF5dRXV6hhXuU3A0Eql4d0247oBpxvnfcmV95QfG8HP059hZ
SJe7T2wwC+IzXVDQO4xnnvrQJ07ZWemxc/grFpgiG+o+pQxapF1bKftysi02Rl6uhdp5wbTe
LeYzt2SI9oKSChwGDQQFixtkNnxuwbdrTwvASwvViDPdIGzIQJrTBqriE5/9nzkXbDZmld8/
7DyriJ/A73RIZllX4dH8mHqsRpU8NEX8IQZWpHWGK5A5nVgvl7MxNfRlIvCvKZQTSnCL8oNq
JgHXm6zCB4gBwDonM8V/2kuQAUVazVA3I376eIWGwzjuqh3H88v7mNHzubLHm5h0ERCSQNz6
UoHVZy3q5xeqbYSaxpDQz3lCNObL6sNaOQNh3DcyzqZJYTcGfuLlmC3AIteAAh7lbybJszYn
MYIENTCCBDECAQEwgawwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNo
ZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwG
A1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDsmC7g3lAwy7h8LafaejBRMA0GCWCGSAFlAwQCAQUAoIICWTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAyMDcwMTQ1MThaMC8GCSqGSIb3
DQEJBDEiBCBqhZBdvveCXcqjtQt9CzwwPrVMm1QyMKfN+AYnuY0kfjBsBgkqhkiG9w0BCQ8x
XzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIG9BgkrBgEEAYI3
EAQxga8wgawwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1
U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EQDsmC7g3lAwy7h8LafaejBRMIG/BgsqhkiG9w0BCRACCzGBr6CBrDCBljELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAOyYLuDeUDDLuHwtp9p6MFEwDQYJ
KoZIhvcNAQEBBQAEggEARHFOBdl70AOuZgUVW9rmr6KJOgTWqQ3zcPYsJE4YhirbirX28DmG
1+aahNTIBv2Ivv57jw+IvJXHOehFwI1JpK4xdj5Ei7cA85sxji9iuWOZd7tn18vOMHmtRJuL
xm2IgTjuNiG5IAycN6XSRBUhvytWK9U3GoO3OS0TnC61223xteOTY08uGyZtbIiBm463+XVb
whTFtoIfMBpHkViOzoU/B/ZpCxFdTu3jEN0mJ4PcZ9HwS+Bnb6UhhkZndeSxm7TfzOc7C4OL
YETMHNoJaGT28/zuZIcWf4+4JVowIqMZvaaDPdfG01tTrY8+zIQvuQNRDqXDmoHMhCsBah/n
TQAAAAAAAA==
--------------ms060406060609030403030708--
