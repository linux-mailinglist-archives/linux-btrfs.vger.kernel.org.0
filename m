Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87B8C1D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfI3Ilf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 04:41:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:47614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfI3Ilf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 04:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53B86AF7E;
        Mon, 30 Sep 2019 08:41:32 +0000 (UTC)
Subject: Re: [PATCH 2/3] btrfs-progs: check/original: Add check and repair for
 invalid inode generation
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190924081120.6283-1-wqu@suse.com>
 <20190924081120.6283-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a621612d-21b7-cc30-ff5a-2502eee5acc4@suse.com>
Date:   Mon, 30 Sep 2019 11:41:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924081120.6283-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.09.19 г. 11:11 ч., Qu Wenruo wrote:
> There are at least two bug reports of kernel tree-checker complaining
> about invalid inode generation.
> 
> All offending inodes seem to be caused by old kernel around 2014, with
> inode generation overflow.
> 
> So add such check and repair ability to lowmem mode check first.
> 
> This involves:
> - Calculate the inode generation upper limit
>   Unlike the original mode context, we don't have anyway to determine if

Perhaps you meant "lowmem mode context" since in lowmem you deduce
whether it's a log-tree inode or not.

>   this inode belongs to log tree.
>   So we use super_generation + 1 as upper limit, just like what we did
>   in kernel tree checker.
> 
> - Check if the inode generation is larger than the upper limit
> 
> - Repair by resetting inode generation to current transaction
>   generation
>   The difference is, in original mode, we have a common trans handle for
>   all repair and reset path for each repair.
> 
> Reported-by: Charles Wright <charles.v.wright@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I tested that code with the image provided and it does work as expected
as well as it's fairly obvious what's happening. So:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  check/main.c          | 50 ++++++++++++++++++++++++++++++++++++++++++-
>  check/mode-original.h |  1 +
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index c2d0f394..018707c8 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -604,6 +604,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
>  	if (errors & I_ERR_INVALID_IMODE)
>  		fprintf(stderr, ", invalid inode mode bit 0%o",
>  			rec->imode & ~07777);
> +	if (errors & I_ERR_INVALID_GEN)
> +		fprintf(stderr, ", invalid inode generation");
>  	fprintf(stderr, "\n");
>  
>  	/* Print the holes if needed */
> @@ -857,6 +859,7 @@ static int process_inode_item(struct extent_buffer *eb,
>  {
>  	struct inode_record *rec;
>  	struct btrfs_inode_item *item;
> +	u64 gen_uplimit;
>  	u64 flags;
>  
>  	rec = active_node->current;
> @@ -879,6 +882,13 @@ static int process_inode_item(struct extent_buffer *eb,
>  	if (S_ISLNK(rec->imode) &&
>  	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
>  		rec->errors |= I_ERR_ODD_INODE_FLAGS;
> +	/*
> +	 * We don't have accurate root info to determine the correct
> +	 * inode generation uplimit, use super_generation + 1 anyway
> +	 */
> +	gen_uplimit = btrfs_super_generation(global_info->super_copy) + 1;
> +	if (btrfs_inode_generation(eb, item) > gen_uplimit)
> +		rec->errors |= I_ERR_INVALID_GEN;
>  	maybe_free_inode_rec(&active_node->inode_cache, rec);
>  	return 0;
>  }
> @@ -2774,6 +2784,41 @@ static int repair_imode_original(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
> +				     struct btrfs_root *root,
> +				     struct btrfs_path *path,
> +				     struct inode_record *rec)
> +{
> +	struct btrfs_inode_item *ii;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	key.objectid = rec->ino;
> +	key.offset = 0;
> +	key.type = BTRFS_INODE_ITEM_KEY;
> +
> +	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
> +	if (ret > 0) {
> +		ret = -ENOENT;
> +		error("no inode item found for ino %llu", rec->ino);
> +		return ret;
> +	}
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to search inode item for ino %llu: %m", rec->ino);
> +		return ret;
> +	}
> +	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			    struct btrfs_inode_item);
> +	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
> +	btrfs_mark_buffer_dirty(path->nodes[0]);
> +	btrfs_release_path(path);
> +	printf("resetting inode generation to %llu for ino %llu\n",
> +		trans->transid, rec->ino);
> +	rec->errors &= ~I_ERR_INVALID_GEN;
> +	return 0;
> +}
> +
>  static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
>  {
>  	struct btrfs_trans_handle *trans;
> @@ -2794,7 +2839,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
>  			     I_ERR_FILE_NBYTES_WRONG |
>  			     I_ERR_INLINE_RAM_BYTES_WRONG |
>  			     I_ERR_MISMATCH_DIR_HASH |
> -			     I_ERR_UNALIGNED_EXTENT_REC)))
> +			     I_ERR_UNALIGNED_EXTENT_REC |
> +			     I_ERR_INVALID_GEN)))
>  		return rec->errors;
>  
>  	/*
> @@ -2829,6 +2875,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
>  		ret = repair_unaligned_extent_recs(trans, root, &path, rec);
>  	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
>  		ret = repair_imode_original(trans, root, &path, rec);
> +	if (!ret && rec->errors & I_ERR_INVALID_GEN)
> +		ret = repair_inode_gen_original(trans, root, &path, rec);
>  	btrfs_commit_transaction(trans, root);
>  	btrfs_release_path(&path);
>  	return ret;
> diff --git a/check/mode-original.h b/check/mode-original.h
> index 78d6bb30..b075a95c 100644
> --- a/check/mode-original.h
> +++ b/check/mode-original.h
> @@ -185,6 +185,7 @@ struct unaligned_extent_rec_t {
>  #define I_ERR_INLINE_RAM_BYTES_WRONG	(1 << 17)
>  #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
>  #define I_ERR_INVALID_IMODE		(1 << 19)
> +#define I_ERR_INVALID_GEN		(1 << 20)
>  
>  struct inode_record {
>  	struct list_head backrefs;
> 
