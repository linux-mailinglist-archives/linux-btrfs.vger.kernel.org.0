Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4D14DA5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3MGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:06:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3MGL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:06:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C2F5B03C;
        Thu, 30 Jan 2020 12:06:06 +0000 (UTC)
Subject: Re: [PATCH 01/20] btrfs: change nr to u64 in
 btrfs_start_delalloc_roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200129235024.24774-1-josef@toxicpanda.com>
 <20200129235024.24774-2-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <21932aac-2499-6112-2f47-e85b7963c037@suse.com>
Date:   Thu, 30 Jan 2020 14:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129235024.24774-2-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.01.20 г. 1:50 ч., Josef Bacik wrote:
> We have btrfs_wait_ordered_roots() which takes a u64 for nr, but
> btrfs_start_delalloc_roots() that takes an int for nr, which makes using
> them in conjunction, especially for something like (u64)-1, annoying and
> inconsistent.  Fix btrfs_start_delalloc_roots() to take a u64 for nr and
> adjust start_delalloc_inodes() and it's callers appropriately.

nit: You could include one more sentence to be explicit about the fact
that now 'nr' management is delegated to start_delalloc_inodes i.e you
pass it as a pointer to that function which in turn will control when
btrfs_Start_delalloc_roots breaks out of its own loop.

> 
> Part of adjusting the callers to this means changing
> btrfs_writeback_inodes_sb_nr() to take a u64 for items.  This may be
> confusing because it seems unrelated, but the caller of
> btrfs_writeback_inodes_sb_nr() already passes in a u64, it's just the
> function variable that needs to be changed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/dev-replace.c |  2 +-
>  fs/btrfs/inode.c       | 27 +++++++++++----------------
>  fs/btrfs/ioctl.c       |  2 +-
>  fs/btrfs/space-info.c  |  2 +-
>  5 files changed, 15 insertions(+), 20 deletions(-)
> 

<snip>

> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9619,7 +9619,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
>   * some fairly slow code that needs optimization. This walks the list
>   * of all the inodes with pending delalloc and forces them to disk.
>   */
> -static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
> +static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr,
> +				 bool snapshot)
>  {
>  	struct btrfs_inode *binode;
>  	struct inode *inode;
> @@ -9659,9 +9660,11 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
>  		list_add_tail(&work->list, &works);
>  		btrfs_queue_work(root->fs_info->flush_workers,
>  				 &work->work);
> -		ret++;
> -		if (nr != -1 && ret >= nr)
> -			goto out;
> +		if (*nr != U64_MAX) {
> +			(*nr)--;
> +			if (*nr == 0)
> +				goto out;
> +		}
>  		cond_resched();
>  		spin_lock(&root->delalloc_lock);
>  	}
> @@ -9686,18 +9689,15 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
>  int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	int ret;
> +	u64 nr = U64_MAX;

This var is never used past start_delalloc_snapshot so you can remove it
and simply pass U64_MAX to start_delalloc_inodes.

>  
>  	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>  		return -EROFS;
>  
> -	ret = start_delalloc_inodes(root, -1, true);
> -	if (ret > 0)
> -		ret = 0;
> -	return ret;
> +	return start_delalloc_inodes(root, &nr, true);
>  }
>  
> -int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
> +int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr)
>  {
>  	struct btrfs_root *root;
>  	struct list_head splice;
> @@ -9720,15 +9720,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
>  			       &fs_info->delalloc_roots);
>  		spin_unlock(&fs_info->delalloc_root_lock);
>  
> -		ret = start_delalloc_inodes(root, nr, false);
> +		ret = start_delalloc_inodes(root, &nr, false);
>  		btrfs_put_root(root);
>  		if (ret < 0)
>  			goto out;
> -
> -		if (nr != -1) {
> -			nr -= ret;
> -			WARN_ON(nr < 0);
> -		}
>  		spin_lock(&fs_info->delalloc_root_lock);
>  	}
>  	spin_unlock(&fs_info->delalloc_root_lock);

<snip>
