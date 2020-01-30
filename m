Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1814D992
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3LRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 06:17:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:56980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3LRf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 06:17:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 570BEAF8E;
        Thu, 30 Jan 2020 11:17:32 +0000 (UTC)
Subject: Re: [PATCH 3/6] btrfs: introduce the inode->file_extent_tree
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
 <20200117140224.42495-4-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3c35e341-0313-54ce-77c9-0ca2eba4c85b@suse.com>
Date:   Thu, 30 Jan 2020 13:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117140224.42495-4-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.01.20 г. 16:02 ч., Josef Bacik wrote:
> In order to keep track of where we have file extents on disk, and thus
> where it is safe to adjust the i_size to, we need to have a tree in
> place to keep track of the contiguous areas we have file extents for.
> Add helpers to use this tree, as it's not required for NO_HOLES file
> systems.  We will use this by setting DIRTY for areas we know we have
> file extent item's set, and clearing it when we remove file extent items
> for truncation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/btrfs_inode.h    |  5 +++
>  fs/btrfs/ctree.h          |  5 +++
>  fs/btrfs/extent-io-tree.h |  1 +
>  fs/btrfs/extent_io.c      | 11 +++++
>  fs/btrfs/file-item.c      | 91 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c          |  6 +++
>  6 files changed, 119 insertions(+)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4e12a477d32e..d9dcbac513ed 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -60,6 +60,11 @@ struct btrfs_inode {
>  	 */
>  	struct extent_io_tree io_failure_tree;
>  
> +	/* keeps track of where we have extent items mapped in order to make
> +	 * sure our i_size adjustments are accurate.
> +	 */
> +	struct extent_io_tree file_extent_tree;
> +
>  	/* held while logging the inode in tree-log.c */
>  	struct mutex log_mutex;
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 00cf1641f1b9..8a2c1665baad 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2851,6 +2851,11 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>  				     struct btrfs_file_extent_item *fi,
>  				     const bool new_inline,
>  				     struct extent_map *em);
> +int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
> +					u64 len);
> +int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
> +				      u64 len);
> +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isize);
>  
>  /* inode.c */
>  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index a3febe746c79..c8bcd2e3184c 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -44,6 +44,7 @@ enum {
>  	IO_TREE_TRANS_DIRTY_PAGES,
>  	IO_TREE_ROOT_DIRTY_LOG_PAGES,
>  	IO_TREE_SELFTEST,
> +	IO_TREE_INODE_FILE_EXTENT,
>  };
>  
>  struct extent_io_tree {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0d40cd7427ba..f9b223d827b3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -265,6 +265,15 @@ void __cold extent_io_exit(void)
>  	bioset_exit(&btrfs_bioset);
>  }
>  
> +/*
> + * For the file_extent_tree, we want to hold the inode lock when we lookup and
> + * update the disk_i_size, but lockdep will complain because our io_tree we hold
> + * the tree lock and get the inode lock when setting delalloc.  These two things
> + * are unrelated, so make a class for the file_extent_tree so we don't get the
> + * two locking patterns mixed up.
> + */
> +static struct lock_class_key file_extent_tree_class;
> +
>  void extent_io_tree_init(struct btrfs_fs_info *fs_info,
>  			 struct extent_io_tree *tree, unsigned int owner,
>  			 void *private_data)
> @@ -276,6 +285,8 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
>  	spin_lock_init(&tree->lock);
>  	tree->private_data = private_data;
>  	tree->owner = owner;
> +	if (owner == IO_TREE_INODE_FILE_EXTENT)
> +		lockdep_set_class(&tree->lock, &file_extent_tree_class);
>  }
>  
>  void extent_io_tree_release(struct extent_io_tree *tree)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index c2f365662d55..e5dc6c4b2f05 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -23,6 +23,97 @@
>  #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
>  				       PAGE_SIZE))
>  
> +/**
> + * @inode - the inode we want to update the disk_i_size for
> + * @new_isize - the isize we want to set to, 0 if we use i_size
> + *
> + * With NO_HOLES set this simply sets the disk_is_size to whatever i_size_read()
> + * returns as it is perfectly fine with a file that has holes without hole file
> + * extent items.
> + *
> + * However for !NO_HOLES we need to only return the area that is contiguous from
> + * the 0 offset of the file.  Otherwise we could end up adjust i_size up to an
> + * extent that has a gap in between.
> + *
> + * Finally new_isize should only be set in the case of truncate where we're not
> + * ready to use i_size_read() as the limiter yet.
> + */
> +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isize)
> +{
> +	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> +	u64 start, end, isize;
> +	int ret;
> +
> +	isize = new_isize ? new_isize : i_size_read(inode);
> +	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
> +		BTRFS_I(inode)->disk_i_size = isize;
> +		return;
> +	}
> +
> +	spin_lock(&BTRFS_I(inode)->lock);
> +	ret = find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, 0,
> +				    &start, &end, EXTENT_DIRTY, NULL);
> +	if (!ret && start == 0)
> +		isize = min(isize, end + 1);
> +	else
> +		isize = 0;
> +	BTRFS_I(inode)->disk_i_size = isize;
> +	spin_unlock(&BTRFS_I(inode)->lock);
> +}
> +


What if we have the following layout for an inode:

[----1M-EXTЕNT---][----2M-HOLE--------][------3M-EXTENT-----------]

In this case the idisk size should be 4m whereas with the above code it
will be 1M. Isn't this wrong?
