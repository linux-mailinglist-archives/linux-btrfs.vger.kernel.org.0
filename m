Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5DB1469B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAWNvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:51:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45977 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAWNvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:51:31 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so1460107qvu.12
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9sTzejp33UP1gXxydawJHRyqYFsSOCev7OfEFrnumPo=;
        b=d+oiaciI/vx1WbIhn276aiiAKwxb1KfSEWYXG15S+cdHEiQ0/wPPF+O5JOArykP12+
         mRyMxupAXceC55rO2fC2jcKS544Nviyk6siLcx7ykN2W5wQXm4VH2WhRxTjPa/wW1Tyx
         xp3SQeql1JMYTHHgsHAMQdRPkncMOgl7wrX8hJC5BQzJ97PUYTxr+KT3FpIf/9YlwMMp
         YYsJ969mf04BT3CZJ+puRVES8234SKE1aXmkv6ZBUTrYn6HViZmhLfAB1vFHLozLG/O+
         Ln4xKkKyYh1cZ1TWQwfxvBnFLSLNaPyh3lc6MsVmm7old9J8mTAlXs+I9eM6ILb/Wmfc
         MpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sTzejp33UP1gXxydawJHRyqYFsSOCev7OfEFrnumPo=;
        b=hEU6HIxZ5JqkdhdCa7FA7cp/3u/sSbNpItpVSNR1M4W8qnkZk1RmHN+ww78iMBsVFl
         r0/oZyzkwMMIfVNJ8U96uwLZqqveVN+NR/msq2IyOLEO87FK9sCcwQZ2ZDbDyt6+wA1F
         0fQSjPF5xIb94gnzLNvmv4nExuCgqrxPzdctXuAUXIax8ltUOgIAaEmpSr9u8uyaEn32
         Ev5GtBHzDc3TogS4EFnyLycCZxYiZRsppzEH3yLBvWVUpE+n1Lw7+ehJ3IUfZFWoL1I8
         mTxphE2JogFmKNV2+vwLcC7fzuBg944lqllu8LLaX5CsV7Gti/0JsoS+IhE88wiKgy1C
         mcWw==
X-Gm-Message-State: APjAAAVoIwZWgpVzQzrAkZukJ3UX/3qeOOR5wAc28X00pf9uHM0oTRH3
        stj8GLiUyFCC2+m7l6AFzfD9q7GFlGO5Jg==
X-Google-Smtp-Source: APXvYqy2ur8XVSQ2USIXeGNWgPnK9t/6/t6kLcvrFip12F0dIhgNZ1zB25VLjwVUCHLoWaGC8zxzuA==
X-Received: by 2002:a0c:f685:: with SMTP id p5mr16346214qvn.44.1579787489602;
        Thu, 23 Jan 2020 05:51:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id d25sm898915qkk.77.2020.01.23.05.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:51:28 -0800 (PST)
Subject: Re: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-3-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9c65b644-6769-12f8-ba93-5f13f89f9bff@toxicpanda.com>
Date:   Thu, 23 Jan 2020 08:51:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123081849.23397-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:18 AM, Johannes Thumshirn wrote:
> Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
> some drawbacks, like not being able to propagate errors from the lower
> layers.
> 
> Change the buffer_heads to BIOs and utilize the page cache for the page
> allocation. Compared to buffer_heads using BIOs are more lightweight and
> we skip several layers of buffer_head code until we either reach the page
> cache or build a BIO and submit it to read the blocks from disk.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - move 'super_page' into for-loop in btrfs_scratch_superblocks() (Nikolay)
> - switch to using pagecahce instead of alloc_pages() (Nikolay, David)
> ---
>   fs/btrfs/disk-io.c | 83 ++++++++++++++++++++++++++++++----------------
>   fs/btrfs/disk-io.h |  4 +--
>   fs/btrfs/volumes.c | 62 ++++++++++++++++++++--------------
>   fs/btrfs/volumes.h |  2 --
>   4 files changed, 94 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index aea48d6ddc0c..b111f32108cc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2635,11 +2635,12 @@ int __cold open_ctree(struct super_block *sb,
>   	u64 features;
>   	u16 csum_type;
>   	struct btrfs_key location;
> -	struct buffer_head *bh;
>   	struct btrfs_super_block *disk_super;
>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>   	struct btrfs_root *tree_root;
>   	struct btrfs_root *chunk_root;
> +	struct page *super_page;
> +	u8 *superblock;
>   	int ret;
>   	int err = -EINVAL;
>   	int clear_free_space_tree = 0;
> @@ -2832,28 +2833,31 @@ int __cold open_ctree(struct super_block *sb,
>   	/*
>   	 * Read super block and check the signature bytes only
>   	 */
> -	bh = btrfs_read_dev_super(fs_devices->latest_bdev);
> -	if (IS_ERR(bh)) {
> -		err = PTR_ERR(bh);
> +	ret = btrfs_read_dev_super(fs_devices->latest_bdev, &super_page);
> +	if (ret) {
> +		err = ret;
>   		goto fail_alloc;
>   	}
>   
> +	superblock = kmap(super_page);
>   	/*
>   	 * Verify the type first, if that or the the checksum value are
>   	 * corrupted, we'll find out
>   	 */
> -	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)bh->b_data);
> +	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
> +					  superblock);
>   	if (!btrfs_supported_super_csum(csum_type)) {
>   		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
>   			  csum_type);
>   		err = -EINVAL;
> -		brelse(bh);
> +		btrfs_release_disk_super(super_page);
>   		goto fail_alloc;
>   	}
>   
>   	ret = btrfs_init_csum_hash(fs_info, csum_type);
>   	if (ret) {
>   		err = ret;
> +		btrfs_release_disk_super(super_page);
>   		goto fail_alloc;
>   	}
>   
> @@ -2861,10 +2865,10 @@ int __cold open_ctree(struct super_block *sb,
>   	 * We want to check superblock checksum, the type is stored inside.
>   	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
>   	 */
> -	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
> +	if (btrfs_check_super_csum(fs_info, superblock)) {
>   		btrfs_err(fs_info, "superblock checksum mismatch");
>   		err = -EINVAL;
> -		brelse(bh);
> +		btrfs_release_disk_super(super_page);
>   		goto fail_csum;
>   	}
>   
> @@ -2873,8 +2877,8 @@ int __cold open_ctree(struct super_block *sb,
>   	 * following bytes up to INFO_SIZE, the checksum is calculated from
>   	 * the whole block of INFO_SIZE
>   	 */
> -	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
> -	brelse(bh);
> +	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));
> +	btrfs_release_disk_super(super_page);
>   
>   	disk_super = fs_info->super_copy;
>   
> @@ -3374,40 +3378,60 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>   }
>   
>   int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret)
> +			struct page **super_page)
>   {
> -	struct buffer_head *bh;
>   	struct btrfs_super_block *super;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	struct page *page;
>   	u64 bytenr;
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	gfp_t gfp_mask;
> +	int ret;
>   
>   	bytenr = btrfs_sb_offset(copy_num);
>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>   		return -EINVAL;
>   
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +	page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT, gfp_mask);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +	bio_set_dev(&bio, bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,
> +		     offset_in_page(bytenr));
> +
> +	ret = submit_bio_wait(&bio);
> +	unlock_page(page);
>   	/*
>   	 * If we fail to read from the underlying devices, as of now
>   	 * the best option we have is to mark it EIO.
>   	 */
> -	if (!bh)
> +	if (ret) {
> +		put_page(page);
>   		return -EIO;
> +	}
>   
> -	super = (struct btrfs_super_block *)bh->b_data;
> +	super = kmap(page);
>   	if (btrfs_super_bytenr(super) != bytenr ||
>   		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		brelse(bh);
> +		btrfs_release_disk_super(page);
>   		return -EINVAL;
>   	}
> +	kunmap(page);
>   
> -	*bh_ret = bh;
> +	*super_page = page;
>   	return 0;
>   }
>   
>   
> -struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
> +int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
>   {
> -	struct buffer_head *bh;
> -	struct buffer_head *latest = NULL;
> +	struct page *latest = NULL;
>   	struct btrfs_super_block *super;
>   	int i;
>   	u64 transid = 0;
> @@ -3419,25 +3443,28 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>   	 */
>   	for (i = 0; i < 1; i++) {
> -		ret = btrfs_read_dev_one_super(bdev, i, &bh);
> +		ret = btrfs_read_dev_one_super(bdev, i, page);
>   		if (ret)
>   			continue;
>   
> -		super = (struct btrfs_super_block *)bh->b_data;
> +		super = kmap(*page);
>   
>   		if (!latest || btrfs_super_generation(super) > transid) {
> -			brelse(latest);
> -			latest = bh;
> +			if (latest)
> +				btrfs_release_disk_super(latest);
> +			latest = *page;
>   			transid = btrfs_super_generation(super);
>   		} else {
> -			brelse(bh);
> +			btrfs_release_disk_super(*page);
>   		}
> +
> +		kunmap(*page);
>   	}
>   
> -	if (!latest)
> -		return ERR_PTR(ret);
> +	if (ret)
> +		return ret;
>   
> -	return latest;
> +	return 0;
>   }
>   
>   /*
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 8c2d6cf1ce59..e04b233c436a 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -54,9 +54,9 @@ int __cold open_ctree(struct super_block *sb,
>   	       char *options);
>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
> -struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
> +int btrfs_read_dev_super(struct block_device *bdev, struct page **super_page);
>   int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret);
> +			     struct page **super_page);
>   int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>   struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
>   				      struct btrfs_key *location);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7a480a2bdf51..f4a6ee518f0c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6,7 +6,6 @@
>   #include <linux/sched.h>
>   #include <linux/bio.h>
>   #include <linux/slab.h>
> -#include <linux/buffer_head.h>
>   #include <linux/blkdev.h>
>   #include <linux/ratelimit.h>
>   #include <linux/kthread.h>
> @@ -500,7 +499,7 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
>   static int
>   btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>   		      int flush, struct block_device **bdev,
> -		      struct buffer_head **bh)
> +		      struct page **super_page)
>   {
>   	int ret;
>   
> @@ -519,9 +518,8 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>   		goto error;
>   	}
>   	invalidate_bdev(*bdev);
> -	*bh = btrfs_read_dev_super(*bdev);
> -	if (IS_ERR(*bh)) {
> -		ret = PTR_ERR(*bh);
> +	ret = btrfs_read_dev_super(*bdev, super_page);
> +	if (ret) {
>   		blkdev_put(*bdev, flags);
>   		goto error;
>   	}
> @@ -530,7 +528,6 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>   
>   error:
>   	*bdev = NULL;
> -	*bh = NULL;
>   	return ret;
>   }
>   
> @@ -611,7 +608,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   {
>   	struct request_queue *q;
>   	struct block_device *bdev;
> -	struct buffer_head *bh;
> +	struct page *super_page;
>   	struct btrfs_super_block *disk_super;
>   	u64 devid;
>   	int ret;
> @@ -622,17 +619,17 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   		return -EINVAL;
>   
>   	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
> -				    &bdev, &bh);
> +				    &bdev, &super_page);
>   	if (ret)
>   		return ret;
>   
> -	disk_super = (struct btrfs_super_block *)bh->b_data;
> +	disk_super = kmap(super_page);
>   	devid = btrfs_stack_device_id(&disk_super->dev_item);
>   	if (devid != device->devid)
> -		goto error_brelse;
> +		goto error_free_page;
>   
>   	if (memcmp(device->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE))
> -		goto error_brelse;
> +		goto error_free_page;
>   
>   	device->generation = btrfs_super_generation(disk_super);
>   
> @@ -641,7 +638,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
>   			pr_err(
>   		"BTRFS: Invalid seeding and uuid-changed device detected\n");
> -			goto error_brelse;
> +			goto error_free_page;
>   		}
>   
>   		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> @@ -667,12 +664,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   		fs_devices->rw_devices++;
>   		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
>   	}
> -	brelse(bh);
> +	btrfs_release_disk_super(super_page);
>   
>   	return 0;
>   
> -error_brelse:
> -	brelse(bh);
> +error_free_page:
> +	btrfs_release_disk_super(super_page);
>   	blkdev_put(bdev, flags);
>   
>   	return -EINVAL;
> @@ -2209,14 +2206,15 @@ static struct btrfs_device *btrfs_find_device_by_path(
>   	u64 devid;
>   	u8 *dev_uuid;
>   	struct block_device *bdev;
> -	struct buffer_head *bh;
> +	struct page *super_page;
>   	struct btrfs_device *device;
>   
>   	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
> -				    fs_info->bdev_holder, 0, &bdev, &bh);
> +				    fs_info->bdev_holder, 0, &bdev,
> +				    &super_page);
>   	if (ret)
>   		return ERR_PTR(ret);
> -	disk_super = (struct btrfs_super_block *)bh->b_data;
> +	disk_super = kmap(super_page);
>   	devid = btrfs_stack_device_id(&disk_super->dev_item);
>   	dev_uuid = disk_super->dev_item.uuid;
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> @@ -2226,7 +2224,7 @@ static struct btrfs_device *btrfs_find_device_by_path(
>   		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>   					   disk_super->fsid, true);
>   
> -	brelse(bh);
> +	btrfs_release_disk_super(super_page);
>   	if (!device)
>   		device = ERR_PTR(-ENOENT);
>   	blkdev_put(bdev, FMODE_READ);
> @@ -7319,25 +7317,39 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
>   
>   void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
>   {
> -	struct buffer_head *bh;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
>   	struct btrfs_super_block *disk_super;
>   	int copy_num;
>   
>   	if (!bdev)
>   		return;
>   
> +	bio_init(&bio, &bio_vec, 1);
>   	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
>   		copy_num++) {
> +		u64 bytenr = btrfs_sb_offset(copy_num);
> +		struct page *page;
>   
> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> +		if (btrfs_read_dev_one_super(bdev, copy_num, &page))
>   			continue;
>   
> -		disk_super = (struct btrfs_super_block *)bh->b_data;
> +		disk_super = kmap(page) + offset_in_page(bytenr);
>   
>   		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> -		set_buffer_dirty(bh);
> -		sync_dirty_buffer(bh);
> -		brelse(bh);
> +
> +		bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio_set_dev(&bio, bdev);
> +		bio_set_op_attrs(&bio, REQ_OP_WRITE, 0);
nit: We're losing REQ_SYNC here, not that it matters but if you have to re-roll 
it may be nice to have.  Otherwise

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
