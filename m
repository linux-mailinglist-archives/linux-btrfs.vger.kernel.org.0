Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C11D6E0935
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjDMIpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDMIpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 04:45:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE36183
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 01:45:19 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1pqREk02ct-00Vkst; Thu, 13
 Apr 2023 10:45:17 +0200
Message-ID: <3138e589-50cc-e6ab-e1d8-404eb715e377@gmx.com>
Date:   Thu, 13 Apr 2023 16:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: btrfs replace errors
Content-Language: en-US
To:     Adam Bahe <adambahe@gmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CACzgC9iMmjGMF5=6u0+XFvxh+3CmB9Eiyd3h09BNADDRr_OVpQ@mail.gmail.com>
 <8a255910-e69b-62e2-d4bd-df8b9593c78d@gmx.com>
 <CACzgC9hDpFxV2f18ROMEjGgvzWgGg28CbMQexGXsnKik39X=HQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CACzgC9hDpFxV2f18ROMEjGgvzWgGg28CbMQexGXsnKik39X=HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:w9de8Y+QACJENruXQmRqn8Naw0LEAq6WIGuIooUEpnwXLkzblw2
 qIPq0Lmr7VGeCSXMWSi073CZWiEG4Wv+xsfnYmHjOPKXRLs1ckTAyoNSconwR14PDiwyB8H
 +zLcpDlTm1U97JISZPZiw3RCoCxNHjYoWMiLCXOZ1dvelqNptQwGSRi5Z09ezwyUiTzaVVI
 UApDCwex/7B31vnmFmV2w==
UI-OutboundReport: notjunk:1;M01:P0:mTeW2vFCNHs=;GWzwie7Nse5qrHerDilDNfFV1J3
 ZPFN/1rnZKVjUFPAt56JUFAWjZGxfinLTZgDdCFIFQ03L5nJJDBj8+58PobFa7Q0fxR/ZnCUy
 K2G4Nf6t9GezsWUbL28MWV2xnSLA3/35htTURwBTl4Adr70ZAh+p5I0VkaKxT1KcTCBQ+7Wid
 fUEAOhmGf5esQDz/EXhG7vmjFIzLAL1icgUFEreN/NLS5+qiUTo0mb2R5PnPyxbCOqds3x/cs
 bat2ACBL7LoySxpqZ1cykp8uAF5yOCPEU5fzQL9+8VAnqlB8uv81s7pGm4qsTk7Z6QEwCr8Gf
 hQw2YIlW6SPMbOyXatGlcqbOnjCxmBddbdWCZ1LapITtDimwDElm3bLJdJ9D9Kmo59V1tYHXf
 PPVQBUMTJjNYkRABORmz3aW1pv0wOGzMElzA3bY233m0dPJG0y3QK04k+tJ7ilUJxnL2nW2xk
 uBsE0ru1Awo0apjA0yE0Zw0BBMHDMM9dUoLRW1PrjwAPPlkpownM8J7+/v2j+y0ZmFRC5ubZI
 lFWnBzl7S+GjD1vzct5+OP5ckCuSGCD3gX4euEU3RRf7FPFimNIt6zAZIg8SzSy9Ymx5vjXyV
 HCiBX/E/2SAYyKA2czpLsRlfXqpGIGTVwDyd68HGzrSImoi3rJHbL+FPkdAQzOjNxU2QVHGEx
 yzpoBZ1gZhxWPNLG7JI8gQiTo0Al60SJssEyNCwvRgXPBCTVXtEgbDKo7b6hbZmYE6g1oyElr
 xUIpsIIfVK0L0ImM364I1g3iuzhhqgS4COQUA7p9A0NMqW12FabeKtgVZfGsIhnhdgs14Wcv7
 8HN7sP/WTyD7a8G0WNWRm0PQWJi8u1v0yUCqYI4KE+IH7Q2pNgaRO9DbGJL2c+eouo3e0eToM
 tcGHG5LQwcBVDgYLQuKdXExk4e65Xpll47Ug36uDn9Vcarb0Vv6QugNrFRO1aykjZWJEdCLD9
 07DKcS5tUOZ4NQCY4uQjCgKp9lg=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/13 16:33, Adam Bahe wrote:
> Thank you for that excellent explanation. I gather that this is behaving 
> as expected and does not signify any data loss issues?

As far as I know, there is no known RAID56 that can lead to direct data 
loss, except the long existing write-hole problem.
(Which is greatly reduced in recent kernels).

> I'm OK with it 
> being slow for now. I did kick off a replace with the "-r" option on my 
> second replace run.

Unfortunately that patch is only merged into David's branch, not yet in 
any stable kernel releases.

Thus for now if that disk is already unreliable, it's better unplug it 
completely if you feel safe enough to do so.

Thanks,
Qu

> For now, I am trying to get the array healthy enough 
> and once that occurs I am going to split my arrays out into 3 or 4 
> different individual raid6 arrays. It is just getting too big :)
> 
> Thanks again!
> 
> On Wed, Apr 12, 2023 at 6:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com 
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
> 
> 
> 
>     On 2023/4/13 06:32, Adam Bahe wrote:
>      > Hello Qu,
>      >
>      > If you are too busy to answer this it is totally fine I can
>     repost it to
>      > the btrfs general mailing list. I have the following array:
>      >
>      > [root@nas ~]# btrfs fi show
>      > Label: 'nas'  uuid: 827aa375-2c38-4794-8f9d-8c7eb3ce715b
>      > Total devices 25 FS bytes used 226.29TiB
>      > devid    0 size 10.91TiB used 10.91TiB path /dev/sdi
>      > devid    1 size 12.73TiB used 12.73TiB path /dev/sdd
>      > devid    2 size 9.10TiB used 9.09TiB path /dev/sde
>      > devid    3 size 9.10TiB used 9.09TiB path /dev/sdf
>      > devid    4 size 16.37TiB used 14.19TiB path /dev/sdv
>      > devid    5 size 10.91TiB used 10.91TiB path /dev/sdk
>      > devid    6 size 9.10TiB used 9.09TiB path /dev/sdl
>      > devid    7 size 9.10TiB used 9.09TiB path /dev/sdm
>      > *devid    8 size 0 used 0 path  MISSING*
>      > devid    9 size 9.10TiB used 9.09TiB path /dev/sdr
>      > devid   10 size 9.10TiB used 9.09TiB path /dev/sds
>      > devid   11 size 10.91TiB used 10.91TiB path /dev/sdw
>      > devid   12 size 9.10TiB used 9.09TiB path /dev/sdx
>      > devid   13 size 9.10TiB used 9.09TiB path /dev/sdy
>      > devid   14 size 10.91TiB used 10.91TiB path /dev/sdu
>      > devid   15 size 14.55TiB used 14.55TiB path /dev/sdo
>      > devid   16 size 14.55TiB used 14.55TiB path /dev/sdn
>      > devid   17 size 14.55TiB used 14.55TiB path /dev/sdh
>      > devid   18 size 14.55TiB used 14.55TiB path /dev/sdb
>      > devid   19 size 14.55TiB used 14.55TiB path /dev/sdc
>      > devid   20 size 14.55TiB used 14.55TiB path /dev/sdq
>      > devid   21 size 14.55TiB used 14.55TiB path /dev/sdt
>      > devid   22 size 16.37TiB used 7.71TiB path /dev/sdp
>      > devid   23 size 16.37TiB used 5.73TiB path /dev/sdg
>      > devid   24 size 16.37TiB used 4.97TiB path /dev/sdj
>      >
>      > As you will see, I have lost a drive. It died in the middle of the
>      > following command:
>      > btrfs replace start 8 /dev/sdi /mnt/nas
>      >
>      > The replace slowed to a crawl, with dmesg constantly complaining
>     about
>      > having issues accessing the dead drive. I rebooted the server,
>     canceled
>      > the replace, and zero'd the drive (dd if=/dev/zero of=/dev/newdrive).
>      >
>      > Currently it is about 20% complete, however dmesg is spewing
>     these errors:
>      > [156916.928176] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136411585380352 for dev <missing disk>
>      > [156917.031913] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136411719663616 for dev <missing disk>
>      > [156917.361978] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136411988230144 for dev <missing disk>
>      > [156920.236832] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136412930768896 for dev <missing disk>
>      > [156921.192775] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136413469278208 for dev <missing disk>
>      > [156921.684204] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136413872128000 for dev <missing disk>
>      > [156923.758676] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136414542561280 for dev <missing disk>
>      > [156923.931279] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136414811127808 for dev <missing disk>
>      > [156924.016508] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136414945411072 for dev <missing disk>
>      > [156925.436490] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136415483920384 for dev <missing disk>
>      > [156926.070170] BTRFS error (device sdi): failed to rebuild valid
>      > logical 136415752486912 for dev <missing disk>
>      >
>      > The replace is completing a lot faster now, around 10% complete
>     per 24h
>      > run. I estimate another 8 days to complete.
>      >
>      >
>      > I cannot find much about this specific error during a
>     replacement. This
>      > is the only drive that went bad (during the replace, not in total
>     over
>      > the life of the array). Previous replaces worked fine without issue.
>      >
>      > I am not sure what this error means, is my replace going to
>     complete ok?
>      > Additionally, the speeds in accessing files on the btrfs array have
>      > slowed to a crawl. Where I used to get anywhere between 150MB/sec
>     and
>      > 300MB/sec, file speeds start off around 100MB/sec and fall to
>     maybe 5MB/sec.
> 
>     [NO SRC DEV AVOIDANCE]
>     There is already a known problem related to handling of bad devices,
>     that dev-replace doesn't really follow its "-r" option.
> 
>     Thus btrfs would always try to read from that bad device first, which
>     can be very slow.
> 
>     This behavior is improved by patch "btrfs: do not use replace target
>     device as an extra mirror", that now replace would proper skip the bad
>     device if "-r" option is utilized.
> 
>     [RAID6 RECOVERY COMBINATIONS]
>     The other thing is, RAID6 rebuild can be slow due to the extra
>     combinations.
> 
>     For RAID6, btrfs would try as many as the number of devices to try all
>     combination to rebuild the data.
> 
>     In your case, the number of devices itself is a cause of problem
>     already.
> 
>     [RAID56 RECOVERY CACHE]
>     Btrfs RAID56 has a cache system to speed up the RMW.
> 
>     But unfortunately any recovery attempt would clear the cache for that
>     full stripe.
> 
>     Thus this means, for RAID6 recovery attempt, every combination would
>     need to read from the disk, again and again...
> 
>     That's the next big thing I'm looking into to improve.
> 
>     Thanks,
>     Qu
>      >
>      >
>      > [root@nas ~]# btrfs fi usage -T /mnt/nas
>      > Overall:
>      >      Device size: 307.42TiB
>      >      Device allocated: 263.62TiB
>      >      Device unallocated:  43.80TiB
>      >      Device missing:  10.91TiB
>      >      Device slack:  10.91TiB
>      >      Used: 262.59TiB
>      >      Free (estimated):  38.83TiB (min: 11.83TiB)
>      >      Free (statfs, df):  11.72TiB
>      >      Data ratio:      1.15
>      >      Metadata ratio:      4.00
>      >      Global reserve: 512.00MiB (used: 0.00B)
>      >      Multiple profiles:        no
>      >
>      >              Data      Metadata  System
>      > Id Path     RAID6     RAID1C4   RAID1C4  Unallocated Total     Slack
>      > -- -------- --------- --------- -------- ----------- ---------
>     --------
>      >   0 /dev/sdi         -         -        -    10.91TiB  10.91TiB
>       7.28TiB
>      >   1 /dev/sdd  12.73TiB         -        -     1.00MiB  12.73TiB  
>           -
>      >   2 /dev/sde   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      >   3 /dev/sdf   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      >   4 /dev/sdv  13.68TiB 519.00GiB 32.00MiB     2.18TiB  16.37TiB  
>           -
>      >   5 /dev/sdk  10.91TiB         -        -     1.00MiB  10.91TiB  
>           -
>      >   6 /dev/sdl   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      >   7 /dev/sdm   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      >   8 missing   10.91TiB         -        -     1.00MiB  10.91TiB  
>           -
>      >   9 /dev/sdr   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      > 10 /dev/sds   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      > 11 /dev/sdw  10.91TiB         -        -     1.00MiB  10.91TiB  
>           -
>      > 12 /dev/sdx   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      > 13 /dev/sdy   9.09TiB         -        -     1.00MiB   9.10TiB  
>           -
>      > 14 /dev/sdu  10.91TiB         -        -     1.00MiB  10.91TiB  
>           -
>      > 15 /dev/sdo  14.55TiB         -        -    10.00MiB  14.55TiB  
>           -
>      > 16 /dev/sdn  14.55TiB         -        -    16.25MiB  14.55TiB  
>           -
>      > 17 /dev/sdh  14.55TiB   1.00GiB        -     1.12MiB  14.55TiB  
>           -
>      > 18 /dev/sdb  14.55TiB   1.00GiB        -     2.81MiB  14.55TiB  
>           -
>      > 19 /dev/sdc  14.55TiB   1.00GiB        -     2.75MiB  14.55TiB  
>           -
>      > 20 /dev/sdq  14.55TiB   1.00GiB        -     1.62MiB  14.55TiB
>       3.64TiB
>      > 21 /dev/sdt  14.55TiB         -        -     9.38MiB  14.55TiB  
>           -
>      > 22 /dev/sdp   7.20TiB 521.00GiB 32.00MiB     8.66TiB  16.37TiB  
>           -
>      > 23 /dev/sdg   5.22TiB 521.00GiB 32.00MiB    10.64TiB  16.37TiB  
>           -
>      > 24 /dev/sdj   4.46TiB 519.00GiB 32.00MiB    11.40TiB  16.37TiB  
>           -
>      > -- -------- --------- --------- -------- ----------- ---------
>     --------
>      >     Total    226.66TiB 521.00GiB 32.00MiB    43.80TiB 307.42TiB
>     10.91TiB
>      >     Used     225.78TiB 517.00GiB 26.42MiB
>      >
>      >
>      > Thank you for all of your hard work!
> 
