Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9305A1B5167
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 02:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDWAip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 20:38:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDWAip (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 20:38:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13E31AB89;
        Thu, 23 Apr 2020 00:38:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 000A5DA704; Thu, 23 Apr 2020 02:38:00 +0200 (CEST)
Date:   Thu, 23 Apr 2020 02:38:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix partial loss of prealloc extent past i_size
 after fsync
Message-ID: <20200423003800.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200421102520.14686-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102520.14686-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 11:25:20AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we have an inode with a prealloc extent that starts at an offset
> lower than the i_size and there is another prealloc extent that starts at
> an offset beyond i_size, we can end up losing part of the first prealloc
> extent (the part that starts at i_size) and have an implicit hole if we
> fsync the file and then have a power failure.
> 
> Consider the following example with comments explaining how and why it
> happens.
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   # Create our test file with 2 consecutive prealloc extents, each with a
>   # size of 128Kb, and covering the range from 0 to 256Kb, with a file
>   # size of 0.
>   $ xfs_io -f -c "falloc -k 0 128K" /mnt/foo
>   $ xfs_io -c "falloc -k 128K 128K" /mnt/foo
> 
>   # Fsync the file to record both extents in the log tree.
>   $ xfs_io -c "fsync" /mnt/foo
> 
>   # Now do a redudant extent allocation for the range from 0 to 64Kb.
>   # This will merely increase the file size from 0 to 64Kb. Instead we
>   # could also do a truncate to set the file size to 64Kb.
>   $ xfs_io -c "falloc 0 64K" /mnt/foo
> 
>   # Fsync the file, so we update the inode item in the log tree with the
>   # new file size (64Kb). This also ends up setting the number of bytes
>   # for the first prealloc extent to 64Kb. This is done by the truncation
>   # at btrfs_log_prealloc_extents().
>   # This means that if a power failure happens after this, a write into
>   # the file range 64Kb to 128Kb will not use the prealloc extent and
>   # will result in allocation of a new extent.
>   $ xfs_io -c "fsync" /mnt/foo
> 
>   # Now set the file size to 256K with a truncate and then fsync the file.
>   # Since no changes happened to the extents, the fsync only updates the
>   # i_size in the inode item at the log tree. This results in an implicit
>   # hole for the file range from 64Kb to 128Kb, something which fsck will
>   # complain when not using the NO_HOLES feature if we replay the log
>   # after a power failure.
>   $ xfs_io -c "truncate 256K" -c "fsync" /mnt/foo
> 
> So instead of always truncating the log to the inode's current i_size at
> btrfs_log_prealloc_extents(), check first if there's a prealloc extent
> that starts at an offset lower than the i_size and with a length that
> crosses the i_size - if there is one, just make sure we truncate to a
> size that corresponds to the end offset of that prealloc extent, so
> that we don't lose the part of that extent that starts at i_size if a
> power failure happens.
> 
> A test case for fstests follows soon.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
