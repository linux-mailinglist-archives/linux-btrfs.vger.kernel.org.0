Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F23772A3C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHGQMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjHGQMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:51 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4A107
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424770; x=1722960770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMIzB+rUZKL3+Uf9qDuNv+xyvyf6jcW5vTMmpArf4JA=;
  b=NfnZuwMWS1Jtz21BUsxxxNI8TP7mK035EqXFr0DJreIVXc1b4koaTsMg
   DPTdjuMcnRy2SChKdJFpIv8Js1jUuLATXDqgOTIibKND0VB7ZHnGPybPG
   SIrzAdyHVDqNgkUpdwfi7VH7MkO5HV+Ke1AVGN7Rsx8x6sB//Snnd7MbF
   EaBWBVSTvX2pbg0pNowI/OQD0x8ZVfF7YQ3Z4RUOIUstT9rh2v0R1SByG
   VQdXVjKSrjaK0BHuca22vKNA5LL8Gn/vFfpeAAtRaWxTvcSBnM+7m8MMl
   SVDLOl/Ojns5i90OhDte8lPnjsOs8GMz143+yQ8wM9X43uHzC18SXLQSg
   w==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710992"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:50 +0800
IronPort-SDR: XSatE76gCb+ZO81q9oKaK0GlhjkiWJDJqznqpGwtDit6m/DsTvWIL3yE9MdbkES+K/cbhJ+WbR
 riYYPbbvEWSBj8aq0RSHvfkcAglfiSPZfDxnPdnIErSXucqRyjTwnSOeC+vIkFu2yNlYH8M6Mn
 9UxMhYJzYj9ZdP4eGHVNqn251N8COKWWRKU9Fkg4qZiG3P0tpC6fmMXy0hesHqR1dkTauZ1OnN
 QLUy+FFwsIzu/5GanXaB8sKiR5JZGj1J3sWSpIngKFX9F3dUV8kKplTbjF4uXr3N/LOSfMXs/5
 MtQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:18 -0700
IronPort-SDR: Uf/B6gePHS0NtZVvc0RAhwh5psU0QzuYRMZGsOHJm+pKSKsjFKts5huLHEOe5pkw5+fahw1n24
 Scu+S8efdJXI0WNMKYLREgW3Haw7qzLy7lUynUeUWmEfCqzah3AWU63VMsJeuH/daWI1MxHJkW
 8Dkx2f7xYqwM4bG9kuVdOMWfq80MUrFfULlFrJcLlSgzrd64ujPpYYZSoQZx8xlXNV4cTEHcld
 LD9y+zHi101LqaymLZ55tMxM/xRSIgmA1n/rOkTlK+Y7YhXI9QLGD5OTRN1tS6+oZEYCjY4fFr
 n08=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 04/10] btrfs: zoned: defer advancing meta_write_pointer
Date:   Tue,  8 Aug 2023 01:12:34 +0900
Message-ID: <3195b4f2e9417c568e6e27b3c218ff67c6e83745.1691424260.git.naohiro.aota@wdc.com>
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

We currently advance the meta_write_pointer in
btrfs_check_meta_write_pointer(). That make it necessary to revert to it
when locking the buffer failed. Instead, we can advance it just before
sending the buffer.

Also, this is necessary for the following commit. In the commit, it needs
to release the zoned_meta_io_lock to allow IOs to come in and wait for them
to fill the currently active block group. If we advance the
meta_write_pointer before locking the extent buffer, the following extent
buffer can pass the meta_write_pointer check, resuting in an unaligned
write failure.

Advancing the pointer is still thread-safe as the extent buffer is locked.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c |  8 ++++----
 fs/btrfs/zoned.c     | 15 +--------------
 fs/btrfs/zoned.h     |  8 --------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f6c47e24956a..d1b0a0181aed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1834,15 +1834,15 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	}
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(ctx->zoned_bg, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
 	if (ctx->zoned_bg) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
+		/* Implies write in zoned mode. */
+
+		/* Mark the last eb in the block group. */
 		btrfs_schedule_zone_finish_bg(ctx->zoned_bg, eb);
+		ctx->zoned_bg->meta_write_pointer += eb->len;
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index beaf082c16c0..3f56604bdaef 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1781,11 +1781,8 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->zoned_bg = block_group;
 	}
 
-	if (block_group->meta_write_pointer == eb->start) {
-		block_group->meta_write_pointer = eb->start + eb->len;
-
+	if (block_group->meta_write_pointer == eb->start)
 		return 0;
-	}
 
 	/* If for_sync, this hole will be filled with trasnsaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)
@@ -1793,16 +1790,6 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	return -EBUSY;
 }
 
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb)
-{
-	if (!btrfs_is_zoned(eb->fs_info) || !cache)
-		return;
-
-	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
-	cache->meta_write_pointer = eb->start;
-}
-
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
 {
 	if (!btrfs_dev_is_sequential(device, physical))
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c0859d8be152..74ec37a25808 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -60,8 +60,6 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				   struct btrfs_eb_write_context *ctx);
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
@@ -194,12 +192,6 @@ static inline int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static inline void btrfs_revert_meta_write_pointer(
-						struct btrfs_block_group *cache,
-						struct extent_buffer *eb)
-{
-}
-
 static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 					    u64 physical, u64 length)
 {
-- 
2.41.0

