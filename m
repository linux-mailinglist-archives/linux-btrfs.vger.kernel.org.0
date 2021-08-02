Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763B43DE325
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHBXjB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 19:39:01 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45148 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHBXjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 19:39:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 840E0B11F65; Mon,  2 Aug 2021 19:38:50 -0400 (EDT)
Date:   Mon, 2 Aug 2021 19:38:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     telsch <telsch@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Random csum errors
Message-ID: <20210802233850.GO10170@hungrycats.org>
References: <trinity-59843172-879e-4efd-9b35-bbfed0ed52c6-1627914043406@3c-app-gmx-bap64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-59843172-879e-4efd-9b35-bbfed0ed52c6-1627914043406@3c-app-gmx-bap64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 02, 2021 at 04:20:43PM +0200, telsch wrote:
> Dear devs,
> 
> since 26.07. scrub keeps reporting csum errors with random files.
> I replaced these files from backups. Then deleted the snapshots that still contained the
> the corrupt files. Snapshot with corrupt files I have determined with md5sum, here I get an input/output error.
> Following new scrub, still finds new csum errors that did not exist before.
> 
> Beginning with Kernel 5.10.52, current 5.10.55
> btrfs-progs 5.13
> 
> Disk layout with problems:
> 
> mdadm raid10 4xhdd => bcache => luks
> mdadm raid6  4xhdd => bcache => luks

Missing information:  what are the model/firmware revision of the
devices, is the bcache in writeback or writethrough mode, how many
SSDs are there, is there a separate bcache SSD for each HDD or are
multiple HDDs sharing any bcache SSDs?

Based on the symptoms, the most likely case is there's one SSD or a
mdadm-mirrored pair of SSDs for bcache, and at least one SSD is failing.
It may be a SSD that is not rated for caching use cases, or a SSD with
firmware bugs that prevent reliable error reporting.  It's also possible
one or more HDDs is silently corrupting data, but that is less common
in the wild.

The writeback/writethrough question informs us how recoverable the
damage is.  Damage in writethrough mode is recoverable in some cases
by simply removing the cache and mounting the backing drives directly.
In writeback mode the data is already gone, and if the SSD fails before
the bcache can be fully flushed, the filesystem will be destroyed.

> Already replaced 2 old hdds with high Raw_Read_Error_Rate values.

1.  Replace all SSDs in the system, or cleanly remove the SSD devices
from the bcache.  Silent corruption is a common early failure mode on
SSDs, and bcache doesn't use checksums to detect it.  If you continue
to use bcache in writeback mode with a bad SSD, it will corrupt more
and more data until the SSD finally dies, and the filesystem will be
unrecoverable after that.  If you're using bcache in writethrough mode,
the corruption will only be affecting reads, and you can simply remove
and discard the SSD without damaging the filesystem (it might even fix
previously uncorrectable data if the copy on the backing HDDs is intact).

2.  If that doesn't solve the problem, run mdadm checkarray and look at
/sys/block/md*/md/mismatch_cnt afterwards.  checkarray doesn't report
non-zero mismatch_cnt, so you'll need to check for it separately.
If the mismatch_cnt is non-zero, you'll have to figure out which
drive is at fault somehow.  Neither mdadm nor SMART will tell you if
one drive's cache RAM goes bad in an array:  mdadm doesn't know which
drive is correct when they have different contents, and generally SMART
cannot detect failures inside the disk's firmware runtime environment
that might affect data integrity like cache DRAM failure.  You might
be able to identify the bad drive by manually inspecting blocks with
different data, but there's no automated way to do this.

3.  To avoid future problems, break the mdadm arrays into separate
devices and put them all in a btrfs raid1 so in future btrfs can tell you
immediately which device is corrupting your data.  (raid1 here to avoid
issues with striped access through a SSD cache).  This might be tricky
to achieve before the bad device is identified, because the bad device
will keep injecting corrupted data that will abort btrfs resize/device
delete operations.

> Aug 02 15:43:18 server kernel: BTRFS info (device dm-0): scrub: started on devid 1
> Aug 02 15:46:06 server kernel: BTRFS warning (device dm-0): checksum error at logical 462380818432 on dev /dev/mapper/root, physical 31640150016, root 29539, inode 27412268, offset 131072, length 4096, links 1 (path: docker-volumes/mayan-edms/media/document_cache/804391c5-e3fe-4941-96dc-ecc0a1d5d8c9-23-1815-92bcac02c4a72586e21044c0b244b052f5747c7d2c25e6086ca89ca64098e3f3)
> Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): bdev /dev/mapper/root errs: wr 0, rd 0, flush 0, corrupt 414, gen 0
> Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): unable to fixup (regular) error at logical 462380818432 on dev /dev/mapper/root
> Aug 02 15:47:25 server kernel: BTRFS info (device dm-0): scrub: finished on devid 1 with status: 0
