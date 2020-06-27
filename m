Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0C420BDCE
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 05:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgF0DGP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 26 Jun 2020 23:06:15 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44296 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgF0DGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 23:06:15 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5D442735951; Fri, 26 Jun 2020 23:06:14 -0400 (EDT)
Date:   Fri, 26 Jun 2020 23:06:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Current bugs with operational impact on btrfs raid5
Message-ID: <20200627030614.GW10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following is a list of bugs that are causing repeated operational
issues on RAID5 arrays on btrfs.  Confirmed recently on 5.4.41.

I've given the bugs some short labels because they are very specific and
very similar, but distinct in critical ways, e.g. parity-update-failure
and read-repair-failure are nearly identical except one requires writes,
while the other occurs under lab test conditions when no writes occur.

These bugs occur in degraded mode:

    Name: spurious-degraded-read-failure

        Report: https://lore.kernel.org/linux-btrfs/20200627024246.GS10769@hungrycats.org/
	"Spurious read errors in btrfs raid5 degraded mode"

	Summary: file reads in degraded mode sometimes spuriously fail
	with csum errors and EIO.  The remaining data and parity blocks
	are correct on surviving disks, but the kernel sometimes cannot
	reconstruct the missing data blocks while in degraded mode.
	Read errors stop once the array exits degraded mode.  Only data
	in non-full block groups is affected (most likely also non-full
	raid stripes).

        Impact: applications do not respond well to random files having
        EIO on read.  'btrfs device remove', 'btrfs balance', and 'btrfs
        resize' abort frequently due to the read failures and are not
        usable to return the array to non-degraded mode.  As far as I
        can tell, no data is lost in raid5 data block groups, even if
        that data is written in degraded mode.  If this bug occurs in
        raid5 metadata block groups, it will make the filesystem unusable
	(frequently forced read-only) until this bug is fixed.  

	Workaround: Use 'btrfs replace' to move array to non-degraded
	mode before attempting balance/delete/resize operations.
	Stop applications to avoid spurious read failures until the
	replace is completed.  Never use raid5 for metadata.

    Name: btrfs-replace-lockup

        Report: https://lore.kernel.org/linux-btrfs/20200627024256.GT10769@hungrycats.org/
	"btrfs raid5 hangs at the end of 'btrfs replace'"

        Summary: 'btrfs replace' sometimes hangs just before it is
        finished.

        Impact: reboot required to complete device replace.

        Workaround: None known.

    Name: btrfs-replace-wrong-state-after-exit

        Report: https://lore.kernel.org/linux-btrfs/20200627024256.GT10769@hungrycats.org/
	"btrfs raid5 hangs at the end of 'btrfs replace'"

        Summary: 'btrfs replace' replace state is not fully cleared.
        The replace kernel thread exits, 'btrfs replace status' reports
        the replace is complete, but later resize and balance operations
        fail with "resize/replace/balance in progress" until the
	kernel is rebooted.

        Impact: (another) reboot required to complete device replace.

        Workaround: None known.

These bugs occur when all disks are online but one is silently corrupted:

    Name: parity-update-failure

        Report: https://www.spinics.net/lists/linux-btrfs/msg100178.html
        "RAID5/6 permanent corruption of metadata and data extents"

        Summary: if a non-degraded raid stripe contains a corrupted
        data block, and a write to a different data block updates the
        parity block in the same raid stripe, the updated parity block
        will be computed using the corrupted data block instead of the
        original uncorrupted data block, making later recovery of the
        corrupted data block impossible in either non-degraded mode or
        degraded mode.

        Impact: writes on a btrfs raid5 with repairable corrupt data can
        in some cases make the corrupted data permanently unrepairable.
        If raid5 metadata is used, this bug may destroy the filesystem.

        Workaround: Frequent scrubs.  Never use raid5 for metadata.

    Name: read-repair-failure

        Report: https://www.spinics.net/lists/linux-btrfs/msg94590.html
        "RAID5 fails to correct correctable errors, makes them
        uncorrectable instead"

        Summary: if a non-degraded raid stripe contains a corrupted data
        block, under unknown conditions a read can update the parity
        block in the raid stripe using the corrupted data block instead
        of the original uncorrupted data block, making later recovery
        of the corrupted data block impossible in either non-degraded
        mode or degraded mode.

        Impact: reads on a btrfs raid5 with repairable corrupt data
        can in some cases make the corrupted data permanently
        unrepairable.  If raid5 metadata is used, this bug may
        destroy the filesystem.

        Workaround: Frequent scrubs.  Never use raid5 for metadata.

    Name: scrub-wrong-error-types

	Report: https://lore.kernel.org/linux-btrfs/20200206234037.GD13306@hungrycats.org
	"RAID5 fails to correct correctable errors, makes them uncorrectable instead"

	Summary: scrub on raid5 data sometimes reports read errors instead
	of csum errors when the only errors present on the underlying
	disk are csum errors.

	Impact: false positives are included in the read error count
	after a scrub.  It can be difficult or impossible to correctly
	identify which disk is failing.

	Workaround: none known.

    Name: scrub-wrong-error-devices

	Report: https://lore.kernel.org/linux-btrfs/20200206234037.GD13306@hungrycats.org
	"RAID5 fails to correct correctable errors, makes them uncorrectable instead"

	Summary: scrub on raid5 data cannot reliably determine the
	failing disk when there is a mismatch between computed parity
	and the parity block on disk, and some of the data blocks in the
	raid stripe do not have csums (e.g. free blocks or nodatacow
	file blocks).  This cannot be fixed with the current on-disk
	format because the necessary information (csums for free and
	nodatasum blocks to identify parity corruption by elimination,
	or csum on the parity block itself) is not available.

	Impact: parity block corruptions on one disk are reported in
	scrub error counts as csum errors distributed across all disks.
	It can be difficult or impossible to correctly identify which
	disk is failing.

	Workaround: none known.

No list of raid5 bugs would be complete without:

    Name: parity-raid-write-hole

        Report: numerous, it's probably the most famous btrfs raid5 bug,
        and the one inexperienced users blame most often for data losses.

        Impact:  negligible.  It occurs orders of magnitude less often
        and destroys orders of magnitude less data each time it occurs
        compared to the above bugs.

        Workaround:  Don't worry about write hole yet.  The other bugs
	will ruin your day first.
