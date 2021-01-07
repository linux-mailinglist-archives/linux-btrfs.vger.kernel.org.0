Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446362ED64D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 19:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbhAGSDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jan 2021 13:03:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbhAGSDL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Jan 2021 13:03:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A2B4AAF1;
        Thu,  7 Jan 2021 18:02:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DA65DA6E9; Thu,  7 Jan 2021 19:00:39 +0100 (CET)
Date:   Thu, 7 Jan 2021 19:00:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        stable@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
Subject: Re: [PATCH v2] btrfs: shrink delalloc pages instead of full inodes
Message-ID: <20210107180038.GV6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        stable@vger.kernel.org,
        =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>
References: <34d0a7e07cf75ca4b44cf54693cd74477649fb88.1609792754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34d0a7e07cf75ca4b44cf54693cd74477649fb88.1609792754.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 04, 2021 at 03:39:50PM -0500, Josef Bacik wrote:
> Commit 38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in
> shrink_delalloc") cleaned up how we do delalloc shrinking by utilizing
> some infrastructure we have in place to flush inodes that we use for
> device replace and snapshot.  However this introduced a pretty serious
> performance regression.  To reproduce the user untarred the source
> tarball of Firefox, and would see it take anywhere from 5 to 20 times as
> long to untar in 5.10 compared to 5.9.
> 
> The root cause is because before we would generally use the normal
> writeback path to reclaim delalloc space, and for this we would provide
> it with the number of pages we wanted to flush.  The referenced commit
> changed this to flush that many inodes, which drastically increased the
> amount of space we were flushing in certain cases, which severely
> affected performance.
> 
> We cannot revert this patch unfortunately, because Filipe has another
> fix that requires the ability to skip flushing inodes that are being

Which fix is that? Commit id or at last the subject.

> cloned in certain scenarios, which means we need to keep using our
> flushing infrastructure or risk re-introducing the deadlock.
> 
> Instead to fix this problem we can go back to providing
> btrfs_start_delalloc_roots with a number of pages to flush, and then set
> up a writeback_control and utilize sync_inode() to handle the flushing
> for us.  This gives us the same behavior we had prior to the fix, while
> still allowing us to avoid the deadlock that was fixed by Filipe.  I
> redid the users original test and got the following results
> 
> 5.9	0m54.258s
> 5.10	1m26.212s
> Patched	0m38.800s

Patched is on which base? Also the hardware type seems to be a
significant factor. I've been testing that on some old SSD, the time
difference was about 5 minutes vs 1, both on 5.11-rc2 and 5.10.5. I'll
add my results to the final version of the patch.

> We are significantly faster because of the work I did around improving
> ENOSPC flushing in 5.10 and 5.11, so reverting to the previous write out
> behavior gave us a pretty big boost.

The reference to the enospc needs to be less vague if you mention 2
versions.

> CC: stable@vger.kernel.org # 5.10
> Reported-by: Ren� Rebe <rene@exactcode.de>
> Fixes: 38d715f494f2 ("btrfs: use btrfs_start_delalloc_roots in shrink_delalloc")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Explicitly state what the regression was in the commit message.
> 
>  fs/btrfs/inode.c      | 60 +++++++++++++++++++++++++++++++------------
>  fs/btrfs/space-info.c |  4 ++-
>  2 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 070716650df8..a8e0a6b038d3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9390,7 +9390,8 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
>   * some fairly slow code that needs optimization. This walks the list
>   * of all the inodes with pending delalloc and forces them to disk.
>   */
> -static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot,
> +static int start_delalloc_inodes(struct btrfs_root *root,
> +				 struct writeback_control *wbc, bool snapshot,
>  				 bool in_reclaim_context)
>  {
>  	struct btrfs_inode *binode;
> @@ -9399,6 +9400,7 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
>  	struct list_head works;
>  	struct list_head splice;
>  	int ret = 0;
> +	bool full_flush = wbc->nr_to_write == LONG_MAX;
>  
>  	INIT_LIST_HEAD(&works);
>  	INIT_LIST_HEAD(&splice);
> @@ -9427,18 +9429,24 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
>  		if (snapshot)
>  			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
>  				&binode->runtime_flags);
> -		work = btrfs_alloc_delalloc_work(inode);
> -		if (!work) {
> -			iput(inode);
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -		list_add_tail(&work->list, &works);
> -		btrfs_queue_work(root->fs_info->flush_workers,
> -				 &work->work);
> -		if (*nr != U64_MAX) {
> -			(*nr)--;
> -			if (*nr == 0)
> +		if (full_flush) {
> +			work = btrfs_alloc_delalloc_work(inode);
> +			if (!work) {
> +				iput(inode);
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			list_add_tail(&work->list, &works);
> +			btrfs_queue_work(root->fs_info->flush_workers,
> +					 &work->work);
> +		} else {
> +			ret = sync_inode(inode, wbc);
> +			if (!ret &&
> +			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +				     &BTRFS_I(inode)->runtime_flags))
> +				ret = sync_inode(inode, wbc);
> +			btrfs_add_delayed_iput(inode);
> +			if (ret || wbc->nr_to_write <= 0)
>  				goto out;
>  		}
>  		cond_resched();
> @@ -9464,18 +9472,29 @@ static int start_delalloc_inodes(struct btrfs_root *root, u64 *nr, bool snapshot
>  
>  int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
>  {
> +	struct writeback_control wbc = {
> +		.nr_to_write = LONG_MAX,
> +		.sync_mode = WB_SYNC_NONE,
> +		.range_start = 0,
> +		.range_end = LLONG_MAX,
> +	};
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	u64 nr = U64_MAX;
>  
>  	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>  		return -EROFS;
>  
> -	return start_delalloc_inodes(root, &nr, true, false);
> +	return start_delalloc_inodes(root, &wbc, true, false);
>  }
>  
>  int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
>  			       bool in_reclaim_context)
>  {
> +	struct writeback_control wbc = {
> +		.nr_to_write = (nr == U64_MAX) ? LONG_MAX : (unsigned long)nr,
> +		.sync_mode = WB_SYNC_NONE,
> +		.range_start = 0,
> +		.range_end = LLONG_MAX,
> +	};
>  	struct btrfs_root *root;
>  	struct list_head splice;
>  	int ret;
> @@ -9489,6 +9508,13 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
>  	spin_lock(&fs_info->delalloc_root_lock);
>  	list_splice_init(&fs_info->delalloc_roots, &splice);
>  	while (!list_empty(&splice) && nr) {
> +		/*
> +		 * Reset nr_to_write here so we know that we're doing a full
> +		 * flush.
> +		 */
> +		if (nr == U64_MAX)
> +			wbc.nr_to_write = LONG_MAX;
> +
>  		root = list_first_entry(&splice, struct btrfs_root,
>  					delalloc_root);
>  		root = btrfs_grab_root(root);
> @@ -9497,9 +9523,9 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr,
>  			       &fs_info->delalloc_roots);
>  		spin_unlock(&fs_info->delalloc_root_lock);
>  
> -		ret = start_delalloc_inodes(root, &nr, false, in_reclaim_context);
> +		ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
>  		btrfs_put_root(root);
> -		if (ret < 0)
> +		if (ret < 0 || wbc.nr_to_write <= 0)
>  			goto out;
>  		spin_lock(&fs_info->delalloc_root_lock);
>  	}
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 67e55c5479b8..e8347461c8dd 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -532,7 +532,9 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
>  
>  	loops = 0;
>  	while ((delalloc_bytes || dio_bytes) && loops < 3) {
> -		btrfs_start_delalloc_roots(fs_info, items, true);
> +		u64 nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
> +
> +		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
>  
>  		loops++;
>  		if (wait_ordered && !trans) {
> -- 
> 2.26.2
