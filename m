Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79B1B9020
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDZMqP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 26 Apr 2020 08:46:15 -0400
Received: from mail.nethype.de ([5.9.56.24]:46981 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgDZMqP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 08:46:15 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jSgfl-000Prw-Ge
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 12:46:13 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jSgfl-0000u7-Co
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 12:46:13 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jSgfl-0001aT-CU
        for linux-btrfs@vger.kernel.org; Sun, 26 Apr 2020 14:46:13 +0200
Date:   Sun, 26 Apr 2020 14:46:13 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: experiment: suboptimal behaviour with write errors and multi-device
 filesystems
Message-ID: <20200426124613.GA5331@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I made an experiment whose results I would like to share with you, in the
hope of possible behaviour improvement in the future.

Summary: A disk was physically removed for a multi-device filesystem while
copying large amounts of data to the fs. btrfs continued writing half a
TB of data without signalling an error - it probably would have continued
like that forever, which I think is suboptimal behaviour.

And here the longer version:

I created a multi-device fs with data=single and meta=raid1 and copied
about 8TB of data to it. After copying roughly 7.5TB of data I powercycled
the disk, which caused the raid controller to remove the device
semi-permanently.

Since the partitions were on LVM, this didn't cause btrfs to see a rmeoved
device (if btrfs can even do that) - it did get EIO on every write, but
btrfs f u for example did display the device even though it was physically
missing, liekly as the device-mapper device was still there.

While the write errors kept increasing (altogether over 300000) in the
kernel log, no other indications hsowed anything out of the ordinary -
mkdir/file writes still worked.

After restoring the missing disk rebooting, I was able to mount the the
filesystem without any special options. Accessing the data got  a lot of:

Apr 24 21:01:53 doom kernel: [   83.515375] BTRFS error (device dm-32): bad tree block start, want 35423883739136 have 15380345110528
Apr 24 21:01:53 doom kernel: [   83.534174] BTRFS info (device dm-32): read error corrected: ino 0 off 35423883743232 (dev /dev/mapper/xmnt-faulty sector 14241833192)
Apr 24 21:01:53 doom kernel: [   83.849524] BTRFS error (device dm-32): parent transid verify failed on 34293446770688 wanted 2575 found 2539

While btrfs seemed to be able to repair most, amybe all, of the metadata
errors, I did get lots of inaccessible files and directories, which is of
course expected.

I tried to balance the metadata to simulate a metadata-only btrfs scrub
(which I wish would exist :), but the balance kept erroring out with
repeated ENOSPC errors and switched the device to read-only, which was
unexpected due to using raid1.

I finally rebalanced the metadata to dup profile and back to raid1, which
seemed to have the expected effect of reparing the metadata errors.

At remounting and unmounting the device, I got a number of these messages
as well:

Apr 24 21:30:48 doom kernel: [ 1818.523929] BTRFS warning (device dm-32): page private not zero on page 32786264244224
Apr 24 21:30:48 doom kernel: [ 1818.523931] BTRFS warning (device dm-32): page private not zero on page 32786264248320
Apr 24 21:30:48 doom kernel: [ 1818.523932] BTRFS warning (device dm-32): page private not zero on page 32786264252416

I then deleted all directories written while the disk was gone, did a
btrfs scrub (no errors) and some other tests (all remaining files were
readable and had correct contents) and it seems btrfs completely recovered
from this accident, which is a very positive change compared to older
kernel versions (I did this with 4.9 and the fs was effectively lost).

Discussion:

The reason I think the write-error behaviour is suboptimal is because
btrfs seems to not be bothered by a disk that loudly throws away all data
- it keeps writing to it and it never signals userspace about it. In my
case, 500GB were written "successfully" before I stopped it.

While signalling userspace for writes is hard (as the EIO comes too
late to signal userspace directly), I nevertheless am suprised by btrfs
not only effectively ignoring all write errors, but also not signaling
errors where it could - for example, a number of subdirectories were
gone or unreadable after the reboot (as they at least partially were on
the missing disk) which were written without error even though they were
multiple times larger than the memory size, i.e. it was almost certainly
writing to directories long _after_ btrfs got an EIO for the respective
directory blocks. This is substantiated by the fact that I was able to
list the directories before rebooting, but not afterwards, so some info
lived in blocks which were not writtem but were still cached.

I can't say with confidence how to improve this behaviour - I could
understand writing some gigabytes of data that are still in the cache,
or writing new files, but I think btrfs should not simply pretend an I/O
error means "successfully written" to the extent it does now.

On the other hand, kicking out a disk because it had a single write error
might not be the best behaviour either, but at least with normal disks,
an EIO on write rarely means that the block has a problem (as disk cache
usually enusres that write errors are silent), but usually indicates
a much worse condition, so cosnidering a diskunusable after EIO (or a
certain number of EIO errors) might be better, especially if there is a
way to get the disk back into the filesystem.

I hope this mail comes in useful.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
