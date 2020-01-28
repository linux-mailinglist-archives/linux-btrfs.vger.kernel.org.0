Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1745C14BD9A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 17:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1QWE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 11:22:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgA1QWE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 11:22:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D5C1B03C;
        Tue, 28 Jan 2020 16:22:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7B12DA730; Tue, 28 Jan 2020 17:21:43 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:21:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: send, fix emission of invalid clone operations
 within the same file
Message-ID: <20200128162143.GW3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200124115204.4086-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124115204.4086-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 11:52:04AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send and a file has extents shared with itself
> at different file offsets, it's possible for send to emit clone operations
> that will fail at the destination because the source range goes beyond the
> file's current size. This happens when the file size has increased in the
> send snapshot, there is a hole between the shared extents and both shared
> extents are at file offsets which are greater the file's size in the
> parent snapshot.
> 
> Example:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt/sdb
> 
>   $ xfs_io -f -c "pwrite -S 0xf1 0 64K" /mnt/sdb/foobar
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
>   $ btrfs send -f /tmp/1.snap /mnt/sdb/base
> 
>   # Create a 320K extent at file offset 512K.
>   $ xfs_io -c "pwrite -S 0xab 512K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0xcd 576K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0xef 640K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0x64 704K 64K" /mnt/sdb/foobar
>   $ xfs_io -c "pwrite -S 0x73 768K 64K" /mnt/sdb/foobar
> 
>   # Clone part of that 320K extent into a lower file offset (192K).
>   # This file offset is greater than the file's size in the parent
>   # snapshot (64K). Also the clone range is a bit behind the offset of
>   # the 320K extent so that we leave a hole between the shared extents.
>   $ xfs_io -c "reflink /mnt/sdb/foobar 448K 192K 192K" /mnt/sdb/foobar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
>   $ btrfs send -p /mnt/sdb/base -f /tmp/2.snap /mnt/sdb/incr
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt/sdc
> 
>   $ btrfs receive -f /tmp/1.snap /mnt/sdc
>   $ btrfs receive -f /tmp/2.snap /mnt/sdc
>   ERROR: failed to clone extents to foobar: Invalid argument
> 
> The problem is that after processing the extent at file offset 192K, send
> does not issue a write operation full of zeroes for the hole between that
> extent and the extent starting at file offset 520K (hole range from 384K
> to 512K), this is because the hole is at an offset larger the size of the
> file in the parent snapshot (384K > 64K). As a consequence the field
> 'cur_inode_next_write_offset' of the send context remains with a value of
> 384K when we start to process the extent at file offset 512K, which is the
> value set after processing the extent at offset 192K.
> 
> This screws up the lookup of possible extents to clone because due to an
> incorrect value of 'cur_inode_next_write_offset' we can now consider
> extents for cloning, in the same inode, that lie beyond the current size
> of the file in the receiver of the send stream. Also, when checking if
> an extent in the same file can be used for cloning, we must also check
> that not only its start offset doesn't start at or beyond the current eof
> of the file in the receiver but that the source range doesn't go beyond
> current eof, that is we must check offset + length does not cross the
> current eof, as that makes clone operations fail with -EINVAL.
> 
> So fix this by updating 'cur_inode_next_write_offset' whenever we start
> processing an extent and checking an extent's offset and length when
> considering it for cloning operations.
> 
> A test case for fstests follows soon.
> 
> Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, with the tested-by tag, thanks.
