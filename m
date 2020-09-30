Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61DD27EF42
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3Qcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 12:32:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Qcx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 12:32:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CB02AC8C;
        Wed, 30 Sep 2020 16:32:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D3B0DA781; Wed, 30 Sep 2020 18:31:32 +0200 (CEST)
Date:   Wed, 30 Sep 2020 18:31:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix filesystem corruption after a device replace
Message-ID: <20200930163132.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 03:30:16PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We use a device's allocation state tree to track ranges in a device used
> for allocated chunks, and we set ranges in this tree when allocating a new
> chunk. However after a device replace operation, we were not setting the
> allocated ranges in the new device's allocation state tree, so that tree
> is empty after a device replace.
> 
> This means that a fitrim operation after a device replace will trim the
> device ranges that have allocated chunks and extents, as we trim every
> range for which there is not a range marked in the device's allocation
> state tree. It is also important during chunk allocation, since the
> device's allocation state is used to determine if a range is already
> allocated when allocating a new chunk.
> 
> This is trivial to reproduce and the following script triggers the bug:
> 
>   $ cat reproducer.sh
>   #!/bin/bash
> 
>   DEV1="/dev/sdg"
>   DEV2="/dev/sdh"
>   DEV3="/dev/sdi"
> 
>   wipefs -a $DEV1 $DEV2 $DEV3 &> /dev/null
> 
>   # Create a raid1 test fs on 2 devices.
>   mkfs.btrfs -f -m raid1 -d raid1 $DEV1 $DEV2 > /dev/null
>   mount $DEV1 /mnt/btrfs
> 
>   xfs_io -f -c "pwrite -S 0xab 0 10M" /mnt/btrfs/foo
> 
>   echo "Starting to replace $DEV1 with $DEV3"
>   btrfs replace start -B $DEV1 $DEV3 /mnt/btrfs
>   echo
> 
>   echo "Running fstrim"
>   fstrim /mnt/btrfs
>   echo
> 
>   echo "Unmounting filesystem"
>   umount /mnt/btrfs
> 
>   echo "Mounting filesystem in degraded mode using $DEV3 only"
>   wipefs -a $DEV1 $DEV2 &> /dev/null
>   mount -o degraded $DEV3 /mnt/btrfs
>   if [ $? -ne 0 ]; then
>           dmesg | tail
>           echo
>           echo "Failed to mount in degraded mode"
>           exit 1
>   fi
> 
>   echo
>   echo "File foo data (expected all bytes = 0xab):"
>   od -A d -t x1 /mnt/btrfs/foo
> 
>   umount /mnt/btrfs
> 
> When running the reproducer:
> 
>   $ ./replace-test.sh
>   wrote 10485760/10485760 bytes at offset 0
>   10 MiB, 2560 ops; 0.0901 sec (110.877 MiB/sec and 28384.5216 ops/sec)
>   Starting to replace /dev/sdg with /dev/sdi
> 
>   Running fstrim
> 
>   Unmounting filesystem
>   Mounting filesystem in degraded mode using /dev/sdi only
>   mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sdi, missing codepage or helper program, or other error.
>   [19581.748641] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi started
>   [19581.803842] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi finished
>   [19582.208293] BTRFS info (device sdi): allowing degraded mounts
>   [19582.208298] BTRFS info (device sdi): disk space caching is enabled
>   [19582.208301] BTRFS info (device sdi): has skinny extents
>   [19582.212853] BTRFS warning (device sdi): devid 2 uuid 1f731f47-e1bb-4f00-bfbb-9e5a0cb4ba9f is missing
>   [19582.213904] btree_readpage_end_io_hook: 25839 callbacks suppressed
>   [19582.213907] BTRFS error (device sdi): bad tree block start, want 30490624 have 0
>   [19582.214780] BTRFS warning (device sdi): failed to read root (objectid=7): -5
>   [19582.231576] BTRFS error (device sdi): open_ctree failed
> 
>   Failed to mount in degraded mode
> 
> So fix by setting all allocated ranges in the replace target device when
> the replace operation is finishing, when we are holding the chunk mutex
> and we can not race with new chunk allocations.
> 
> A test case for fstests follows soon.
> 
> Fixes: 1c11b63eff2a67 ("btrfs: replace pending/pinned chunks lists with io tree")
> CC: stable@vger.kernel.org # 5.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next (a few days ago actually), thanks.
