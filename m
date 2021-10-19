Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7030433700
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhJSN2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 09:28:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35996 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhJSN2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 09:28:52 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 96BD6BCDA72; Tue, 19 Oct 2021 09:26:31 -0400 (EDT)
Date:   Tue, 19 Oct 2021 09:26:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     mailing@dmilz.net
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
Message-ID: <20211019132631.GB1208@hungrycats.org>
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
 <20211018140936.GA1208@hungrycats.org>
 <aefefca716de925195a0190a8d583a1d@dmilz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefefca716de925195a0190a8d583a1d@dmilz.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 12:57:39PM +0200, mailing@dmilz.net wrote:
> On 18.10.2021 16:09, Zygo Blaxell wrote:
> > On Wed, Oct 13, 2021 at 02:35:39PM +0200, mailing@dmilz.net wrote:
> > > Hello,
> > > 
> > > I faced issue with btrfs FS /var forced to RO due to errno=-28 (no
> > > space
> > > left).

> > Obviously, keeping 7GB reserved for metadata doesn't work on a device
> > that is only 2.5GB to start with.  Even if you elect not to use discard
> > or scrub, you'd still need 2.5GB for dup metadata.
> > 
> 
> Since this incident, the FS has been extended to 5GB.
> 
> But in our case the chunk size for metadata is 128MB, so:
> 2 [dup metadata] * ( 128 * ( 1 [disk] + 1 [discard] + 1 [balance] ) + 512
> [Global Reserve] ) = 1792 MB ?

The global reserve is normally much less than 512 MB on smaller disks.
It is only 13MB on the 5GB disks.

> > While it's possible to use non-mixed block groups on a filesystem that
> > has only a few GB, it's not possible to use a significant number of
> > btrfs features, including scrub, balance, RAID disk replacement, online
> > conversion to other RAID profiles, device shrink, or discard, due to
> > the requirement to have an extra unlocked block group with available
> > free space during these operations.
> 
> Last weekend I had the same behavior, the size allocated to metadata went
> from 128MB to up to 768MB, so up to 6 * 12* MB metadata but the metdata
> usage didn't grow:
> 
> ### Sat Oct 16 23:59:57 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   2647.25MiB
>     Device unallocated:                 2472.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1097.75MiB
>     Free (estimated):                   2942.38MiB      (min: 1706.00MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1089.62MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:512.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1024.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    2472.75MiB
> 
> 
> 
> ### Sun Oct 17 00:00:32 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   2903.25MiB
>     Device unallocated:                 2216.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1097.44MiB
>     Free (estimated):                   2686.69MiB      (min: 1578.31MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1089.31MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1280.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    2216.75MiB
> 
> 
> ### Sun Oct 17 00:05:27 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   2903.25MiB
>     Device unallocated:                 2216.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1099.69MiB
>     Free (estimated):                   2684.44MiB      (min: 1576.06MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1091.56MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1280.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    2216.75MiB
> 
> 
> ### Sun Oct 17 00:05:32 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   3159.25MiB
>     Device unallocated:                 1960.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1100.25MiB
>     Free (estimated):                   2427.88MiB      (min: 1447.50MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1092.12MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:768.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1536.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    1960.75MiB
> 
> ### Sun Oct 17 00:12:53 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   3159.25MiB
>     Device unallocated:                 1960.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1100.62MiB
>     Free (estimated):                   2427.50MiB      (min: 1447.12MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1092.50MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:768.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1536.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    1960.75MiB
> ### Sun Oct 17 00:12:58 CEST 2021
> Overall:
>     Device size:                        5120.00MiB
>     Device allocated:                   2903.25MiB
>     Device unallocated:                 2216.75MiB
>     Device missing:                        0.00MiB
>     Used:                               1100.69MiB
>     Free (estimated):                   2683.44MiB      (min: 1575.06MiB)
>     Data ratio:                               1.00
>     Metadata ratio:                           2.00
>     Global reserve:                       13.00MiB      (used: 0.12MiB)
> 
> Data,single: Size:1559.25MiB, Used:1092.56MiB
>    /dev/mapper/rootvg-varvol    1559.25MiB
> 
> Metadata,DUP: Size:640.00MiB, Used:4.00MiB
>    /dev/mapper/rootvg-varvol    1280.00MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    2216.75MiB
> 
> So if I understand properly it might be due to chunk being needed for
> balance/discard or scrub.
> Is there 3rd party tools which are also able to lock metadata block group as
> well? It seems to happens at the same time, when backup is running
> (spectrum), and/or HANA backup and/or ReaR backup as well.

If the 3rd party tools are triggering any of the btrfs maintenance
functions then they'll lock block groups; otherwise, normal filesystem
operations don't generally hold locks at the block group level.

There might be some additional issues with the 4.12 kernel that cause
it to allocate more than the minimum metadata.  I recall there were
some problems with old kernels where multiple threads allocating at
the same time will all grab their own chunks, but I'm not sure which
kernel those were fixed in.  There are also changes to the allocator's
behavior with the 'ssd' and 'nossd' mount options in 4.14 which might
cause these effects.

Some temporary overallocation is normal.  It's likely it would have
worked even without the overallocation, the overallocation has a pretty
large impact on these tiny filesystems.  This seems a bit higher than
the amount I've come to expect from modern btrfs.
