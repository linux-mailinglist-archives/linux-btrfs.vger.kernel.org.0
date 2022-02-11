Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC94B1A32
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 01:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiBKAMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 19:12:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbiBKAMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 19:12:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EA272E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644538324;
        bh=4RJTWN4nkQ64o1djGBP1s/HsFfVJxsv9otsLrAimUhw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DZDP7ecjWWSa2tJcVpW5WRbA80pKB7DAZXRonDBbXxztCY46iJ6OdPIFr4LLGVRKu
         WceUX/sNYeOSE65PSuBjiSD7gSOCAvbb1hIM+v0JFn3uhkAxW9V/mbus0bTqpGuzRK
         fL1FcsRJaIz6SBDM3D72Yg0zdF2Yk0lwDMeEUoHs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1nz2l53GUu-00jIZH; Fri, 11
 Feb 2022 01:12:04 +0100
Message-ID: <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
Date:   Fri, 11 Feb 2022 08:12:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Used space twice as actually consumed
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZkCDbUy/AEJkBj62w9CpU6HTzE4FZeyfu8nlz3mP7hxpTlnHSg
 HnmzuqyXfSgxlaLifoxaMwhnB8dvUFF9ffo1O3OagPfy2gW1XMCbBC6W+9B0mGsP7LO13D0
 B3LsjPwFPRCG31/mBmt64DOyf/yh+F/Eestzr7G2d4FMkKO+3YYJl4QhBHaF5NcmiCqTphn
 kefof5pOors2zuyWrQLDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSABYquIdOM=:1rIRhIFkwLkarOX4w5iyZv
 cCtn7MkzHHBymm3AjzxgJYSsqh7neNLgU9KRQTaprDBoGeSdi5OkzmduAUmFuV5vCqPjQO4l/
 Kz8uaLQ5lHPtAFIupG3v3a8xcfc0ttZX8K/CDtQlZCcg4dqKt3qMn5kClOP03HLAFkomw0BVJ
 nsSihYDZj9S13/MUd5dNTCPuGEZoqe1aRFixeSqjvc2l/2YpQfug3p65Fp2lAKM26mI1vjmPS
 yg3vlN2SOM4SWUCkM6ULrg35BG4uyL9TplmLIl/UD0FRgai2WShmHkerRLuqaKm79ztVZ3Ig2
 f04VPahpbyiPVPE0aL4rFWI7a2Z6HmL9NEmBgKKoS3C8JZaZvsKpMMYGUns7+NV9nHkRMCBu6
 BlvgfrZjz/eIKaxu2yYwqchhXMUpddETyX1Y7mB4znlHLr1GYkdHUuNWo7xr7ie5KHTkxUL4N
 FGkqKmsSUej5c02mYHp1W0+IR2cLBSf43wdfULPIx01P2trErU8I8dPAas8W6nvoC3rYnM7OI
 6cVckbwrfJnOXZrkTRjBLCX2hqinEkNISfxQo4QrAwO8v6hl5qrb3gr4fkQvPXiEBwcRw8AQf
 9ha82xp+DShqsoEYRGKHJcBIXskAftLjmtf4zm8XrSzk/DgxF0EULgFd4iyNgipvTdSCiTKPH
 c6xPblM/3zLIwMLXsuFC6mQ/Bytm9pDbvs1kiWtk+2fSvJtXvqonNPp7Jux6hyuKNm1ntOR4H
 ohbUr7Y83uWgemFKSjxhtsLHroRbv7NqHsVU2fFdPZd+E+aLRyzoTIvZ631GLlUbpdAqDrRgW
 ArlZI+020KtdBD3Sl7Xnshn4hFVWqmQaEREzFbVcmo3iB/ztNGTF991tRETELMeJeRCyBs8eW
 dkbWTbmpRQ7NaXPRZKvAgbRr5I1GGdWxaF9AjsGEzQrkb8yfvdRJoBRstHxDEUo0vE9wknLPY
 XKaYOHQsuxw/SQjpwaije2DtbnVd2o9HOMGy8kSM+UEEkReWvy1cjvgzGk6yz5vM2W/V5gGAM
 5KFlPMHftXBFB1SUJl3VNCA0VF66R0e6YrJmJ3rie+Qyg7E5IG4deGga494i4Z0S+r0xsiqcE
 kEcEZND91NCJXA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 02:54, Andrei Borzenkov wrote:
> I am at a loss.
>
> bor@tw:~> uname -a
>
> Linux tw 5.16.4-1-default #1 SMP PREEMPT Sat Jan 29 12:57:02 UTC 2022 (b=
146677) x86_64 x86_64 x86_64 GNU/Linux
>
>
> opnSUSE Tumbleweed.
>
>
> bor@tw:~> sudo btrfs fi us -T /
>
> [sudo] password for root:
>
> Overall:
>
>      Device size:		  38.91GiB
>
>      Device allocated:		  38.91GiB
>
>      Device unallocated:		   1.00MiB
>
>      Device missing:		     0.00B
>
>      Used:			  23.91GiB
>
>      Free (estimated):		  13.14GiB	(min: 13.14GiB)
>
>      Free (statfs, df):		  13.14GiB
>
>      Data ratio:			      1.00
>
>      Metadata ratio:		      2.00
>
>      Global reserve:		  85.95MiB	(used: 0.00B)
>
>      Multiple profiles:		        no
>
>
>
>               Data     Metadata  System
>
> Id Path      single   DUP       DUP      Unallocated
>
> -- --------- -------- --------- -------- -----------
>
>   1 /dev/vda2 35.34GiB   3.51GiB 64.00MiB     1.00MiB
>
> -- --------- -------- --------- -------- -----------
>
>     Total     35.34GiB   1.75GiB 32.00MiB     1.00MiB
>
>     Used      22.19GiB 877.94MiB 16.00KiB
>
> bor@tw:~>
>
>
> Well, that's wrong for all I can tell.
>
> bor@tw:~> sudo btrfs qgroup show /
>
> qgroupid         rfer         excl
>
> --------         ----         ----
>
> 0/5          16.00KiB     16.00KiB
>
> 0/257        16.00KiB     16.00KiB
>
> 0/258        16.00KiB     16.00KiB
>
> 0/259         9.04GiB      8.92GiB
>
> 0/260         2.69MiB      2.69MiB
>
> 0/261        16.00KiB     16.00KiB
>
> 0/262       708.24MiB    708.24MiB
>
> 0/263        16.00KiB     16.00KiB
>
> 0/264        16.00KiB     16.00KiB
>
> 0/265        16.00KiB     16.00KiB
>
> 0/266        16.00KiB     16.00KiB
>
> 0/1411        2.12GiB      1.91GiB
>
> bor@tw:~>
>
>
> So it is about 11GiB in all subvolumes. Still btrfs claims 22GiB are use=
d.
>
> There are no snapshots (currently). There is single root subvolume which
> is 259. All snapshots have been removed.
>
> bor@tw:~> sudo btrfs sub li -u /
>
> ID 257 gen 96090 top level 5 uuid 257f04e8-e972-1a42-956f-1252b88713a4 p=
ath @
>
> ID 258 gen 120221 top level 257 uuid 2b9cfacf-5c3d-924e-90e6-8f01818df65=
9 path @/.snapshots
>
> ID 259 gen 120339 top level 258 uuid 52afd41d-c722-4e48-b020-5b95a2d6fd8=
4 path @/.snapshots/1/snapshot
>
> ID 260 gen 120221 top level 257 uuid 40812ba2-102c-ae42-bf07-2b51e531d92=
3 path @/boot/grub2/i386-pc
>
> ID 261 gen 120221 top level 257 uuid 9105e591-b3d9-a84a-93e9-6902fd78897=
b path @/boot/grub2/x86_64-efi
>
> ID 262 gen 120339 top level 257 uuid be0f25f1-8505-7a4d-87bf-29bcb06ce55=
c path @/home
>
> ID 263 gen 120186 top level 257 uuid e95e8fd5-5bc0-e94a-bc56-c355357479d=
c path @/opt
>
> ID 264 gen 120221 top level 257 uuid 4b0f5496-dc32-9d43-a36c-333b18b9370=
c path @/srv
>
> ID 265 gen 120331 top level 257 uuid d658c9bd-dbe2-e842-9e31-c943119b725=
f path @/tmp
>
> ID 266 gen 120221 top level 257 uuid 71717a12-5b0c-8240-9ef4-907586ed935=
c path @/usr/local
>
> ID 1411 gen 120340 top level 257 uuid f5f4dae5-fdbc-9141-8fba-83e95b9ea1=
32 path @/var
>
> bor@tw:~>
>
>
>
>
>
>
> Any idea what's going on and where to look? I seem to have strange roots
> that are not visible as subvolumes, like
>
>          item 71 key (1329 ROOT_ITEM 81748) itemoff 7377 itemsize 439
>
>                  generation 81749 root_dirid 256 bytenr 70449102848 byte=
_limit 0 bytes_used 313655296
>
>                  last_snapshot 81748 flags 0x1000000000001(RDONLY) refs =
0
>
>                  drop_progress key (9414435 INODE_ITEM 0) drop_level 1

This subvolume is still being dropped, thus it still takes up some space.

I believe There are similar subvolumes waiting to be dropped, thus they
may be the reason they are taking up the extra space.

>
>                  level 2 generation_v2 81749
>
>                  uuid 2c5e44c6-cb4d-1b4f-a3f0-df1ee3509f47
>
>                  parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
>
>                  received_uuid 00000000-0000-0000-0000-000000000000
>
>                  ctransid 81748 otransid 81748 stransid 0 rtransid 0
>
>                  ctime 1614326844.216735782 (2021-02-26 11:07:24)
>
>                  otime 1614326844.284742808 (2021-02-26 11:07:24)
>
>                  stime 0.0 (1970-01-01 03:00:00)
>
>                  rtime 0.0 (1970-01-01 03:00:00)
>
>
> This apparently was once snapshot of root subvolume (52afd41d-c722-4e48-=
b020-5b95a2d6fd84).
> There are more of them.
>
> Any chance those "invisible" trees continue to consume space? How can I =
remove them?

They are being dropped in the background.
You can wait for them to be completely dropped by using command "btrfs
subvolume sync".

THanks,
Qu
