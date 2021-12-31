Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D85482598
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Dec 2021 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhLaTOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Dec 2021 14:14:12 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:36972 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhLaTOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Dec 2021 14:14:11 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id F083712C402; Fri, 31 Dec 2021 14:14:10 -0500 (EST)
Date:   Fri, 31 Dec 2021 14:14:10 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed
Message-ID: <Yc9Wgsint947Tj59@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 30, 2021 at 04:10:23PM -0500, Eric Levy wrote:
> Hello.
> 
> I had a simple Btrfs partition, with only one subvolume, about 250 Gb
> in size. As it began to fill, I added a second volume, live. By the
> time the size of the file system reached the limit for the first
> volume, the file system reverted to read only.
> 
> >From journalctl, the following message has recurred, with the same
> numeric values:
> 
> BTRFS error (device sdc1): parent transid verify failed on 867434496
> wanted 9212 found 8675

To be clear, do the parent transid verify failed messages appear _before_
or _after_ the filesystem switches to read-only?

"After" is fine.  When the kernel switches btrfs to read-only, it stops
updating the disk, so pointers in memory no longer match what's on disk
and you will get a whole stream of errors that only exist in btrfs's
kernel RAM.  A umount/mount will clear those.  This is most likely caused
by running out of metadata space because you didn't balance data block
groups on the first drive after (or in some cases before) adding the
second drive.

"Before" is the unrecoverable case.  Some drives silently dropped writes,
which is a failure btrfs can detect but not recover from except in
cases where the missing data is present on some other drive (i.e. RAID1
configurations).  Depending on how "added a second volume, live" was done,
writes could be interrupted or lost on the first drive without reporting
to the kernel (e.g. bumping the cables or browning out a power supply).

Since the "after" case can happen on healthy hardware in this scenario,
but the "before" case requires a hardware failure, it's more likely
you're in the "after" case, and the filesystem can be recovered by
carefully rearranging the data on the disks.  We'll need the output of
'btrfs fi usage' to see where to start with this.

> Presently, the file system mounts only as read only. It will not mount
> in read-write, even with the usebackuproot option. 
> 
> It seems that balance and scrub are not available, either due to read-
> only mode, or some other reason. Both abort as soon as they begin to
> run.

Mount with '-o skip_balance'.  If you're in the "after" case then this
will avoid running out of metadata space again during mount.

> What is the best next step for recovery?

Confirm whether the first "parent transid verify failed" message appears
before or after the filesystem is forced read-only.  If it's before,
the best next step is mkfs and restore your backups.

If it's after, try -o skip_balance and provide us with 'btrfs fi usage'
details.

You will need to rearrange free space (balance with filters, delete some
data, or add additional drives temporarily) so that you can do a data
balance, then balance data block groups until both drives have equal free
space on them.  Also you should convert all existing metadata to raid1
profile (there's no sane use case for dup metadata on multiple drives)
but you'll have to do that after making space with data balances.
