Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC922EB51
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgG0LiQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 27 Jul 2020 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgG0LiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 07:38:16 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DEC061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 04:38:15 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id D17F0125360;
        Mon, 27 Jul 2020 13:38:13 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Understanding "Used" in df
Date:   Mon, 27 Jul 2020 13:38:13 +0200
Message-ID: <1622535.kDMmNaIAU4@merkaba>
In-Reply-To: <20200723045106.GL10769@hungrycats.org>
References: <3225288.0drLW0cIUP@merkaba> <20200723045106.GL10769@hungrycats.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell - 23.07.20, 06:51:06 CEST:
> On Wed, Jul 22, 2020 at 05:10:19PM +0200, Martin Steigerwald wrote:
> > I have:
> > 
> > % LANG=en df -hT /home
> > Filesystem            Type   Size  Used Avail Use% Mounted on
> > /dev/mapper/sata-home btrfs  300G  175G  123G  59% /home
> > 
> > And:
> > 
> > merkaba:~> btrfs fi sh /home
> > Label: 'home'  uuid: […]
> > 
> >         Total devices 2 FS bytes used 173.91GiB
> >         devid    1 size 300.00GiB used 223.03GiB path
> >         /dev/mapper/sata-home
> >         devid    2 size 300.00GiB used 223.03GiB path
> >         /dev/mapper/msata-home
> > 
> > merkaba:~> btrfs fi df /home
> > Data, RAID1: total=218.00GiB, used=171.98GiB
> > System, RAID1: total=32.00MiB, used=64.00KiB
> > Metadata, RAID1: total=5.00GiB, used=1.94GiB
> > GlobalReserve, single: total=490.48MiB, used=0.00B
> > 
> > As well as:
> > 
> > merkaba:~> btrfs fi usage -T /home
> > 
> > Overall:
> >     Device size:                 600.00GiB
> >     Device allocated:            446.06GiB
> >     Device unallocated:          153.94GiB
> >     Device missing:                  0.00B
> >     Used:                        347.82GiB
> >     Free (estimated):            123.00GiB      (min: 123.00GiB)
> >     Data ratio:                       2.00
> >     Metadata ratio:                   2.00
> >     Global reserve:              490.45MiB      (used: 0.00B)
> >     Multiple profiles:                  no
> >     
> >                           Data      Metadata System
> > 
> > Id Path                   RAID1     RAID1    RAID1    Unallocated
> > -- ---------------------- --------- -------- -------- -----------
> > 
> >  1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
> >  2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
> > 
> > -- ---------------------- --------- -------- -------- -----------
> > 
> >    Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
> >    Used                   171.97GiB  1.94GiB 64.00KiB
> > 
> > I think I understand all of it, including just 123G instead of
> > 300 - 175 = 125 GiB "Avail" in df -hT.
> > 
> > But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs
> > fi sh') is allocated *within* the block group / chunks?
> 
> statvfs (the 'df' syscall) does not report a "used" number, only total
> and available btrfs data blocks (no metadata blocks are counted).
> 'df' computes "used" by subtracting f_blocks - f_bavail.
> 
> 	122.99875 = 300 - 171.97 - 5 - .03125
> 
> 	df_free = total - data_used - metadata_allocated - system_allocated

I get that one. That is for what is still free.

But I do not understand "Used" in df as.

1) It it would be doing 300 GiB - what is still available, it would do 300-122.99 = 177.01

2) If it would add together all allocated within a chunk… 

171.98 GiB used in data + 64 KiB used in system + 1,94 GiB used in metadata ~= 174 GiB

3) It may consider all allocated system and metadata chunks as lost for writing
data:

171.98 used in date + 32 MiB allocated in system + 5 GiB allocated in metadata ~= 176.98 GiB

4) It may consider 2 of those 5 GiB chunks for metadata as reclaimable and
then it would go like this:

171.98 used in date + 32 MiB allocated in system + 3 GiB metadata ~= 116.98 GiB = 174.98 GiB

That would be about right, but also as unpredictable as it can get.

> Inline files count as metadata instead of data, so even when you are
> out of data blocks (zero blocks free in df), you can sometimes still
> write small files.  Sometimes, when you write one small file, 1GB of
> available space disappears as a new metadata block group is allocated.
> 
> 'df' doesn't take metadata or data sharing into account at all, or
> the space required to store csums, or bursty metadata usage workloads.
> 'df' can't predict these events, so its accuracy is limited to no
> better than about 0.5% of the size of the filesystem or +/- 1GB,
> whichever is larger.

So just assume that df output can be +/- 1 GiB off?

I am just wondering cause I aimed to explaining this to participants of
my Linux courses… and for now I have the honest answer that I have
no clue why df displays "175 GiB" as used.

> > Does this have something to do with that global reserve thing?
> 
> 'df' currently tells you nothing about metadata (except in kernels
> before 5.6, when you run too low on metadata space, f_bavail is
> abruptly set to zero).  That's about the only impact global reserve
> has on 'df'.

But it won't claim used or even just allocated metadata space as available
for writing data?

> Global reserve is metadata allocated-but-unused space, and all
> metadata is not visible to df.  The reserve ensures that critical
> btrfs metadata operations can complete without running out of space,
> by forcing non-critical long-running operations to commit
> transactions when no metadata space is available outside the reserved
> pool.  It mostly works, though there are still a few bugs left that
> lead to EROFS when metadata runs low.

Hmmm, thanks.

But as far as I understood also from the other post, Global Reserve is
reserved but not reported as used in df?

I am not sure whether I am getting it though.

Best,
-- 
Martin


