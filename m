Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324A65A874
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 01:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjAAALf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 19:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAAALe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 19:11:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CCDDD
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 16:11:32 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1ovstA27mR-00suLy; Sun, 01
 Jan 2023 01:11:24 +0100
Message-ID: <d494c63e-c111-b559-9567-0cbe21a069d2@gmx.com>
Date:   Sun, 1 Jan 2023 08:11:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Siddhartha Menon <siddharthamenon@outlook.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
References: <20221231184749.28896-1-siddharthamenon@outlook.com>
 <PAXP193MB20897179089B101CFFFB4B7CA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 2/2] Fix several style errors in fs/btrfs/inode.c
In-Reply-To: <PAXP193MB20897179089B101CFFFB4B7CA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:773/3WfeLMsp6Tmfi7+c6PDHkKeQPl20alWafnTIatuL1dWYNe6
 ArYGBHkLo2ujEaDeTdHbgvXQDoATur34DKRCMGNaLFLLPDJojv7LghBDkVcCxrcfng6SSE2
 ANGIw6XLu950i55CYzGV/V0wmX4Rlz+CknKSIFt+0htPp0NRtqIBaNW1rZ9cVEQdFlfni+z
 mDoIsRgCLwQbFPZZ7tVOQ==
UI-OutboundReport: notjunk:1;M01:P0:8PQw3ZXhuyY=;nT3wLSyNDciJZj1qu0KGlAth9AQ
 /1stRgtDhzPjx35wKduMy2C+F+xT6oUJ0dWQ9ef6eSGIjcXcwgUJ7vYny2ae6LSdRnso61siD
 u+ejio34GokcXmd2y4p0J25rkLv7LPJv+i09V1Exock3sxXYARKGJpcvgNCxJF5V6urSCd3/w
 /d7ta2C9YeXHLGPczvxI2A/Y+IY/K0p35JNnCGk3l7nH+bTT2RTs1ienQXVjZLk8fhLi9F4VW
 DwITpx2QXXfbNH/cHPm6atLdY46/QFWISkgKKXhaYu7Fy0jHddPRPMxSyIYHP7I+A/5YPzLQ8
 /tbrYJkQBaFzVBzGJ8u/VE8N2ilewgTsyE1LV2hfOD9A56+KkaEnZFHbWWefCgcMu0jWfYTiL
 +LHOtc4TP2qJY/siPJ6T71Yofh/3iZQSBmX4QTV2QufEMeAgXp+pGQJHQdviWSm08wHnidgKt
 CL4iAZp65h0tV2UeFx/34RZGxz0SudnGr6wkSzgzv51YHSqpnD7ekC0ZgFvV0GT1VQ8Hqh0Ig
 ZkLBsQ6r56/XLUdHa7G7rPxipdCsUjoH9pyOB13RtkTJpnlC0vx197S5VzVGRFXpiMZokE+t5
 WIaiD9sIvLskA3WpnTXd4wat6BuLFlpsL54gVaxmA1LR+vYPgTHWnnD21wYXYTLKTWkO6oLTk
 lsWriM6I8CXQ6sQMyGmukD/2sy5Vt7QGg9pVtqKGKK2HhTv5cjDg9ME5WAgr5HaGENRukXL6C
 MOu0FECc07WNfWaPZ9I1psnb+cDY0Nx/lL88ecABIWvggM8joPebAH/ct76eNSG+nGCEBFmfO
 BEOWnVzCw8a2hUHCvCKJFJVkFJW1eFOx0bTsRWz6/gQuS2ee0ttt04TcuMs4Wi7j39Vv9xthB
 XRnuvRSkVeYTn71TtbSegKsXm6v9gmjuxCnPOeoJDZ69NNHhBbcrjqDzRuSRXsaKqW11dWLRB
 IFE/FamHm1jDbfesrOgQZgAjydY=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/1 02:47, Siddhartha Menon wrote:
> Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>

Even for pure style cleanup, you need a commit message.

Not to mention this is not a simple style cleanup.

There are several big problems affecting some core components, did you 
ever test the patches?

> ---
>   fs/btrfs/inode.c | 49 +++++++++++++++++++++++++-----------------------
>   1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cb95d47e4d02..ee7ca0e69aa1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -366,6 +366,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>   	if (compress_type != BTRFS_COMPRESS_NONE) {
>   		struct page *cpage;
>   		int i = 0;
> +

You can submit a patch to address all such missing newline between 
declaration and code.

IIRC there used to be a warning for this.

>   		while (compressed_size > 0) {
>   			cpage = compressed_pages[i];
>   			cur_size = min_t(unsigned long, compressed_size,
> @@ -1221,7 +1222,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   	u64 blocksize = fs_info->sectorsize;
>   	struct btrfs_key ins;
>   	struct extent_map *em;
> -	unsigned clear_bits;
> +	unsigned int clear_bits;
>   	unsigned long page_ops;
>   	bool extent_reserved = false;
>   	int ret = 0;
> @@ -1557,7 +1558,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>   	u64 num_chunks = DIV_ROUND_UP(end - start, SZ_512K);
>   	int i;
>   	bool should_compress;
> -	unsigned nofs_flag;
> +	unsigned int nofs_flag;

For unsigned -> unsigned int, it's also fine to do it in a separate 
patch, not mixing with other different changes.

>   	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
>   
>   	unlock_extent(&inode->io_tree, start, end, NULL);
> @@ -1575,7 +1576,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>   	memalloc_nofs_restore(nofs_flag);
>   
>   	if (!ctx) {
> -		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
> +		unsigned int clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
>   			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
>   			EXTENT_DO_ACCOUNTING;
>   		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
> @@ -3846,7 +3847,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>   				ret = PTR_ERR(trans);
>   				goto out;
>   			}
> -			btrfs_debug(fs_info, "auto deleting %Lu",
> +			btrfs_debug(fs_info, "auto deleting %llu",
>   				    found_key.objectid);
>   			ret = btrfs_del_orphan_item(trans, root,
>   						    found_key.objectid);
> @@ -3892,8 +3893,8 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
>   {
>   	u32 nritems = btrfs_header_nritems(leaf);
>   	struct btrfs_key found_key;
> -	static u64 xattr_access = 0;
> -	static u64 xattr_default = 0;
> +	static u64 xattr_access;
> +	static u64 xattr_default;

Nope, xattr_access is immediately read.
If you removed the initialization, we got garbage.


In fact, you should initialize them using the same lines at the if 
(!xattr_access) branch.


>   	int scanned = 0;
>   
>   	if (!xattr_access) {
> @@ -4920,7 +4921,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>   	bool only_release_metadata = false;
>   	u32 blocksize = fs_info->sectorsize;
>   	pgoff_t index = from >> PAGE_SHIFT;
> -	unsigned offset = from & (blocksize - 1);
> +	unsigned int offset = from & (blocksize - 1);
>   	struct page *page;
>   	gfp_t mask = btrfs_alloc_write_mask(mapping);
>   	size_t write_bytes = blocksize;
> @@ -5358,7 +5359,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
>   		struct extent_state *cached_state = NULL;
>   		u64 start;
>   		u64 end;
> -		unsigned state_flags;
> +		unsigned int state_flags;
>   
>   		node = rb_first(&io_tree->state);
>   		state = rb_entry(node, struct extent_state, rb_node);
> @@ -5842,7 +5843,7 @@ static struct inode *new_simple_dir(struct super_block *s,
>   	inode->i_op = &simple_dir_inode_operations;
>   	inode->i_opflags &= ~IOP_XATTR;
>   	inode->i_fop = &simple_dir_operations;
> -	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
> +	inode->i_mode = 0755;

Big NO. You completely ignored the file type.

>   	inode->i_mtime = current_time(inode);
>   	inode->i_atime = inode->i_mtime;
>   	inode->i_ctime = inode->i_mtime;
> @@ -5983,7 +5984,7 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
>   struct dir_entry {
>   	u64 ino;
>   	u64 offset;
> -	unsigned type;
> +	unsigned int type;
>   	int name_len;
>   };
>   
> @@ -6667,9 +6668,11 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>   	if (unlikely(ino == BTRFS_FIRST_FREE_OBJECTID)) {
>   		u64 local_index;
>   		int err;
> +
>   		err = btrfs_del_root_ref(trans, key.objectid,
>   					 root->root_key.objectid, parent_ino,
>   					 &local_index, name);
> +

I don't think the newline is ever needed.

>   		if (err)
>   			btrfs_abort_transaction(trans, err);
>   	} else if (add_backref) {
> @@ -8930,20 +8933,20 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
>   
>   	while (1) {
>   		ordered = btrfs_lookup_first_ordered_extent(inode, (u64)-1);
> +
>   		if (!ordered)
>   			break;
> -		else {
> -			btrfs_err(root->fs_info,
> -				  "found ordered extent %llu %llu on inode cleanup",
> -				  ordered->file_offset, ordered->num_bytes);
>   
> -			if (!freespace_inode)
> -				btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
> +		btrfs_err(root->fs_info,

The error message is only supposed to be triggered at if (!ordered) branch.

But now it's unconditionally.

> +			  "found ordered extent %llu %llu on inode cleanup",
> +			  ordered->file_offset, ordered->num_bytes);
>   
> -			btrfs_remove_ordered_extent(inode, ordered);
> -			btrfs_put_ordered_extent(ordered);
> -			btrfs_put_ordered_extent(ordered);
> -		}
> +		if (!freespace_inode)
> +			btrfs_lockdep_acquire(root->fs_info, btrfs_ordered_extent);
> +
> +		btrfs_remove_ordered_extent(inode, ordered);
> +		btrfs_put_ordered_extent(ordered);
> +		btrfs_put_ordered_extent(ordered);
>   	}
>   	btrfs_qgroup_check_reserved_leak(inode);
>   	inode_tree_del(inode);
> @@ -9357,10 +9360,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
>   	if (ret) {
>   		if (ret == -EEXIST) {
>   			/* we shouldn't get

If you're changing the style, please also change the comment to follow 
the common standard.

Thanks,
Qu
> -			 * eexist without a new_inode */
> -			if (WARN_ON(!new_inode)) {
> +			 * eexist without a new_inode
> +			 */
> +			if (WARN_ON(!new_inode))
>   				goto out_fscrypt_names;
> -			}
>   		} else {
>   			/* maybe -EOVERFLOW */
>   			goto out_fscrypt_names;
