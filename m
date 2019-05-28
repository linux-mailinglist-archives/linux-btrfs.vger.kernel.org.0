Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0472CD99
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfE1R2D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 13:28:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:44848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfE1R2D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 13:28:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A252FAC20;
        Tue, 28 May 2019 17:28:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D466DA85E; Tue, 28 May 2019 19:28:57 +0200 (CEST)
Date:   Tue, 28 May 2019 19:28:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: incremental send, fix emission of invalid clone
 operations
Message-ID: <20190528172857.GW15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190520085700.29424-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520085700.29424-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 09:57:00AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send we can now issue clone operations with a
> source range that ends at the source's file eof and with a destination
> range that ends at an offset smaller then the destination's file eof.
> If the eof of the source file is not aligned to the sector size of the
> filesystem, the receiver will get a -EINVAL error when trying to do the
> operation or, on older kernels, silently corrupt the destination file.
> The corruption happens on kernels without commit ac765f83f1397646
> ("Btrfs: fix data corruption due to cloning of eof block"), while the
> failure to clone happens on kernels with that commit.
> 
> Example reproducer:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt/sdb
> 
>   $ xfs_io -f -c "pwrite -S 0xb1 0 2M" /mnt/sdb/foo
>   $ xfs_io -f -c "pwrite -S 0xc7 0 2M" /mnt/sdb/bar
>   $ xfs_io -f -c "pwrite -S 0x4d 0 2M" /mnt/sdb/baz
>   $ xfs_io -f -c "pwrite -S 0xe2 0 2M" /mnt/sdb/zoo
> 
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
> 
>   $ btrfs send -f /tmp/base.send /mnt/sdb/base
> 
>   $ xfs_io -c "reflink /mnt/sdb/bar 1560K 500K 100K" /mnt/sdb/bar
>   $ xfs_io -c "reflink /mnt/sdb/bar 1560K 0 100K" /mnt/sdb/zoo
>   $ xfs_io -c "truncate 550K" /mnt/sdb/bar
> 
>   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
> 
>   $ btrfs send -f /tmp/incr.send -p /mnt/sdb/base /mnt/sdb/incr
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt/sdc
> 
>   $ btrfs receive -f /tmp/base.send /mnt/sdc
>   $ btrfs receive -vv -f /tmp/incr.send /mnt/sdc
>   (...)
>   truncate bar size=563200
>   utimes bar
>   clone zoo - source=bar source offset=512000 offset=0 length=51200
>   ERROR: failed to clone extents to zoo
>   Invalid argument
> 
> The failure happens because the clone source range ends at the eof of file
> bar, 563200, which is not aligned to the filesystems sector size (4Kb in
> this case), and the destination range ends at offset 0 + 51200, which is
> less then the size of the file zoo (2Mb).
> 
> So fix this by detecting such case and instead of issuing a clone
> operation for the whole range, do a clone operation for smaller range
> that is sector size aligned followed by a write operation for the block
> containing the eof. Here we will always be pessimistic and assume the
> destination filesystem of the send stream has the largest possible sector
> size (64Kb), since we have no way of determining it.
> 
> This fixes a recent regression introduced in kernel 5.2-rc1.
> 
> Fixes: 040ee6120cb6706 ("Btrfs: send, improve clone range")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to 5.2-rc queue, thanks.
