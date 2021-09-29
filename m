Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF03E41CB21
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbhI2Rij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 13:38:39 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48764 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhI2Rij (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 13:38:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B172FB9AE4D; Wed, 29 Sep 2021 13:33:13 -0400 (EDT)
Date:   Wed, 29 Sep 2021 13:31:36 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Brandon Heisner <brandonh@wolfram.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
Message-ID: <20210929173055.GO29026@hungrycats.org>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 09:23:01PM -0500, Brandon Heisner wrote:
> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP
> Fri Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is

That is a really old kernel.  I recall there were some anomalous
metadata allocation behaviors with kernels of that age, e.g. running
scrub and balance at the same time would allocate a lot of metadata
because scrub would lock a metadata block group immediately after
it had been allocated, forcing another metadata block group to be
allocated immediately.  The symptom of that bug is very similar to
yours--without warning, hundreds of GB of metadata block groups are
allocated, all empty, during a scrub or balance operation.

Unfortunately I don't have a better solution than "upgrade to a newer
kernel", as that particular bug was solved years ago (along with
hundreds of others).

> version locked to that kernel.  The metadata has reserved a full
> 1T of disk space, while only using ~38G.  I've tried to balance the
> metadata to reclaim that so it can be used for data, but it doesn't
> work and gives no errors.  It just says it balanced the chunks but the
> size doesn't change.  The metadata total is still growing as well,
> as it used to be 1.04 and now it is 1.08 with only about 10G more
> of metadata used.  I've tried doing balances up to 70 or 80 musage I
> think, and the total metadata does not decrease.  I've done so many
> attempts at balancing, I've probably tried to move 300 chunks or more.
> None have resulted in any change to the metadata total like they do
> on other servers running btrfs.  I first started with very low musage,
> like 10 and then increased it by 10 to try to see if that would balance
> any chunks out, but with no success.

Have you tried rebooting?  The block groups may be stuck in a locked
state in memory or pinned by pending discard requests, in which case
balance won't touch them.  For that matter, try turning off discard
(it's usually better to run fstrim once a day anyway, and not use
the discard mount option).

> # /sbin/btrfs balance start -musage=60 -mlimit=30 /opt/zimbra
> Done, had to relocate 30 out of 2127 chunks
> 
> I can do that command over and over again, or increase the mlimit,
> and it doesn't change the metadata total ever.

I would use just -m here (no filters, only metadata).  If it gets the
allocation under control, run 'btrfs balance cancel'; if it doesn't,
let it run all the way to the end.  Each balance starts from the last
block group, so you are effectively restarting balance to process the
same 30 block groups over and over here.

> # btrfs fi show /opt/zimbra/
> Label: 'Data'  uuid: ece150db-5817-4704-9e84-80f7d8a3b1da
>         Total devices 4 FS bytes used 1.48TiB
>         devid    1 size 1.46TiB used 1.38TiB path /dev/sde
>         devid    2 size 1.46TiB used 1.38TiB path /dev/sdf
>         devid    3 size 1.46TiB used 1.38TiB path /dev/sdg
>         devid    4 size 1.46TiB used 1.38TiB path /dev/sdh
> 
> # btrfs fi df /opt/zimbra/
> Data, RAID10: total=1.69TiB, used=1.45TiB
> System, RAID10: total=64.00MiB, used=640.00KiB
> Metadata, RAID10: total=1.08TiB, used=37.69GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # btrfs fi us /opt/zimbra/ -T
> Overall:
>     Device size:                   5.82TiB
>     Device allocated:              5.54TiB
>     Device unallocated:          291.54GiB
>     Device missing:                  0.00B
>     Used:                          2.96TiB
>     Free (estimated):            396.36GiB      (min: 396.36GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
>             Data      Metadata  System
> Id Path     RAID10    RAID10    RAID10    Unallocated
> -- -------- --------- --------- --------- -----------
>  1 /dev/sde 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  2 /dev/sdf 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  3 /dev/sdg 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  4 /dev/sdh 432.75GiB 276.00GiB  16.00MiB   781.65GiB
> -- -------- --------- --------- --------- -----------
>    Total      1.69TiB   1.08TiB  64.00MiB     3.05TiB
>    Used       1.45TiB  37.69GiB 640.00KiB
> 
> 
> 
> 
> 
> 
> -- 
> Brandon Heisner
> System Administrator
> Wolfram Research
