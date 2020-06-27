Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094D620BDC2
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgF0Cmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 22:42:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41966 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgF0Cmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:42:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 954A77358D2; Fri, 26 Jun 2020 22:42:46 -0400 (EDT)
Date:   Fri, 26 Jun 2020 22:42:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Spurious read errors in btrfs raid5 degraded mode
Message-ID: <20200627024246.GS10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I removed a failed disk from a raid5 filesystem (-draid5 -mraid1) and
mounted the filesystem with -o degraded.  I observed a large number of
csum failures and IO errors while reading files, particularly recently
modified files but also some files much older than the disk failure.
These occurred under two conditions:

	1.  "cp testfile test2; sync; sysctl vm.drop_caches=3; sha1sum
	test2" The sha1sum would return EIO about half the time, and
	report csum failures in the kernel log.  The write in the cp
	command completed without error, and the file was readable while
	it was cached in RAM, but could not be re-read from disk (i.e.
	some files written after the degraded mount were unreadable).

        2.  Some files that existed before the disk failure would return
        EIO on reads and csum failures in the kernel log.  (i.e. files
        written before the degraded mount were unreadable).  The set of
        such damaged files grew over time (i.e. the file was readable
        at one time, then not readable at a later time), giving the
        (false) impression that new writes were corrupting old data.

In both cases these EIO errors were persistent, even across a reboot:
once they appeared, they did not go away or change location on multiple
read attempts spaced hours (and gigabytes of IO activity) apart.  A
reboot did not affect the locations of IO errors in files.

A bit of probing showed that the files in case 2 were close enough
to files in case 1 to share raid stripes.  99.2% of the block groups
on this filesystem were completely full, and no files were observed
affected by this bug in the completely full block groups.

Hypothesis: the bug is a bug in the degraded read code that is triggered
by partially filled or partially empty raid stripes.  Such a bug shouldn't
appear in a block group that is completely full since a completely full
block group cannot have partially empty raid stripes.

The apparent corruption is _not_ permanent!  The data is not damaged on
disk, and btrfs replace can recover it.  Most IO errors and csum failures
disappeared at the end of the btrfs replace operation.

At the end of the btrfs replace operation for the failed disk (which
will be the subject of some different bug reports), only 84K of data
was permanently lost in 16TB of filesystem--all of it on the disks that
had not been replaced.
