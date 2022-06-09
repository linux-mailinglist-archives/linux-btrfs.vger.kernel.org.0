Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55207545615
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiFIVAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiFIVAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 17:00:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B00326FE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uebglSZkHIwtcIAyB4w2ig3C1W7wizubnbMl9ePoeoY=; b=IbacWpn3XB+D2ALpZRINxXVR2N
        UT8VAL4g2OH+RioStVdg3lUlPi8LJ9GzOuRO2YRrsBxfLx9SV3YPSNjVZQF4hsA/qRJWK8UZx8QKa
        l0BixogwsTGDbcu4xkWxgomv+O3+LYxaVpHI1v7RO5/BOpqupVchLxhcnc3jqxJWckS+gHNfYkiDR
        nLW4zcScBsFbGaVvsic8pDALlXb++++cnSMYP8AkIfl411qnQPVGhP+hDp7lzKrXMsFMsNWNSySvq
        5NigbZdCVyMWjqQvixmob8R2mLVV8t9y7yFUKWnpj5xe5ZkpuzM/oVhguBzBCzFx+OYRR9E2dlLfy
        BlYFR4hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzPGN-00DqsN-21; Thu, 09 Jun 2022 21:00:19 +0000
Date:   Thu, 9 Jun 2022 22:00:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <YqJfYzwVZlITeED0@casper.infradead.org>
References: <20220609164629.30316-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609164629.30316-1-dsterba@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 06:46:29PM +0200, David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> API.  We don't use the page cache or the mapping anywhere else, the page
> is a temporary space for the associated bio.
> 
> Allocate pages for all super block copies at device allocation time,
> also to avoid any later allocation problems when writing the super
> block. This simplifies the page reference tracking, but the page lock is
> still used as waiting mechanism for the write and write error is tracked
> in the page.
> 
> As there is a separate page for each super block copy all can be
> submitted in parallel, as before.

Why not submit the same page to all IOs?  Something like this
(uncompiled, probably full of brokenness, really just for getting the
concept across)


diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 31c3f592e587..f7c2de47dc88 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1767,8 +1767,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->block_group_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
-	kfree(fs_info->super_copy);
-	kfree(fs_info->super_for_commit);
+	free_page(fs_info->super_copy);
+	free_page(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
 	kvfree(fs_info);
 }
@@ -3981,20 +3981,19 @@ static void btrfs_end_super_write(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		page = bvec->bv_page;
 
+		lock_page(page);
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
 				"lost page write due to IO error on %s (%d)",
 				rcu_str_deref(device->name),
 				blk_status_to_errno(bio->bi_status));
-			ClearPageUptodate(page);
-			SetPageError(page);
+
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
-		} else {
-			SetPageUptodate(page);
+			page->index++;
 		}
-
-		put_page(page);
+		if (--page->private == 0)
+			end_page_writeback(page);
 		unlock_page(page);
 	}
 
@@ -4083,8 +4082,8 @@ static int write_dev_supers(struct btrfs_device *device,
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct page *page = virt_to_page(sb);
 	int i;
-	int errors = 0;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
@@ -4092,21 +4091,31 @@ static int write_dev_supers(struct btrfs_device *device,
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	shash->tfm = fs_info->csum_shash;
+	page->private = max_mirrors;
+	page->index = 0;	/* errors */
+	SetPageWriteback(page);
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
 		if (ret == -ENOENT) {
+			lock_page(page);
+			if (--page->private == 0)
+				end_page_writeback(page);
+			unlock_page(page);
 			continue;
 		} else if (ret < 0) {
 			btrfs_err(device->fs_info,
 				"couldn't get super block location for mirror %d",
 				i);
-			errors++;
+			lock_page(page);
+			page->index++;
+			if (--page->private == 0)
+				end_page_writeback(page);
+			unlock_page(page);
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
@@ -4119,22 +4128,6 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
-		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
-					   GFP_NOFS);
-		if (!page) {
-			btrfs_err(device->fs_info,
-			    "couldn't get super block page for bytenr %llu",
-			    bytenr);
-			errors++;
-			continue;
-		}
-
-		/* Bump the refcount for wait_dev_supers() */
-		get_page(page);
-
-		disk_super = page_address(page);
-		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
-
 		/*
 		 * Directly use bios here instead of relying on the page cache
 		 * to do I/O, so we don't lose the ability to do integrity
@@ -4146,8 +4139,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
-		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
-			       offset_in_page(bytenr));
+		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE, 0);
 
 		/*
 		 * We FUA only the first super block.  The others we allow to
@@ -4159,8 +4151,11 @@ static int write_dev_supers(struct btrfs_device *device,
 
 		btrfsic_submit_bio(bio);
 
-		if (btrfs_advance_sb_log(device, i))
-			errors++;
+		if (btrfs_advance_sb_log(device, i)) {
+			lock_page(page);
+			page->index++;
+			unlock_page(page);
+		}
 	}
 	return errors < i ? 0 : -1;
 }
@@ -4172,64 +4167,13 @@ static int write_dev_supers(struct btrfs_device *device,
  * Return number of errors when page is not found or not marked up to
  * date.
  */
-static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
+static int wait_dev_supers(struct btrfs_device *device,
+		struct btrfs_super_block *sb)
 {
-	int i;
-	int errors = 0;
-	bool primary_failed = false;
-	int ret;
-	u64 bytenr;
-
-	if (max_mirrors == 0)
-		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
-
-	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
-
-		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
-		if (ret == -ENOENT) {
-			break;
-		} else if (ret < 0) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-			continue;
-		}
-		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
-		    device->commit_total_bytes)
-			break;
-
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
-				     bytenr >> PAGE_SHIFT);
-		if (!page) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-			continue;
-		}
-		/* Page is submitted locked and unlocked once the IO completes */
-		wait_on_page_locked(page);
-		if (PageError(page)) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-		}
-
-		/* Drop our reference */
-		put_page(page);
-
-		/* Drop the reference from the writing run */
-		put_page(page);
-	}
-
-	/* log error, force error return */
-	if (primary_failed) {
-		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
-			  device->devid);
-		return -1;
-	}
+	struct page *page = virt_to_page(sb);
 
-	return errors < i ? 0 : -1;
+	wait_on_page_writeback(page);
+	return page->index;
 }
 
 /*
@@ -4475,18 +4419,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		return -EIO;
 	}
 
-	total_errors = 0;
-	list_for_each_entry(dev, head, dev_list) {
-		if (!dev->bdev)
-			continue;
-		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
-		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
-			continue;
-
-		ret = wait_dev_supers(dev, max_mirrors);
-		if (ret)
-			total_errors++;
-	}
+	total_errors = wait_dev_supers(dev, sb);
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 	if (total_errors > max_errors) {
 		btrfs_handle_fs_error(fs_info, -EIO,
