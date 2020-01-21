Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF8143DDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 14:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUNU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 08:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUNU4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 08:20:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC747AEAC;
        Tue, 21 Jan 2020 13:20:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62821DA738; Tue, 21 Jan 2020 14:20:37 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:20:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix infinite loop during fsync after rename
 operations
Message-ID: <20200121132037.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200115132135.23994-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115132135.23994-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 01:21:35PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Recently fsstress (from fstests) sporadically started to trigger an
> infinite loop during fsync operations. This turned out to be because
> support for the rename exchange and whiteout operations was added to
> fsstress in fstests. These operations, unlike any others in fsstress,
> cause file names to be reused, whence triggering this issue. However
> it's not necessary to use rename exchange and rename whiteout operations
> trigger this issue, simple rename operations and file creations are
> enough to trigger the issue.
> 
> The issue boils down to when we are logging inodes that conflict (that
> had the name of any inode we need to log during the fsync operation),
> we keep logging them even if they were already logged before, and after
> that we check if there's any other inode that conflicts with them and
> then add it again to the list of inodes to log. Skipping already logged
> inodes fixes the issue.
> 
> Consider the following example:
> 
>   $ mkfs.btrfs -f /dev/sdb
>   $ mount /dev/sdb /mnt
> 
>   $ mkdir /mnt/testdir                           # inode 257
> 
>   $ touch /mnt/testdir/zz                        # inode 258
>   $ ln /mnt/testdir/zz /mnt/testdir/zz_link
> 
>   $ touch /mnt/testdir/a                         # inode 259
> 
>   $ sync
> 
>   # The following 3 renames achieve the same result as a rename exchange
>   # operation (<rename_exchange> /mnt/testdir/zz_link to /mnt/testdir/a).
> 
>   $ mv /mnt/testdir/a /mnt/testdir/a/tmp
>   $ mv /mnt/testdir/zz_link /mnt/testdir/a
>   $ mv /mnt/testdir/a/tmp /mnt/testdir/zz_link
> 
>   # The following rename and file creation give the same result as a
>   # rename whiteout operation (<rename_whiteout> zz to a2).
> 
>   $ mv /mnt/testdir/zz /mnt/testdir/a2
>   $ touch /mnt/testdir/zz                        # inode 260
> 
>   $ xfs_io -c fsync /mnt/testdir/zz
>     --> results in the infinite loop
> 
> The following steps happen:
> 
> 1) When logging inode 260, we find that its reference named "zz" was
>    used by inode 258 in the previous transaction (through the commit
>    root), so inode 258 is added to the list of conflicting indoes that
>    need to be logged;
> 
> 2) After logging inode 258, we find that its reference named "a" was
>    used by inode 259 in the previous transaction, and therefore we add
>    inode 259 to the list of conflicting inodes to be logged;
> 
> 3) After logging inode 259, we find that its reference named "zz_link"
>    was used by inode 258 in the previous transaction - we add inode 258
>    to the list of conflicting inodes to log, again - we had already
>    logged it before at step 3. After logging it again, we find again
>    that inode 259 conflicts with him, and we add again 259 to the list,
>    etc - we end up repeating all the previous steps.
> 
> So fix this by skipping logging of conflicting inodes that were already
> logged.
> 
> Fixes: 6b5fc433a7ad67 ("Btrfs: fix fsync after succession of renames of different files")
> CC: stable@vger.kernel.org
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
