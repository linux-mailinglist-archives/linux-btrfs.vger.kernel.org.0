Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9C19E1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEJN1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 09:27:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfEJN1k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 09:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3701AE1F
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 13:27:38 +0000 (UTC)
Subject: Re: [PATCH 05/17] btrfs: don't assume ordered sums to be 4 bytes
From:   Nikolay Borisov <nborisov@suse.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-6-jthumshirn@suse.de>
 <9f6864d5-9659-a121-5de1-3e5993eabef8@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <12f8e39d-99e5-3244-a61a-71819ed5586f@suse.com>
Date:   Fri, 10 May 2019 16:27:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f6864d5-9659-a121-5de1-3e5993eabef8@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.05.19 г. 16:25 ч., Nikolay Borisov wrote:
> 
> 
> On 10.05.19 г. 14:15 ч., Johannes Thumshirn wrote:
>> BTRFS has the implicit assumption that a checksum in btrfs_orderd_sums is 4
>> bytes. While this is true for CRC32C, it is not for any other checksum.
>>
>> Change the data type to be a byte array and adjust loop index calculation
>> accordingly.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> ---
>>  fs/btrfs/compression.c  |  4 ++--
>>  fs/btrfs/ctree.h        |  3 ++-
>>  fs/btrfs/file-item.c    | 28 +++++++++++++++-------------
>>  fs/btrfs/ordered-data.c | 10 ++++++----
>>  fs/btrfs/ordered-data.h |  4 ++--
>>  fs/btrfs/scrub.c        |  2 +-
>>  6 files changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 4ec1df369e47..98d8c2ed367f 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -632,7 +632,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>>  
>>  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>>  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
>> -							    sums);
>> +							    (u8 *)sums);
> 
> This cast (and other similar) are plain ugly. Imho we first need to get
> the code into shape for later modification. This means postponing sha256
> patch and instead focusing on first getting the code to use u8 where
> relevant. Otherwise such cleanup is going to be postponed for "some time
> in the future" will is unlikely to ever materialize.

Oh, so you fix that in the next patch. Okay, disregard this then.
> 
>>  				BUG_ON(ret); /* -ENOMEM */
>>  			}
>>  			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
>> @@ -658,7 +658,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>>  	BUG_ON(ret); /* -ENOMEM */
>>  
>>  	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>> -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>> +		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u8 *) sums);
>>  		BUG_ON(ret); /* -ENOMEM */
>>  	}
>>  
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 0a2a377f1640..e62934fb8748 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3184,7 +3184,8 @@ int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
>>  struct btrfs_dio_private;
>>  int btrfs_del_csums(struct btrfs_trans_handle *trans,
>>  		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
>> -blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u32 *dst);
>> +blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>> +				   u8 *dst);
>>  blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
>>  			      u64 logical_offset);
>>  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index d431ea8198e4..210ff69917a0 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -22,9 +22,9 @@
>>  #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
>>  				       PAGE_SIZE))
>>  
>> -#define MAX_ORDERED_SUM_BYTES(fs_info) ((PAGE_SIZE - \
>> +#define MAX_ORDERED_SUM_BYTES(fs_info, csum_size) ((PAGE_SIZE - \
>>  				   sizeof(struct btrfs_ordered_sum)) / \
>> -				   sizeof(u32) * (fs_info)->sectorsize)
>> +				   (csum_size) * (fs_info)->sectorsize)
>>  
>>  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
>>  			     struct btrfs_root *root,
>> @@ -144,7 +144,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>>  }
>>  
>>  static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>> -				   u64 logical_offset, u32 *dst, int dio)
>> +				   u64 logical_offset, u8 *dst, int dio)
>>  {
>>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>  	struct bio_vec bvec;
>> @@ -211,7 +211,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
>>  		if (!dio)
>>  			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
>>  		count = btrfs_find_ordered_sum(inode, offset, disk_bytenr,
>> -					       (u32 *)csum, nblocks);
>> +					       csum, nblocks);
>>  		if (count)
>>  			goto found;
>>  
>> @@ -283,7 +283,8 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
>>  	return 0;
>>  }
>>  
>> -blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u32 *dst)
>> +blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>> +				   u8 *dst)
>>  {
>>  	return __btrfs_lookup_bio_sums(inode, bio, 0, dst, 0);
>>  }
>> @@ -374,7 +375,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>>  				      struct btrfs_csum_item);
>>  		while (start < csum_end) {
>>  			size = min_t(size_t, csum_end - start,
>> -				     MAX_ORDERED_SUM_BYTES(fs_info));
>> +				     MAX_ORDERED_SUM_BYTES(fs_info, csum_size));
>>  			sums = kzalloc(btrfs_ordered_sum_size(fs_info, size),
>>  				       GFP_NOFS);
>>  			if (!sums) {
>> @@ -439,6 +440,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
>>  	int i;
>>  	u64 offset;
>>  	unsigned nofs_flag;
>> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>>  
>>  	nofs_flag = memalloc_nofs_save();
>>  	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
>> @@ -473,6 +475,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
>>  						 - 1);
>>  
>>  		for (i = 0; i < nr_sectors; i++) {
>> +			u32 tmp;
>>  			if (offset >= ordered->file_offset + ordered->len ||
>>  				offset < ordered->file_offset) {
>>  				unsigned long bytes_left;
>> @@ -498,17 +501,16 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
>>  				index = 0;
>>  			}
>>  
>> -			sums->sums[index] = ~(u32)0;
>> +			memset(&sums->sums[index], 0xff, csum_size);
>>  			data = kmap_atomic(bvec.bv_page);
>> -			sums->sums[index]
>> -				= btrfs_csum_data(data + bvec.bv_offset
>> +			tmp = btrfs_csum_data(data + bvec.bv_offset
>>  						+ (i * fs_info->sectorsize),
>> -						sums->sums[index],
>> +						*(u32 *)&sums->sums[index],
>>  						fs_info->sectorsize);
>>  			kunmap_atomic(data);
>> -			btrfs_csum_final(sums->sums[index],
>> +			btrfs_csum_final(tmp,
>>  					(char *)(sums->sums + index));
>> -			index++;
>> +			index += csum_size;
>>  			offset += fs_info->sectorsize;
>>  			this_sum_bytes += fs_info->sectorsize;
>>  			total_bytes += fs_info->sectorsize;
>> @@ -904,9 +906,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>  	write_extent_buffer(leaf, sums->sums + index, (unsigned long)item,
>>  			    ins_size);
>>  
>> +	index += ins_size;
>>  	ins_size /= csum_size;
>>  	total_bytes += ins_size * fs_info->sectorsize;
>> -	index += ins_size;
>>  
>>  	btrfs_mark_buffer_dirty(path->nodes[0]);
>>  	if (total_bytes < sums->len) {
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index 52889da69113..6f7a18148dcb 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -924,14 +924,16 @@ int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
>>   * be reclaimed before their checksum is actually put into the btree
>>   */
>>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>> -			   u32 *sum, int len)
>> +			   u8 *sum, int len)
>>  {
>> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>  	struct btrfs_ordered_sum *ordered_sum;
>>  	struct btrfs_ordered_extent *ordered;
>>  	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
>>  	unsigned long num_sectors;
>>  	unsigned long i;
>>  	u32 sectorsize = btrfs_inode_sectorsize(inode);
>> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>>  	int index = 0;
>>  
>>  	ordered = btrfs_lookup_ordered_extent(inode, offset);
>> @@ -947,10 +949,10 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>>  			num_sectors = ordered_sum->len >>
>>  				      inode->i_sb->s_blocksize_bits;
>>  			num_sectors = min_t(int, len - index, num_sectors - i);
>> -			memcpy(sum + index, ordered_sum->sums + i,
>> -			       num_sectors);
>> +			memcpy(sum + index, ordered_sum->sums + i * csum_size,
>> +			       num_sectors * csum_size);
>>  
>> -			index += (int)num_sectors;
>> +			index += (int)num_sectors * csum_size;
>>  			if (index == len)
>>  				goto out;
>>  			disk_bytenr += num_sectors * sectorsize;
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 4c5991c3de14..9a9884966343 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -23,7 +23,7 @@ struct btrfs_ordered_sum {
>>  	int len;
>>  	struct list_head list;
>>  	/* last field is a variable length array of csums */
>> -	u32 sums[];
>> +	u8 sums[];
>>  };
>>  
>>  /*
>> @@ -183,7 +183,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>>  int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
>>  				struct btrfs_ordered_extent *ordered);
>>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>> -			   u32 *sum, int len);
>> +			   u8 *sum, int len);
>>  u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
>>  			       const u64 range_start, const u64 range_len);
>>  u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index f7b29f9db5e2..2cf3cf9e9c9b 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -2448,7 +2448,7 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>>  	ASSERT(index < UINT_MAX);
>>  
>>  	num_sectors = sum->len / sctx->fs_info->sectorsize;
>> -	memcpy(csum, sum->sums + index, sctx->csum_size);
>> +	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
>>  	if (index == num_sectors - 1) {
>>  		list_del(&sum->list);
>>  		kfree(sum);
>>
> 
