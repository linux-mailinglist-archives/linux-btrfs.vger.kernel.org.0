Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1E769F43
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGaRU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjGaRTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:19:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EC4687
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823926; x=1722359926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29NmnBpzMVnfklSXrLpRVa5ows284tTdzjd0plRynD0=;
  b=dcMY8jifPOaqA9th1DZnf7E3ryOxtDSp81CgYnUcuuYJt4WY3SOTr29V
   p6rilutUg4NQpIif368bfQWptvvCrcKPUrIMTlVqPNIxBkTFPBKDWi3S/
   86jax+LTsOtYLGI4GYiYuUEKnQ/Py0ztEJ6NblPah12XvMZLMCXJkjilf
   E9N310gS8+xo6Jp2p/MAUilWnxI6hou0Yw+We9HCRDRQxj+nvjAM8NPBR
   fSqTCO9/T7fOJbIdPCjoR+U9jSqp3L8FoI8t7e7eUKyDH5Tp7+QqOJa+c
   s0sel3hUyyaWcOeAfyl8anq7f/hFH6Fzym8EL/4TK5U5RgAYH2c7vEyDi
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269554"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:34 +0800
IronPort-SDR: TDm8OaQM+SoDTsXh2NYNBsLCa83rHDJwzFvfvjlK+gdrn5Mn3ALAFHnci3RbKpar2CYmeI+tHl
 xMfYv6CX8Psr2tmfR/OoiBt4Ltq5tKVb1uQOiKbns9wemKqeRrjzR2yNKfTSaclSwdmNlDuZNJ
 KONLrbRlZrxmPwVoOMg+0ZjZw97UTvesUSEVZjXUh79YOFxkqAKzUExiLBsz8ao9UBRbvXlOzu
 Yuoc153uztPQFvqyiMyXxNd5fUglGPaHZRRFD/Ua8QfUaemj0Ft3uOyiZLXylHfr407CAZF/rN
 kXo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:11 -0700
IronPort-SDR: oet1X2vtkw0955oZHfZbyktzc0PTL3D1JiutwKH4dcunIaxlfrlyBeyEIdDUoGsOch1VCiRfNd
 ZAA4/UyLR/TPTIFSylg/PoqHT04lTaF3mZkMVg4hzwEanLMq4rmgPomY8urMgsnHOQffucaeN+
 3iUzoaSAj5ip7nnuRfKWoC4rHHB2i5wxRBgHJe9IIgqurqWHY7ZfJchV85ZJN83scx+bZD/9wm
 TuuoL0cWmJiWavKg0ktO2oj4hqcEYxD1KwmKdteVjUzsTmBw1GK4bqWYxwl6VNBkpFK6jnq127
 KJk=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:34 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 02/10] btrfs: zoned: introduce block_group context to btrfs_eb_write_context
Date:   Tue,  1 Aug 2023 02:17:11 +0900
Message-ID: <31cfb11cd71edc3513f0d65d1da6a2b6d3b959e7.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For metadata write out on the zoned mode, we call
btrfs_check_meta_write_pointer() to check if an extent buffer to be written
is aligned to the write pointer.

We lookup for a block group containing the extent buffer for every extent
buffer, which take unnecessary effort as the writing extent buffers are
mostly contiguous.

Introduce "block_group" to cache the block group working on.

Also, while at it, rename "cache" to "block_group".

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++--------
 fs/btrfs/extent_io.h |  1 +
 fs/btrfs/zoned.c     | 35 ++++++++++++++++++++---------------
 fs/btrfs/zoned.h     |  6 ++----
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 40633bc15c97..da8d9478972c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1788,7 +1788,6 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 {
 	struct writeback_control *wbc = ctx->wbc;
 	struct address_space *mapping = page->mapping;
-	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1826,7 +1825,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 
 	ctx->eb = eb;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, ctx)) {
 		/*
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
@@ -1840,18 +1839,15 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	}
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(cache, eb);
-		if (cache)
-			btrfs_put_block_group(cache);
+		btrfs_revert_meta_write_pointer(ctx->block_group, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
-	if (cache) {
+	if (ctx->block_group) {
 		/*
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
+		btrfs_schedule_zone_finish_bg(ctx->block_group, eb);
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
@@ -1864,6 +1860,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	struct btrfs_eb_write_context ctx = {
 		.wbc = wbc,
 		.eb = NULL,
+		.block_group = NULL,
 	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
@@ -1967,6 +1964,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
+
+	if (ctx.block_group)
+		btrfs_put_block_group(ctx.block_group);
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e243a8eac910..d616d30ed4bd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -96,6 +96,7 @@ struct extent_buffer {
 struct btrfs_eb_write_context {
 	struct writeback_control *wbc;
 	struct extent_buffer *eb;
+	struct btrfs_block_group *block_group;
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5e4285ae112c..a6cdd0c4d7b7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1748,30 +1748,35 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret)
+				    struct btrfs_eb_write_context *ctx)
 {
-	struct btrfs_block_group *cache;
-	bool ret = true;
+	const struct extent_buffer *eb = ctx->eb;
+	struct btrfs_block_group *block_group = ctx->block_group;
 
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
-	cache = btrfs_lookup_block_group(fs_info, eb->start);
-	if (!cache)
-		return true;
+	if (block_group) {
+		if (block_group->start > eb->start ||
+		    block_group->start + block_group->length <= eb->start) {
+			btrfs_put_block_group(block_group);
+			block_group = NULL;
+			ctx->block_group = NULL;
+		}
+	}
 
-	if (cache->meta_write_pointer != eb->start) {
-		btrfs_put_block_group(cache);
-		cache = NULL;
-		ret = false;
-	} else {
-		cache->meta_write_pointer = eb->start + eb->len;
+	if (!block_group) {
+		block_group = btrfs_lookup_block_group(fs_info, eb->start);
+		if (!block_group)
+			return true;
+		ctx->block_group = block_group;
 	}
 
-	*cache_ret = cache;
+	if (block_group->meta_write_pointer != eb->start)
+		return false;
+	block_group->meta_write_pointer = eb->start + eb->len;
 
-	return ret;
+	return true;
 }
 
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 27322b926038..49d5bd87245c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -59,8 +59,7 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct extent_buffer *eb,
-				    struct btrfs_block_group **cache_ret);
+				    struct btrfs_eb_write_context *ctx);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
@@ -190,8 +189,7 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 }
 
 static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-			       struct extent_buffer *eb,
-			       struct btrfs_block_group **cache_ret)
+						  struct btrfs_eb_write_context *ctx)
 {
 	return true;
 }
-- 
2.41.0

