Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD61A53A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Apr 2020 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDKUVf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 11 Apr 2020 16:21:35 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40700 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgDKUVe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 16:21:34 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9AEA366510F; Sat, 11 Apr 2020 16:21:34 -0400 (EDT)
Date:   Sat, 11 Apr 2020 16:21:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kjansen387 <kjansen387@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs freezing on writes
Message-ID: <20200411202134.GN2693@hungrycats.org>
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org>
 <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
 <20200409230724.GM2693@hungrycats.org>
 <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 11, 2020 at 09:46:43PM +0200, kjansen387 wrote:
> I have tried to rebalance metadata..
> 
> Starting point:
> # btrfs fi usage /storage
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.45TiB
>     Device unallocated:            3.47TiB
>     Device missing:                  0.00B
>     Used:                          7.35TiB
>     Free (estimated):              1.78TiB      (min: 1.78TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,RAID1: Size:3.72TiB, Used:3.67TiB (98.74%)
>    /dev/sdc        2.81TiB
>    /dev/sdb        2.81TiB
>    /dev/sda     1017.00GiB
>    /dev/sdd      840.00GiB
> 
> Metadata,RAID1: Size:6.00GiB, Used:5.09GiB (84.86%)
>    /dev/sdc        3.00GiB
>    /dev/sdb        3.00GiB
>    /dev/sda        1.00GiB
>    /dev/sdd        5.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:608.00KiB (1.86%)
>    /dev/sdb       32.00MiB
>    /dev/sdd       32.00MiB
> 
> Unallocated:
>    /dev/sdc      845.02GiB
>    /dev/sdb      845.99GiB
>    /dev/sda      845.02GiB
>    /dev/sdd     1017.99GiB
>
> I did:
> # btrfs fi resize 4:-2g /storage/
> # btrfs balance start -mdevid=4 /storage
> # btrfs fi resize 4:max /storage/
> 
> but the distribution of metadata ended up like before.
> 
> I also tried (to match the free space of the other disks):
> # btrfs fi resize 4:-172g /storage/
> # btrfs balance start -mdevid=4 /storage
> # btrfs fi resize 4:max /storage/
> 
> again, the distribution of metadata ended up like before..
> 
> Any other tips to rebalance metadata ?

The purpose of resize -2g was to make a little less unallocated space
on one drive compared to all the others, starting with all the drives
having equal unallocated space.  The purpose of resize -172g was to
make the extra unallocated space on sdd go away, so it would be equal to
the other 3 drives.  You have to do _both_ of those before the balance.
Or just add the two numbers, i.e. resize -174g.

If you really want to be sure, resize by -200g (far more than necessary),
then balance start -mlimit=4,devid=4.  The balance is "I know there are
exactly 5 block groups now, and I want to leave exactly one behind,"
and the resize is "I want no possibility of new block groups on sdd for
some time."

> On 10-Apr-20 01:07, Zygo Blaxell wrote:
> > On Thu, Apr 09, 2020 at 11:53:00PM +0200, kjansen387 wrote:
> > > btrfs fi resize 1:-1g /export;           # Assuming 4GB metadata
> > > btrfs fi resize 2:-2g /export;           # Assuming 5GB metadata
> > 
> > Based on current data, yes; however, it's possible that the device remove
> > you are already running might balance the metadata as a side-effect.
> > Redo the math with the values you get after the device remove is done.
> > You may not need to balance anything.
> > 
> > > btrfs balance start -mdevid=1 /export;   # Why only devid 1, and not 2 ?
> > 
> > We want balance to relocate metadata block groups that are on both
> > devids 1 and 2, i.e. the BG has a chunk on both drives at the same time.
> > Balance filters only allow one devid to be specified, but in this case
> > 'devid=1' or 'devid=2' is close enough.  All we want to do here is filter
> > out block groups where one mirror chunk is already on devid 3, 4, or 5,
> > since that would just place the metadata somewhere else on the same disks.
> > 
> > > btrfs fi resize 1:max /export;
> > > btrfs fi resize 2:max /export;
> > > 
> > > Thanks!
> > > 
> > > 
> 
