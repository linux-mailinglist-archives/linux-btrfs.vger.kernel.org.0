Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081C924F11
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEUMmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 08:42:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42155 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEUMmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 08:42:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so29140660eda.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HclI7gN58qNbzn4rBo7u3LnXW71zmzd3tlN87kkWG6U=;
        b=GISW9JD4HFWzP1XGweLowzb+EQRxtOONR0ISsyWmX0mQdwtEYKDoZzsbqOK0ChCbiw
         IqoBoXwsV8EyWuCYlR5DIN6wac62Gr+hIhaSTV9bsS/+yukiRMi/htmPxPNtdEByarcn
         dV0ORi8au5CyLKGQXZTAKWdzKfVv4GZB8W7on0/UZDUmPVZdXkeOD1OyJkh8nOae6hrk
         Ok6oFE9bhtSF1qfWS+SUljIZ5QurtG3rgAsoJrecKiP57oZphaqd/0tEH0QrwIfvJ6ZU
         xrLW5NMoz0mbovRQ5j9cghyvemCuy3QSHRBKan7UN7EV7wtHxDOgEeu1UKykIPjvgwMh
         xH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HclI7gN58qNbzn4rBo7u3LnXW71zmzd3tlN87kkWG6U=;
        b=OcESKAekCZjeGB7R00jZFrCqIp3qO+hJ6H9X4CpoV6YIjJ+BEYQnGvpkXqL/kfK01/
         ZXtWxtt3dNibu7jw7weSvrDMg5C9OG1+urxeaU0yS5k+Q+6Fe5uVWc+ceYaEGD/IY4te
         XmeGUFe95Nor3i//0Waawl4zz1Z+YAuorcu4he8Yu5DYnYjbnVqDLRX0NygC3ermJhbh
         +oe2XMjVIFCCwH6+8WIPhOqYAso8mHNzWEe3+1PH8es2bE4bQb8NFnlgebHseI2OKrFg
         LAeT2G5jnMA/RWQj/+iiQiRHn2HyGL9Co9VYzjiruXmPEBfe1Te5q7qfWSlBTWkE7Fqg
         K6Aw==
X-Gm-Message-State: APjAAAXAqKoFTHoBmr7l0HTxYbdk9K7sc1OPRZkvmR/ZoQXN207wVlea
        Pd4ZHuWwwxakHN5ws/uQENw=
X-Google-Smtp-Source: APXvYqwUY/Cgp8N3Kcw57Ilo4wl2sPCiuoYhpPX96A/mEnd/s5EKFBLSyr4DUTn9ghlWDl+SYvUWDA==
X-Received: by 2002:a50:a535:: with SMTP id y50mr82260935edb.249.1558442542440;
        Tue, 21 May 2019 05:42:22 -0700 (PDT)
Received: from [10.20.1.223] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id r14sm6286413eda.65.2019.05.21.05.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:42:21 -0700 (PDT)
Subject: Re: [PATCH v2 04/13] btrfs: don't assume ordered sums to be 4 bytes
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190516084803.9774-1-jthumshirn@suse.de>
 <20190516084803.9774-5-jthumshirn@suse.de>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <2d338f7a-2165-976a-7f51-3557347b32cd@gmail.com>
Date:   Tue, 21 May 2019 15:42:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084803.9774-5-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.05.19 г. 11:47 ч., Johannes Thumshirn wrote:
> BTRFS has the implicit assumption that a checksum in btrfs_orderd_sums is 4
> bytes. While this is true for CRC32C, it is not for any other checksum.
> 
> Change the data type to be a byte array and adjust loop index calculation
> accordingly.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/compression.c  |  4 ++--
>  fs/btrfs/ctree.h        |  3 ++-
>  fs/btrfs/file-item.c    | 28 +++++++++++++++-------------
>  fs/btrfs/ordered-data.c | 10 ++++++----
>  fs/btrfs/ordered-data.h |  4 ++--
>  fs/btrfs/scrub.c        |  2 +-
>  6 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4ec1df369e47..98d8c2ed367f 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
<snip>

>  
> -#define MAX_ORDERED_SUM_BYTES(fs_info) ((PAGE_SIZE - \
> +#define MAX_ORDERED_SUM_BYTES(fs_info, csum_size) ((PAGE_SIZE - \
>  				   sizeof(struct btrfs_ordered_sum)) / \
> -				   sizeof(u32) * (fs_info)->sectorsize)
> +				   (csum_size) * (fs_info)->sectorsize)
>  

nit: As discussed this is fragile and error prone so ideally it shall be
converted to an inline function.

<snip>

> @@ -904,9 +906,9 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  	write_extent_buffer(leaf, sums->sums + index, (unsigned long)item,
>  			    ins_size);
>  
> +	index += ins_size;
>  	ins_size /= csum_size;
>  	total_bytes += ins_size * fs_info->sectorsize;
> -	index += ins_size;
nit:

This is rather tricky, because changing btrfs_ordered_sum::sums to u8
means that we need to be indexing  inside this array with the raw size
of the data there i.e the size of the checksums being inserted and after
that divide it by csum_size to get the actual number of checksums.
Effectively you are changing the indexing here from "index of particular
csum" to "index of  particular byte".

I just wanted to state that explicitly.

>  
>  	btrfs_mark_buffer_dirty(path->nodes[0]);
>  	if (total_bytes < sums->len) {
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 52889da69113..6f7a18148dcb 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -924,14 +924,16 @@ int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
>   * be reclaimed before their checksum is actually put into the btree
>   */
>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> -			   u32 *sum, int len)
> +			   u8 *sum, int len)
>  {
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_ordered_sum *ordered_sum;
>  	struct btrfs_ordered_extent *ordered;
>  	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
>  	unsigned long num_sectors;
>  	unsigned long i;> @@ -632,7 +632,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  
>  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> -							    sums);
> +							    (u8 *)sums);
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
> @@ -658,7 +658,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	BUG_ON(ret); /* -ENOMEM */
>  
>  	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
> +		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u8 *) sums);
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d85541f13f65..2ec742db2001 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3198,7 +3198,8 @@ int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
>  struct btrfs_dio_private;
>  int btrfs_del_csums(struct btrfs_trans_handle *trans,
>  		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
> -blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u32 *dst);
> +blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> +				   u8 *dst);
>  blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
>  			      u64 logical_offset);
>  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index d431ea8198e4..210ff69917a0 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -22,9 +22,9 @@
>  #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
>  				       PAGE_SIZE))
>  	u32 sectorsize = btrfs_inode_sectorsize(inode);
> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>  	int index = 0;
>  
>  	ordered = btrfs_lookup_ordered_extent(inode, offset);
> @@ -947,10 +949,10 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
>  			num_sectors = ordered_sum->len >>
>  				      inode->i_sb->s_blocksize_bits;
>  			num_sectors = min_t(int, len - index, num_sectors - i);
> -			memcpy(sum + index, ordered_sum->sums + i,
> -			       num_sectors);
> +			memcpy(sum + index, ordered_sum->sums + i * csum_size,
> +			       num_sectors * csum_size);
>  
> -			index += (int)num_sectors;
> +			index += (int)num_sectors * csum_size;
>  			if (index == len)
>  				goto out;
>  			disk_bytenr += num_sectors * sectorsize;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 4c5991c3de14..9a9884966343 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -23,7 +23,7 @@ struct btrfs_ordered_sum {
>  	int len;
>  	struct list_head list;
>  	/* last field is a variable length array of csums */
> -	u32 sums[];
> +	u8 sums[];
>  };
>  
>  /*
> @@ -183,7 +183,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>  int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
>  				struct btrfs_ordered_extent *ordered);
>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> -			   u32 *sum, int len);
> +			   u8 *sum, int len);
>  u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
>  			       const u64 range_start, const u64 range_len);
>  u64 btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f7b29f9db5e2..2cf3cf9e9c9b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2448,7 +2448,7 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>  	ASSERT(index < UINT_MAX);
>  
>  	num_sectors = sum->len / sctx->fs_info->sectorsize;
> -	memcpy(csum, sum->sums + index, sctx->csum_size);
> +	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
>  	if (index == num_sectors - 1) {
>  		list_del(&sum->list);
>  		kfree(sum);
> 
