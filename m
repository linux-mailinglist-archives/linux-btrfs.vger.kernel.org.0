Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4167824F5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfEUM4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 08:56:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:55424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEUM4N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 08:56:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 361DEABD4;
        Tue, 21 May 2019 12:56:12 +0000 (UTC)
Subject: Re: [PATCH v2 05/13] btrfs: dont assume compressed_bio sums to be 4
 bytes
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-6-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8bb202e9-935d-eed8-f0d5-58f6a44bc991@suse.com>
Date:   Tue, 21 May 2019 15:56:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084803.9774-6-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.05.19 г. 11:47 ч., Johannes Thumshirn wrote:
> BTRFS has the implicit assumption that a checksum in compressed_bio is 4
> bytes. While this is true for CRC32C, it is not for any other checksum.
> 
> Change the data type to be a byte array and adjust loop index calculation
> accordingly.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/compression.c  | 27 +++++++++++++++++----------
>  fs/btrfs/compression.h  |  2 +-
>  fs/btrfs/file-item.c    |  2 +-
>  fs/btrfs/ordered-data.c |  3 ++-
>  4 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 98d8c2ed367f..d5642f3b5c44 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -57,12 +57,14 @@ static int check_compressed_csum(struct btrfs_inode *inode,
>  				 struct compressed_bio *cb,
>  				 u64 disk_start)
>  {
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>  	int ret;
>  	struct page *page;
>  	unsigned long i;
>  	char *kaddr;
>  	u32 csum;
> -	u32 *cb_sum = &cb->sums;
> +	u8 *cb_sum = cb->sums;
>  
>  	if (inode->flags & BTRFS_INODE_NODATASUM)
>  		return 0;
> @@ -76,13 +78,13 @@ static int check_compressed_csum(struct btrfs_inode *inode,
>  		btrfs_csum_final(csum, (u8 *)&csum);
>  		kunmap_atomic(kaddr);
>  
> -		if (csum != *cb_sum) {
> +		if (memcmp(&csum, cb_sum, csum_size)) {
>  			btrfs_print_data_csum_error(inode, disk_start, csum,
> -					*cb_sum, cb->mirror_num);
> +					*(u32 *)cb_sum, cb->mirror_num);
>  			ret = -EIO;
>  			goto fail;
>  		}
> -		cb_sum++;
> +		cb_sum += csum_size;
>  
>  	}
>  	ret = 0;
> @@ -537,7 +539,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	struct extent_map *em;
>  	blk_status_t ret = BLK_STS_RESOURCE;
>  	int faili = 0;
> -	u32 *sums;
> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +	u8 *sums;
>  
>  	em_tree = &BTRFS_I(inode)->extent_tree;
>  
> @@ -559,7 +562,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	cb->errors = 0;
>  	cb->inode = inode;
>  	cb->mirror_num = mirror_num;
> -	sums = &cb->sums;
> +	sums = cb->sums;
>  
>  	cb->start = em->orig_start;
>  	em_len = em->len;
> @@ -618,6 +621,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		page->mapping = NULL;
>  		if (submit || bio_add_page(comp_bio, page, PAGE_SIZE, 0) <
>  		    PAGE_SIZE) {
> +			unsigned int nr_sectors;
> +
>  			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
>  						  BTRFS_WQ_ENDIO_DATA);
>  			BUG_ON(ret); /* -ENOMEM */
> @@ -632,11 +637,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  
>  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> -							    (u8 *)sums);
> +							    sums);
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
> -			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
> -					     fs_info->sectorsize);
> +
> +			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
> +						  fs_info->sectorsize);
> +			sums += csum_size * nr_sectors;

nit: I think nr_sectors is not a good name in this particular case
because you really care about nr_csums this bio spans. To me at least,
it feels more intuitive to see :

nr_csums = DIV_ROUND_UP
sums += csum_size * nr_csums.


>  
>  			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
>  			if (ret) {
> @@ -658,7 +665,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	BUG_ON(ret); /* -ENOMEM */
>  
>  	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> -		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u8 *) sums);
> +		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 9976fe0f7526..191e5f4e3523 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -61,7 +61,7 @@ struct compressed_bio {
>  	 * the start of a variable length array of checksums only
>  	 * used by reads
>  	 */
> -	u32 sums;
> +	u8 sums[];
>  };
>  
>  static inline unsigned int btrfs_compress_type(unsigned int type_level)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 210ff69917a0..c551479afa63 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -182,7 +182,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
>  		}
>  		csum = btrfs_bio->csum;
>  	} else {
> -		csum = (u8 *)dst;
> +		csum = dst;
>  	}
>  
>  	if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 6f7a18148dcb..a65e5f32160b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -927,9 +927,10 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>  			   u8 *sum, int len)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
>  	struct btrfs_ordered_sum *ordered_sum;
>  	struct btrfs_ordered_extent *ordered;
> -	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
> +	struct btrfs_ordered_inode_tree *tree = &btrfs_inode->ordered_tree;
>  	unsigned long num_sectors;
>  	unsigned long i;
>  	u32 sectorsize = btrfs_inode_sectorsize(inode);
> 

Irrelevant change, this hunk could be dropped. Furthermore, I don't see
how having an explicit variable brings any value apart from increased
stack usage.

