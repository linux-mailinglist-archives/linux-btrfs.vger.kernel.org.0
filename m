Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877786E02E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 02:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLX7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLX7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:59:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6EB3C39
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Apr 2023 16:59:47 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof9P-1qArm52DIv-00p5Y6; Thu, 13
 Apr 2023 01:59:45 +0200
Message-ID: <8a255910-e69b-62e2-d4bd-df8b9593c78d@gmx.com>
Date:   Thu, 13 Apr 2023 07:59:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Adam Bahe <adambahe@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CACzgC9iMmjGMF5=6u0+XFvxh+3CmB9Eiyd3h09BNADDRr_OVpQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs replace errors
In-Reply-To: <CACzgC9iMmjGMF5=6u0+XFvxh+3CmB9Eiyd3h09BNADDRr_OVpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XO0X4HzeWT459E14nhaFs37Azm2FQ17JIUyJ3FhaKULfekZVV+H
 uGvHw22b+wr6p4CnFkAoozTv3WuXMrKoj+HFEjYCZ9feOXjUIsqzzgE1h6B4GR9w2y1wvoN
 UUHqUWrK3uO4urDwZo49Lncr5pjdGJXMzNc1m29bA6pAULa8uJrxs9dyfqZzUAf1hUjyXFi
 64lKwSHtEbkeX7xb1LdGA==
UI-OutboundReport: notjunk:1;M01:P0:Qf5W4GdSgic=;gw5aN5LGOgw9uHI5e7Q40Mr9Bea
 NPrCNPe2P5/v/zT3POrlQD9oVcXUjAyb6/GKFI8PIGB+gP1QNcD1sMzBTBnLg/sn9X8b6ukaA
 mSuubeoppWCSKW0SAGpH8dg13HHvKAVeNaBDIAUizMl+l+qb+/8XekiDUAd8JcsI/4YqhN0I0
 OVXEg/Old1y5EjWCcLChWnjaY1NxyXJ2xjXdLd7+VzJnG6LBs2NrPNgAA8+URb0pTobKLmctp
 1UCSzqY9EyC9sg1E0/T0z93ZoFJyrS/VK2I9rbA8i2OAKOxNb2pRvKEM89OZpbkrtuIpm/xXx
 1a/j/JNbYj5T4rH1rj0qlOKdta727QFzJNa3RdJdpeZw03vqxve/JQZ3UuFCEg0XDSe5xVEI1
 mEUiFQJms/45CKGE6l7n//jfN28N/FgIGRfcZict7TUPANG16kg4Kt1hASQ5PZRw+RHaSDbz3
 SuF6leNzWQrsU1AXZDtzuEgGiGs6CINHo/+ozztPgjv1aIZpbB3MeWluEUhB2iravRXqsdxnj
 qUlL6HDo0F11qUW0UY7QkmVuLLziJgNEiYPLYZd1tUj8YX+QgB6ci1Ih1dSmhL0lhSVxyTwxa
 9GmKNBfjclQtTfgqFRFXkW0QB4j0mO94vp2pJelN55iKmWLoQs3AJlwJY5g2fb4/YMrnWfw0l
 IyYTeN5VwMQoxmMBHcjuZhGqkwqlpd6LJ6qXSjWgTD8wQ8FUnLJrzxgpoG+jQLd2ayCS9LmTb
 akX+ShfKQHvj2f4RzTJ5LSSIy4cPY+mIzMtk83BiIn0lGFG2PoPZbjQJ8fVnYw3i8KkHxh4Xk
 HkadLA/jVrkMgR7kOTi9WI7qisf5N6rq7p15/dUkpWkuXpegsMCKH7AesUgDyzjopFjO/FZs6
 3yBWG/Urhwah4qrE2LpDbaiWtZZdVF+HmbZPmK+U1bjO/0U3t8/RRk0ZAUIwy39gkalb/Q6FK
 QIKPk8BrnyK6G37i9+h1mplmJns=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/13 06:32, Adam Bahe wrote:
> Hello Qu,
> 
> If you are too busy to answer this it is totally fine I can repost it to 
> the btrfs general mailing list. I have the following array:
> 
> [root@nas ~]# btrfs fi show
> Label: 'nas'  uuid: 827aa375-2c38-4794-8f9d-8c7eb3ce715b
> Total devices 25 FS bytes used 226.29TiB
> devid    0 size 10.91TiB used 10.91TiB path /dev/sdi
> devid    1 size 12.73TiB used 12.73TiB path /dev/sdd
> devid    2 size 9.10TiB used 9.09TiB path /dev/sde
> devid    3 size 9.10TiB used 9.09TiB path /dev/sdf
> devid    4 size 16.37TiB used 14.19TiB path /dev/sdv
> devid    5 size 10.91TiB used 10.91TiB path /dev/sdk
> devid    6 size 9.10TiB used 9.09TiB path /dev/sdl
> devid    7 size 9.10TiB used 9.09TiB path /dev/sdm
> *devid    8 size 0 used 0 path  MISSING*
> devid    9 size 9.10TiB used 9.09TiB path /dev/sdr
> devid   10 size 9.10TiB used 9.09TiB path /dev/sds
> devid   11 size 10.91TiB used 10.91TiB path /dev/sdw
> devid   12 size 9.10TiB used 9.09TiB path /dev/sdx
> devid   13 size 9.10TiB used 9.09TiB path /dev/sdy
> devid   14 size 10.91TiB used 10.91TiB path /dev/sdu
> devid   15 size 14.55TiB used 14.55TiB path /dev/sdo
> devid   16 size 14.55TiB used 14.55TiB path /dev/sdn
> devid   17 size 14.55TiB used 14.55TiB path /dev/sdh
> devid   18 size 14.55TiB used 14.55TiB path /dev/sdb
> devid   19 size 14.55TiB used 14.55TiB path /dev/sdc
> devid   20 size 14.55TiB used 14.55TiB path /dev/sdq
> devid   21 size 14.55TiB used 14.55TiB path /dev/sdt
> devid   22 size 16.37TiB used 7.71TiB path /dev/sdp
> devid   23 size 16.37TiB used 5.73TiB path /dev/sdg
> devid   24 size 16.37TiB used 4.97TiB path /dev/sdj
> 
> As you will see, I have lost a drive. It died in the middle of the 
> following command:
> btrfs replace start 8 /dev/sdi /mnt/nas
> 
> The replace slowed to a crawl, with dmesg constantly complaining about 
> having issues accessing the dead drive. I rebooted the server, canceled 
> the replace, and zero'd the drive (dd if=/dev/zero of=/dev/newdrive).
> 
> Currently it is about 20% complete, however dmesg is spewing these errors:
> [156916.928176] BTRFS error (device sdi): failed to rebuild valid 
> logical 136411585380352 for dev <missing disk>
> [156917.031913] BTRFS error (device sdi): failed to rebuild valid 
> logical 136411719663616 for dev <missing disk>
> [156917.361978] BTRFS error (device sdi): failed to rebuild valid 
> logical 136411988230144 for dev <missing disk>
> [156920.236832] BTRFS error (device sdi): failed to rebuild valid 
> logical 136412930768896 for dev <missing disk>
> [156921.192775] BTRFS error (device sdi): failed to rebuild valid 
> logical 136413469278208 for dev <missing disk>
> [156921.684204] BTRFS error (device sdi): failed to rebuild valid 
> logical 136413872128000 for dev <missing disk>
> [156923.758676] BTRFS error (device sdi): failed to rebuild valid 
> logical 136414542561280 for dev <missing disk>
> [156923.931279] BTRFS error (device sdi): failed to rebuild valid 
> logical 136414811127808 for dev <missing disk>
> [156924.016508] BTRFS error (device sdi): failed to rebuild valid 
> logical 136414945411072 for dev <missing disk>
> [156925.436490] BTRFS error (device sdi): failed to rebuild valid 
> logical 136415483920384 for dev <missing disk>
> [156926.070170] BTRFS error (device sdi): failed to rebuild valid 
> logical 136415752486912 for dev <missing disk>
> 
> The replace is completing a lot faster now, around 10% complete per 24h 
> run. I estimate another 8 days to complete.
> 
> 
> I cannot find much about this specific error during a replacement. This 
> is the only drive that went bad (during the replace, not in total over 
> the life of the array). Previous replaces worked fine without issue.
> 
> I am not sure what this error means, is my replace going to complete ok? 
> Additionally, the speeds in accessing files on the btrfs array have 
> slowed to a crawl. Where I used to get anywhere between 150MB/sec and 
> 300MB/sec, file speeds start off around 100MB/sec and fall to maybe 5MB/sec.

[NO SRC DEV AVOIDANCE]
There is already a known problem related to handling of bad devices, 
that dev-replace doesn't really follow its "-r" option.

Thus btrfs would always try to read from that bad device first, which 
can be very slow.

This behavior is improved by patch "btrfs: do not use replace target 
device as an extra mirror", that now replace would proper skip the bad 
device if "-r" option is utilized.

[RAID6 RECOVERY COMBINATIONS]
The other thing is, RAID6 rebuild can be slow due to the extra combinations.

For RAID6, btrfs would try as many as the number of devices to try all 
combination to rebuild the data.

In your case, the number of devices itself is a cause of problem already.

[RAID56 RECOVERY CACHE]
Btrfs RAID56 has a cache system to speed up the RMW.

But unfortunately any recovery attempt would clear the cache for that 
full stripe.

Thus this means, for RAID6 recovery attempt, every combination would 
need to read from the disk, again and again...

That's the next big thing I'm looking into to improve.

Thanks,
Qu
> 
> 
> [root@nas ~]# btrfs fi usage -T /mnt/nas
> Overall:
>      Device size: 307.42TiB
>      Device allocated: 263.62TiB
>      Device unallocated:  43.80TiB
>      Device missing:  10.91TiB
>      Device slack:  10.91TiB
>      Used: 262.59TiB
>      Free (estimated):  38.83TiB (min: 11.83TiB)
>      Free (statfs, df):  11.72TiB
>      Data ratio:      1.15
>      Metadata ratio:      4.00
>      Global reserve: 512.00MiB (used: 0.00B)
>      Multiple profiles:        no
> 
>              Data      Metadata  System
> Id Path     RAID6     RAID1C4   RAID1C4  Unallocated Total     Slack
> -- -------- --------- --------- -------- ----------- --------- --------
>   0 /dev/sdi         -         -        -    10.91TiB  10.91TiB  7.28TiB
>   1 /dev/sdd  12.73TiB         -        -     1.00MiB  12.73TiB        -
>   2 /dev/sde   9.09TiB         -        -     1.00MiB   9.10TiB        -
>   3 /dev/sdf   9.09TiB         -        -     1.00MiB   9.10TiB        -
>   4 /dev/sdv  13.68TiB 519.00GiB 32.00MiB     2.18TiB  16.37TiB        -
>   5 /dev/sdk  10.91TiB         -        -     1.00MiB  10.91TiB        -
>   6 /dev/sdl   9.09TiB         -        -     1.00MiB   9.10TiB        -
>   7 /dev/sdm   9.09TiB         -        -     1.00MiB   9.10TiB        -
>   8 missing   10.91TiB         -        -     1.00MiB  10.91TiB        -
>   9 /dev/sdr   9.09TiB         -        -     1.00MiB   9.10TiB        -
> 10 /dev/sds   9.09TiB         -        -     1.00MiB   9.10TiB        -
> 11 /dev/sdw  10.91TiB         -        -     1.00MiB  10.91TiB        -
> 12 /dev/sdx   9.09TiB         -        -     1.00MiB   9.10TiB        -
> 13 /dev/sdy   9.09TiB         -        -     1.00MiB   9.10TiB        -
> 14 /dev/sdu  10.91TiB         -        -     1.00MiB  10.91TiB        -
> 15 /dev/sdo  14.55TiB         -        -    10.00MiB  14.55TiB        -
> 16 /dev/sdn  14.55TiB         -        -    16.25MiB  14.55TiB        -
> 17 /dev/sdh  14.55TiB   1.00GiB        -     1.12MiB  14.55TiB        -
> 18 /dev/sdb  14.55TiB   1.00GiB        -     2.81MiB  14.55TiB        -
> 19 /dev/sdc  14.55TiB   1.00GiB        -     2.75MiB  14.55TiB        -
> 20 /dev/sdq  14.55TiB   1.00GiB        -     1.62MiB  14.55TiB  3.64TiB
> 21 /dev/sdt  14.55TiB         -        -     9.38MiB  14.55TiB        -
> 22 /dev/sdp   7.20TiB 521.00GiB 32.00MiB     8.66TiB  16.37TiB        -
> 23 /dev/sdg   5.22TiB 521.00GiB 32.00MiB    10.64TiB  16.37TiB        -
> 24 /dev/sdj   4.46TiB 519.00GiB 32.00MiB    11.40TiB  16.37TiB        -
> -- -------- --------- --------- -------- ----------- --------- --------
>     Total    226.66TiB 521.00GiB 32.00MiB    43.80TiB 307.42TiB 10.91TiB
>     Used     225.78TiB 517.00GiB 26.42MiB
> 
> 
> Thank you for all of your hard work!
