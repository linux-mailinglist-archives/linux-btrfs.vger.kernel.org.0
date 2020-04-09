Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA381A3CBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgDIXHZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 9 Apr 2020 19:07:25 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42656 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDIXHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 19:07:25 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3AF90661176; Thu,  9 Apr 2020 19:07:25 -0400 (EDT)
Date:   Thu, 9 Apr 2020 19:07:25 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kjansen387 <kjansen387@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs freezing on writes
Message-ID: <20200409230724.GM2693@hungrycats.org>
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org>
 <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 09, 2020 at 11:53:00PM +0200, kjansen387 wrote:
> Hi Zygo,
> 
> Thanks for your reply!
> 
> > Try 'btrfs fi usage /export'.
> I'm removing /dev/sdd at the moment, my usage now (metadata usage was the
> same a few weeks back):
> 
> # btrfs fi usage /export
> Overall:
>     Device size:                  10.92TiB
>     Device allocated:              7.58TiB
>     Device unallocated:            3.34TiB
>     Device missing:                  0.00B
>     Used:                          7.45TiB
>     Free (estimated):              1.73TiB      (min: 1.73TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,RAID1: Size:3.78TiB, Used:3.72TiB (98.35%)
>    /dev/sde        2.53TiB
>    /dev/sdf        2.52TiB
>    /dev/sdb      869.00GiB
>    /dev/sdc      868.00GiB
>    /dev/sdd      838.00GiB
> 
> Metadata,RAID1: Size:6.00GiB, Used:5.18GiB (86.40%)
>    /dev/sde        4.00GiB
>    /dev/sdf        5.00GiB
>    /dev/sdb        1.00GiB
>    /dev/sdc        1.00GiB
>    /dev/sdd        1.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:592.00KiB (1.81%)
>    /dev/sdc       32.00MiB
>    /dev/sdd       32.00MiB
> 
> Unallocated:
>    /dev/sde        1.11TiB
>    /dev/sdf        1.11TiB
>    /dev/sdb      993.02GiB
>    /dev/sdc      993.99GiB
>    /dev/sdd     -839.03GiB
> 
> 
> What this suggests to me is that I don't have 5GB metadata - I have 12GB ?

It's RAID1, so there are 2 sets of 6x 1 GB block groups.  Each block
group consists of a mirrored pair of 1GB chunks on 2 different disks.

They are not all on sde and sdf as I had guessed before.  The worst case
would be that 4GB are mirrored between sde and sdf, then 1GB between
sdc and sdd, and 1GB between sdf and sdb (i.e. sdf has 4GB mirrored with
sde and 1GB mirrored with sdb for a total of 5GB on sdf), but certainly
other combinations are possible to arrive at those numbers.

"Metadata,RAID1: Size:6.00GiB, Used:5.18GiB" is referring to logical
sizes--you have 6 logical GB allocted for 5.18 logical GB of
metadata--while the lines that follow are referring to physical sizes
on each disk (a total of 12 GB allocated on all disks).

You'll notice system and data follow the same pattern.

> > 	btrfs fi resize 1:-4g /export;
> > 	btrfs fi resize 2:-4g /export;
> > 	btrfs balance start -mdevid=1 /export;
> > 	btrfs fi resize 1:max /export;
> > 	btrfs fi resize 2:max /export;
> 
> I'm moving from 5 to 4 disks for the time being, assuming metadata stays the
> same I guess I'd have to aim for 3GB metadata per disk. Do I have to change
> the commands like this ?
> 
> btrfs fi resize 1:-1g /export;           # Assuming 4GB metadata
> btrfs fi resize 2:-2g /export;           # Assuming 5GB metadata

Based on current data, yes; however, it's possible that the device remove
you are already running might balance the metadata as a side-effect.
Redo the math with the values you get after the device remove is done.
You may not need to balance anything.

> btrfs balance start -mdevid=1 /export;   # Why only devid 1, and not 2 ?

We want balance to relocate metadata block groups that are on both
devids 1 and 2, i.e. the BG has a chunk on both drives at the same time.
Balance filters only allow one devid to be specified, but in this case
'devid=1' or 'devid=2' is close enough.  All we want to do here is filter
out block groups where one mirror chunk is already on devid 3, 4, or 5,
since that would just place the metadata somewhere else on the same disks.

> btrfs fi resize 1:max /export;
> btrfs fi resize 2:max /export;
> 
> Thanks!
> 
> 
