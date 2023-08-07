Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B3772A3B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHGQMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjHGQMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FB9F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424769; x=1722960769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCqCEWtdNsdcrbDu/klYMSsyOMKVVYrG/3D0RMsBynA=;
  b=S7i3xcfQw6rzY1qTv1UY3TRSU8UaW7PwhgalBJj4E02fAQxf7APcgWH5
   IR38TkjVNdUvvg+NYFX9Rz/sEdLRzJ9FhU0J1V4voIGHKF5zgX6UPHfyb
   biUo06mXYOoanOtDqk2uyyRVzeZXycX8SGKQwoYVdViY6xJFR1rUXhpKd
   26iEji68aHV6m11N3YhZ5Fj/po6oSzOO8QjIyluXIBk5a635olrhOj07f
   4fGeQUK4nmGtQ04AZg72oyfMdCG2LQ/aKWrtaOUOg+P1q4fsGoyXnRtV1
   /YRAnUbqiBDio/F94fMt3IjpSIzo1t0QsvjlAu20PGw/bZ3oRK6L5qod8
   g==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710987"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:49 +0800
IronPort-SDR: kxs4REdnYyTBO0H+CkvGMWKZ19uJOO9PKBEJzOFwQkg5gYUov/oXgqL4ylA2UPe/L33ebLBG7N
 evjZ+GMdMT1nla+SQOgXxQf9uSdVgcmT0FVI7MoRa1ek/3EyVEvDaosVu51ZSDmHn5sY+/oAo2
 rB7fF2BQ+KETMZnDQfByzRHGpWZXWTfvXzpzysGoRbYa8s36Wu3ruMxknXCSA2hGkTdEmuLmaj
 b2xBZ4lpP+IVRZtJ3pI3zxHS1DOQ38m/kGp3ERcAl296N5Qwr1TJsFIQ6cRjqsNSk4x288zRvW
 3ec=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:17 -0700
IronPort-SDR: tyrdB2f4L12H8IQGwC67ex/tBlQ6W2ua3Ee6Qaitcbfm0lrI5TfsvbtNccN4TBZhDhj+nAjlpX
 OYLqeMRT1KF2TBQbojYYLhaYoTozClqYfnYkFGZgHPEe5+L9iYZIe3evay6Jn2eINoBiFJtP4i
 oOuzPpvpR327zhVq5Rak1uraNZFYapXAHlYlQAyqcB7EJ2UlHHDhwVn41Cp+knL35lUBKCPiAj
 ajoR5fNnMN9EQESvGbir+t4R7nZZ5gHDkNhUGeJMMn+ohKYBDVB10dUQqJ0F0rfdDcTQBUiFKB
 bs8=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:49 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 03/10] btrfs: zoned: return int from btrfs_check_meta_write_pointer
Date:   Tue,  8 Aug 2023 01:12:33 +0900
Message-ID: <0e8fe9f690ef9aa146df3021fd8a60531693ed0a.1691424260.git.naohiro.aota@wdc.com>
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

Now that we have writeback_control passed to
btrfs_check_meta_write_pointer(), we can move the wbc condition in
submit_eb_page() to btrfs_check_meta_write_pointer() and return int.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 11 +++--------
 fs/btrfs/zoned.c     | 30 ++++++++++++++++++++++--------
 fs/btrfs/zoned.h     | 10 +++++-----
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4a629a7cf478..f6c47e24956a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1825,14 +1825,9 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 
 	ctx->eb = eb;
 
-	if (!btrfs_check_meta_write_pointer(eb->fs_info, ctx)) {
-		/*
-		 * If for_sync, this hole will be filled with
-		 * trasnsaction commit.
-		 */
-		if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
-			ret = -EAGAIN;
-		else
+	ret = btrfs_check_meta_write_pointer(eb->fs_info, ctx);
+	if (ret) {
+		if (ret == -EBUSY)
 			ret = 0;
 		free_extent_buffer(eb);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3a763eb535b0..beaf082c16c0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1747,14 +1747,23 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct btrfs_eb_write_context *ctx)
+/*
+ * Check @ctx->eb is aligned to the write pointer
+ *
+ * Return:
+ *   0: @ctx->eb is at the write pointer. You can write it.
+ *   -EAGAIN: There is a hole. The caller should handle the case.
+ *   -EBUSY: There is a hole, but the caller can just bail out.
+ */
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx)
 {
+	const struct writeback_control *wbc = ctx->wbc;
 	const struct extent_buffer *eb = ctx->eb;
 	struct btrfs_block_group *block_group = ctx->zoned_bg;
 
 	if (!btrfs_is_zoned(fs_info))
-		return true;
+		return 0;
 
 	if (block_group) {
 		if (block_group->start > eb->start ||
@@ -1768,15 +1777,20 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	if (!block_group) {
 		block_group = btrfs_lookup_block_group(fs_info, eb->start);
 		if (!block_group)
-			return true;
+			return 0;
 		ctx->zoned_bg = block_group;
 	}
 
-	if (block_group->meta_write_pointer != eb->start)
-		return false;
-	block_group->meta_write_pointer = eb->start + eb->len;
+	if (block_group->meta_write_pointer == eb->start) {
+		block_group->meta_write_pointer = eb->start + eb->len;
 
-	return true;
+		return 0;
+	}
+
+	/* If for_sync, this hole will be filled with trasnsaction commit. */
+	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
+		return -EAGAIN;
+	return -EBUSY;
 }
 
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 49d5bd87245c..c0859d8be152 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -58,8 +58,8 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
-bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-				    struct btrfs_eb_write_context *ctx);
+int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_eb_write_context *ctx);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
@@ -188,10 +188,10 @@ static inline void btrfs_record_physical_zoned(struct btrfs_bio *bbio)
 {
 }
 
-static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-						  struct btrfs_eb_write_context *ctx)
+static inline int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+						 struct btrfs_eb_write_context *ctx)
 {
-	return true;
+	return 0;
 }
 
 static inline void btrfs_revert_meta_write_pointer(
-- 
2.41.0

