Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BF58751E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 03:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiHBBkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHBBkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 21:40:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1F06341
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659404416;
        bh=4RFwPfqWeOM8fu5XQkEoY1sVGROZyBDlDEcaXDZCHFY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=SGU6dj7nQjSuXYGcMJ69El8tY8cKX9NE9QJJBStZGqkG00oC74jKde3W9zLBCUxVZ
         vz1LVqkZDpMmkZcN5csvdjEG0VEIe3VmDLRpivAc97giPgSOmEc1nS8LWV6KA+jAlH
         tZneX9qhkgP10oyo/7HmcQ0iuOR765uVQXDpP/6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1nMfNC48rd-017pld; Tue, 02
 Aug 2022 03:40:16 +0200
Message-ID: <1bcfc031-2bc5-20f2-bebe-1b1f2baa56e7@gmx.com>
Date:   Tue, 2 Aug 2022 09:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Martin Edelius <martin.edelius@outlook.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <DB9P192MB119500EDD9CD8A59B250AFE7989B9@DB9P192MB1195.EURP192.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "parent transid verify failed" on raid5 array
In-Reply-To: <DB9P192MB119500EDD9CD8A59B250AFE7989B9@DB9P192MB1195.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uurPI1JXieNyNFv7tyi/Zr1Q3A2Pa4a8jb4Ke3zeAwvQnxS7plg
 1RSOeKlotWhUHUDNgntZg/sOjEV/BpF8qXSLKFJ8B1bO2UwKpu9eAiDLQ8lHmZ4cvIWwhCp
 Pj6O7sWvqPFHFY/Oxh+LiNjPQMeHcVL79J+cZ5tFVbjrZYUyWG4nJoiYbux9zhwYoGDgmx2
 vlmG0+d+ZtY7OdliKFa4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+2is55e2y3s=:GeJIvlV+IELtkKEX/HnN3G
 xQhpUTXMBwcN2BAa5Ya7vs2RicpFsGXtcttdF6coo1FFL4vCo8C8SmsQMPuKFgzSliLrw1aJ6
 Tkr/KHlP/4k8XEo/dTez+AQmbxKVRIuS20l17ktc1cIcfbyCiEB3gtnYHeyOaaWkjpKrnxAEg
 GmcG/C744VgysoO7vj7gFTl17fQbZCu8mdFHdLmQbZFHbcU5sixn+g7BVFr54n6x9te0WLvDj
 Ocw84N7BIOTR8qj2yGkEyfF4AhTfoXkLVhV0RbJLIndvrxNXKrPsjXkGIl0IgnFlbZSv2chvc
 pFn9gBfzV2mmwWa3QWHTKj584M/603QHnYJpqIm1hAy/o32ia+PTA51rkbfeyB2KOY2dSLiOJ
 gJwZm3ctGwQWhNxNUbKhSUx+jeaA+XJG0CzlEtQSsnB1g8HYoujS3UR5HKIMYRcNoXxSosj4g
 Zq5rP/sOILdk1cnbhZTs38mR9Ccr7fUpwlS0iegawfCVrjfr0JOFRgKGeTDadJWbMBHiLtmS7
 ZfWiuRyl/H8NRsGL6T3BH0rH3mO+alBs2HKWmkFZqbtjJVdyTxIaXr3VAH9MgkF2qPPuYmHXX
 WV7jsW4XZ9HHCwKU14dYlNbMLaykGST3ea7ODlU2BIcLR8e60NitOb5KSErNfSZ95pDTAr6l6
 XLtSuZ9BVqiWy4B2VWIddf/6rIjNStH7YaMLtalrSD8ZC3CSgdFfp7HPlKDYcnyn0q0f6vmjn
 3IvLOfgMrKEXjBM1/Mn63lzCJJOLpwKmyozNhS47rJ/wbKLzrZYvoXJW/4NHAup0+0y8uEJyY
 IQqneA/yaUl0kJagoTcMD20qowdBqR6gl9YwSZPeiEb8vcU2s4sDrTP3C/HXoWcCLlYljAP9k
 JAcS/gC445YHtFZuDp7VDwstISqPXYssfDpxP2G9X9lOZCU7PJgPQpBF5dCOri/TLoMlnmNK4
 gx4iawQvSFL+q6QEorsEH2mV3brnPjbvE35JqhuKdorCqgODiLAwWuPSma8ou6XKSaGnny2DV
 Eflz/uOzX7pfpys33S2lq88lwfU2tlYIp5kbwx82HYcRsAnyx5NrQmHshstUf5UDiB5GHttDZ
 HLeL7Lx3Uym74HYDMh8vE6QeULYhlt8oKYedZXEw2wyIduutf7KvZiwww==
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/31 16:40, Martin Edelius wrote:
> Hi all!
>
> I've been looking around for a solution to my problematic raid5 array an=
d although there's quite a bit of useful information I also see the advice=
 to not try and fix this error myself and instead consult this mailing lis=
t. (As a side note, I did search this list for a potential fix but got 300=
0+ results so I resorted to starting a new thread.)

Unfortunately, RAID56 from btrfs is not recommended.

The main problem is, even without power loss, recovery for btrfs RAID5
has its problems, mostly related to its cached raid56 data.

Furthermore due to a bad design in P/Q update during a RMW, even if we
didn't touch any data in a vertical stripe, the P/Q of that vertical
stripe will still be calculated and written to disk.

Combined with above cached usage, btrfs RAID5 has a very bad behavior to
cause more corruption, if one data stripe has some corruption already.

This behavior will be at least greatly improve in the incoming v5.20
kernel, but unfortunately these fixes are not yet backported, thus your
v5.4 kernel will be affected by this.

>
> I was away for a couple of days and came home to this problem so I'm not=
 entirely sure what happened. As there are no signs of power outages my gu=
ess is that it's just a faulty disk (/dev/sdb). The SMART info says that i=
t's been online for a little over a year so IMHO it should last a lot long=
er but I guess it didn't.

Exactly the worst case, a faulty disk, then newer writes will easily
spread the corruption into other devices.

>
> I'm running the Rockstor NAS and do my best to keep everything updated o=
n a regular basis.
>
> So far I've only tried mounting the filesystem as degraded and read-only=
 (and with the usebackuproot option as a sort of last resort) but keep get=
ting the same error:
> mount: /mnt2: wrong fs type, bad option, bad superblock on /dev/sdb, mis=
sing codepage or helper program, or other error.
>
> I have other disks I can swap in but I've had mixed results previously (=
when the array broke the first time) using the recommended commands (btrfs=
 replace for example) and I have data on this array I haven't backed up ye=
t (rookie mistake, I know) so I'd rather ask you for guidance before I sta=
rt potentially making things worse. :)
>
> Here's the info requested:
>
> Rockstor:/mnt2 # uname -a
> Linux Rockstor 5.3.18-lp152.106-default #1 SMP Mon Nov 22 08:38:17 UTC 2=
021 (52078fe) x86_64 x86_64 x86_64 GNU/Linux
>
> Rockstor:/mnt2 # btrfs --version
> btrfs-progs v4.19.1
>
> Rockstor:/mnt2 # btrfs fi show
> Label: 'ROOT'  uuid: cd444c07-dfe0-4813-9a71-6833c48d1cab
>          Total devices 1 FS bytes used 5.32GiB
>          devid    1 size 109.75GiB used 8.80GiB path /dev/sda4
>
> Label: 'SDD'  uuid: 3d0e1b45-666a-46c6-9c83-e2f16a73b79e
>          Total devices 4 FS bytes used 257.92GiB
>          devid    1 size 465.76GiB used 89.00GiB path /dev/sdc
>          devid    2 size 465.76GiB used 89.00GiB path /dev/sdi
>          devid    3 size 465.76GiB used 89.00GiB path /dev/sdh
>          devid    4 size 465.76GiB used 89.00GiB path /dev/sdd
>
> Label: 'HDD'  uuid: 0aae387e-2847-44a5-8db7-0635421d80af
>          Total devices 8 FS bytes used 11.41TiB
>          devid    1 size 2.73TiB used 1.64TiB path /dev/sdb
>          devid    2 size 2.73TiB used 1.64TiB path /dev/sdj
>          devid    3 size 1.82TiB used 1.64TiB path /dev/sdl
>          devid    4 size 1.82TiB used 1.64TiB path /dev/sdg
>          devid    5 size 3.64TiB used 1.64TiB path /dev/sdf
>          devid    6 size 3.64TiB used 1.64TiB path /dev/sde
>          devid    7 size 3.64TiB used 1.64TiB path /dev/sdm
>          devid    8 size 3.64TiB used 1.64TiB path /dev/sdk
>
> Rockstor:/mnt2 # btrfs fi df /mnt2
> Data, single: total=3D8.54GiB, used=3D5.22GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D232.00MiB, used=3D100.03MiB
> GlobalReserve, single: total=3D13.61MiB, used=3D0.00B

Fs in /mnt2 is not using RAID5 at all, all pure single, so I guess it's
the ROOT fs.


>
> The dmesg log is approximately 258 kb so I placed it in my OneDrive inst=
ead: https://1drv.ms/u/s!AsKRbODiURBmrMdN3oEHLQqlLqxujA?e=3DOIo05V (let me=
 know if you want me to provide it through some other means).

According to the dmesg, the error is from sdb/sdl, thus the HDD fs,
which I believe should be RAID5.

Mind to share the `btrfs fi df` output of that HDD fs?


Another thing is, it really looks like some RAID5 destructive RMW:

   BTRFS error (device sdb): parent transid verify failed on
11190780739584 wanted 192504 found 191675
   BTRFS error (device sdb): bad tree block start, want 11190780739584
have 0

The first line mostly means it's from the data stripe, and it's bad.
That's fine since it's a fault disk.

Then the 2nd line is worse, it should be rebuilt from P and other data
stripes.
However the rebuilt data are just all zero, and failed to even pass
basic tree block check.

This looks exactly the destructive RMW caused by fault disk.

Unfortunately, what we can do is only to salvage data.

If possible, try to use some liveCD with kernel >=3D v5.15, then mount the
HDD fs with "rescue=3Dall,ro", if lucky enough, you may be able to mount
the fs and grab whatever you have.

Thanks,
Qu

>
> Thanks.
>
>
> Brg,
> Martin
>
