Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73093FB081
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 06:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhH3Eqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 00:46:46 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34764 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhH3Eqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 00:46:44 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 70231B5298E; Mon, 30 Aug 2021 00:45:50 -0400 (EDT)
Date:   Mon, 30 Aug 2021 00:45:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: It's broke, Jim. BTRFS mounted read only after corruption errors
 on Samsung 980 Pro
Message-ID: <20210830044550.GI29026@hungrycats.org>
References: <9070016.RUGz74dYir@ananda>
 <2069411.iu4ZIu9ccT@ananda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2069411.iu4ZIu9ccT@ananda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 10:17:33AM +0200, Martin Steigerwald wrote:
> Hi!
> 
> Martin Steigerwald - 22.08.21, 13:14:39 CEST:
> > This might be a sequel of:
> > 
> > Corruption errors on Samsung 980 Pro
> > 
> > https://lore.kernel.org/linux-btrfs/2729231.WZja5ltl65@ananda/
> > 
> > As the checksum errors I had gone away after clearing the v2 space
> > cache, I thought I can continue using this BTRFS filesystem. Maybe I
> > was wrong about that.
> 
> see: https://lore.kernel.org/linux-btrfs/9070016.RUGz74dYir@ananda/
> 
> I was broke again. *sigh*
> 
> Hardware and software same as before. Except: kernel 5.14-rc7. Oh and 
> one
> thing I did not mention before: I am using kyber as io scheduler for 
> that
> 2 TB Samsung 980 Pro SSD, not sure whether that matters.
> 
> Another kernel goes into unwillingness mode (see below) after resume 
> from
> hibernation. This time I scrubbed the home filesystem immediately. The 
> scrub
> was okay. Then I checked it and got:
> 
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> root 256 inode 144953 errors 200, dir isize wrong
> root 256 inode 3829720 errors 1, no inode item
> 	unresolved ref dir 144953 index 3646 namelen 36 name 
> agent_config_akonadi_imap_resource_8 filetype 1 errors 5, no dir item, no 
> inode ref
> 	unresolved ref dir 144953 index 3650 namelen 36 name 
> agent_config_akonadi_imap_resource_9 filetype 1 errors 5, no dir item, no 
> inode ref
> root 256 inode 3829724 errors 1, no inode item
> 	unresolved ref dir 144953 index 3654 namelen 36 name 
> agent_config_akonadi_imap_resource_7 filetype 1 errors 5, no dir item, no 
> inode ref
> root 256 inode 3829725 errors 1, no inode item
> 	unresolved ref dir 144953 index 3656 namelen 36 name 
> agent_config_akonadi_imap_resource_6 filetype 1 errors 5, no dir item, no 
> inode ref
> root 256 inode 3829727 errors 1, no inode item
> 	unresolved ref dir 144953 index 3657 namelen 41 name 
> agent_config_akonadi_imap_resource_9.lock filetype 1 errors 5, no dir 
> item, no inode ref
> root 256 inode 3829731 errors 1, no inode item
> 	unresolved ref dir 144953 index 3660 namelen 41 name 
> agent_config_akonadi_imap_resource_7.lock filetype 1 errors 5, no dir 
> item, no inode ref
> root 256 inode 3829733 errors 1, no inode item
> 	unresolved ref dir 144953 index 3663 namelen 41 name 
> agent_config_akonadi_imap_resource_6.lock filetype 1 errors 5, no dir 
> item, no inode ref
> root 256 inode 3829735 errors 1, no inode item
> 	unresolved ref dir 144953 index 3666 namelen 41 name 
> agent_config_akonadi_imap_resource_8.lock filetype 1 errors 5, no dir 
> item, no inode ref
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/nvme/home
> UUID: bbf23cc8-1a3e-44d1-b7a2-dd2ad1d6bbbf
> found 226030166016 bytes used, error(s) found
> total csum bytes: 218416176
> total tree bytes: 2366423040
> total fs tree bytes: 1832189952
> total extent tree bytes: 256720896
> btree space waste bytes: 372842673
> file data blocks allocated: 877801508864
>  referenced 236660666368
> 
> 
> Then I tried to repair it:
> 
> enabling repair mode
> WARNING:
> 
> 	Do not use --repair unless you are advised to do so by a 
> developer
> 	or an experienced user, and then only after having accepted that 
> no
> 	fsck can successfully repair all types of filesystem corruption. 
> Eg.
> 	some software or hardware bugs can fatally damage a volume.
> 	The operation will start in 10 seconds.
> 	Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> 
> Heh, I am experienced after repairing and fixing all these other issues I
> had recently, am I?
> 
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> Deleting bad dir index [144953,96,3646] root 256
> Deleting bad dir index [144953,96,3650] root 256
> Deleting bad dir index [144953,96,3654] root 256
> Deleting bad dir index [144953,96,3656] root 256
> Deleting bad dir index [144953,96,3657] root 256
> Deleting bad dir index [144953,96,3660] root 256
> Deleting bad dir index [144953,96,3663] root 256
> Deleting bad dir index [144953,96,3666] root 256
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> 
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/nvme/home
> UUID: bbf23cc8-1a3e-44d1-b7a2-dd2ad1d6bbbf
> No device size related problem found
> found 226030166016 bytes used, no error found
> total csum bytes: 218416176
> total tree bytes: 2366423040
> total fs tree bytes: 1832189952
> total extent tree bytes: 256720896
> btree space waste bytes: 372842673
> file data blocks allocated: 877801508864
>  referenced 236660666368
> 
> This appears to have worked. Another run of btrfs check reported no 
> errors.
> 
> Last time suspected XXHASH as the culprit, just a gut feeling. So I used
> the standard crc32c. Cause I did not think of it I initially used space 
> cache
> v1. But I switched it to space cache v2 I think yesterday.
> 
> Anyway it can't be xxhash cause crc32c also causes trouble.

Normally if the drive (or scheduler for that matter) was the problem,
you would get mostly parent transid verify failed and csum errors,
and every btrfs check error would be preceded by a csum verify failure.

This is not happening here, so the drive is probably fine (unless it's
corrupting the hibernation image, but you can verify that by enabling
hashes on the hibernation image).

> My current theory is this:
> 
> It happens that after resume from hibernation the kernel stops working
> correcly. A few seconds till maybe a minute or two after hibernation. I
> captured the backtraces in the log this time. See below.
> 
> There is some BTRFS backtrace, but it appears to be related to obtaining
> kernel memory, and then also a general protection fault. I saw general
> protection faults before already on this machine, but never anywhere 
> else.

That's a very bad sign.  If there are random GPFs, you'll need to take
the machine out of production until they are resolved.  Either something
is externally corrupting kernel RAM (like RAM failure or a firmware bug)
or there's a bug in the kernel that is corrupting kernel RAM (like a
use-after-free or hibernation code bug).

> My idea now is if the kernel crashes while BTRFS likes to write 
> something
> BTRFS might not be consistent afterwards. 

That isn't how btrfs works.  btrfs orders writes so that if the kernel
is operating correctly, but simply stops writing to the filesystem at
any time, no corruption occurs (the filesystem simply reverts to the
previously committed transaction) (assuming no raid5/6).

A _completely different_ scenario is that the kernel's memory is
corrupted, but the kernel does not stop immediately--it continues writing
to the filesystem, unaware of corruption, persisting bad data on disk.
If the kernel doesn't crash immediately, btrfs can complete transactions
with bad metadata.  In that case, btrfs (or any filesystem) will be
damaged, as will any data that machine touches.  The damage may not
be repairable as it will bypass or destroy filesystem data integrity
protections.

> I still think it shall survive
> a sudden interruption when writting data even if the cause for that is a
> kernel crash, but as Linux is a monolithic kernel, whatever has caused
> the kernel mal function may affect BTRFS as well.

It doesn't matter if the kernel is monolithic.  RAM is monolithic.
RAM corruption, however caused, can and will break everything in RAM,
whether it is kernel, userspace, or firmware.

> So what I will try next is to shutdown the machine after each day or 
> just
> keep it in standby and hope the battery will not take damage from it. In
> other words I will aim at avoiding hibernation. Its hard for me. I use 
> it
> on all of my laptops and now I have the fastest laptop I ever had so 
> far,
> but I cannot seem to use it reliably anymore. The faster the laptop, the
> faster it crashes if it does, so to say.
> 
> Any other ideas, theories, hints?

Start a memory tester running (e.g. 'memtester' or '7z b 9999 -md=xxM'
where xx is large enough to allocate most of the free RAM), do hibernation
and resume, and see if the memory tester reports failure after resume.

If so, you have firmware data integrity issues, or there is a bug in
the hibernation code.

Use suspend-to-RAM as a workaround (unless that corrupts memory too).
