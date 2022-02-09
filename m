Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E814AE692
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 03:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiBICj3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 21:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiBIB42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 20:56:28 -0500
Received: from smtp-pro1.mana.pf (smtp-pro1.mana.pf [202.3.225.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58381C06157B
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 17:56:26 -0800 (PST)
Received: from tiare.sysnux.pf (unknown [43.249.178.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: courrier@sysnux.pf)
        by smtp-pro1.mana.pf (Postfix) with ESMTPSA id 7A9E054151;
        Tue,  8 Feb 2022 15:56:24 -1000 (-10)
Received: from [192.168.0.200] (tiare.sysnux.pf [192.168.0.200])
        by tiare.sysnux.pf (Postfix) with ESMTP id B53493020DDC;
        Tue,  8 Feb 2022 15:56:23 -1000 (-10)
DKIM-Filter: OpenDKIM Filter v2.11.0 tiare.sysnux.pf B53493020DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysnux.pf; s=202012;
        t=1644371783; bh=aJZuuwt7NTJWdMnZtlnq44j1IJkmV6LUpsn9DB7snGE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=EMXfNWqyGAQqkAPA0ZxprQd7TvMDygNxXigEzZ6o8Ejn40+csC4jaVV48D3J9wUjK
         ataaQcDpYVliY5FD0sjUOj6FRgUrzRthliXVksEh4Ptr/ofSMCT1z7UQsjKZXrUB8g
         45JcjPKg4ZstzVEqahHtn93SNg+ipEz6+wQixdy4=
Message-ID: <634769aa-9a97-33f4-caa6-c66ca0f877f4@sysnux.pf>
Date:   Tue, 8 Feb 2022 15:56:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-GB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com> <stp1bs$l94$1@ciao.gmane.io>
 <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
From:   Jean-Denis Girard <jd.girard@sysnux.pf>
In-Reply-To: <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070205090106070304010106"
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

--------------ms070205090106070304010106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qu,

Sorry for late reply, and I still have not applied the last diff you sent.

But I wanted to report that without rebooting (uptime is 3 days 7 hours) 
or doing anything special, my system now behaves much better. 
btrfs-cleaner sometimes appears in top, but not for long period, and CPU 
usage is low. iostat seems reasonnable too.

Not sure what to conclude...


Thanks,
-- 
Jean-Denis Girard

SysNux                   Systèmes   Linux   en   Polynésie  française
https://www.sysnux.pf/   Tél: +689 40.50.10.40 / GSM: +689 87.797.527


Le 06/02/2022 à 15:16, Qu Wenruo a écrit :
> 
> 
> On 2022/2/7 01:43, Jean-Denis Girard wrote:
>> Hi list,
>>
>> I'm also experiencing high IO with autodefrag on 5.16.6 patched
>> with: -
>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=609387,
>>
>>
> - https://patchwork.kernel.org/project/linux-btrfs/list/?series=611509,
>> - btrfs-defrag-bring-back-the-old-file-extent-search-behavior.diff.
> 
> OK, btrfs_search_forward() doesn't help in this case I guess.
> 
>>
>> After about 24 hours uptime, btrfs-cleaner is most of the time at 90
>> % CPU usage
>>
>> %CPU  %MEM     TIME+ COMMAND 77,6   0,0  29:03.25 btrfs-cleaner 19,1
>> 0,0   3:40.22 kworker/u24:8-btrfs-endio-write 19,1   0,0   1:50.46
>> kworker/u24:27-btrfs-endio-write 18,4   0,0   4:14.82
>> kworker/u24:7-btrfs-endio-write 17,4   0,0   4:08.08
>> kworker/u24:10-events_unbound 17,4   0,0   4:23.41
>> kworker/u24:9-btrfs-delalloc 15,8   0,0   3:41.21
>> kworker/u24:3-btrfs-endio-write 15,1   0,0   2:12.61
>> kworker/u24:26-blkcg_punt_bio 14,8   0,0   3:40.13
>> kworker/u24:18-btrfs-delalloc 12,8   0,0   3:55.70
>> kworker/u24:20-btrfs-delalloc 12,5   0,0   4:01.79
>> kworker/u24:1-btrfs-delalloc 12,2   0,0   4:04.63
>> kworker/u24:22-btrfs-endio-write 11,5   0,0   1:11.90
>> kworker/u24:11-btrfs-endio-write 11,2   0,0   1:25.96
>> kworker/u24:0-blkcg_punt_bio 10,2   0,0   4:24.17
>> kworker/u24:24+events_unbound ...
>>
>> Load average is 5,56, 6,88, 6,71 while just writing that mail.
>>
>> And iostat shows:
>>
  hours uptime>> avg-cpu:  %user   %nice %system %iowait  %st days eal   
%idle 1,5%    0,0%
>> 26,8%    6,3%    0,0%   65,4%
>>
>> tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>> kB_dscd Device 33893,50         0,0k       172,2M        57,8M
>> 0,0k       1,7G 577,7M nvme0n1 169,40         0,0k         1,2M
>> 0,0k       0,0k      12,5M 0,0k sda 178,90         0,0k         1,3M
>> 0,0k       0,0k      12,5M 0,0k sdb
>>
>> I hope that helps.
> 
> And what are the mount options?
> 
>  From the CPU usage, it looks like there are some infinite loop, but I
> can't find out why by a quick glance.
> 
> And since there is no extra read, it looks like it's doing defrag again
> and again on the same inode and range.
> 
> 
> Mind to apply attached `debug.diff`?
> 
> Then you still need to provide `/sys/kernel/debug/tracing/trace`, which
> can be very large and full of added debug info.
> (This means this can slow down your system)
> 
> The example of my local test would result something like this in above
> trace file:
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 11/11   #P:16
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     btrfs-cleaner-1770    [014] .....   961.534329: btrfs_defrag_file:
> entry r/i=5/257 start=0 len=131072 newer=7 thres=262144
>     btrfs-cleaner-1770    [014] .....   961.534333:
> defrag_collect_targets: add target r/i=5/257 start=0 len=16384 em=0
> len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534335:
> defrag_collect_targets: add target r/i=5/257 start=16384 len=16384
> em=16384 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534336:
> defrag_collect_targets: add target r/i=5/257 start=32768 len=16384
> em=32768 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534337:
> defrag_collect_targets: add target r/i=5/257 start=49152 len=16384
> em=49152 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534564:
> defrag_collect_targets: add target r/i=5/257 start=0 len=16384 em=0
> len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534567:
> defrag_collect_targets: add target r/i=5/257 start=16384 len=16384
> em=16384 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534568:
> defrag_collect_targets: add target r/i=5/257 start=32768 len=16384
> em=32768 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534569:
> defrag_collect_targets: add target r/i=5/257 start=49152 len=16384
> em=49152 len=16384 gen=7 newer=7
>     btrfs-cleaner-1770    [014] .....   961.534580: btrfs_defrag_file:
> defrag target r/i=5/257 start=0 len=65536
>     btrfs-cleaner-1770    [014] .....   961.534681:
> btrfs_run_defrag_inodes: defrag finish r/i=5/257 ret=0 defragged=16
> last_scanned=131072 last_off=0 cycled=0
> 
> Thanks,
> Qu
> 
> 
>>
>>
>> Thanks,

--------------ms070205090106070304010106
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
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjAyMDkwMTU2MjNaMC8GCSqGSIb3
DQEJBDEiBCCHhnyrgqzpZAPPCi7gfYYW+Q5NEXpwG2jMOhsNi6L/oDBsBgkqhkiG9w0BCQ8x
XzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIG9BgkrBgEEAYI3
EAQxga8wgawwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1
U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EQDsmC7g3lAwy7h8LafaejBRMIG/BgsqhkiG9w0BCRACCzGBr6CBrDCBljELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0
aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAOyYLuDeUDDLuHwtp9p6MFEwDQYJ
KoZIhvcNAQEBBQAEggEABVSHCdBQwqbo8Roi64oaBLNi7xZRSErZCce0UHNG9U4+i/f0ccYT
GcdbT34ybkRlPgVVkcHNfjdOqIkvglbAAiXgp/+JW+Nlqjfs1M96v5fZxU0laW61Z340Gcdb
CWXpddSXJfAe6a50JjBo4K7M5Hk4qwIOKafOMqW5HfAvIYqyy5dKEHpTKiIcSt+SOG78iYm6
DSAfovMOBDz3vLDsAzaXvIolDE75tTg0TfhZ2o2QJ7wIuIiekDqRWIegSwwYJJ08T/hJVaeO
nG07MUt0aYcUi5E+gKtjY9zilR4eLFX/Dpw8O+BSGOa+mB+rnpEuRSp+WJcvcQhMjYEx4ifs
jQAAAAAAAA==
--------------ms070205090106070304010106--
