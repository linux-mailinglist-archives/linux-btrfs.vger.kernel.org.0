Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAD4B9D9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 11:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiBQKwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 05:52:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiBQKwH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 05:52:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B372944C7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 02:51:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90B221F3A2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645095111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uikjpPuNMRfbownWAD5ex3Psx3w450TfQ4Bysj8aE+s=;
        b=R2qOhV6J3R7iB1cZL3lkUniBwaud/w7RDDRXu8J0dGYKJ3QVxwunsSVrtn337H9/esBO4q
        YDP1COsrNaOpfMxNoY6/z+Q+Jcm4ShBijmZbXOYGOlWK5GYQsN85Va/IvoPFOEWiy4vmLX
        sMYY2DkZycptKCDg6/YQQK1v6QCLFrE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D07BF13DD8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLuQJMYoDmKESwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 10:51:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: move scrub_remap_extent() call into scrub_extent() with more comments
Date:   Thu, 17 Feb 2022 18:51:24 +0800
Message-Id: <9e2dcc040f570bb4aa1e6627c276742ccfca513c.1645094762.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645094762.git.wqu@suse.com>
References: <cover.1645094762.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[SUSPICIOUS CODE]
When refactoring scrub code, I notice a very strange behavior around
scrub_remap_extent():

		if (sctx->is_dev_replace)
			scrub_remap_extent(fs_info, cur_logical, scrub_len,
					   &cur_physical, &target_dev, &cur_mirror);

As replace target is a 1:1 copy of the source device, thus physical
offset inside the target should be the same as physical inside source,
thus this remap call makes no sense to me.

[REAL FUNCTIONALITY]
After more investigation, the function name scrub_remape_extent()
doesn't tell anything of the truth, nor does its if () condition.

The real story behind this function is that, for scrub_pages() we never
expect missing device, even for replacing missing device.

What scrub_remap_extent() is really doing is to find a live mirror, and
make later scrub_pages() to read data from the good copy, other than
from the missing device and increase error counters unnecessarily.

[IMPROVEMENT]
We have no need to bother scrub_remap_extent() in scrub_simple_mirror()
at all, we only need to call it before we call scrub_pages().

And rename the function to scrub_find_live_copy(), add extra comments on
them.

By this we can remove one parameter from scrub_extent(), and reduce the
unnecessary calls to scrub_remape_extent() for regular replace.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 62 +++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e5e704ea1f2f..83e43d4e596a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -233,11 +233,11 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u32 len,
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct btrfs_work *work);
 static void scrub_block_complete(struct scrub_block *sblock);
-static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
-			       u64 extent_logical, u32 extent_len,
-			       u64 *extent_physical,
-			       struct btrfs_device **extent_dev,
-			       int *extent_mirror_num);
+static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
+				 u64 extent_logical, u32 extent_len,
+				 u64 *extent_physical,
+				 struct btrfs_device **extent_dev,
+				 int *extent_mirror_num);
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage);
 static void scrub_wr_submit(struct scrub_ctx *sctx);
@@ -2213,7 +2213,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		 * We shouldn't be scrubbing a missing device. Even for dev
 		 * replace, we should only get here for RAID 5/6. We either
 		 * managed to mount something with no mirrors remaining or
-		 * there's a bug in scrub_remap_extent()/btrfs_map_block().
+		 * there's a bug in scrub_find_good_copy()/btrfs_map_block().
 		 */
 		goto bioc_out;
 	}
@@ -2532,8 +2532,11 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 			u64 logical, u32 len,
 			u64 physical, struct btrfs_device *dev, u64 flags,
-			u64 gen, int mirror_num, u64 physical_for_dev_replace)
+			u64 gen, int mirror_num)
 {
+	struct btrfs_device *src_dev = dev;
+	u64 src_physical = physical;
+	int src_mirror = mirror_num;
 	int ret;
 	u8 csum[BTRFS_CSUM_SIZE];
 	u32 blocksize;
@@ -2561,6 +2564,18 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 		WARN_ON(1);
 	}
 
+	/*
+	 * For dev-replace case, we can have @dev being a missing device.
+	 * Regular scrub will avoid its execution on missing device at all,
+	 * as that would trigger tons of read error.
+	 *
+	 * Reading from missing device will cause read error counts to
+	 * increase unnecessarily.
+	 * So here we change the read source to a good mirror.
+	 */
+	if (sctx->is_dev_replace && !dev->bdev)
+		scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
+				     &src_dev, &src_mirror);
 	while (len) {
 		u32 l = min(len, blocksize);
 		int have_csum = 0;
@@ -2571,15 +2586,15 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 			if (have_csum == 0)
 				++sctx->stat.no_csum;
 		}
-		ret = scrub_pages(sctx, logical, l, physical, dev, flags, gen,
-				  mirror_num, have_csum ? csum : NULL,
-				  physical_for_dev_replace);
+		ret = scrub_pages(sctx, logical, l, src_physical, src_dev,
+				  flags, gen, src_mirror,
+				  have_csum ? csum : NULL, physical);
 		if (ret)
 			return ret;
 		len -= l;
 		logical += l;
 		physical += l;
-		physical_for_dev_replace += l;
+		src_physical += l;
 	}
 	return 0;
 }
@@ -3266,14 +3281,11 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	path.skip_locking = 1;
 	/* Go through each */
 	while (cur_logical < logical_end) {
-		int cur_mirror = mirror_num;
-		struct btrfs_device *target_dev = device;
 		u64 extent_start;
 		u64 extent_len;
 		u64 extent_flags;
 		u64 extent_gen;
 		u64 scrub_len;
-		u64 cur_physical;
 
 		/* Canceled ? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
@@ -3330,11 +3342,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		scrub_len = min(min(extent_start + extent_len,
 				    logical_end), cur_logical + max_length) -
 			    cur_logical;
-		cur_physical = cur_logical - logical_start + physical;
 
-		if (sctx->is_dev_replace)
-			scrub_remap_extent(fs_info, cur_logical, scrub_len,
-					   &cur_physical, &target_dev, &cur_mirror);
 		if (extent_flags & BTRFS_EXTENT_FLAG_DATA) {
 			ret = btrfs_lookup_csums_range(csum_root, cur_logical,
 					cur_logical + scrub_len - 1,
@@ -3354,10 +3362,10 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			cur_logical += scrub_len;
 			continue;
 		}
-		ret = scrub_extent(sctx, map, cur_logical, scrub_len, cur_physical,
-				   target_dev, extent_flags, extent_gen,
-				   cur_mirror, cur_logical - logical_start +
-				   physical);
+		ret = scrub_extent(sctx, map, cur_logical, scrub_len,
+				   cur_logical - logical_start + physical,
+				   device, extent_flags, extent_gen,
+				   mirror_num);
 		scrub_free_csums(sctx);
 		if (ret)
 			break;
@@ -4344,11 +4352,11 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 	return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
 }
 
-static void scrub_remap_extent(struct btrfs_fs_info *fs_info,
-			       u64 extent_logical, u32 extent_len,
-			       u64 *extent_physical,
-			       struct btrfs_device **extent_dev,
-			       int *extent_mirror_num)
+static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
+				 u64 extent_logical, u32 extent_len,
+				 u64 *extent_physical,
+				 struct btrfs_device **extent_dev,
+				 int *extent_mirror_num)
 {
 	u64 mapped_length;
 	struct btrfs_io_context *bioc = NULL;
-- 
2.35.1

