Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2269414B3B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1Lrw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 06:47:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgA1Lrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 06:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4kjz0pLLzYhN1+1Eg9M2M/oaemTXUA3+4TagTFDWeBI=; b=EKv27h63+WAkUqD4muwIguzrk
        3vEtafscPOpgCTHZtrxUTwPg/gmKRZWNqlFsOE2OCT1iiNwHHMdQAje8/8hK5X8+JSmx4Cc49Mmzo
        Y8z0U5cCpLuOq/d9Dr4jwUPRNhPihZbEjGh3tWDUmHmgurlOzpW5BhdEUwBLTVwl4y4p3Qd2153jm
        i2wAqdzeWfJsUqz1tNn3Vf7gilc66aijsPO0whlZiMPcM3np/uo7CoPv//xfehAiLnxYEiq5S58vR
        AUja4Ph0FayQSeUWB8DZ2LQjqIe4tCreQZOfRX2H3wHrW6lUEzYCFVtl6ScAyThDzs38OvWMpxE/c
        IF6fqZwJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwPLP-0008Od-Ta; Tue, 28 Jan 2020 11:47:47 +0000
Date:   Tue, 28 Jan 2020 03:47:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/5] btrfs: remove buffer heads from super block
 reading
Message-ID: <20200128114747.GA17444@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200127155931.10818-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127155931.10818-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 12:59:27AM +0900, Johannes Thumshirn wrote:
>  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>  	struct btrfs_root *tree_root;
>  	struct btrfs_root *chunk_root;
> +	struct page *super_page;
> +	u8 *superblock;

Any good reason this isn't a struct btrfs_super_block * instead?

> +	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
> +					  superblock);
>  	if (!btrfs_supported_super_csum(csum_type)) {
>  		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
>  			  csum_type);
>  		err = -EINVAL;
> -		brelse(bh);
> +		kunmap(super_page);
> +		put_page(super_page);
>  		goto fail_alloc;
>  	}
>  
>  	ret = btrfs_init_csum_hash(fs_info, csum_type);
>  	if (ret) {
>  		err = ret;
> +		kunmap(super_page);
> +		put_page(super_page);
>  		goto fail_alloc;
>  	}
>  
> @@ -2861,10 +2867,11 @@ int __cold open_ctree(struct super_block *sb,
>  	 * We want to check superblock checksum, the type is stored inside.
>  	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
>  	 */
> -	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
> +	if (btrfs_check_super_csum(fs_info, superblock)) {
>  		btrfs_err(fs_info, "superblock checksum mismatch");
>  		err = -EINVAL;
> -		brelse(bh);
> +		kunmap(super_page);
> +		put_page(super_page);
>  		goto fail_csum;
>  	}
>  
> @@ -2873,8 +2880,9 @@ int __cold open_ctree(struct super_block *sb,
>  	 * following bytes up to INFO_SIZE, the checksum is calculated from
>  	 * the whole block of INFO_SIZE
>  	 */
> -	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
> -	brelse(bh);
> +	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));
> +	kunmap(super_page);
> +	put_page(super_page);

Would it make sense to move the code up to here in a helper to
simplify the error handling?

>  
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret)
> +			struct page **super_page)
>  {
> -	struct buffer_head *bh;
>  	struct btrfs_super_block *super;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	struct page *page;
>  	u64 bytenr;
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	gfp_t gfp_mask;
> +	int ret;
>  
>  	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return -EINVAL;
>  
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +	page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT, gfp_mask);

Why not simply use read_cache_page_gfp to find or read the page?

> -	super = (struct btrfs_super_block *)bh->b_data;
> +	super = kmap(page);
>  	if (btrfs_super_bytenr(super) != bytenr ||
>  		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		brelse(bh);
> +		kunmap(page);
> +		put_page(page);
>  		return -EINVAL;
>  	}
> +	kunmap(page);
>  
> -	*bh_ret = bh;
> +	*super_page = page;

Given that both callers need the kernel virtual address, why not leave it
kmapped?  OTOH if you use read_cache_page_gfp, we could just kill
btrfs_read_dev_one_super and open code the call to read_cache_page_gfp
and btrfs_super_bytenr / btrfs_super_magic in the callers.

> +	bio_init(&bio, &bio_vec, 1);
>  	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
>  		copy_num++) {
> +		u64 bytenr = btrfs_sb_offset(copy_num);
> +		struct page *page;
>  
> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> +		if (btrfs_read_dev_one_super(bdev, copy_num, &page))
>  			continue;
>  
> -		disk_super = (struct btrfs_super_block *)bh->b_data;
> +		disk_super = kmap(page) + offset_in_page(bytenr);
>  
>  		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> -		set_buffer_dirty(bh);
> -		sync_dirty_buffer(bh);
> -		brelse(bh);
> +
> +		bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio_set_dev(&bio, bdev);
> +		bio.bi_opf = REQ_OP_WRITE;
> +		bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,
> +			     offset_in_page(bytenr));
> +
> +		lock_page(page);
> +		submit_bio_wait(&bio);
> +		unlock_page(page);
> +		kunmap(page);
> +		put_page(page);
> +		bio_reset(&bio);

Facoting out the code to write a single sb would clean this up a bit.
Also no real need to keep the page kmapped when under I/O.
