Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DF20BDEA
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgF0DYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 23:24:16 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46280 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgF0DYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 23:24:16 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0DB527359A3; Fri, 26 Jun 2020 23:24:14 -0400 (EDT)
Date:   Fri, 26 Jun 2020 23:24:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: How to use btrfs raid5 successfully(ish)
Message-ID: <20200627032414.GX10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are some guidelines for users running btrfs raid5 arrays to
survive single-disk failures without losing all the data.  Tested with
kernel 5.4.41.

This list is intended for users.  The developer version of
this list (with references to detailed bug descriptions) is
https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/

Most of this advice applies to raid6 as well.  btrfs raid5 is in such
rough shape that I'm not bothering to test raid6 yet.

	- never use raid5 for metadata.

Use raid1 for metadata (raid1c3 for raid6).  raid5 metadata is vulnerable
to multiple known bugs that can each prevent successful recovery from
disk failure or cause unrecoverable filesystem damage.

	- run scrubs often.

Scrub can repair corrupted data before it is permanently lost.  Ordinary
read and write operations on btrfs raid5 are not able to repair disk
corruption in some cases.

	- run scrubs on one disk at a time.

btrfs scrub is designed for mirrored and striped arrays.  'btrfs scrub'
runs one kernel thread per disk, and that thread reads (and, when
errors are detected and repair is possible, writes) to a single disk
independently of all other disks.  When 'btrfs scrub' is used for a raid5
array, it still runs a thread for each disk, but each thread reads data
blocks from all disks in order to compute parity.  This is a performance
disaster, as every disk is read and written competitively by each thread.

To avoid these problems, run 'btrfs scrub start -B /dev/xxx' for each
disk sequentially in the btrfs array, instead of 'btrfs scrub stat
/mountpoint/filesystem'.  This will run much faster.

        - ignore spurious IO errors on reads while the filesystem is
        degraded.

Due to a bug, the filesystem will report random spurious IO errors and
csum failures on reads in raid5 degraded mode where no errors exist
on disk.  This affects normal read operations, btrfs balance, and device
remove, but not 'btrfs replace'.  Such errors should be ignored until
'btrfs replace' completes.

This bug does not appear to affect writes, but it will make some data
that was recently written unreadable until the array exits degraded mode.

	- device remove and balance will not be usable in degraded mode.

'device remove' and balance won't harm anything in degraded mode, but
they will abort frequently due to the random spurious IO errors.

	- when a disk fails, use 'btrfs replace' to replace it.

'btrfs replace' is currently the only reliable way to get a btrfs raid5
out of degraded mode.

If you plan to use spare drives, do not add them to the filesystem before
a disk failure.  You may not able to redistribute data from missing
disks over existing disks with device remove.  Keep spare disks empty
and activate them using 'btrfs replace' as active disks fail.

	- plan for the filesystem to be unusable during recovery.

There is currently no solution for reliable operation of applications
using a filesystem with raid5 data during a disk failure.  Data storage
works to the extent I have been able to test it, but data retrieval is
unreliable due to the spurious read error bug.

Shut down any applications using the filesystem at the time of disk
failure, and keep them down until the failed disk is fully replaced.

	- be prepared to reboot multiple times during disk replacement.

'btrfs replace' has some minor bugs that don't impact data, but do force
kernel reboots due to hangs and stuck status flags.  Replace will restart
automatically after a reboot when the filesystem is mounted again.

        - spurious IO errors and csum failures will disappear when
	the filesystem is no longer in degraded mode, leaving only
	real IO errors and csum failures.

Any read errors after btrfs replace is done (and maybe after an extra
reboot to be sure replace is really done) are real data loss.  Sorry.

	- btrfs raid5 does not provide as complete protection against
	on-disk data corruption as btrfs raid1 does.

When data corruption is present on disks (e.g. when a disk is temporarily
disconnected and then reconnected), bugs in btrfs raid5 read and write
code may fail to repair the corruption, resulting in permanent data loss.

btrfs raid5 is quantitatively more robust against data corruption than
ext4+mdadm (which cannot self-repair corruption at all), but not as
reliable as btrfs raid1 (which can self-repair all single-disk corruptions
detectable by csum check).

	- scrub and dev stats report data corruption on wrong devices
	in raid5.

When there are csum failures, error counters of a random disk will be
incremented, not necessarily the disk that contains the corrupted blocks.
This makes it difficult or impossible to identify which disk in a raid5
array is corrupting data.

	- scrub sometimes counts a csum error as a read error instead
	on raid5.

Read and write errors are counted against the correct disk; however,
there is some overlap in the read counter, which is a combination
of true csum errors and false read failures.

	- errors during readahead operations are repaired without
	incrementing dev stats, discarding critical failure information.

This is not just a raid5 bug, it affects all btrfs profiles.

	- what about write hole?

There is a write hole issue on btrfs raid5, but it occurs much less often
than the other known issues, and the other issues affect much more data
per failure event.
