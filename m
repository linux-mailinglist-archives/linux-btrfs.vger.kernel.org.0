Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9330246B43C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhLGHr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 02:47:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLGHru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 02:47:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 266951FD48
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638863060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smnA8ETnoPn9EgutluPCifpf1hfsVYTidwBv5GLVVqw=;
        b=m2pfx6k0XXdBuHcn+tqCWh3TrJADzlPCDXXCww9Tyng9EwC/qABFtniGGazs+1z24pHZcQ
        XgxanNdIH2ZWRpXqKqxy8ezQYBD+P5RKMHxXrArN2SgFSK6YDoL624Ea12H0PujLP4wd7P
        0EcsIG4B0gVslxmKAEaYYzJtfL3mB/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DE4C1332F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eH9VDdMQr2FRHwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 07:44:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
Date:   Tue,  7 Dec 2021 15:43:59 +0800
Message-Id: <20211207074400.63352-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207074400.63352-1-wqu@suse.com>
References: <20211207074400.63352-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function scrub_stripe() we allocated two btrfs_path, one @path for
extent tree search and another @ppath for full stripe extent tree search
for RAID56.

This is totally uncessary, as the @ppath usage is completely inside
scrub_raid56_parity(), thus we can move the path allocation into
scrub_raid56_parity() completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 15a123e67108..a3bd3dfd5e8b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2892,7 +2892,6 @@ static void scrub_parity_put(struct scrub_parity *sparity)
 static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 						  struct map_lookup *map,
 						  struct btrfs_device *sdev,
-						  struct btrfs_path *path,
 						  u64 logic_start,
 						  u64 logic_end)
 {
@@ -2901,6 +2900,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	struct btrfs_root *csum_root;
 	struct btrfs_extent_item *extent;
 	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_path *path;
 	u64 flags;
 	int ret;
 	int slot;
@@ -2919,6 +2919,14 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	int extent_mirror_num;
 	int stop_loop = 0;
 
+	path = btrfs_alloc_path();
+	if (!path) {
+		spin_lock(&sctx->stat_lock);
+		sctx->stat.malloc_errors++;
+		spin_unlock(&sctx->stat_lock);
+		return -ENOMEM;
+	}
+
 	ASSERT(map->stripe_len <= U32_MAX);
 	nsectors = map->stripe_len >> fs_info->sectorsize_bits;
 	bitmap_len = scrub_calc_parity_bitmap_len(nsectors);
@@ -2928,6 +2936,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 		spin_lock(&sctx->stat_lock);
 		sctx->stat.malloc_errors++;
 		spin_unlock(&sctx->stat_lock);
+		btrfs_free_path(path);
 		return -ENOMEM;
 	}
 
@@ -3117,7 +3126,7 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	scrub_wr_submit(sctx);
 	mutex_unlock(&sctx->wr_lock);
 
-	btrfs_release_path(path);
+	btrfs_free_path(path);
 	return ret < 0 ? ret : 0;
 }
 
@@ -3167,7 +3176,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   int num, u64 base, u64 length,
 					   struct btrfs_block_group *cache)
 {
-	struct btrfs_path *path, *ppath;
+	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_root *csum_root;
@@ -3229,12 +3238,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	if (!path)
 		return -ENOMEM;
 
-	ppath = btrfs_alloc_path();
-	if (!ppath) {
-		btrfs_free_path(path);
-		return -ENOMEM;
-	}
-
 	/*
 	 * work on commit root. The related disk blocks are static as
 	 * long as COW is applied. This means, it is save to rewrite
@@ -3243,8 +3246,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
-	ppath->search_commit_root = 1;
-	ppath->skip_locking = 1;
 	/*
 	 * trigger the readahead for extent tree csum tree and wait for
 	 * completion. During readahead, the scrub is officially paused
@@ -3347,7 +3348,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 				stripe_logical += base;
 				stripe_end = stripe_logical + increment;
 				ret = scrub_raid56_parity(sctx, map, scrub_dev,
-							  ppath, stripe_logical,
+							  stripe_logical,
 							  stripe_end);
 				if (ret)
 					goto out;
@@ -3518,7 +3519,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 						stripe_end = stripe_logical +
 								increment;
 						ret = scrub_raid56_parity(sctx,
-							map, scrub_dev, ppath,
+							map, scrub_dev,
 							stripe_logical,
 							stripe_end);
 						if (ret)
@@ -3565,7 +3566,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
-	btrfs_free_path(ppath);
 
 	if (sctx->is_dev_replace && ret >= 0) {
 		int ret2;
-- 
2.34.1

