Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD0769F44
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGaRUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjGaRUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC81BF1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823940; x=1722359940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZMbr38WIVVfSUpxRsQULT34AVa+TI4hSVGvb2cAnmE=;
  b=HkD508sEcG5qnUy73dbcBn10jT0k0XDfatgfOJjFIDQ3GxdWWbT74qAu
   w3C3u+erGPI79cdagd3h/PyrOPocp8ZyFclTND47v+893WrMEge669Qut
   KLGhCjUVrCmAUvR0nRYtVQQzm9gaKLqRnDTGBtUkx8LscfZwtCzYq9Ovx
   SzxdPeD7adgdHo2A11fSNLuV+MxWJH9FqkJT4DFDVRDpHV0SLpHJz1ekk
   +UTmMB4k/tWzbVgSX/kIhcNfC+L2aBey9Bwygr3sdOVWtDUChApULms/o
   GskMjYa5YiEMKbgrGsZUy2eeFFPSlchGV8ps8eixlU5DGTbB/ajBEUpRt
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269556"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:35 +0800
IronPort-SDR: Ko9ewRLr+30Et4OC5WBzZNgwUo5cCE5ww9DC3pj6jZqsaH25TOfcHFpD0nj6OIx1wyVJeZz3G2
 jUjsvmgH8xHldPf2VluytoCHApriub3aDWcDT4OvDV+nExVIO8BHg2foCFw7MTynQAYfIpUnLK
 zkcPeYhNtXmdRYYXww+ZdzGZuChKQ4FirHovPnbl6bn9HyXwglPC6+He2zH96mjY7u0En+lA23
 w47YhOmiGhX3EkyRXNddaM0DZn+EOWqFppK5xL9Lsz/0HkDfTOvgc42tCVoB1BtUVDyAw+kYGE
 A5s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:12 -0700
IronPort-SDR: 6AFjpUaM/6VdWD3HC0gyfdgK3G6e+zMCPBIRsMYRpNT4dbkGNE2wFifDTnxzapA5+xfsPimR2B
 yZZTIRgdNudvxiesHOYUbbn5jSiZXB9IPP5t3P61kFcPX6ZXLt6w2HxwznEFAEj9AvrgCeJEeG
 w1yNB7FmH+E8gx83afw3L0t9Hxt9uk/v6mlerb5REv2gHoARx8Yr+34LGOaerZXjkw/RjGcPnj
 QcT75M9GQoyRTfe6J7SL6dxPeuemjGxiX3TnTaiAlsNowXPaqYVQ/YRhNt21DwGY7m9I2N8VVB
 FE4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 03/10] btrfs: zoned: return int from btrfs_check_meta_write_pointer
Date:   Tue,  1 Aug 2023 02:17:12 +0900
Message-ID: <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
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

Now that we have writeback_controll passed to
btrfs_check_meta_write_pointer(), we can move the wbc condition in
submit_eb_page() to btrfs_check_meta_write_pointer() and return int.
---
 fs/btrfs/extent_io.c | 11 +++--------
 fs/btrfs/zoned.c     | 30 ++++++++++++++++++++++--------
 fs/btrfs/zoned.h     | 10 +++++-----
 3 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da8d9478972c..012f2853b835 100644
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
index a6cdd0c4d7b7..0aa32b19adb5 100644
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
 	struct btrfs_block_group *block_group = ctx->block_group;
 
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
 		ctx->block_group = block_group;
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

