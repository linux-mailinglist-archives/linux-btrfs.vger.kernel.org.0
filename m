Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34C23FD189
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 04:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhIACxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 22:53:09 -0400
Received: from omta012.uswest2.a.cloudfilter.net ([35.164.127.235]:50168 "EHLO
        omta012.uswest2.a.cloudfilter.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241782AbhIACxI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 22:53:08 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 22:53:08 EDT
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.145])
        by cmsmtp with ESMTP
        id KyQdmVig6eXrBLGFMmrwjB; Wed, 01 Sep 2021 02:45:04 +0000
Received: from ws ([24.255.45.226])
        by cmsmtp with ESMTPSA
        id LGFJmLsNRwez0LGFLmlSUZ; Wed, 01 Sep 2021 02:45:04 +0000
Authentication-Results: cox.net; auth=pass (LOGIN)
 smtp.auth=1i5t5.duncan@cox.net
X-Authority-Analysis: v=2.4 cv=D8Ikltdj c=1 sm=1 tr=0 ts=612ee930
 a=rsvNbDP3XdDalhZof1p64w==:117 a=rsvNbDP3XdDalhZof1p64w==:17
 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=oMBDMDRiGzW92iJXmS0A:9 a=CjuIK1q_8ugA:10
 a=AjGcO6oz07-iQ99wixmX:22
Date:   Tue, 31 Aug 2021 19:45:01 -0700
From:   Duncan <1i5t5.duncan@cox.net>
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption
 errors
Message-ID: <20210831194501.175dadf1@ws>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNcoIYdOaA9IKLNsBzpCcLE4uTfZ0C+IM1A66mZE0m3vfe5hDGpdTIeUgqE+SQTdrC6sqqwfUFlLB4BvutD0bUnXacvj6n7Dvct4sfBibKXG7kWn/TOB
 +c0psh0GBsX9uZcIo8l7+Lfm6DltP7Mva51ZZObg8sg/fTgUi0PWRWpc6oRPhkdIKKLkbq1oCTX2xOqJKdlHaiM0lo4Wx1mk3wI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Steigerwald posted on Sun, 22 Aug 2021 13:14:39 +0200 as
excerpted:

> This might be a sequel of:
> 
> Corruption errors on Samsung 980 Pro
> 
> https://lore.kernel.org/linux-btrfs/2729231.WZja5ltl65@ananda/

I saw on the previous thread some discussion of trim/discard but lost 
track of whether you're still trying to enable it in the mount options
or not.

I'd suggest *NOT* enabling trim/discard on any samsung SSDs unless you 
are extremely confident that it is well tested and known to work on
your particular model, because...

I have a samsung 850 evo and did some earlier research on trim/discard 
for it.

What I found was that at least for earlier samsung ssds, queued-trim
had been found not to work safely, with a number of bugs filed over the 
years, resulting in samsung ssds (and a few others) being queued-trim-
blacklisted in the kernel.  Back when I did my research at least, the 
blacklist was for all samsung ssd models, with the problem being that 
they claimed sata 3.1 compliance which requires queued-trim, but they 
didn't actually handle it as a queued command.  When it's not queued
the queued command stream must be flushed before a discard, with the
discard and then another flush issued to ensure proper write order,
before queued command stream can be resumed.

In theory the black-listing should mean the kernel does the right thing 
and it's simply slower, but then it's slower, so not enabling the
discard mount option is probably a good idea anyway.

Now it's quite possible that your newer 980 pro model handles
queued-trim properly, but it's also possible that it still doesn't,
while the kernel blacklist might have been updated assuming it does, or
that the blacklist isn't applying for some reason. And given that you're
seeing problems, probably better safe than sorry. I'd leave discard
disabled.

Another consideration for btrfs is the older root-blocks that are not 
normally immediately overwritten, that thus remain available to use for 
repair/recovery should that be necessary.   Because they're technically 
no longer in use the discard mount option clears these along with other 
unused blocks, so they're no longer an option for repair/recover. =:^(

The alternative (beyond possibly deliberately leaving some unpartitioned
free-space for the ssd wear-leveling algorithm to work with, in
addition to the unreported space it already reserves for that
purpose) is fstrim.

At least on my systemd-option gentoo, there's a weekly fstrim scheduled 
(see fstrim.service and fstrim.timer, owned by the util-linux package), 
tho I don't recall whether I had to enable it or whether it was enabled 
automatically.

Tho it's worth noting that the default fstrim.service apparently (based 
on my logs) only trims filesystems mounted read-write when it runs.  I 
have several filesystems not mounted by default (backups and /boot 
mostly), and my / is mounted read-only by default, and they don't get 
fstrimmed.  But the backups tend to be mkfs.btrfs, mount, backup, 
unmount, with few or no writes after the backup, and mkfs.btrfs already 
does a trim to clear the partition before it does the mkfs, so there's 
little to trim there.  / and /boot get more writes, but /boot is
sub-GiB and / is only 8 GiB, trivial when I've several hundred GiB of
the 1 TB ssd entirely unpartitioned for the ssd firmware to wear-level
with, so I'm not too worried.  But it's something to be aware of and to
consider modifying the scheduled commandline if necessary for your
use-case.

Something else I used to wonder about was whether fstrim handled all 
devices on a multi-device btrfs, or just the specific device that it
was pointed at (that mount said was mounted in the case of the
automatic runs).  But while the log only indicates the one device
fstrimmed, the reported space trimmed is the free space of the entire
filesystem, pair-device btrfs raid1 for most of my btrfs, with double
the free space of the one device reported as trimmed, so it does appear
to trim the free space on all devices of the filesystem despite only
listing one in the log.

As for backup root-blocks, fstrim will still clear those too, but since 
it's running just once a week, on filesystems with any routine writes
at all, the window in which there's not at least a couple backup
root-blocks available is going to be reasonably small, likely to be
considered worth the trivial incremental risk for anyone following the
sysadmin's rule that the value of the data is defined by the number
(and freshness) of backups of said data it's considered valuable enough
to have.  And for filesystems without a lot of writes that's less risk
of damage during any potential crash within that window anyway, so
again, worth the trivial incremental risk, especially compared to that
of using the discard mount option.

-- 
Duncan - No HTML messages please; they are filtered as spam.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
