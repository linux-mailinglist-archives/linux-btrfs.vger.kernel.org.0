Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB229EAFB
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgJ2Luo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 07:50:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgJ2Luo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 07:50:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lCsOLWjxqUS493XwMM4d16eXv1dv57WX3AjuwE6XbaE=;
        b=pCqD/OhqFVJd52hQPBntXVHKEdXCWSdXvuvFVfz/BvGLYShvLqSAP9s/hgKzWz/0hFRAw3
        MWAo780Bq/Ns+oXUVQyqRifN0P+oPmWpKqKIt0DVA82W0ntwgdjHaSTGO2HwL4vq4o15CV
        PDTzfOi7ghjx8KDRdg037PY8L4imTGI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 147CEACBA;
        Thu, 29 Oct 2020 11:50:42 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] btrfs: file-item: refactor btrfs_lookup_bio_sums()
 to handle out-of-order bvecs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-4-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <765375f6-7c4f-e9d9-f0f5-3de9bac74cce@suse.com>
Date:   Thu, 29 Oct 2020 13:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029071218.49860-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.10.20 г. 9:12 ч., Qu Wenruo wrote:
> Refactor btrfs_lookup_bio_sums() by:
> - Remove the @file_offset parameter
>   There are two factors making the @file_offset parameter useless:
>   * For csum lookup in csum tree, file offset makes no sense
>     We only need disk_bytenr, which is unrelated to file_offset
>   * page_offset (file offset) of each bvec is not contig
>     bio can be merged, meaning we could have pages at different
>     file offsets in the same bio.
>   Thus passing file_offset makes no sense any longer.
>   The only user of file_offset is for data reloc inode, we will use
>   a new function, search_file_offset_in_bio(), to handle it.
> 
> - Extract the csum tree lookup into find_csum_tree_sums()
>   The new function will handle the csum search in csum tree.
>   The return value is the same as btrfs_find_ordered_sum(), returning
>   the found number of sectors who has checksum.
> 
> - Change how we do the main loop
>   The only needed info from bio is:
>   * the on-disk bytenr
>   * the file_offset (if file_offset == (u64)-1)
>   * the length
> 
>   After extracting above info, we can do the search without bio
>   at all, which makes the main loop much simpler:
> 
> 	for (cur_disk_bytenr = orig_disk_bytenr;
> 	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
> 	     cur_disk_bytenr += count * sectorsize) {
> 
> 		/* Lookup csum tree */
> 		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
> 					    search_len, csum_dst);
> 		if (!count) {
> 			/* Csum hole handling */
> 		}
> 	}
> 
> - Use single variable as core to calculate all other offsets
>   Instead of all differnt type of variables, we use only one core
>   variable, cur_disk_bytenr, which represents the current disk bytenr.
> 
>   All involves values can be calculated from that core variable, and
>   all those variable will only be visible in the inner loop.
> 
> 	diff_sectors = div_u64(cur_disk_bytenr - orig_disk_bytenr,
> 			       sectorsize);
> 	cur_disk_bytenr = orig_disk_bytenr +
> 			  diff_sectors * sectorsize;
> 	csum_dst = csum + diff_sectors * csum_size;
> 
> All above refactor makes btrfs_lookup_bio_sums() way more robust than it
> used to, especially related to the file offset lookup.
> Now file_offset lookup is only related to data reloc inode, other wise
> we don't need to bother file_offset at all.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c |   4 +-
>  fs/btrfs/ctree.h       |   2 +-
>  fs/btrfs/file-item.c   | 256 ++++++++++++++++++++++++++---------------
>  fs/btrfs/inode.c       |   5 +-
>  4 files changed, 171 insertions(+), 96 deletions(-)
> 

<snip>


> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index acacdd0bfe2c..85e7a3618a07 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -239,39 +239,140 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +/*
> + * Helper to find csums for logical bytenr range
> + * [disk_bytenr, disk_bytenr + len) and restore the result to @dst.

nit: s/restore/store

> + *
> + * Return >0 for the number of sectors we found.
> + * Return 0 for the range [disk_bytenr, disk_bytenr + sectorsize) has no csum
> + * for it. Caller may want to try next sector until one range is hit.
> + * Return <0 for fatal error.
> + */
> +static int find_csum_tree_sums(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_path *path, u64 disk_bytenr,
> +			       u64 len, u8 *dst)

A better name would be search_csum_tree.

> +{
> +	struct btrfs_csum_item *item = NULL;
> +	struct btrfs_key key;
> +	u32 csum_size = btrfs_super_csum_size(fs_info->super_copy);

nit: Why u32, btrfs_super_csum_size is defined as returning 'int',
however this function is really returning u16 since "struct btrfs_csums"
is defined as u16.

> +	u32 sectorsize = fs_info->sectorsize;
> +	int ret;
> +	u64 csum_start;
> +	u64 csum_len;
> +
> +	ASSERT(IS_ALIGNED(disk_bytenr, sectorsize) &&
> +	       IS_ALIGNED(len, sectorsize));
> +
> +	/* Check if the current csum item covers disk_bytenr */
> +	if (path->nodes[0]) {
> +		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +				      struct btrfs_csum_item);
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +		csum_start = key.offset;
> +		csum_len = btrfs_item_size_nr(path->nodes[0], path->slots[0]) /

nit: put the division in brackets, it doesn't affect correctness but it
makes it more obvious since multiplication and division have same
precedence then associativitiy comes into play...

> +			   csum_size * sectorsize;
> +
> +		if (csum_start <= disk_bytenr &&
> +		    csum_start + csum_len > disk_bytenr)

if (in_range(disk_bytenr, csum_start, csum_len))

> +			goto found;
> +	}
> +
> +	/* Current item doesn't contain the desired range, re-search */
> +	btrfs_release_path(path);
> +	item = btrfs_lookup_csum(NULL, fs_info->csum_root, path,
> +				 disk_bytenr, 0);
> +	if (IS_ERR(item)) {
> +		ret = PTR_ERR(item);
> +		goto out;
> +	}
> +found:

The found label could be moved right before ret = div_u64 since if you
go directly to it it's guaranteed you have already done the
btrfs_item_to_key et al operations so you are simply duplicating them now.

> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	csum_start = key.offset;
> +	csum_len = btrfs_item_size_nr(path->nodes[0], path->slots[0]) /
> +		   csum_size * sectorsize;

nit: put brackets around division.

> +	ASSERT(csum_start <= disk_bytenr &&
> +	       csum_start + csum_len > disk_bytenr);

Use in_range macro

> +
> +	ret = div_u64(min(csum_start + csum_len, disk_bytenr + len) -
> +		      disk_bytenr, sectorsize);
> +	read_extent_buffer(path->nodes[0], dst, (unsigned long)item,
> +			ret * csum_size);
> +out:
> +	if (ret == -ENOENT) {
> +		ret = 0;
> +		memset(dst, 0, csum_size);
> +	}
> +	return ret;
> +}
> +
> +/*
> + * A helper to locate the file_offset of @cur_disk_bytenr of a @bio.
> + *
> + * Bio of btrfs represents read range of
> + * [bi_sector << 9, bi_sector << 9 + bi_size).
> + * Knowing this, we can iterate through each bvec to locate the page belong to
> + * @cur_disk_bytenr and get the file offset.
> + *
> + * @inode is used to determine the bvec page really belongs to @inode.
> + *
> + * Return 0 if we can't find the file offset;
> + * Return >0 if we find the file offset and restore it to @file_offset_ret
> + */
> +static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
> +				     u64 disk_bytenr, u64 *file_offset_ret)
> +{
> +	struct bvec_iter iter;
> +	struct bio_vec bvec;
> +	u64 cur = bio->bi_iter.bi_sector << 9;
> +	int ret = 0;
> +
> +	bio_for_each_segment(bvec, bio, iter) {
> +		struct page *page = bvec.bv_page;
> +
> +		if (cur > disk_bytenr)
> +			break;
> +		if (cur + bvec.bv_len <= disk_bytenr) {
> +			cur += bvec.bv_len;
> +			continue;
> +		}
> +		ASSERT(cur <= disk_bytenr && cur + bvec.bv_len > disk_bytenr);

in_range(disk_bytenr, cur, bvec.bv_len)

> +		if (page && page->mapping && page->mapping->host &&
> +		    page->mapping->host == inode) {
We are guaranteed to always have a page, since this bvec will have been
aded via bio_add_page, since those will be data pages we are guaranteed
to have mapping and mapping->host, so you ought to only check if it's
the same inode, no ?

> +			ret = 1;
> +			*file_offset_ret = page_offset(page) + bvec.bv_offset
> +				+ disk_bytenr - cur;
> +			break;
> +		}
> +	}
> +	return ret;
> +}

> +
<snip>

> @@ -323,81 +427,53 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>  		path->skip_locking = 1;
>  	}
>  
> -	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
> -
> -	bio_for_each_segment(bvec, bio, iter) {
> -		page_bytes_left = bvec.bv_len;
> -		if (count)
> -			goto next;
> -
> -		if (page_offsets)
> -			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
> +	for (cur_disk_bytenr = orig_disk_bytenr;
> +	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
> +	     cur_disk_bytenr += count * sectorsize) {
> +		int search_len = orig_disk_bytenr + orig_len - cur_disk_bytenr;
> +		int diff_sectors;

 This variable is misnamed, it's  really offset_sector or sector_offset.

> +		u8 *csum_dst;> +
> +		diff_sectors = div_u64(cur_disk_bytenr - orig_disk_bytenr,
> +				       sectorsize);
> +		cur_disk_bytenr = orig_disk_bytenr +
> +				  diff_sectors * sectorsize;

Since you already increment cur_disk_bytenr with count * sector size
where count is the number of csums, why do you have recalculate it here?
Furthermore you convert to sectors in diff_sectors and then you multiply
it by sectorsize which gives you back just cur_disk_bytenr -
orig_disk_bytenr so the end expression is:

cur_disk_bytenr = orig_disk_bytenr + cur_disk_bytenr - orig_disk_bytenr
=> cur_disk_bytenr = cur_disk_bytenr - am I missing something?


> +		csum_dst = csum + diff_sectors * csum_size;
> +
> +		count = find_csum_tree_sums(fs_info, path, cur_disk_bytenr,
> +					    search_len, csum_dst);

Missing error handling if count is negative!

> +		if (!count) {
> +			/*
> +			 * For not found case, the csum has been zeroed
> +			 * in find_csum_tree_sums() already, just skip
> +			 * to next sector.
> +			 */
> +			count = 1;

<snip>

