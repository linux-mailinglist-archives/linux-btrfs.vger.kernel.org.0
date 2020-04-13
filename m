Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601EE1A6512
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Apr 2020 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgDMKOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Apr 2020 06:14:40 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:55178 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgDMKOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Apr 2020 06:14:39 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 06:14:38 EDT
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id D1B45B2183C;
        Mon, 13 Apr 2020 13:08:53 +0300 (MSK)
Received: from mxback9q.mail.yandex.net (mxback9q.mail.yandex.net [IPv6:2a02:6b8:c0e:6b:0:640:b813:52e4])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id CD2AA7F2001C;
        Mon, 13 Apr 2020 13:08:53 +0300 (MSK)
Received: from vla4-a16f3368381d.qloud-c.yandex.net (vla4-a16f3368381d.qloud-c.yandex.net [2a02:6b8:c17:d85:0:640:a16f:3368])
        by mxback9q.mail.yandex.net (mxback/Yandex) with ESMTP id Y4wR8RvBsY-8r3e2hDZ;
        Mon, 13 Apr 2020 13:08:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1586772533;
        bh=DCvIuZcTKcoieQMidfY/C6yATm/BE9mNkbKRAb3+n2U=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-ID;
        b=B4D9zljgxLPTHJP7w7G96UWg1sgxiJ31Jv+D99PfqONYmqi5HuShQlFcbUs2WnmKY
         x/dOhC6k8pKZ5osr7jYNTk79PqMjreKof/U4aZcIvo+1GZyK+9J9TsQ2S8euAcwEvn
         Ymmx3VJiIEXgJieE+cbjmZVjKugNVweDFaDq0pwQ=
Authentication-Results: mxback9q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-a16f3368381d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id SkogZ2Ttgg-8qXqLDgq;
        Mon, 13 Apr 2020 13:08:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Joshua Houghton <joshua.houghton@yandex.ru>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        DanglingPointer <danglingpointerexception@gmail.com>,
        Torstein Eide <torsteine@gmail.com>
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
Date:   Mon, 13 Apr 2020 10:08:50 +0000
Message-ID: <4521727.GXAFRqVoOG@arch>
In-Reply-To: <20200318211157.11090-1-kreijack@libero.it>
References: <20200318211157.11090-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wednesday, 18 March 2020 21:11:56 UTC Goffredo Baroncelli wrote:
> Hi all,
> 
> this patch adds support for the raid5/6 profiles in the command
> 'btrfs filesystem usage'.
> 
> Until now the problem was that the value r_{data,metadata}_used is not
> easy to get for a RAID5/6, because it depends by the number of disks.
> And in a filesystem it is possible to have several raid5/6 chunks with a
> different number of disks.
> 
> In order to bypass this issue, I reworked the code to get rid of these
> values where possible and to use the l_{data,metadata}_used ones.
> Notably the biggest differences is in how the free space estimation
> is computed. Before it was:
> 
> 	free_estimated = (r_data_chunks - r_data_used) / data_ratio;
> 
> After it is:
> 
> 	free_estimated = l_data_chunks - l_data_used;
> 
> which give the same results when there is no mixed raid level, but a
> better result in the other case. I have to point out that before in the
> code there was a comment that said the opposite.
> 
> The other place where the r_{data,metadata}_used are use is for the
> "Used:" field. For this case I estimated these values using the
> following formula (only for raid5/6 profiles):
> 
> 	r_data_used += (double)r_data_chunks * l_data_used /
>                                l_data_chunks;
> 
> Note that this is not fully accurate. Eg. suppose to have two raid5 chunks,
> the first one with 3 disks, the second one with 4 disks, and that each
> chunk is 1GB.
> r_data_chunks_r56, l_data_used_r56, l_data_chunks_r56 are completely
> defined, but real r_data_used is completely different in these two cases:
> - the first chunk is full and the second one id empty
> - the first chunk is full empty and the second one is full
> However now this error affect only the "Used:" field.
> 
> 
> So now if you run btrfs fi us in a raid6 filesystem you get:
> 
> $ sudo btrfs fi us /
> Overall:
>     Device size:		  40.00GiB
>     Device allocated:		   8.28GiB
>     Device unallocated:		  31.72GiB
>     Device missing:		     0.00B
>     Used:			   5.00GiB
>     Free (estimated):		  17.36GiB	(min: 17.36GiB)
>     Data ratio:			      2.00
>     Metadata ratio:		      0.00
>     Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> [...]
> 
> Instead before:
> 
> $ sudo btrfs fi us /
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:		  40.00GiB
>     Device allocated:		     0.00B
>     Device unallocated:		  40.00GiB
>     Device missing:		     0.00B
>     Used:			     0.00B
>     Free (estimated):		     0.00B	(min: 8.00EiB)
>     Data ratio:			      0.00
>     Metadata ratio:		      0.00
>     Global reserve:		   3.25MiB	(used: 0.00B)
> 
> Data,RAID6: Size:4.00GiB, Used:2.50GiB (62.53%)
> [...]
> 
> 
> I want to point out that this patch should be compatible with my
> previous patches set (the ones related to the new ioctl
> BTRFS_IOC_GET_CHUNK_INFO). If both are merged we will have a 'btrfs fi us'
> commands with full support a raid5/6 filesystem without needing root
> capability.
> 
> Comments are welcome.
> BR
> G.Baroncelli

Hi Goffredo

Thanks you for this. It's something I've been wanting for a while. Do 
you know why I get significantly different results in the overall summary when I 
do not run it as root. I'm not sure if this is a bug or a limitation.

When I run it as root it looks to be showing the correct values.

joshua@r2400g:~/development/btrfs-progs$ colordiff -u <(./btrfs fi us /mnt/raid/) <(sudo ./btrfs fi us /mnt/raid/)
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
--- /dev/fd/63  2020-04-13 10:54:26.833747190 +0100
+++ /dev/fd/62  2020-04-13 10:54:26.843746984 +0100
@@ -1,17 +1,32 @@
 Overall:
     Device size:                 29.11TiB
-    Device allocated:           284.06GiB
-    Device unallocated:                  28.83TiB
-    Device missing:              29.11TiB
-    Used:                       280.99GiB
-    Free (estimated):               0.00B      (min: 14.95TiB)
-    Data ratio:                              0.00
+    Device allocated:            19.39TiB
+    Device unallocated:                   9.72TiB
+    Device missing:                 0.00B
+    Used:                        18.67TiB
+    Free (estimated):             7.82TiB      (min: 5.39TiB)
+    Data ratio:                              1.33
     Metadata ratio:                  2.00
     Global reserve:             512.00MiB      (used: 0.00B)
 
 Data,RAID5: Size:14.33TiB, Used:13.80TiB (96.27%)
+   /dev/mapper/traid3     4.78TiB
+   /dev/mapper/traid1     4.78TiB
+   /dev/mapper/traid2     4.78TiB
+   /dev/mapper/traid4     4.78TiB
 
 Metadata,RAID1: Size:142.00GiB, Used:140.49GiB (98.94%)
+   /dev/mapper/traid3    63.00GiB
+   /dev/mapper/traid1    64.00GiB
+   /dev/mapper/traid2    63.00GiB
+   /dev/mapper/traid4    94.00GiB
 
 System,RAID1: Size:32.00MiB, Used:1.00MiB (3.12%)
+   /dev/mapper/traid1    32.00MiB
+   /dev/mapper/traid4    32.00MiB
 
+Unallocated:
+   /dev/mapper/traid3     2.44TiB
+   /dev/mapper/traid1     2.44TiB
+   /dev/mapper/traid2     2.44TiB
+   /dev/mapper/traid4     2.41TiB


This is in contrast to raid1 which seems to be mostly correct, irrespective
of what user I run as.


joshua@arch:/var/joshua$ colordiff -u <(btrfs fi us raid/) <(sudo btrfs fi us raid/)
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
--- /dev/fd/63  2020-04-13 09:52:54.630750079 +0000
+++ /dev/fd/62  2020-04-13 09:52:54.637416835 +0000
@@ -2,7 +2,7 @@
     Device size:                  8.00GiB
     Device allocated:             1.32GiB
     Device unallocated:                   6.68GiB
-    Device missing:               8.00GiB
+    Device missing:                 0.00B
     Used:                       383.40MiB
     Free (estimated):             3.55GiB      (min: 3.55GiB)
     Data ratio:                              2.00
@@ -10,8 +10,17 @@
     Global reserve:               3.25MiB      (used: 0.00B)
 
 Data,RAID1: Size:409.56MiB, Used:191.28MiB (46.70%)
+   /dev/loop0   409.56MiB
+   /dev/loop1   409.56MiB
 
 Metadata,RAID1: Size:256.00MiB, Used:416.00KiB (0.16%)
+   /dev/loop0   256.00MiB
+   /dev/loop1   256.00MiB
 
 System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
+   /dev/loop0     8.00MiB
+   /dev/loop1     8.00MiB
 
+Unallocated:
+   /dev/loop0     3.34GiB
+   /dev/loop1     3.34GiB

Does anyone know if this is something we can fix? I'm happy to take a look.

Joshua Houghton


