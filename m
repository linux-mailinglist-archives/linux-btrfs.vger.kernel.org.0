Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2F772A39
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHGQMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHGQMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:49 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2E107
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424768; x=1722960768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFF6wf0YB4ZW/uxoji6c4/mJIHKWuQFNRCIjEuQmjzk=;
  b=RbyishWroGajb1+eXF06FbfJjASs/gK75ZvUdNGiAJmjHTNU4c+eDtdc
   of/4hIehLMdsQNzx5N8P89oFjmvwIOi850SpYjw3pugq9YVr+V9QL+b5k
   KZxLrkKoOXZj4ZKjely8mpEC0NqWAZQFxXtcRhjfB/YS5yAB71j9V7A3p
   MVeFZXM58ZzYp45g46gb57s2jOiF29UA+EEcIDfP+ZeADCEYyOPmoQi9q
   nJKO0DFbQgaFmOrzGPokWBqzbJTRsKWDLaKMf7wWCHSMqH4RVKx8+FCyJ
   65Uendta2mpdRSZ6240O8kUXL1AMv33nvAkmu/ThKK/f4Kfep3JEA0iSm
   w==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710986"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:47 +0800
IronPort-SDR: JHeutKy2X9rrlMtT1ZWofP6X8ldNV+1O9NLlsGhXXXDECg6snG7cQrH3b3egTzbc9c+tNxe2Gi
 sZNc2bxcZNbNA+/nGtd0+PWaZ6HM9IruHaEu2BTrSvDKU7leEtTHMsV4OsozBG7D/xpXGSQCfn
 Wjc4Kwmpr8O5kei4UffNr7bzG2cNLS7kvyRnS2RyQh6umQYRGEl9ORc3XCYtp4Et8jsCDj8nxW
 y5r2xcZD/a7HLaBgXCM/CeCjKxIJLRvR6VJLgeIN/PUwqdVESfXHIkSRSf1bTQoiEHFrNuzcz7
 j1c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:16 -0700
IronPort-SDR: TOV83ROXglfpRxshTi8fCEU8s5LiiRYdInmSLXiLevCHZvbWv/2B6vEb6cOT+pWpXlvkR7oSF6
 Tzfx8e9Axj9mEspWSN0eqzRz/R+5eWnOezIymxmNq1jFop5WnXSpXH5Pm8A1iVCgptOIBfoZ+/
 f77k8sFukY1hpMXtqlvm4yiXJWXYK//8/DBzCXtfys81Px4SWABv2IcIYsmAQAVdKIjabrxnSb
 7G1FxiXny9ss+seOduc1D3CoJ/pFsr3XrsHnMy4FR5JqNTM7IcTCvHcqLJs97QnAQ8AGYjEfEa
 JT8=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 02/10] btrfs: zoned: introduce block group context to btrfs_eb_write_context
Date:   Tue,  8 Aug 2023 01:12:32 +0900
Message-ID: <a22f2c2de29bab01e35836abcf15b35e0c6e7820.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Introduce "zoned_bg" to cache the block group working on.

Also, while at it, rename "cache" to "block_group".

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/zoned.c     | 35 ++++++++++++++++++++---------------
 fs/btrfs/zoned.h     |  6 ++----
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5905d2d42aab..4a629a7cf478 100644
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
+		btrfs_revert_meta_write_pointer(ctx->zoned_bg, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
-	if (cache) {
+	if (ctx->zoned_bg) {
 		/*
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
+		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
@@ -1964,6 +1960,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
+
+	if (ctx.zoned_bg)
+		btrfs_put_block_group(ctx.zoned_bg);
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e243a8eac910..68368ba99321 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -96,6 +96,8 @@ struct extent_buffer {
 struct btrfs_eb_write_context {
 	struct writeback_control *wbc;
 	struct extent_buffer *eb;
+	/* Block group @eb resides in. Only used for zoned mode. */
+	struct btrfs_block_group *zoned_bg;
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5e4285ae112c..3a763eb535b0 100644
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
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
 
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
+			ctx->zoned_bg = NULL;
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
+		ctx->zoned_bg = block_group;
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

