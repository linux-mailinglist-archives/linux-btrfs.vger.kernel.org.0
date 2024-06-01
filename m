Return-Path: <linux-btrfs+bounces-5382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0368D6DAE
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 05:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065601C21668
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2024 03:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7AAD4B;
	Sat,  1 Jun 2024 03:24:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAE2594
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Jun 2024 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717212299; cv=none; b=fkgkGHDXlOVMIg6l6MgVXJ5GQoFE2Mr8O1QfS+DelESdahdRdJKx6MTvOhQCdcoaugfIfW25uBi+7VJrlW8BWcQ+X9pZIjusqu7hAexZokxZF/iUNM6xBDaiPGG4zdTzLTnx3KXmO+Wml2u5iGL2rWKu12muQi6K2g0DTRebNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717212299; c=relaxed/simple;
	bh=KxQX8+chqnJyNi+oHgYz6/pOP/TsXsaLs5rcocmg5tY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uk1Pjux2F5N7m45sJAh/hDR3hpLKIh1l/WrHA2DNkR9C4EWQiMqbEfUr2mplidnIJvuId60HiZ0tqgfT6hzhvU1Bjj4nY1UM0SkQ2daydMxqz8FCzTHn53BNv3fIIDtUNaC5jbDYXS8oPqZJadDsFBeNUFyny7EDWeqp5Bliy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 50B1BE236F2; Fri, 31 May 2024 23:24:43 -0400 (EDT)
Date: Fri, 31 May 2024 23:24:43 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: linux-btrfs@vger.kernel.org
Subject: raid5 silent data loss in 6.2 and later, after "7a3150723061 btrfs:
 raid56: do data csum verification during RMW cycle"
Message-ID: <ZlqUe+U9hJ87jJiq@hungrycats.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is a new silent data loss bug in kernel 6.2 and later.
The requirements for the bug are:

	1.  6.2 or later kernel
	2.  raid5 data in the filesystem
	3.  one device severely corrupted
	4.  some free space fragmentation to trigger a lot of rmw cycles

I first discovered this bug after a `pvmove` went badly wrong and wiped
out 70% of one data LV of a btrfs raid5 filesystem.  I figured out a
recipe for reproducing the bug on a test VM (below), and a possible
approach for a fix.

Bug insertion
-------------

The bug is introduced in this commit:

	7a3150723061 btrfs: raid56: do data csum verification during RMW cycle

This commit fixes a long-standing btrfs raid5 bug which mishandled cases
where a raid5 stripe contains corrupted data in some blocks while new data
is written to other blocks in the same stripe.  This older bug resulted
in existing correct data becoming corrupted when new data is written to
the filesystem.  EIO and csum failures would occur later when reading
affected blocks, i.e. the errors were detectable.

Bug effect
----------

The change fixes the old bug, but also introduces two new behaviors that
are potentially worse:

1.  New writes are now silently dropped.  After `sync` and `sysctl
vm.drop_caches=3`, recently written extents are missing from the files,
as if they were never written by the application.  Instead, there is a
hole in the file, or a truncated file.  There is no indication that this
has occurred other than the missing data:  no dmesg messages, no errors
reported to applications at write time.  The data can be read back from
the filesystem while it is still in page cache, which can delay detection
of the failure until after the data is evicted from cache.

2.  `fsync` (system call) and `sync -f` (shell command) sometimes
return EIO.  In this situation, devices are online, metadata is intact,
all corruption is located on a single device and is recoverable, so no
writes should ever be failing, but they apparently do.  This also affects
internal btrfs maintenance operations like balance, which aborts with
an IO failure when triggering the bug.

Reverting the commit 7a3150723061 on 6.2.16 restores the old behavior:
no silent data loss on new writes, only the old detectable data corruption
on existing data occurs.  It seems we can't have nice things.


Analysis
--------

In the commit, I notice that when reading the rmw stripe, any blocks with
csum errors are flagged in rbio->error_bitmap, but nothing ever clears
those error bits once they are set.  Contrast with the scrub repair code,
which clears out the entire rbio->error_bitmap vector after repairing
the stripe.  The old code didn't set any error_bitmap bits during rmw,
and not much else has changed in this commit, which makes the new set_bit
calls a good candidate for root cause.

I tried some experiments:

	- clear the error_bits individually after setting uptodate = 1
	  (still has problems: after verifying the recovered csum,
	   failed reconstruction would leave error bits set, so writes
	   to the stripe that should not fail will fail)

	- clear the entire error_bits vector after successful repair_sectors
	  (might cause corruption if some reconstruction fails and later
	   reads use data from the stripe without verifying the csum again)

	- remove the new set_bit() call added in the above commit
	  (breaks repair but fixes EIO and dropped writes)

For the first two I didn't have much success.  I'm pretty sure I don't
know how to calculate the error_bit index correctly, so my first attempt
didn't have any effect on the test.  I get a lot of UAF crashes if I clear
the entire vector in the second test--I suspect it needs some protection
from concurrent access that I'm missing.

My third experiment breaks the error recovery code, but it does prevent
the sync failures and missing extent holes, so it shows that the error
recovery code itself is not what is causing the dropped writes--it's
the bits left set in error_bitmap after recovery is done.


Test Case
---------

My test case uses three loops running in parallel on a 500 GiB test filesystem:

		    Data      Metadata System
	Id Path     RAID5     RAID1    RAID1    Unallocated Total     Slack
	-- -------- --------- -------- -------- ----------- --------- --------
	 1 /dev/vdb  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB 19.59GiB
	 2 /dev/vdc  71.00GiB  1.00GiB  8.00MiB   647.99GiB 720.00GiB  3.71GiB
	 3 /dev/vdd  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB  3.71GiB
	 4 /dev/vde  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
	 5 /dev/vdf  71.00GiB  2.00GiB        -   647.00GiB 720.00GiB 11.00GiB
	-- -------- --------- -------- -------- ----------- --------- --------
	   Total    284.00GiB  4.00GiB  8.00MiB     3.16TiB   3.52TiB 49.02GiB
	   Used     262.97GiB  2.61GiB 64.00KiB

The data is a random collection of small files, half of which have been deleted
to make lots of small free space holes for rmw.

Loop 1 alternates between corrupting device 3 and repairing it with scrub:

	while true; do
		# Any big file will do, usually faster than /dev/random
		# Skipping the first 1M leaves the superblock intact
		while cat vmlinux; do :; done | dd of=/dev/vdd bs=1024k seek=1
		# This should fix all the corruption as long as there are no
		# reads or writes anywhere on the filesystem
		btrfs scrub start -Bd /dev/vdd
	done

Loop 2 runs `sync -f` to detect sync errors and drops caches:

	while true; do
		# Sometimes throws EIO
		sync -f /testfs
		sysctl vm.drop_caches=3
		sleep 9
	done

Loop 3 does some random git activity on a clone of the 'btrfs-progs'
repo to detect lost writes at the application level:

	while true; do
		cd /testfs/btrfs-progs
		# Sometimes fails complaining about various files being corrupted
		find * -type f -print | unsort -r | while read -r x; do
			date >> "$x"
			git commit -am"Modifying $x"
		done
		git repack -a
	done

The errors occur on the sync -f and various git commands, e.g.:

	sync: error syncing '/media/testfs/': Input/output error
	vm.drop_caches = 3

	error: object file .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5 is empty
	fatal: loose object 39c876ad9b9af9f5410246d9a3d6bbc331677ee5 (stored in .git/objects/39/c876ad9b9af9f5410246d9a3d6bbc331677ee5) is corrupt

