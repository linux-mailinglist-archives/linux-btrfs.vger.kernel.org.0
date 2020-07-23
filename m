Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754122A6B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 06:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgGWEvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 00:51:08 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34772 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEvI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 00:51:08 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 431D77796C2; Thu, 23 Jul 2020 00:51:07 -0400 (EDT)
Date:   Thu, 23 Jul 2020 00:51:06 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Understanding "Used" in df
Message-ID: <20200723045106.GL10769@hungrycats.org>
References: <3225288.0drLW0cIUP@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3225288.0drLW0cIUP@merkaba>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 05:10:19PM +0200, Martin Steigerwald wrote:
> I have:
> 
> % LANG=en df -hT /home
> Filesystem            Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-home btrfs  300G  175G  123G  59% /home
> 
> And:
> 
> merkaba:~> btrfs fi sh /home   
> Label: 'home'  uuid: […]
>         Total devices 2 FS bytes used 173.91GiB
>         devid    1 size 300.00GiB used 223.03GiB path /dev/mapper/sata-home
>         devid    2 size 300.00GiB used 223.03GiB path /dev/mapper/msata-home
> 
> merkaba:~> btrfs fi df /home
> Data, RAID1: total=218.00GiB, used=171.98GiB
> System, RAID1: total=32.00MiB, used=64.00KiB
> Metadata, RAID1: total=5.00GiB, used=1.94GiB
> GlobalReserve, single: total=490.48MiB, used=0.00B
> 
> As well as:
> 
> merkaba:~> btrfs fi usage -T /home
> Overall:
>     Device size:                 600.00GiB
>     Device allocated:            446.06GiB
>     Device unallocated:          153.94GiB
>     Device missing:                  0.00B
>     Used:                        347.82GiB
>     Free (estimated):            123.00GiB      (min: 123.00GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              490.45MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
>                           Data      Metadata System              
> Id Path                   RAID1     RAID1    RAID1    Unallocated
> -- ---------------------- --------- -------- -------- -----------
>  1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
>  2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
> -- ---------------------- --------- -------- -------- -----------
>    Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
>    Used                   171.97GiB  1.94GiB 64.00KiB   
> 
> 
> I think I understand all of it, including just 123G instead of
> 300 - 175 = 125 GiB "Avail" in df -hT.
> 
> But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs fi sh')
> is allocated *within* the block group / chunks?

statvfs (the 'df' syscall) does not report a "used" number, only total
and available btrfs data blocks (no metadata blocks are counted).
'df' computes "used" by subtracting f_blocks - f_bavail.

	122.99875 = 300 - 171.97 - 5 - .03125

	df_free = total - data_used - metadata_allocated - system_allocated

Inline files count as metadata instead of data, so even when you are
out of data blocks (zero blocks free in df), you can sometimes still
write small files.  Sometimes, when you write one small file, 1GB of
available space disappears as a new metadata block group is allocated.

'df' doesn't take metadata or data sharing into account at all, or
the space required to store csums, or bursty metadata usage workloads.
'df' can't predict these events, so its accuracy is limited to no better
than about 0.5% of the size of the filesystem or +/- 1GB, whichever is
larger.

> Does this have something to do with that global reserve thing?

'df' currently tells you nothing about metadata (except in kernels
before 5.6, when you run too low on metadata space, f_bavail is abruptly
set to zero).  That's about the only impact global reserve has on 'df'.

Global reserve is metadata allocated-but-unused space, and all metadata
is not visible to df.  The reserve ensures that critical btrfs metadata
operations can complete without running out of space, by forcing
non-critical long-running operations to commit transactions when no
metadata space is available outside the reserved pool.  It mostly works,
though there are still a few bugs left that lead to EROFS when metadata
runs low.

> 
> Thank you,
> -- 
> Martin
> 
> 
