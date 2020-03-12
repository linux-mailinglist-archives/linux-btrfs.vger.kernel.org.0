Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D09183AD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Mar 2020 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCLUtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Mar 2020 16:49:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCLUtA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Mar 2020 16:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D0C9AAEB8;
        Thu, 12 Mar 2020 20:48:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1383FDA7A7; Thu, 12 Mar 2020 21:48:32 +0100 (CET)
Date:   Thu, 12 Mar 2020 21:48:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: relocation: Use btrfs_find_all_leaves() to locate
 parent tree leaves of a data extent
Message-ID: <20200312204832.GK12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310081415.49080-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310081415.49080-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 04:14:15PM +0800, Qu Wenruo wrote:
> In relocation, we need to locate all parent tree leaves referring one
> data extent, thus we have a complex mechanism to iterate throught extent
> tree and subvolume trees to locate related leaves.
> 
> However this is already done in backref.c, we have
> btrfs_find_all_leaves(), which can return a ulist containing all leaves
> referring to that data extent.
> 
> Use btrfs_find_all_leaves() to replace find_data_references().
      ^^^^^^^^^^J^^^^^^^^^^

The function is called btrfs_find_all_leafs, which is wrong spelling of
leaves, I was tempted to rename it in the same patch but unfortunately
ther's one more untouched caller so it's for another one.

> There is a special handling for v1 space cache data extents, where we
> need to delete the v1 space cache data extents, to avoid those data
> extents to hang the data relocation.
> 
> In this patch, the special handling is done by re-iterating the root
> tree leaf.
> Although it's a little less efficient than the old handling, considering
> we can reuse a lot of code, it should be acceptable.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This patch is originally in my backref cache branch, but since it's
> pretty independent from other backref cache code, and straightforward to
> test/review, it's sent for more comprehensive test/review/merge.
> ---
>  fs/btrfs/backref.c    |   8 +-
>  fs/btrfs/backref.h    |   4 +
>  fs/btrfs/relocation.c | 314 ++++++++----------------------------------
>  3 files changed, 62 insertions(+), 264 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 327e4480957b..f2728fb3ee8f 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1409,10 +1409,10 @@ static void free_leaf_list(struct ulist *blocks)
>   *
>   * returns 0 on success, <0 on error
>   */
> -static int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
> -				struct btrfs_fs_info *fs_info, u64 bytenr,
> -				u64 time_seq, struct ulist **leafs,
> -				const u64 *extent_item_pos, bool ignore_offset)
> +int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
> +			 struct btrfs_fs_info *fs_info, u64 bytenr,
> +			 u64 time_seq, struct ulist **leafs,
> +			 const u64 *extent_item_pos, bool ignore_offset)
>  {
>  	int ret;
>  
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 777f61dc081e..723d6da99114 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -40,6 +40,10 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
>  
>  int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
>  
> +int btrfs_find_all_leafs(struct btrfs_trans_handle *trans,
> +			 struct btrfs_fs_info *fs_info, u64 bytenr,
> +			 u64 time_seq, struct ulist **leafs,
> +			 const u64 *extent_item_pos, bool ignore_offset);
>  int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>  			 struct btrfs_fs_info *fs_info, u64 bytenr,
>  			 u64 time_seq, struct ulist **roots, bool ignore_offset);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 02afe294ee2d..319d50c7ada5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -23,6 +23,7 @@
>  #include "print-tree.h"
>  #include "delalloc-space.h"
>  #include "block-group.h"
> +#include "backref.h"
>  
>  /*
>   * Relocation overview
> @@ -3620,31 +3621,6 @@ static int __add_tree_block(struct reloc_control *rc,
>  	return ret;
>  }
>  
> -/*
> - * helper to check if the block use full backrefs for pointers in it
> - */
> -static int block_use_full_backref(struct reloc_control *rc,
> -				  struct extent_buffer *eb)
> -{
> -	u64 flags;
> -	int ret;
> -
> -	if (btrfs_header_flag(eb, BTRFS_HEADER_FLAG_RELOC) ||
> -	    btrfs_header_backref_rev(eb) < BTRFS_MIXED_BACKREF_REV)
> -		return 1;
> -
> -	ret = btrfs_lookup_extent_info(NULL, rc->extent_root->fs_info,
> -				       eb->start, btrfs_header_level(eb), 1,
> -				       NULL, &flags);
> -	BUG_ON(ret);
> -
> -	if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)
> -		ret = 1;
> -	else
> -		ret = 0;
> -	return ret;
> -}
> -
>  static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_block_group *block_group,
>  				    struct inode *inode,
> @@ -3688,174 +3664,42 @@ static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
>  }
>  
>  /*
> - * helper to add tree blocks for backref of type BTRFS_EXTENT_DATA_REF_KEY
> - * this function scans fs tree to find blocks reference the data extent
> + * Helper function to locate the free space cache EXTENT_DATA in root tree leaf
> + * and delete the cache inode, to avoid free space cache data extent blocking
> + * data relocation.
>   */
> -static int find_data_references(struct reloc_control *rc,
> -				struct btrfs_key *extent_key,
> -				struct extent_buffer *leaf,
> -				struct btrfs_extent_data_ref *ref,
> -				struct rb_root *blocks)
> +static int delete_v1_space_cache(struct btrfs_fs_info *fs_info,
> +				 struct extent_buffer *leaf,

The fs_info seems to be redundant, so I've replaced it with
leaf->fs_info here

> +	ret = delete_block_group_cache(fs_info, block_group, NULL,
> +					space_cache_ino);
> +	return ret;
>  }
