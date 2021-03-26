Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEC34A358
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCZIpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 04:45:01 -0400
Received: from rin.romanrm.net ([51.158.148.128]:34464 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhCZIoX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 04:44:23 -0400
X-Greylist: delayed 60324 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 04:44:23 EDT
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 6212D6A5;
        Fri, 26 Mar 2021 08:44:21 +0000 (UTC)
Date:   Fri, 26 Mar 2021 13:44:21 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     "Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Why doesn't btrfs find additional space after (VMware) disk
 extension?
Message-ID: <20210326134421.24cd109a@natsu>
In-Reply-To: <f50ee91d04c94feda3a6ce413332e83d@claas.com>
References: <8a4b55eb42bd42d181abe9d7c208607c@claas.com>
        <20210325205857.412ab914@natsu>
        <f50ee91d04c94feda3a6ce413332e83d@claas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 26 Mar 2021 08:09:50 +0000
"Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com> wrote:

> > You got the right lead there, but I believe it's 
> > 
> > btrfs filesystem resize 3:max /
> > 
> > -- 
> > With respect,
> > Roman
> 
> Thanks a lot, you got me one step further (but directly stuck again).
> Unfortunately it now just shows that new space as Unallocated

That's OK


> I also tried to add a new subvol hoping that one would be able to profit
> from that new space (it didn't).
> 
> I assume I must add that unallocated space to any subvol, but have no clue
> how to do so.

No, you don't need to, the free space is FS-wide, it does not belong to
subvolumes.

> Again - no documentation found was helping.
> Any Idea what I am missing?

> # btrfs filesystem show
> Label: none  uuid: 26c2b9c2-7ef7-476c-825d-9931b6344c37
>         Total devices 3 FS bytes used 125.09GiB
>         devid    1 size 47.51GiB used 47.51GiB path /dev/sdb2
>         devid    2 size 32.00GiB used 32.00GiB path /dev/sdc
>         devid    3 size 500.00GiB used 47.52GiB path /dev/sdd
> 
> 
> # btrfs filesystem usage /
> Overall:
>     Device size:                 579.51GiB
>     Device allocated:            127.02GiB
>     Device unallocated:          452.49GiB
>     Device missing:                  0.00B
>     Used:                        125.42GiB
>     Free (estimated):            452.73GiB      (min: 226.49GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:               24.00MiB      (used: 0.00B)
> 
> Data,RAID0: Size:125.01GiB, Used:124.76GiB
>    /dev/sdb2      46.51GiB
>    /dev/sdc       31.99GiB
>    /dev/sdd       46.51GiB
> 
> Metadata,RAID1: Size:1.00GiB, Used:333.56MiB
>    /dev/sdb2       1.00GiB
>    /dev/sdd        1.00GiB
> 
> System,RAID1: Size:8.00MiB, Used:16.00KiB
>    /dev/sdc        8.00MiB
>    /dev/sdd        8.00MiB
> 
> Unallocated:
>    /dev/sdb2       1.00MiB
>    /dev/sdc        1.00MiB
>    /dev/sdd      452.48GiB
> 
> # btrfs balance /
> WARNING:
> 
>         Full balance without filters requested. This operation is very
>         intense and takes potentially very long. It is recommended to
>         use the balance filters to narrow down the scope of balance.
>         Use 'btrfs balance start --full-balance' option to skip this
>         warning. The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/': No space left on device

My guess is that you ask FS to store data and metadata as RAID0 and RAID1,
i.e. each requiring *two* devices either for striping or mirroring, but you do
not actually have two devices with free space to write new data to, only one
(sdd).

With such setup of 47 + 32 + 500 GB, you will be able to store only about 160
GB of data on the FS. Or with 47 and 32 being already filled on the addition of
500GB, even less.

If you want to fully use all the disk space at cost of some performance (at
least for now), you can convert your data to "single":

  btrfs balance start -dconvert=single /

It might not be necessary to convert all of it, just some will be enough to
give it a little room and also make all new block groups also "single".
So, at first try adding "-dlimit=10" to the above line.

-- 
With respect,
Roman
