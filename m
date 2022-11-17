Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3562D7B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 11:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiKQKHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKQKHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 05:07:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA929824
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 02:07:07 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1oYrin1f2z-00NVYv; Thu, 17
 Nov 2022 11:07:05 +0100
Message-ID: <5fcf68ec-836a-3517-289d-bb77527468f7@gmx.com>
Date:   Thu, 17 Nov 2022 18:07:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: block group x has wrong amount of free space
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>,
        linux-btrfs@vger.kernel.org
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
 <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
 <em62944e8a-0e4b-4028-ae00-383aac0608ab@7b52163e.com>
 <d7cc9778-9e97-f749-e110-d93a7045e341@gmx.com>
 <em7ed36627-a727-470e-872c-a2af32cdb18d@7b52163e.com>
 <em8aefb52c-4cdc-4cfb-ad52-1c807d8f7756@7b52163e.com>
 <emcca5c139-84cb-403b-af68-e288e31878e3@7b52163e.com>
 <c91c89b4-58e6-526a-bfb8-fb332e792cc3@gmx.com>
 <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em6eb00339-18ce-4f15-8b9d-da8058301e72@7b52163e.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bE5E9zsV1Zq6Jm7YYMBqU4mQPODAt+5DdlDvsdBdCx/bvMHWsgw
 WUiWU0yVBx1tH3SN1NKgGe4DqILyKJES+b0Uc6nHOehJ7TqsEa+aCSIOuOkWWNkSn4tsckp
 DDSVH9gz3rMmgYVcoqmKtifzTtTxsV9Mf0F20WoPim7MEvIcjDx6tQSP3FSVASSGiQXF0z1
 0JbOdbzSbTVAwXJyYzkeA==
UI-OutboundReport: notjunk:1;M01:P0:d2IN0MiVUHk=;fw/7Nsb5L/UZsw2gaHHFypm9Duw
 fmWabrVvTRhfJVT7vybZ7zWfHwuPcpnSocFc5TMQW16I36hnyqYXNdwHhnradc2L3ZCd1vWF8
 LKOPaVg1PIJtrzAuqT1fvB6lO6BKaqhFJsGUEPswspECXNCXJOM7Fok/QMwoMfGaG/Jpax38l
 61GprAeCr27CICzEcx8i9mozKDlzyfjkVZFFRtlk0wrTU3Q8wjDWTKi2cb3VCst765vwkpsQe
 SgcRYeKHe9rowBjZ8vXXgESvf+VXV7tGTp1gfWgqsacCQOpw86PzzGoBLuAgPLYmiwdTAod6G
 fiWmkkI4WJKXGVCecPtmV6i724DGH03bOAFn2YHUScrGGSWrfgc+624MlY5KEnrfqW6o3mw/D
 p/OhjMTSU0hF1muzkzy0AcdNS5npKqi9Cl6OMnt8hni72YmhKCncwhyIvZwT3B6VHry0kfhKY
 DvIBxIuZwcpF4repzbdZf30zcT3XkxaujdQn57QbHsI+ubTkx540M1f3YBSOq33n3wtgxgHzJ
 4dY5s7GgHmfDpgbLcPqRpvI5qWhp66oY+USal0iB6Q08Tv/1yS8CxRSokAILopihT+BOJ9wp1
 lWBJXPCjmwBxs1SM511BrH/zW0d1LFalOyPkjgvi3fQK1EwkA7tMsQrDTnxGmfidN0MpoxOle
 tEViT1WviRPsYagPNQErfDh9GMfLHeMPNmM+rSTNFaMJrQR7VWPyTtIP3I7Si3tvK0uOtk2ua
 2H5V+VdiTt66vzyEKIj+fo0RSDo2/vlrVqzCzdXK7sOQ42T6KW5FNtzsGP/GMk48vh9vrTCq0
 /a4WFzr49az2kKSpf+oQNFaEf3YY1fLWX3gkK175Bjq7zS0V2VIeXsO9jzDRkH6MdHPlr//6z
 qfzjRrm4SRnncEBmFVX3W0maAAXLjQ2pT2boz3jhXXwwS1OrD1VYS/2CpuqrHztR2Zu10hj2V
 1WGf6a9+VLaafnuwQWbp556CAVQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/17 17:36, Hendrik Friedel wrote:
> Hello,
> 
> thakns Qu.
> No, in fact , I did not switch to v2.
> So, process is now
> btrfs check
> btrfs check --repair
> btrfs check --clear-space-cache v1
> mount [...] -o space_cache=v2
> correct?
> 
> Below the result for btrfs check.
> Is it safe to run repair?

You can skip --repair and go --clear-space-cache v1 directly.

Or even skip them all, go mount -o space_cache=v2 directly.

Thanks,
Qu
> 
> Best regards,
> Hendrik
> 
> btrfs check /dev/sdc1
> Opening filesystem to check...
> Checking filesystem on /dev/sdc1
> UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> block group 18861583040512 has wrong amount of free space, free space 
> cache has 380928 block group has 643072
> failed to load free space cache for block group 18861583040512
> block group 18894869037056 has wrong amount of free space, free space 
> cache has 6664192 block group has 6926336
> failed to load free space cache for block group 18894869037056
> block group 18897016520704 has wrong amount of free space, free space 
> cache has 1024000 block group has 1286144
> failed to load free space cache for block group 18897016520704
> block group 18928155033600 has wrong amount of free space, free space 
> cache has 1867776 block group has 2129920
> failed to load free space cache for block group 18928155033600
> block group 18930302517248 has wrong amount of free space, free space 
> cache has 1183744 block group has 1445888
> ...
> failed to load free space cache for block group 22777519472640
> block group 22834427789312 has wrong amount of free space, free space 
> cache has 6647808 block group has 6909952
> failed to load free space cache for block group 22834427789312
> block group 22837649014784 has wrong amount of free space, free space 
> cache has 5095424 block group has 5619712
> failed to load free space cache for block group 22837649014784
> block group 22840870240256 has wrong amount of free space, free space 
> cache has 7413760 block group has 7675904
> failed to load free space cache for block group 22840870240256
> block group 22847312691200 has wrong amount of free space, free space 
> cache has 8011776 block group has 8273920
> failed to load free space cache for block group 22847312691200
> block group 22917105909760 has wrong amount of free space, free space 
> cache has 815104 block group has 1077248
> failed to load free space cache for block group 22917105909760
> block group 22921400877056 has wrong amount of free space, free space 
> cache has 737280 block group has 999424
> failed to load free space cache for block group 22921400877056
> block group 22925695844352 has wrong amount of free space, free space 
> cache has 405504 block group has 667648
> failed to load free space cache for block group 22925695844352
> block group 22926769586176 has wrong amount of free space, free space 
> cache has 167936 block group has 430080
> failed to load free space cache for block group 22926769586176
> block group 22941801971712 has wrong amount of free space, free space 
> cache has 802816 block group has 1064960
> failed to load free space cache for block group 22941801971712
> block group 22954686873600 has wrong amount of free space, free space 
> cache has 1261568 block group has 1785856
> failed to load free space cache for block group 22954686873600
> block group 24271094349824 has wrong amount of free space, free space 
> cache has 1441792 block group has 1703936
> failed to load free space cache for block group 24271094349824
> block group 24405312077824 has wrong amount of free space, free space 
> cache has 4104192 block group has 4366336
> failed to load free space cache for block group 24405312077824
> block group 24417123237888 has wrong amount of free space, free space 
> cache has 9011200 block group has 9273344
> block group 27656635875328 has wrong amount of free space, free space 
> cache has 14712832 block group has 14974976 
>                                       |
> failed to load free space cache for block group 27656635875328
> block group 28392149024768 has wrong amount of free space, free space 
> cache has 12722176 block group has 12984320
> failed to load free space cache for block group 28392149024768
> block group 28904323874816 has wrong amount of free space, free space 
> cache has 5193728 block group has 5455872
> failed to load free space cache for block group 28904323874816
> block group 29502398070784 has wrong amount of free space, free space 
> cache has 1159168 block group has 1421312
> failed to load free space cache for block group 29502398070784
> block group 30060743819264 has wrong amount of free space, free space 
> cache has 45056 block group has 49152
> failed to load free space cache for block group 30060743819264
> block group 30111209684992 has wrong amount of free space, free space 
> cache has 49913856 block group has 50176000
> failed to load free space cache for block group 30111209684992
> [4/7] checking fs roots
> 
> 
> 
> [5/7] checking only csums items (without verifying data)
> 
> [6/7] checking root refs
> [7/7] checking quota groups
> found 10848736583681 bytes used, no error found
> total csum bytes: 10584151824
> total tree bytes: 14628978688
> total fs tree bytes: 1877164032
> total extent tree bytes: 897548288
> btree space waste bytes: 1633419138
> file data blocks allocated: 20692194222080
>   referenced 13014102208512
> 
> 
> ------ Originalnachricht ------
> Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An "Hendrik Friedel" <hendrik@friedels.name>; linux-btrfs@vger.kernel.org
> Datum 17.11.2022 00:15:55
> Betreff Re: block group x has wrong amount of free space
> 
>>
>>
>> On 2022/11/17 02:52, Hendrik Friedel wrote:
>>> Hello,
>>>
>>> hm, now I have new errors:
>>> [Mi Nov 16 19:10:03 2022] Btrfs loaded, crc32c=crc32c-intel, 
>>> zoned=yes, fsverity=yes
>>> [Mi Nov 16 19:10:03 2022] BTRFS: device label DataPool1 devid 1 
>>> transid 1184729 /dev/sdc1 scanned by btrfs (214)
>>> [Mi Nov 16 19:10:03 2022] BTRFS: device label DataPool1 devid 2 
>>> transid 1184729 /dev/sda1 scanned by btrfs (214)
>>> [Mi Nov 16 19:10:06 2022] BTRFS info (device sdc1): using crc32c 
>>> (crc32c-intel) checksum algorithm
>>> [Mi Nov 16 19:10:06 2022] BTRFS info (device sdc1): disk space 
>>> caching is enabled
>>> [Mi Nov 16 19:10:29 2022] BTRFS error (device sdc1): 'BackupsWindows' 
>>> is not a valid subvolume
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): block group 
>>> 18737028988928 has wrong amount of free space
>>
>> So the whole situation seems to be all caused by bad free space cache.
>>
>> Have you cleared them?
>>
>> It's strongly recommended to clear v1 space cache, and migrate to v2.
>>
>> Thanks,
>> Qu
>>
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18737028988928, rebuilding it now
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): block group 
>>> 18750987632640 has wrong amount of free space
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18750987632640, rebuilding it now
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): block group 
>>> 18756356341760 has wrong amount of free space
>>> [Mi Nov 16 19:20:25 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18756356341760, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18786421112832 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18786421112832, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18833665753088 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18833665753088, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18861583040512 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18861583040512, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18897016520704 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18897016520704, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18894869037056 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18894869037056, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18928155033600 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18928155033600, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18930302517248 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18930302517248, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18932450000896 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18932450000896, rebuilding it now
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): block group 
>>> 18934597484544 has wrong amount of free space
>>> [Mi Nov 16 19:20:26 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18934597484544, rebuilding it now
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): block group 
>>> 18963588513792 has wrong amount of free space
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18963588513792, rebuilding it now
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): block group 
>>> 18982915866624 has wrong amount of free space
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18982915866624, rebuilding it now
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): block group 
>>> 18997948252160 has wrong amount of free space
>>> [Mi Nov 16 19:20:27 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 18997948252160, rebuilding it now
>>> [Mi Nov 16 19:20:31 2022] BTRFS warning (device sdc1): block group 
>>> 19922439962624 has wrong amount of free space
>>> [Mi Nov 16 19:20:31 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 19922439962624, rebuilding it now
>>> [Mi Nov 16 19:20:31 2022] BTRFS warning (device sdc1): block group 
>>> 19978274537472 has wrong amount of free space
>>> [Mi Nov 16 19:20:31 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 19978274537472, rebuilding it now
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 0 (dev /dev/sdc1 sector 18235428920)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 4096 (dev /dev/sdc1 sector 18235428928)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 8192 (dev /dev/sdc1 sector 18235428936)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 12288 (dev /dev/sdc1 sector 18235428944)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 16384 (dev /dev/sdc1 sector 18235428952)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 20480 (dev /dev/sdc1 sector 18235428960)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 24576 (dev /dev/sdc1 sector 18235428968)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 32768 (dev /dev/sdc1 sector 18235428984)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 28672 (dev /dev/sdc1 sector 18235428976)
>>> [Mi Nov 16 19:20:39 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 41923 off 36864 (dev /dev/sdc1 sector 18235428992)
>>> [Mi Nov 16 19:20:40 2022] BTRFS warning (device sdc1): block group 
>>> 22599278329856 has wrong amount of free space
>>> [Mi Nov 16 19:20:40 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22599278329856, rebuilding it now
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): block group 
>>> 22777519472640 has wrong amount of free space
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22777519472640, rebuilding it now
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): block group 
>>> 22834427789312 has wrong amount of free space
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22834427789312, rebuilding it now
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): block group 
>>> 22837649014784 has wrong amount of free space
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22837649014784, rebuilding it now
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): block group 
>>> 22840870240256 has wrong amount of free space
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22840870240256, rebuilding it now
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): block group 
>>> 22847312691200 has wrong amount of free space
>>> [Mi Nov 16 19:20:42 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22847312691200, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22917105909760 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22917105909760, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22921400877056 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22921400877056, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22926769586176 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22926769586176, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22925695844352 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22925695844352, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22941801971712 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22941801971712, rebuilding it now
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): block group 
>>> 22954686873600 has wrong amount of free space
>>> [Mi Nov 16 19:20:43 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 22954686873600, rebuilding it now
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 4096 (dev /dev/sdc1 sector 10459632808)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 12288 (dev /dev/sdc1 sector 10459632824)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 8192 (dev /dev/sdc1 sector 10459632816)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 0 (dev /dev/sdc1 sector 10459632800)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 20480 (dev /dev/sdc1 sector 10459632840)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 16384 (dev /dev/sdc1 sector 10459632832)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 24576 (dev /dev/sdc1 sector 10459632848)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 28672 (dev /dev/sdc1 sector 10459632856)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 32768 (dev /dev/sdc1 sector 10459632864)
>>> [Mi Nov 16 19:20:46 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 43126 off 40960 (dev /dev/sdc1 sector 10459632880)
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): block group 
>>> 24271094349824 has wrong amount of free space
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 24271094349824, rebuilding it now
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): block group 
>>> 24405312077824 has wrong amount of free space
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 24405312077824, rebuilding it now
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): block group 
>>> 24417123237888 has wrong amount of free space
>>> [Mi Nov 16 19:20:49 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 24417123237888, rebuilding it now
>>> [Mi Nov 16 19:21:02 2022] BTRFS warning (device sdc1): block group 
>>> 27656635875328 has wrong amount of free space
>>> [Mi Nov 16 19:21:02 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 27656635875328, rebuilding it now
>>> [Mi Nov 16 19:21:06 2022] BTRFS warning (device sdc1): block group 
>>> 28392149024768 has wrong amount of free space
>>> [Mi Nov 16 19:21:06 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 28392149024768, rebuilding it now
>>> [Mi Nov 16 19:21:07 2022] BTRFS warning (device sdc1): block group 
>>> 28904323874816 has wrong amount of free space
>>> [Mi Nov 16 19:21:07 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 28904323874816, rebuilding it now
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 4096 (dev /dev/sdc1 sector 19727228416)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 0 (dev /dev/sdc1 sector 19727228408)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 8192 (dev /dev/sdc1 sector 19727228424)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 16384 (dev /dev/sdc1 sector 19727228440)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 12288 (dev /dev/sdc1 sector 19727228432)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 20480 (dev /dev/sdc1 sector 19727228448)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 28672 (dev /dev/sdc1 sector 19727228464)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 24576 (dev /dev/sdc1 sector 19727228456)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 32768 (dev /dev/sdc1 sector 19727228472)
>>> [Mi Nov 16 19:21:10 2022] BTRFS info (device sdc1): read error 
>>> corrected: ino 80458 off 36864 (dev /dev/sdc1 sector 19727228480)
>>> [Mi Nov 16 19:21:10 2022] BTRFS warning (device sdc1): block group 
>>> 29502398070784 has wrong amount of free space
>>> [Mi Nov 16 19:21:10 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 29502398070784, rebuilding it now
>>> [Mi Nov 16 19:21:13 2022] BTRFS warning (device sdc1): block group 
>>> 30060743819264 has wrong amount of free space
>>> [Mi Nov 16 19:21:13 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 30060743819264, rebuilding it now
>>> [Mi Nov 16 19:21:13 2022] BTRFS warning (device sdc1): block group 
>>> 30111209684992 has wrong amount of free space
>>> [Mi Nov 16 19:21:13 2022] BTRFS warning (device sdc1): failed to load 
>>> free space cache for block group 30111209684992, rebuilding it now
>>> [Mi Nov 16 19:24:07 2022]  wait_current_trans+0xc0/0x130 [btrfs]
>>> [Mi Nov 16 19:24:07 2022]  start_transaction+0x245/0x610 [btrfs]
>>> [Mi Nov 16 19:24:07 2022]  btrfs_create_common+0xb1/0x110 [btrfs]
>>> [Mi Nov 16 19:28:09 2022] INFO: task btrfs-transacti:2403 blocked for 
>>> more than 120 seconds.
>>> [Mi Nov 16 19:28:09 2022] task:btrfs-transacti state:D stack:    0 
>>> pid: 2403 ppid:     2 flags:0x00004000
>>> [Mi Nov 16 19:28:09 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Mi Nov 16 19:28:09 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Mi Nov 16 19:28:09 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Mi Nov 16 19:30:10 2022] INFO: task btrfs-transacti:2403 blocked for 
>>> more than 241 seconds.
>>> [Mi Nov 16 19:30:10 2022] task:btrfs-transacti state:D stack:    0 
>>> pid: 2403 ppid:     2 flags:0x00004000
>>> [Mi Nov 16 19:30:10 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Mi Nov 16 19:30:10 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Mi Nov 16 19:30:10 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>
>>> All errors are on sdc. Hardware issue?
>>> The smart values look ok.
>>>
>>> But in dmesg I also find:
>>> [Mi Nov 16 19:20:39 2022] ata3.00: exception Emask 0x10 SAct 0x10 
>>> SErr 0x850000 action 0x6 frozen
>>> [Mi Nov 16 19:20:39 2022] ata3.00: irq_stat 0x08000000, interface 
>>> fatal error
>>> [Mi Nov 16 19:20:39 2022] ata3: SError: { PHYRdyChg CommWake LinkSeq }
>>> [Mi Nov 16 19:20:39 2022] ata3.00: failed command: READ FPDMA QUEUED
>>> [Mi Nov 16 19:20:39 2022] ata3.00: cmd 
>>> 60/00:20:38:98:ea/02:00:3e:04:00/40 tag 4 ncq dma 262144 in
>>>                                     res 
>>> 40/00:00:00:10:a9/00:00:f1:04:00/40 Emask 0x10 (ATA bus error)
>>> [Mi Nov 16 19:20:39 2022] ata3.00: status: { DRDY }
>>> [Mi Nov 16 19:20:39 2022] ata3: hard resetting link
>>> [Mi Nov 16 19:20:39 2022] ata3: SATA link up 6.0 Gbps (SStatus 133 
>>> SControl 300)
>>> [Mi Nov 16 19:20:39 2022] ata3.00: ACPI cmd 
>>> f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
>>> [Mi Nov 16 19:20:39 2022] ata3.00: ACPI cmd 
>>> b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
>>> [Mi Nov 16 19:20:39 2022] ata3.00: ACPI cmd 
>>> f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
>>> [Mi Nov 16 19:20:39 2022] ata3.00: ACPI cmd 
>>> b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
>>> [Mi Nov 16 19:20:39 2022] ata3.00: configured for UDMA/133
>>> [Mi Nov 16 19:20:39 2022] ata3: EH complete
>>>
>>>
>>> Best regards,
>>> Hendrik
>>>
>>> ------ Originalnachricht ------
>>> Von "Hendrik Friedel" <hendrik@friedels.name>
>>> An "Qu Wenruo" <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
>>> Datum 16.11.2022 17:17:46
>>> Betreff Re[3]: block group x has wrong amount of free space
>>>
>>>> Sorry, I had re-directed some output to a file:
>>>> Starting repair.
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sdc1
>>>> UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>>> No device size related problem found
>>>> cache and super generation don't match, space cache will be invalidated
>>>> found 10848863809537 bytes used, no error found
>>>> total csum bytes: 10584151620
>>>> total tree bytes: 14628896768
>>>> total fs tree bytes: 1877082112
>>>> total extent tree bytes: 897548288
>>>> btree space waste bytes: 1633585277
>>>> file data blocks allocated: 20692111388672
>>>>  referenced 13014020022272
>>>>
>>>> Greetings,
>>>> Hendrik
>>>>
>>>> ------ Originalnachricht ------
>>>> Von "Hendrik Friedel" <hendrik@friedels.name>
>>>> An "Qu Wenruo" <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
>>>> Datum 16.11.2022 17:11:03
>>>> Betreff Re[2]: block group x has wrong amount of free space
>>>>
>>>>> Hello Qu,
>>>>>
>>>>> that worked:
>>>>> root@homeserver:~/btrfs# btrfs --version
>>>>> btrfs-progs v6.0.1
>>>>> root@homeserver:~/btrfs# btrfs check --repair /dev/sdc1 > 
>>>>> repair_log.txt
>>>>> [1/7] checking root items
>>>>> Fixed 0 roots.
>>>>> [2/7] checking extents
>>>>> [3/7] checking free space cache
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups
>>>>>
>>>>> Thanks a lot! I am wondering now, what the cause of this issue 
>>>>> could have been and how to prevent this?
>>>>>
>>>>> Greetings,
>>>>> Hendrik
>>>>>
>>>>> ------ Originalnachricht ------
>>>>> Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>> An "Hendrik Friedel" <hendrik@friedels.name>; 
>>>>> linux-btrfs@vger.kernel.org
>>>>> Datum 16.11.2022 13:57:47
>>>>> Betreff Re: block group x has wrong amount of free space
>>>>>
>>>>>>
>>>>>>
>>>>>> On 2022/11/16 20:54, Hendrik Friedel wrote:
>>>>>>> Thanks Qu,
>>>>>>>
>>>>>>> unfortunately, btrfs check --repair failed. There is lots of 
>>>>>>> output. I have shortened the repeats. Still it is very long, sorry.
>>>>>>> Any further chance?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Hendrik
>>>>>>>
>>>>>> [...]
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>
>>>>>> This is in fact a code bug.
>>>>>>
>>>>>> And I forgot to mention, your progs is a little older than expected.
>>>>>>
>>>>>> Would you be able to build/grab a newer btrfs-progs?
>>>>>> v6.0.1 recommended.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 16500433666048 wanted 1184699 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> parent transid verify failed on 15504896409600 wanted 1184650 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504896409600
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>>
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504894869504 wanted 1184618 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=128 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504894869504 wanted 1184618 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=128 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504894869504 wanted 1184618 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=128 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504894869504 wanted 1184618 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>>   [ repeats many times ]
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=128 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504895688704 wanted 1184644 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895688704
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504896131072 wanted 1184697 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=140 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504896131072 wanted 1184697 
>>>>>>> found 1184703
>>>>>>> [ repeats many times ]
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=140 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504896884736 wanted 1183227 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504896884736
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504896655360 wanted 1184665 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=148 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504896655360 wanted 1184665 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> [repeats many times]
>>>>>>> ERROR: child eb corrupted: parent bytenr=16500421459968 item=157 
>>>>>>> parent level=2 child level=0
>>>>>>> parent transid verify failed on 15504895754240 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895754240
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504895770624 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895770624
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504895950848 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895950848
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504895967232 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895967232
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504895983616 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504895983616
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504898523136 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504898523136
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504899031040 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504899031040
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504899047424 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504899047424
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504898146304 wanted 1184688 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504898146304
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504895000576 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>>
>>>>>>> ......
>>>>>>>
>>>>>>> parent transid verify failed on 15504898834432 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504898834432
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504897294336 wanted 1184658 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504897294336
>>>>>>> ctree.c:1147: btrfs_search_slot: Warning: assertion `p->nodes[0] 
>>>>>>> != NULL` failed, value 1
>>>>>>> btrfs(btrfs_search_slot+0x172)[0x5647bd817d07]
>>>>>>> btrfs(btrfs_write_dirty_block_groups+0xd7)[0x5647bd8221fd]
>>>>>>> btrfs(commit_tree_roots+0x174)[0x5647bd845925]
>>>>>>> btrfs(btrfs_commit_transaction+0xc6)[0x5647bd845b51]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> parent transid verify failed on 15504897179648 wanted 1184376 
>>>>>>> found 1184703
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 15504897179648
>>>>>>> btrfs unable to find ref byte nr 12333456637952 parent 0 root 2  
>>>>>>> owner 0 offset 0
>>>>>>> transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` 
>>>>>>> triggered, value -5
>>>>>>> btrfs(+0x456a7)[0x5647bd8456a7]
>>>>>>> btrfs(btrfs_commit_transaction+0x26b)[0x5647bd845cf6]
>>>>>>> btrfs(+0x65802)[0x5647bd865802]
>>>>>>> btrfs(cmd_check+0x213a)[0x5647bd867fb3]
>>>>>>> btrfs(main+0x89)[0x5647bd813703]
>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f4252dccd0a]
>>>>>>> btrfs(_start+0x2a)[0x5647bd81338a]
>>>>>>> Aborted
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> ------ Originalnachricht ------
>>>>>>> Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>; 
>>>>>>> linux-btrfs@vger.kernel.org
>>>>>>> Datum 16.11.2022 12:41:52
>>>>>>> Betreff Re: block group x has wrong amount of free space
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022/11/16 19:40, Hendrik Friedel wrote:
>>>>>>>>> Hello Qu,
>>>>>>>>>
>>>>>>>>> thanks for your help. That's bad news :-(
>>>>>>>>> I ran btrfs check now, with this output:
>>>>>>>>> [1/7] checking root items
>>>>>>>>> [2/7] checking extents
>>>>>>>>> ref mismatch on [16500433387520 16384] extent item 1, found 0
>>>>>>>>> backref 16500433387520 root 2 not referenced back 0x55a783c592d0
>>>>>>>>> incorrect global backref count on 16500433387520 found 1 wanted 0
>>>>>>>>> backpointer mismatch on [16500433387520 16384]
>>>>>>>>> owner ref check failed [16500433387520 16384]
>>>>>>>>> ref mismatch on [16500433666048 16384] extent item 0, found 1
>>>>>>>>> tree backref 16500433666048 parent 2 root 2 not found in extent 
>>>>>>>>> tree
>>>>>>>>> backpointer mismatch on [16500433666048 16384]
>>>>>>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>>>>>>> [3/7] checking free space cache
>>>>>>>>> cache and super generation don't match, space cache will be 
>>>>>>>>> invalidated
>>>>>>>>> [4/7] checking fs roots
>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>> [6/7] checking root refs
>>>>>>>>> [7/7] checking quota groups
>>>>>>>>> found 10848863825921 bytes used, error(s) found
>>>>>>>>> total csum bytes: 10584151620
>>>>>>>>> total tree bytes: 14628896768
>>>>>>>>> total fs tree bytes: 1877082112
>>>>>>>>> total extent tree bytes: 897548288
>>>>>>>>> btree space waste bytes: 1633585295
>>>>>>>>> file data blocks allocated: 20692111388672
>>>>>>>>>   referenced 13014020022272
>>>>>>>>>
>>>>>>>>> How bad is it?
>>>>>>>>
>>>>>>>> Not that bad, "btrfs check --repair" should be able to fix.
>>>>>>>>
>>>>>>>> After that, feel free to clear cache again and migrate to v2 cache.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Hendrik
>>>>>>>>>
>>>>>>>>> ------ Originalnachricht ------
>>>>>>>>> Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>>>>>> An "Hendrik Friedel" <hendrik@friedels.name>; 
>>>>>>>>> linux-btrfs@vger.kernel.org
>>>>>>>>> Datum 16.11.2022 00:15:55
>>>>>>>>> Betreff Re: block group x has wrong amount of free space
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2022/11/16 06:05, Hendrik Friedel wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> I now ran btrfs check --clear-space-cache v1 /dev/sdb1
>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>> dsChecking filesystem on /dev/sdb1
>>>>>>>>>>> UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>>>>>>>>>> Failed to find [16500433649664, 168, 16384]
>>>>>>>>>>
>>>>>>>>>> Unfortunately, this line and the kernel dmesg both shows that, 
>>>>>>>>>> your extent tree seems corrupted.
>>>>>>>>>>
>>>>>>>>>> Thus a "btrfs check --readonly" run on that device would 
>>>>>>>>>> verify if the extent tree is really corrupted.
>>>>>>>>>>
>>>>>>>>>> And after that, we can discuss how to continue.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>> btrfs unable to find ref byte nr 16500433666048 parent 0 root 
>>>>>>>>>>> 2  owner 0 offset 0
>>>>>>>>>>> transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` 
>>>>>>>>>>> triggered, value -5
>>>>>>>>>>> btrfs(+0x456a7)[0x562c84e456a7]
>>>>>>>>>>> btrfs(btrfs_commit_transaction+0x26b)[0x562c84e45cf6]
>>>>>>>>>>> btrfs(btrfs_clear_free_space_cache+0xa4)[0x562c84e38f0b]
>>>>>>>>>>> btrfs(+0x5974c)[0x562c84e5974c]
>>>>>>>>>>> btrfs(cmd_check+0x8ca)[0x562c84e66743]
>>>>>>>>>>> btrfs(main+0x89)[0x562c84e13703]
>>>>>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f6dc5402d0a]
>>>>>>>>>>> btrfs(_start+0x2a)[0x562c84e1338a]
>>>>>>>>>>> Aborted.
>>>>>>>>>>>
>>>>>>>>>>> I then ran mount /dev/sdb1 -o clear_cache /mnt/
>>>>>>>>>>> It ran without issue, but in the kernel log, I still see 
>>>>>>>>>>> errors like:
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) 
>>>>>>>>>>> in __btrfs_free_extent:3063: errno=-2 No such entry
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] BTRFS info (device sdc1: state EA): 
>>>>>>>>>>> forced readonly
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state 
>>>>>>>>>>> EA) in btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>>>>>>>>>> [Di Nov 15 22:42:27 2022] BTRFS warning (device sdc1: state 
>>>>>>>>>>> EA): Skipping commit of aborted transaction.
>>>>>>>>>>> [Di Nov 15 22:42:27 2022] BTRFS: error (device sdc1: state 
>>>>>>>>>>> EA) in cleanup_transaction:1983: errno=-2 No such entry
>>>>>>>>>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): using 
>>>>>>>>>>> crc32c (crc32c-intel) checksum algorithm
>>>>>>>>>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): force 
>>>>>>>>>>> clearing of disk cache
>>>>>>>>>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): disk 
>>>>>>>>>>> space caching is enabled
>>>>>>>>>>> [Di Nov 15 22:48:28 2022] BTRFS error (device sdc1): qgroup 
>>>>>>>>>>> generation mismatch, marked as inconsistent
>>>>>>>>>>> [Di Nov 15 22:48:28 2022] BTRFS info (device sdc1): checking 
>>>>>>>>>>> UUID tree
>>>>>>>>>>> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 
>>>>>>>>>>> blocked for more than 120 seconds.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: 
>>>>>>>>>>> btrfs-transacti Tainted: G            E      6.0.8 #1
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] RIP: 
>>>>>>>>>>> 0010:__btrfs_free_extent+0x6ba/0xa50 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> btrfs_write_dirty_block_groups+0x184/0x3e0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] WARNING: CPU: 0 PID: 1408097 at 
>>>>>>>>>>> fs/btrfs/extent-tree.c:3063 __btrfs_free_extent+0x716/0xa50 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: 
>>>>>>>>>>> btrfs-transacti Tainted: G        W   E      6.0.8 #1
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] RIP: 
>>>>>>>>>>> 0010:__btrfs_free_extent+0x716/0xa50 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> btrfs_write_dirty_block_groups+0x184/0x3e0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) 
>>>>>>>>>>> in __btrfs_free_extent:3063: errno=-2 No such entry
>>>>>>>>>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state 
>>>>>>>>>>> EA) in btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>>>>>>>>>> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 
>>>>>>>>>>> blocked for more than 120 seconds.
>>>>>>>>>>> [Di Nov 15 22:52:28 2022] task:btrfs-transacti state:D 
>>>>>>>>>>> stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>>>>>>>>>> [Di Nov 15 22:52:28 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:52:28 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:52:28 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:54:29 2022] INFO: task btrfs-transacti:1434591 
>>>>>>>>>>> blocked for more than 241 seconds.
>>>>>>>>>>> [Di Nov 15 22:54:29 2022] task:btrfs-transacti state:D 
>>>>>>>>>>> stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>>>>>>>>>> [Di Nov 15 22:54:29 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:54:29 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:54:29 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:56:30 2022] INFO: task btrfs-transacti:1434591 
>>>>>>>>>>> blocked for more than 362 seconds.
>>>>>>>>>>> [Di Nov 15 22:56:30 2022] task:btrfs-transacti state:D 
>>>>>>>>>>> stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>>>>>>>>>> [Di Nov 15 22:56:30 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:56:30 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:56:30 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:58:30 2022] INFO: task btrfs-transacti:1434591 
>>>>>>>>>>> blocked for more than 483 seconds.
>>>>>>>>>>> [Di Nov 15 22:58:30 2022] task:btrfs-transacti state:D 
>>>>>>>>>>> stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>>>>>>>>>> [Di Nov 15 22:58:30 2022]  
>>>>>>>>>>> btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>>>>>>>>>> [Di Nov 15 22:58:30 2022]  transaction_kthread+0x13d/0x1b0 
>>>>>>>>>>> [btrfs]
>>>>>>>>>>> [Di Nov 15 22:58:30 2022]  ? 
>>>>>>>>>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Best regards,
>>>>>>>>>>> Hendrik
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> ------ Originalnachricht ------
>>>>>>>>>>> Von "Hendrik Friedel" <hendrik@friedels.name>
>>>>>>>>>>> An linux-btrfs@vger.kernel.org
>>>>>>>>>>> Datum 14.11.2022 23:41:40
>>>>>>>>>>> Betreff block group x has wrong amount of free space
>>>>>>>>>>>
>>>>>>>>>>>> Hello,
>>>>>>>>>>>>
>>>>>>>>>>>> I noticed very high load on my system (not CPU utilization, 
>>>>>>>>>>>> but load). I was able to trace it down to a slow reaction of 
>>>>>>>>>>>> my btrfs filesystem, whilst iotop showed very low r/w activity.
>>>>>>>>>>>>
>>>>>>>>>>>> Thus, I startet btrfs check (ro).
>>>>>>>>>>>> It found:
>>>>>>>>>>>> block group 30060743819264 has wrong amount of free space, 
>>>>>>>>>>>> free space cache has 45056 block group has 49152
>>>>>>>>>>>> failed to load free space cache for block group 30060743819264
>>>>>>>>>>>>
>>>>>>>>>>>> Now, I found sources telling me to clear the space cache. 
>>>>>>>>>>>> Some suggest to use the mount option, others to use btrfs 
>>>>>>>>>>>> check --clear-space-cache [v1 or v2].
>>>>>>>>>>>>
>>>>>>>>>>>> Can you please advice me, what the best way forward is - and 
>>>>>>>>>>>> how to prevent this to happen again?
>>>>>>>>>>>>
>>>>>>>>>>>> Below you find further information on my system. btrfs df 
>>>>>>>>>>>> cannot run currently, as btrfs check is running. I had to 
>>>>>>>>>>>> zip the dmesg.log that is requested in the wiki.
>>>>>>>>>>>> When the issue occured, I was still running linux-5.19.2 (I 
>>>>>>>>>>>> did not yet notice when updating the kernel).
>>>>>>>>>>>>
>>>>>>>>>>>> Best regards and thanks for your help in advance,
>>>>>>>>>>>> Hendrik
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> root@homeserver:/home/henfri#   uname -a
>>>>>>>>>>>> Linux homeserver 6.0.8 #1 SMP PREEMPT_DYNAMIC Sat Nov 12 
>>>>>>>>>>>> 14:18:32 CET 2022 x86_64 GNU/Linux
>>>>>>>>>>>> root@homeserver:/home/henfri#   btrfs --version
>>>>>>>>>>>> btrfs-progs v4.20.2
>>>>>>>>>>>> root@homeserver:/home/henfri#   btrfs fi show
>>>>>>>>>>>> Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>>>>>>>>>>>         Total devices 1 FS bytes used 162.58GiB
>>>>>>>>>>>>         devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>>>>>>>>>>>
>>>>>>>>>>>> Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>>>>>>>>>>>         Total devices 2 FS bytes used 9.87TiB
>>>>>>>>>>>>         devid    1 size 10.91TiB used 9.89TiB path /dev/sdc1
>>>>>>>>>>>>         devid    2 size 10.91TiB used 9.89TiB path /dev/sdb1
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>
> 
