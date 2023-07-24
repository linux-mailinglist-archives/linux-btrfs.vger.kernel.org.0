Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FF75EA71
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGXETC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGXETA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072C6138
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172338; x=1721708338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKXvNWF7OtiyUhlJVvIaxe2pDZxA+zKUoLQGxrYwxMo=;
  b=mYI1/rVH/T1MCBlJcjM3m11YJXpURAKDz2loNikMiEibVAtjoRStwOiH
   jo6IBBeYGbqNdZRRLIdsanoqWmflODwIdIANfKgAixS657XCTT80Dqeg1
   ZJPf6B+pajEwcfIj4w/04IaOVnYTXuHWbbSLv2Abg27P7B5FOGC46C86R
   d9gRWJtD+x+KtE1xFfWoIY0SCXee/Ic0px/ndvANs511XcUGCtuHKPr3h
   WqbjePexZUH0SiB88uMuvr95oQHjffzpSwVxbyOsPOTRjBmoeIOPrkpkb
   NMWVK13RcXxgLzSfHGrQXsVP5C+yQINy+OhFba1G8ioaio/n8KkSpE6m4
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524370"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:18:58 +0800
IronPort-SDR: 3rfAwoNovKYgS6L/8EXxOIJL6wtMTVfy/TZHT/nPkI7DGqVbDoKPgtFa9UbwViQIaWV4x5qq+w
 V9abZlC6TB0zk62WVLwFdTIzvvDLKlsxvbxPe7/fcKWGwaRjBqiE95wa0igcWzcFtBRh/37JSU
 wY0oWZYmgzxsuCCzcgex+9y1K5uXTG2wNOjgmvjEqvX+SHSGD+UvQQ0cJJeRAuxV17dAt8hJrp
 y1GXr8TepsUpBgdwzgl8EqCz45jrBBVY33SH1rO/QxVv5RgNiMdOqQgjrbvhILlzg7AAi46A6d
 JPU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:03 -0700
IronPort-SDR: SCTc/1F3iBcdM96fsUFgS0t17Yabz0C2v0+k0FkGrKtvXYSNqAlsirJAJWyHYE8KQPGLKBS7mp
 /ZNSjAyDuB8WhANw1qb6WkJbSgzX0LlfLmHYT8Esw9LG0InizRReOcFP+zVjsiJCwR1dnMG9Zg
 z4GnJdYfMsWDX0UK+DINf7rgLjKTdqmMbGr4uv5JeqdsiuccqXdpHo+aX2KJlnragTSpRt3R9y
 KO1qzmN1CoWPZ6EEcUy8CiPaUYnnirEY9MET96X9ZwyTozwGnRUfi3qmVJtSlUrhLQVomFo8fo
 wHg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:18:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/8] btrfs: zoned: introduce block_group context for submit_eb_page()
Date:   Mon, 24 Jul 2023 13:18:30 +0900
Message-ID: <d20226362b9b193d85f63e81ee128ef3062e2203.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Introduce "bg_context" to cache the block group working on.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 21 +++++++++++----------
 fs/btrfs/zoned.c     | 32 +++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 91282aefcb77..c7a88d2b5555 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1855,10 +1855,10 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
  * Return <0 for fatal error.
  */
 static int submit_eb_page(struct page *page, struct writeback_control *wbc,
-			  struct extent_buffer **eb_context)
+			  struct extent_buffer **eb_context,
+			  struct btrfs_block_group **bg_context)
 {
 	struct address_space *mapping = page->mapping;
-	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1894,7 +1894,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
+	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, bg_context)) {
 		/*
 		 * If for_sync, this hole will be filled with
 		 * trasnsaction commit.
@@ -1910,18 +1910,15 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	*eb_context = eb;
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(cache, eb);
-		if (cache)
-			btrfs_put_block_group(cache);
+		btrfs_revert_meta_write_pointer(*bg_context, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
-	if (cache) {
+	if (*bg_context) {
 		/*
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
-		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
+		btrfs_schedule_zone_finish_bg(*bg_context, eb);
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
@@ -1932,6 +1929,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_buffer *eb_context = NULL;
+	struct btrfs_block_group *bg_context = NULL;
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -1973,7 +1971,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, wbc, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &eb_context, &bg_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -2034,6 +2032,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 		ret = 0;
 	if (!ret && BTRFS_FS_ERROR(fs_info))
 		ret = -EROFS;
+
+	if (bg_context)
+		btrfs_put_block_group(bg_context);
 	btrfs_zoned_meta_io_unlock(fs_info);
 	return ret;
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5e4285ae112c..58bd2de4026d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1751,27 +1751,33 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret)
 {
-	struct btrfs_block_group *cache;
-	bool ret = true;
+	struct btrfs_block_group *cache = NULL;
 
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
-	cache = btrfs_lookup_block_group(fs_info, eb->start);
-	if (!cache)
-		return true;
+	if (*cache_ret) {
+		cache = *cache_ret;
+		if (cache->start > eb->start ||
+		    cache->start + cache->length <= eb->start) {
+			btrfs_put_block_group(cache);
+			cache = NULL;
+			*cache_ret = NULL;
+		}
+	}
 
-	if (cache->meta_write_pointer != eb->start) {
-		btrfs_put_block_group(cache);
-		cache = NULL;
-		ret = false;
-	} else {
-		cache->meta_write_pointer = eb->start + eb->len;
+	if (!cache) {
+		cache = btrfs_lookup_block_group(fs_info, eb->start);
+		if (!cache)
+			return true;
+		*cache_ret = cache;
 	}
 
-	*cache_ret = cache;
+	if (cache->meta_write_pointer != eb->start)
+		return false;
+	cache->meta_write_pointer = eb->start + eb->len;
 
-	return ret;
+	return true;
 }
 
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-- 
2.41.0

