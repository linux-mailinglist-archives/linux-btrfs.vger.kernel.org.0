Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763DA4552F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 03:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhKRDAq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 22:00:46 -0500
Received: from scadrial.mjdsystems.ca ([192.99.73.14]:38189 "EHLO
        scadrial.mjdsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbhKRDAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 22:00:45 -0500
Received: from cwmtaff.localnet (unknown [IPv6:2607:f2c0:ed80:400:123d:1cff:feaf:8fb1])
        by scadrial.mjdsystems.ca (Postfix) with ESMTPSA id 2FF02820253F;
        Wed, 17 Nov 2021 21:57:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed; d=mjdsystems.ca;
        s=202010; t=1637204264;
        bh=srDW2I3wuiFxVgrY+ZjnlVBFSr19OWZp/g/7psKrf40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmtRKHmui3+Q5JbiXmcgeMlQaWNmxr85mKIadTNBU8JSbWgPZN2szhwe+87sr4Lqn
         wfzxhTAHaIUPHsVCwu/mseoEXjuNTvnE+JMh1rcSgDymkIOwL2/ZZKyHtIRfxM44V2
         EUXSvJwPCZmXxli4ztVHUxKt7zqqDQ5Dsmvdw+NYr9I6t1SMRpsED4dIxSgEd4ksi7
         8gtlvy9QYsw9+H40TTWTWlZ4ikAjs0wOD8w0buQXMsi4+RmnccbpNHXda45a4bWC2X
         XkPXbrQglu1QquQpm41E35Nbt3mldIy7jci/gRiddnqneqtdo09qpSy0/e1uVCABjQ
         yKZLybpYfo7BtXX7Xxt0EBc0GavGMW22T7kzRHcVXvDN1rFm+prDt5k2GWyFbnzOme
         2fmCOI9Oes82bh/ZZeO1xiXAmX6zf/9F/nYKAqQJrjwAHJin4bfXLqAah9ys2HcyjF
         VQHh198GDPYRT7oHcMtdTQJFhhg2LJOBRUQeS9Iu0CqCWn3bHoPq31HrjbdScH6A+m
         yfBsVynHvb0tBN0Xkc11nqjXrbNQpuw0r4Gi1bQnOKoC0bcWecYc8vCKou0gvDSnAL
         ap9hkuEOpl8n2hPcefUOUSw+6vOjFh+hyVKycQvfxm4Cy7qkN7lrs4qTToE9wHpVL0
         6sSDv6siq51XwPAXMZZItl8s=
From:   Matthew Dawson <matthew@mjdsystems.ca>
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Help recovering filesystem (if possible)
Date:   Wed, 17 Nov 2021 21:57:40 -0500
Message-ID: <3321185.LZWGnKmheA@cwmtaff>
In-Reply-To: <CAMthOuMxvff2d0THhKWCpErQFumrJA9vmNqS6vtBNDwUwf3j-w@mail.gmail.com>
References: <2586108.vuYhMxLoTh@cwmtaff> <CAMthOuMxvff2d0THhKWCpErQFumrJA9vmNqS6vtBNDwUwf3j-w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Monday, November 15, 2021 5:46:43 A.M. EST Kai Krakow wrote:
> Am Mo., 15. Nov. 2021 um 02:55 Uhr schrieb Matthew Dawson
> 
> <matthew@mjdsystems.ca>:
> > I recently upgrade one of my machines to the 5.15.2 kernel.  on the first
> > reboot, I had a kernel fault during the initialization (I didn't get to
> > capture the printed stack trace, but I'm 99% sure it did not have BTRFS
> > related calls).  I then rebooted the machine back to a 5.14 kernel, but
> > the
> > BCache (writeback) cache was corrupted.  I then force started the
> > underlying disks, but now my BTRFS filesystem will no longer mount.  I
> > realize there may be missing/corrupted data, but I would like to ideally
> > get any data I can off the disks.
> 
> I had a similar issue lately where the system didn't reboot cleanly
> (there's some issue in the BIOS or with the SSD firmware where it
> would disconnect the SSD from SATA a few seconds after boot, forcing
> bcache into detaching dirty caches).
> 
> Since you are seeing transaction IDs lacking behind expectations, I
> think you've lost dirty writeback data from bcache. Do fix this in the
> future, you should use bcache only in writearound or writethrough
> mode.
Considering I started the bcache devices without the cache, I don't doubt I've 
lost writeback data and I have no doubts there will be issues.  At this point 
I'm just in data recovery, trying to get what I can.

> 
> > This system involves 10 8TB disk, some are doing BCache -> LUKS -> BTRFS,
> > some are doing LUKS -> BTRFS.
> 
> Not LUKS here, and all my btrfs pool members are attached to a single
> SSD as caching frontend.
> 
> > When I try to mount the filesystem, I get the following in dmesg:
> > [117632.798339] BTRFS info (device dm-0): flagging fs with big metadata
> > feature [117632.798344] BTRFS info (device dm-0): disk space caching is
> > enabled [117632.798346] BTRFS info (device dm-0): has skinny extents
> > [117632.873186] BTRFS error (device dm-0): parent transid verify failed on
> > 132806584614912 wanted 3240123 found 3240119
> 
> I had luck with the following steps:
> 
> * ensure that all members are attached to bcache as they should
> * ensure bcache is running in writearound mode for each member
> * ensure that btrfs did scan for all members
> 
> Next, I started `btrfs check` for each member disk, eventually one
> would contain the needed disk structures and only showed a few errors.
> 
> I was then able to mount btrfs through that device node, open ctree
> didn't fail this time. I don't remember if I used "usebackuproot" for
> mount or a similar switch for "btrfs check".
> 
> I then ran `btrfs scrub` which fixed the broken metadata. Luckily, I
> had only metadata corruption on the disks which had dirty writeback
> cleared, and metadata runs in RAID-1 mode for me.
> 
> "btrfs check" then didn't find any errors. Reboot worked fine.
Thanks for the suggestion.  Unfortunately, all my disks report basically the 
same errors, so I wasn't able to recover my system this way.

> 
> [...]
> 
> > Is there any hope in recovering this data?  Or should I give up on it at
> > this point and reformat?  Most of the data is backed up (or are backups
> > themselves), but I'd like to get what I can.
> 
> Well, I'm doing daily backups with borg - to a different technology
> (no btrfs, no bcache, different system). I don't think backing up
> btrfs to btrfs is a brilliant idea, especially not when both are
> mounted to the same system.
I'm not quite that redundant, but the backups of things I really care about 
are actually to an off-site system.  But accessing data through a backup can be 
painful compared to hopefully just getting it out.  Also the local backups on 
the system would be nice to have, for historical purposes.

> 
> You may try my steps above. If you've found a member device which
> shows fewer errors, you COULD try to repair it if mount still fails
> (or try one of the recovery mount options). But you may want to ask
> the experts again here.
I did try, thanks.  Unfortunately as noted above it wasn't helpful.

Hopefully someone has a different idea?  I am posting here because I feel any 
luck is going to start using more dangerous options and those usually say to 
ask the mailing list first.

> 
> Depending on how much dirty writeback you've lost in bcache, chances
> may be good that one of the members has enough metadata to
> successfully mount or repair the filesystem. Or at least, it's a good
> start for "btrfs restore" then.
> 
> What do we learn from this?
> 
> * probably do not use bcache in writeback mode if you can avoid it
> * switch bcache to writearound mode before kernel upgrades, wait for
> writeback to finish
> * success mounting btrfs may depend a lot on which member device you
> actually mount

Thanks,
-- 
Matthew


