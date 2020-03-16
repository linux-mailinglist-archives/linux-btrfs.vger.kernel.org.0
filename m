Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D640186553
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 07:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgCPG7i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Mar 2020 02:59:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58227 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgCPG7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 02:59:37 -0400
Received: from [192.168.177.20] ([91.56.77.2]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MC2sF-1j1L8I3l6L-00CTG3; Mon, 16 Mar 2020 07:59:32 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     waxhead@dirtcellar.net, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re[2]: the free space cache file is invalid, skip it
Date:   Mon, 16 Mar 2020 06:59:30 +0000
Message-Id: <em643b0c79-ce6a-4c14-90e6-d5e15bfffebf@ryzen>
In-Reply-To: <f2e7a222-0f92-a905-bd9c-6a8d1a5a0cd1@dirtcellar.net>
References: <emfc09a7c5-74d2-4f64-92cc-9a8cffa964e1@ryzen>
 <f2e7a222-0f92-a905-bd9c-6a8d1a5a0cd1@dirtcellar.net>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:pWP6jdThHdchJzYnCw9I1Yi2jnuLQ+C2BLOzarj2H6KGc2BAbff
 NqVc8/b0+yhrZvKVab/2VzR72Kg4CNy2VZYBDeSJSlv2nxlilKo03vCfwLQue92jp7u0opp
 9VG9pIyX8SIuxn2/CnSZDJXbiULREfztrYfOFe9l4F/i2hY6jdpo7LQ+YHCHkIT/hfwYrOh
 T4FeyEkSOpEWFBxUgGkMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZ0PCojFGHs=:SCsvCFlJtXb27WP5VHqUFP
 mYvtN3n1E/8qeQ2jHAI91dOVxP/ZrKGY8qE+Bb4TnCJk5ZiKBNI8AtMXWP5uQtQJkpwTBPTS9
 PsjnlF6CUKf7Ly3LKFVzS7s2TSjgqq6Lnssx00H3FbtJQwOQ+i18nIEFAraJeFZg5Hi7Q39S2
 FDJvnKAyczVAWALoKYtV9HgtTpCdRNeIMV3if7QovCdVOMkhzLjY19/4dcfmawuEhXgWV6+Vi
 3g/v5BiMIAIF2wq3IT9R1tjz9c1hxKCR55f8jE7ZraQMuX3rC02uXXJS2W1OHx96P17lr+JVN
 PFWecff37GB+SGo9vtHCIc75Hpv2x24r/DMi4I/K5NK3dHW962S3rguUopXftHgIPs9htgfMU
 RzDSU6iuWxdsSwtnObSJRVHxe0rmkaKKX5aSMyCK1wK6qMHG91OcFcgCDLJDthfkwZp5BRC4d
 u9d75LurWj/8iSsENpJ94qXv2QZNXlBIPzuG/TZvaQgnUAQDYljKUZCwsdxoSwkNuMvvetkQT
 NHPo7gUDtSKoD9YXl3YhBYfbQvEq4eXRzenkFEvCmHApumaZyAjFqV3d6RTXea5mO7LpsYhUn
 nhOD5EzMBhIsPqC5do00xgTBZc9Wk1LGEFUOWpB0dher9ZkA4bXYf0IJ68PXY0xmdOwWAhPIW
 6BHuhAlgQdUvMDcSZRw2KPfxW4BFr8bJqaP2TmyhPSA4VXta2MZQWApT6L44t+0PM5zaSprhY
 EQYWWG51viV/2Zj5mxbjZHfR9SHCt5mPh1LMUPzwjrlB2rflrVDR5Sx6WQZleDQKVv+jZMbl0
 zJELtycu4f/SaiSZ34mUJAhYexDrsAN5ryrrZ65CETT+aINPMdse+FEDo+h3sI+aZrJQNs6
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

thank you for your reply.
Here the further information:
root@homeserver:~# uname -a
Linux homeserver 5.4.8 #1 SMP Sun Jan 5 15:39:51 CET 2020 x86_64 
GNU/Linux
root@homeserver:~# btrfs --version
btrfs-progs v4.20.2
root@homeserver:~# btrfs filesystem show /srv/DataPool1
Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         Total devices 2 FS bytes used 6.56TiB
         devid    1 size 7.28TiB used 7.06TiB path /dev/sdf1
         devid    2 size 7.28TiB used 7.06TiB path /dev/sdc1

root@homeserver:~# btrfs filesystem usage -T /srv/DataPool1
Overall:
     Device size:                  14.55TiB
     Device allocated:             14.12TiB
     Device unallocated:          439.94GiB
     Device missing:                  0.00B
     Used:                         13.12TiB
     Free (estimated):            731.00GiB      (min: 731.00GiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

              Data    Metadata System
Id Path      RAID1   RAID1    RAID1    Unallocated
-- --------- ------- -------- -------- -----------
  2 /dev/sdc1 7.05TiB 15.00GiB 64.00MiB   219.97GiB
  1 /dev/sdf1 7.05TiB 15.00GiB 64.00MiB   219.97GiB
-- --------- ------- -------- -------- -----------
    Total     7.05TiB 15.00GiB 64.00MiB   439.94GiB
    Used      6.55TiB 10.69GiB  1.02MiB

My last knowledge was, that one should not use btrfs check unless asked 
to by a developer. Consequently, I rather ask for advice here.

Regards,
Hendrik


------ Originalnachricht ------
Von: "waxhead" <waxhead@dirtcellar.net>
An: "Hendrik Friedel" <hendrik@friedels.name>; "Btrfs BTRFS" 
<linux-btrfs@vger.kernel.org>
Gesendet: 15.03.2020 16:49:00
Betreff: Re: the free space cache file is invalid, skip it

>First , I am just a regular btrfs user so take what I say with a grain of salt.
>
>However, according to the FAQ here:
>https://btrfs.wiki.kernel.org/index.php/FAQ
>
>You should run btrfs check on your filfeystem. This may be a brilliant or horrific idea. You probably want to drop your free space cache file as well ,but wait until a developer answers if you wanna be on the safe side.
>
>If you expect some serious help you should probably post the outputs of these commands and state just for the record what distro you are using and I am sure you will get help soon (the BTRFS list is very friendly).
>
>uname -a
>btrfs --version
>btrfs filesystem show /mountpoint
>btrfs filesystem usage -T /mountpoint
>
>Hendrik Friedel wrote:
>>Hello,
>>
>>I see these errors in my syslog:
>>
>>Mar 15 00:16:31 homeserver kernel: [524589.677551] BTRFS info (device sdf1): the free space cache file (12785106812928) is invalid, skip it
>>Mar 15 00:16:32 homeserver kernel: [524590.494705] BTRFS info (device sdf1): the free space cache file (12787254296576) is invalid, skip it
>>Mar 15 00:16:53 homeserver kernel: [524611.371823] BTRFS info (device sdf1): the free space cache file (14405383225344) is invalid, skip it
>>Mar 15 00:18:18 homeserver kernel: [524696.803108] BTRFS info (device sdf1): the free space cache file (15598377500672) is invalid, skip it
>>Mar 15 00:18:18 homeserver kernel: [524696.935340] BTRFS info (device sdf1): the free space cache file (15613409886208) is invalid, skip it
>>Mar 15 00:18:19 homeserver kernel: [524698.074946] BTRFS info (device sdf1): the free space cache file (15643474657280) is invalid, skip it
>>Mar 15 00:18:19 homeserver kernel: [524698.074952] BTRFS info (device sdf1): the free space cache file (15643474657280) is invalid, skip it
>>Mar 15 00:18:21 homeserver kernel: [524699.353843] BTRFS info (device sdf1): the free space cache file (15663875751936) is invalid, skip it
>>Mar 15 00:19:37 homeserver kernel: [524776.142963] BTRFS info (device sdf1): the free space cache file (15062513221632) is invalid, skip it
>>Mar 15 00:19:38 homeserver kernel: [524776.307788] BTRFS info (device sdf1): the free space cache file (15065734447104) is invalid, skip it
>>Mar 15 00:19:38 homeserver kernel: [524776.549028] BTRFS info (device sdf1): the free space cache file (15070029414400) is invalid, skip it
>>Mar 15 00:19:38 homeserver kernel: [524776.675084] BTRFS info (device sdf1): the free space cache file (15071103156224) is invalid, skip it
>>Mar 15 00:19:38 homeserver kernel: [524777.004195] BTRFS info (device sdf1): the free space cache file (15076471865344) is invalid, skip it
>>Mar 15 00:19:50 homeserver kernel: [524788.446974] BTRFS info (device sdf1): the free space cache file (15559722795008) is invalid, skip it
>>Mar 15 00:19:51 homeserver kernel: [524789.965874] BTRFS info (device sdf1): the free space cache file (15570460213248) is invalid, skip it
>>Mar 15 00:21:59 homeserver kernel: [524918.102725] BTRFS info (device sdf1): the free space cache file (15064660705280) is invalid, skip it
>>Mar 15 00:25:49 homeserver kernel: [525147.576735] BTRFS info (device sdf1): the free space cache file (15564017762304) is invalid, skip it
>>Mar 15 00:27:33 homeserver kernel: [525251.725178] BTRFS info (device sdf1): the free space cache file (16411300724736) is invalid, skip it
>>
>>a scrub of that drive was finde.
>>Also, the stats look good:
>>btrfs dev stats /srv/dev-disk-by-label-DataPool1
>>[/dev/sdf1].write_io_errs    0
>>[/dev/sdf1].read_io_errs     0
>>[/dev/sdf1].flush_io_errs    0
>>[/dev/sdf1].corruption_errs  0
>>[/dev/sdf1].generation_errs  0
>>[/dev/sdc1].write_io_errs    0
>>[/dev/sdc1].read_io_errs     0
>>[/dev/sdc1].flush_io_errs    0
>>[/dev/sdc1].corruption_errs  0
>>[/dev/sdc1].generation_errs  0
>>
>>Is this concerning?
>>What should I do?
>>
>>Regards,
>>Hendrik
>>

