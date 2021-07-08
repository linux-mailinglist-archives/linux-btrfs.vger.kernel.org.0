Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2503A3BF8A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhGHLGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:06:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGHLGn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:06:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A4F32216D;
        Thu,  8 Jul 2021 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625742241;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7k8162AxIvijG3JoKW5DrMgHXjhZ6w9ytK9+8WoE6Y=;
        b=Z7PKpk0F5t88iOtO3HYfrHhZ2i7/NgoXM4R2RgMnBKa/rJ/2G1YcZE17IkIumdSfX8CAZb
        Z65mA3d3DhlDVu10DRjc9XSZhBnKq2mYBcY4HHdzwNrF3FtfvQHX2KxeqKW5ZmH5qVOryz
        53cZ3A4uNztoxKQjgMC5I4gzExaiCDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625742241;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7k8162AxIvijG3JoKW5DrMgHXjhZ6w9ytK9+8WoE6Y=;
        b=/tgBCHxG3+kamm4MotfV5iuMjY5gYxdLtj4zGo9S2P+mmuVlDb3x0hNEqa9neu36JuvM9N
        H50EY8njgNx0bLAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 332DBA3B88;
        Thu,  8 Jul 2021 11:04:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1468FDAF79; Thu,  8 Jul 2021 13:01:27 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:01:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix unpersisted i_size on fsync after expanding
 truncate
Message-ID: <20210708110126.GU2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <6cceff8fdd4cf0293d28201c5602e011574d3b97.1625582327.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cceff8fdd4cf0293d28201c5602e011574d3b97.1625582327.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 06, 2021 at 03:41:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we have an inode that does not have the full sync flag set, was changed
> in the current transaction, then it is logged while logging some other
> inode (like its parent directory for example), its i_size is increased by
> a truncate operation, the log is synced through an fsync of some other
> inode and then finally we explicitly call fsync on our inode, the new
> i_size is not persisted.
> 
> The following example shows how to trigger it, with comments explaining
> how and why the issue happens:
> 
>   $ mkfs.btrfs -f /dev/sdc
>   $ mount /dev/sdc /mnt
> 
>   $ touch /mnt/foo
>   $ xfs_io -f -c "pwrite -S 0xab 0 1M" /mnt/bar
> 
>   $ sync
> 
>   # Fsync bar, this will be a noop since the file has not yet been
>   # modified in the current transaction. The goal here is to clear
>   # BTRFS_INODE_NEEDS_FULL_SYNC from the inode's runtime flags.
>   $ xfs_io -c "fsync" /mnt/bar
> 
>   # Now rename both files, without changing their parent directory.
>   $ mv /mnt/bar /mnt/bar2
>   $ mv /mnt/foo /mnt/foo2
> 
>   # Increase the size of bar2 with a truncate operation.
>   $ xfs_io -c "truncate 2M" /mnt/bar2
> 
>   # Now fsync foo2, this results in logging its parent inode (the root
>   # directory), and logging the parent results in logging the inode of
>   # file bar2 (its inode item and the new name). The inode of file bar2
>   # is logged with an i_size of 0 bytes since it's logged in
>   # LOG_INODE_EXISTS mode, meaning we are only logging its names (and
>   # xattrs if it had any) and the i_size of the inode will not be changed
>   # when the log is replayed.
>   $ xfs_io -c "fsync" /mnt/foo2
> 
>   # Now explicitly fsync bar2. This resulted in doing nothing, not
>   # logging the inode with the new i_size of 2M and the hole from file
>   # offset 1M to 2M. Because the inode did not have the flag
>   # BTRFS_INODE_NEEDS_FULL_SYNC set, when it was logged through the
>   # fsync of file foo2, its last_log_commit field was updated,
>   # resulting in this explicit of file bar2 not doing anything.
>   $ xfs_io -c "fsync" /mnt/bar2
> 
>   # File bar2 content and size before a power failure.
>   $ od -A d -t x1 /mnt/bar2
>   0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>   *
>   1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   *
>   2097152
> 
>   <power failure>
> 
>   # Mount the filesystem to replay the log.
>   $ mount /dev/sdc /mnt
> 
>   # Read the file again, should have the same content and size as before
>   # the power failure happened, but it doesn't, i_size is still at 1M.
>   $ od -A d -t x1 /mnt/bar2
>   0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>   *
>   1048576
> 
> This started to happen after commit 209ecbb8585bf6 ("btrfs: remove stale
> comment and logic from btrfs_inode_in_log()"), since btrfs_inode_in_log()
> no longer checks if the inode's list of modified extents is not empty.
> However, checking that list is not the right way to address this case
> and the check was added long time ago in commit 125c4cf9f37c98
> ("Btrfs: set inode's logged_trans/last_log_commit after ranged fsync")
> for a different purpose, to address consecutive ranged fsyncs.
> 
> The reason that checking for the list emptiness makes this test pass is
> because during an expanding truncate we create an extent map to represent
> a hole from the old i_size to the new i_size, and add that extent map to
> the list of modified extents in the inode. However if we are low on
> available memory and we can not allocate a new extent map, then we don't
> treat it as an error and just set the full sync flag on the inode, so that
> the next fsync does not rely on the list of modified extents - so checking
> for the emptiness of the list to decide if the inode needs to be logged is
> not reliable, and results in not logging the inode if it was not possible
> to allocate the extent map for the hole.
> 
> Fix this by ensuring that if we are only logging that an inode exists
> (inode item, names/references and xattrs), we don't update the inode's
> last_log_commit even if it does not have the full sync runtime flag set.
> 
> A test case for fstests follows soon.
> 
> CC: stable@vger.kernel.org # 5.13+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
