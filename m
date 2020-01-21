Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6070143DA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgAUNIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 08:08:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:60172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUNIA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 08:08:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB6EDAC84;
        Tue, 21 Jan 2020 13:07:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 827FADA738; Tue, 21 Jan 2020 14:07:42 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:07:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RESEND] btrfs: free block groups after free'ing fs trees
Message-ID: <20200121130741.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117135649.41983-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117135649.41983-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 08:56:49AM -0500, Josef Bacik wrote:
> Sometimes when running generic/475 we would trip the
> WARN_ON(cache->reserved) check when free'ing the block groups on umount.
> This is because sometimes we don't commit the transaction because of IO
> errors and thus do not cleanup the tree logs until at umount time.
> These blocks are still reserved until they are cleaned up, but they
> aren't cleaned up until _after_ we do the free block groups work.  Fix
> this by moving the free after free'ing the fs roots, that way all of the
> tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
> loops of generic/475 confirmed this fixes the problem.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - Nothing has changed in this since last submission, it was simply rebased.
> 
>  fs/btrfs/disk-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d453bdc74e91..55a03a21d752 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4056,12 +4056,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
>  	btrfs_stop_all_workers(fs_info);
>  
> -	btrfs_free_block_groups(fs_info);
> -
>  	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
>  	free_root_pointers(fs_info, true);
>  	btrfs_free_fs_roots(fs_info);
>  
> +	btrfs_free_block_groups(fs_info);

Each step in the shutdown sequence should be documented so we don't
shuffle the lines like that, the patch that moved
btrfs_free_block_groups to the original place fixed another bug
(5cdd7db6c5c9d33dc66).

> +
>  	iput(fs_info->btree_inode);
>  
>  #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> -- 
> 2.24.1
