Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381356A251
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 14:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiGGMuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiGGMui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 08:50:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E3A2B639
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:50:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 741C62202F;
        Thu,  7 Jul 2022 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657198235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XcMBZEbCRqJ8YiW1p8GVRUKV/decAjg2yGAIWQip88k=;
        b=cdV+znUTPskkdaXHJTRXPbbM3hfFrhLk+XOIj0ReeMPhUfdX5ojcShv4kdjm633tddXC37
        skWRgRy5q8JMod6NqkkQVbjsV+VxdUZ2Wa6+nzz8aEiC7AAaSMwUZyKQ9ubBmtegxYWq9b
        8TlleuF8idAirdCkpM2IKktbGk+ESUU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2628B13461;
        Thu,  7 Jul 2022 12:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PqipBpvWxmL8fAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 07 Jul 2022 12:50:35 +0000
Message-ID: <f8773669-79a7-6cbc-4c70-b805527b3268@suse.com>
Date:   Thu, 7 Jul 2022 15:50:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] btrfs: fix repair of compressed extents
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220630160130.2550001-1-hch@lst.de>
 <20220630160130.2550001-5-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220630160130.2550001-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.06.22 г. 19:01 ч., Christoph Hellwig wrote:
> Currently the checksum of compressed extents is verified based on the
> compressed data and the lower btrfs_bio, but the actual repair process
> is driven by end_bio_extent_readpage on the upper btrfs_bio for the
> decompressed data.
> 
> This has a bunch of issues, including not being able to properly
> communicate the failed mirror up in case that the I/O submission got
> preempted, a general loss of if an error was an I/O error or a checksum
> verification failure, but most importantly that this design causes
> btrfs_clean_io_failure to eventually write back the uncompressed good
> data onto the disk sectors that are supposed to contain compressed data.
> 
> Fix this by moving the repair to the lower btrfs_bio.  To do so, a fair
> amount of code has to be reshuffled:
> 
>   a) the lower btrfs_bio now needs a valid csum pointer.  The easiest way
>      to archive that is to pass NULL btrfs_lookup_bio_sums and just use
>      the btrfs_bio management of csums.  For a compressed_bio that is
>      split into multiple btrfs_bios this mean additional memory
>      allocations, but the code becomes a lot more regular.
>   b) checksum verifiaction now runs diretly on the lower btrfs_bio instead
>      of the compressed_bio.  This actually nicely simplifies the end I/O
>      processing.
>   c) btrfs_repair_one_sector can't just look up the logical address for
>      the file offset any more, as there is no coresponding relative
>      offsets that apply to the file offset and the logic address for
>      compressed extents.  Instead require that the saved bvec_iter in the
>      btrfs_bio is filled out for all read bios and use that, which again
>      removes a fair amount of code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Overall it looks good but there are a couple of minor nits.

> ---
>   fs/btrfs/compression.c | 171 ++++++++++++++---------------------------
>   fs/btrfs/compression.h |   7 --
>   fs/btrfs/extent_io.c   |  46 +++--------
>   fs/btrfs/extent_io.h   |   1 -
>   fs/btrfs/inode.c       |   7 ++
>   5 files changed, 75 insertions(+), 157 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e756da640fd7b..c8b14a5bd89be 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -136,66 +136,14 @@ static int compression_decompress(int type, struct list_head *ws,
>   
>   static int btrfs_decompress_bio(struct compressed_bio *cb);
>   
> -static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
> -				      unsigned long disk_size)
> -{
> -	return sizeof(struct compressed_bio) +
> -		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * fs_info->csum_size;
> -}
> -
> -static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
> -				 u64 disk_start)
> -{
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	const u32 csum_size = fs_info->csum_size;
> -	const u32 sectorsize = fs_info->sectorsize;
> -	struct page *page;
> -	unsigned int i;
> -	u8 csum[BTRFS_CSUM_SIZE];
> -	struct compressed_bio *cb = bio->bi_private;
> -	u8 *cb_sum = cb->sums;
> -
> -	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
> -	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
> -		return 0;
> -
> -	for (i = 0; i < cb->nr_pages; i++) {
> -		u32 pg_offset;
> -		u32 bytes_left = PAGE_SIZE;
> -		page = cb->compressed_pages[i];
> -
> -		/* Determine the remaining bytes inside the page first */
> -		if (i == cb->nr_pages - 1)
> -			bytes_left = cb->compressed_len - i * PAGE_SIZE;
> -
> -		/* Hash through the page sector by sector */
> -		for (pg_offset = 0; pg_offset < bytes_left;
> -		     pg_offset += sectorsize) {
> -			int ret;
> -
> -			ret = btrfs_check_sector_csum(fs_info, page, pg_offset,
> -						      csum, cb_sum);
> -			if (ret) {
> -				btrfs_print_data_csum_error(inode, disk_start,
> -						csum, cb_sum, cb->mirror_num);
> -				if (btrfs_bio(bio)->device)
> -					btrfs_dev_stat_inc_and_print(
> -						btrfs_bio(bio)->device,
> -						BTRFS_DEV_STAT_CORRUPTION_ERRS);
> -				return -EIO;
> -			}
> -			cb_sum += csum_size;
> -			disk_start += sectorsize;
> -		}
> -	}
> -	return 0;
> -}
> -
>   static void finish_compressed_bio_read(struct compressed_bio *cb)
>   {
>   	unsigned int index;
>   	struct page *page;
>   
> +	if (cb->status == BLK_STS_OK)
> +		cb->status = errno_to_blk_status(btrfs_decompress_bio(cb));

nit: That's a sneaky line, initially I was wondering "huh, where did the 
btrfs_decompress_bio() call go". If David thinks the same I think it's 
best if the function call is on a separate line.
> +
>   	/* Release the compressed pages */
>   	for (index = 0; index < cb->nr_pages; index++) {
>   		page = cb->compressed_pages[index];
> @@ -233,59 +181,54 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
>   	kfree(cb);
>   }
>   
> -/* when we finish reading compressed pages from the disk, we
> - * decompress them and then run the bio end_io routines on the
> - * decompressed pages (in the inode address space).
> - *
> - * This allows the checksumming and other IO error handling routines
> - * to work normally
> - *
> - * The compressed pages are freed here, and it must be run
> - * in process context
> +/*
> + * Verify the checksums and kick off repair if needed on the uncompressed data
> + * before decompressing it into the original bio and freeing the uncompressed
> + * pages.
>    */
>   static void end_compressed_bio_read(struct bio *bio)
>   {
>   	struct compressed_bio *cb = bio->bi_private;
> -	struct inode *inode;
> -	unsigned int mirror = btrfs_bio(bio)->mirror_num;
> -	int ret = 0;
> -
> -	if (bio->bi_status)
> -		cb->status = bio->bi_status;
> -
> -	if (!refcount_dec_and_test(&cb->pending_ios))
> -		goto out;
> -
> -	/*
> -	 * Record the correct mirror_num in cb->orig_bio so that
> -	 * read-repair can work properly.
> -	 */
> -	btrfs_bio(cb->orig_bio)->mirror_num = mirror;
> -	cb->mirror_num = mirror;
> -
> -	/*
> -	 * Some IO in this cb have failed, just skip checksum as there
> -	 * is no way it could be correct.
> -	 */
> -	if (cb->status != BLK_STS_OK)
> -		goto csum_failed;
> +	struct inode *inode = cb->inode;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_inode *bi = BTRFS_I(inode);
> +	bool csum = !(bi->flags & BTRFS_INODE_NODATASUM) &&
> +		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
> +	blk_status_t status = bio->bi_status;
> +	struct btrfs_bio *bbio = btrfs_bio(bio);
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	u32 offset;
> +
> +	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
> +		u64 start = bbio->file_offset + offset;
> +
> +		if (!status &&
> +		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
> +					       bv.bv_offset))) {

In the !csum case you'd be executing a lot of code for no gain i.e 
clean_io_failure. Instead, factor out the !csum case as a break from the 
btrfs_bio_for_each_sector i.e no point in running clean_io_failure for 
every sector in this case.

> +			clean_io_failure(fs_info, &bi->io_failure_tree,
> +					 &bi->io_tree, start, bv.bv_page,
> +					 btrfs_ino(bi), bv.bv_offset);
> +		} else {
> +			int ret;
>   
> -	inode = cb->inode;
> -	ret = check_compressed_csum(BTRFS_I(inode), bio,
> -				    bio->bi_iter.bi_sector << 9);
> -	if (ret)
> -		goto csum_failed;
> +			refcount_inc(&cb->pending_ios);
> +			ret = btrfs_repair_one_sector(inode, bbio, offset,
> +					bv.bv_page, bv.bv_offset,
> +					btrfs_submit_data_read_bio);
> +			if (ret) {
> +				refcount_dec(&cb->pending_ios);
> +				status = errno_to_blk_status(ret);
> +			}
> +		}
> +	}
>   
> -	/* ok, we're the last bio for this extent, lets start
> -	 * the decompression.
> -	 */
> -	ret = btrfs_decompress_bio(cb);
> +	if (status)
> +		cb->status = status;
>   
> -csum_failed:
> -	if (ret)
> -		cb->status = errno_to_blk_status(ret);
> -	finish_compressed_bio_read(cb);
> -out:
> +	if (refcount_dec_and_test(&cb->pending_ios))
> +		finish_compressed_bio_read(cb);
> +	btrfs_bio_free_csum(bbio);
>   	bio_put(bio);
>   }
>   
> @@ -478,7 +421,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   
>   	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>   	       IS_ALIGNED(len, fs_info->sectorsize));
> -	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
> +	cb = kmalloc(sizeof(struct compressed_bio), GFP_NOFS);

nit: This change is irrelevant to this patch - indeed we don't need to 
allocate the flex array at the end of compressed_bio for writes, as the 
csums are being stored in the ordered extents for the bio, still this 
it's independent of this patch.

>   	if (!cb)
>   		return BLK_STS_RESOURCE;
>   	refcount_set(&cb->pending_ios, 1);

<snip>

> @@ -2573,41 +2570,14 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
>   	failrec->start = start;
>   	failrec->len = sectorsize;
>   	failrec->failed_mirror = failrec->this_mirror = bbio->mirror_num;
> -	failrec->compress_type = BTRFS_COMPRESS_NONE;
> -
> -	read_lock(&em_tree->lock);
> -	em = lookup_extent_mapping(em_tree, start, failrec->len);
> -	if (!em) {
> -		read_unlock(&em_tree->lock);
> -		kfree(failrec);
> -		return ERR_PTR(-EIO);
> -	}
> -
> -	if (em->start > start || em->start + em->len <= start) {
> -		free_extent_map(em);
> -		em = NULL;
> -	}
> -	read_unlock(&em_tree->lock);
> -	if (!em) {
> -		kfree(failrec);
> -		return ERR_PTR(-EIO);
> -	}
> -
> -	logical = start - em->start;
> -	logical = em->block_start + logical;
> -	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
> -		logical = em->block_start;
> -		failrec->compress_type = em->compress_type;
> -	}
> +	failrec->logical = (bbio->iter.bi_sector << SECTOR_SHIFT) + bio_offset;
>   
>   	btrfs_debug(fs_info,
> -		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
> -		    logical, start, failrec->len);
> -
> -	failrec->logical = logical;
> -	free_extent_map(em);
> +		    "Get IO Failure Record: (new) logical=%llu, start=%llu",
> +		    failrec->logical, start);

nit: While at it the '(new)' could be removed as I don't think it's 
rather informative, I guess David can also do this fix up. Also let's 
not remove the len, sure, it's always (at least for the time being) be a 
sectorsize but at least it's explicit in the error message.

>   
> -	failrec->num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
> +	failrec->num_copies = btrfs_num_copies(fs_info, failrec->logical,
> +					       sectorsize);
>   	if (failrec->num_copies == 1) {
>   		/*
>   		 * we only have a single copy of the data, so don't bother with

<snip>
