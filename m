Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD175EA72
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGXETG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGXETB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851E12A
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172340; x=1721708340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkbHsQPodeumTQV0ZPXUopEi0yKEpcZC1ntWalkN2oE=;
  b=QaWAwPzms5SHNs477pTcn1kgXFEauXM7C7YjG2zbUggF/qZyuv13wHLy
   KKB1HbVFMeuhHx1Ltc80lZXCNo8QtOoQLKMQAXJlNNWwK70I6/64mw74j
   caP29qi00wP4EqLtIsfYEGKr8EWl1VBRFWuG5NHceeBcXOHmzZXTnf7Zf
   aILziMjMHWiSE1gYZFOijKJWWY9o4BIbWmaAtJCrxFsuv9oJ3P8qDOTfS
   nGQA3Azoc5b7uUzqiW09F8wsphYyTy4SNfENU5kfT2VDtXrYusESoR0yH
   54ibgKWddRYXds8CJD4yLFyVeIi60Lc8HSDkBpPlWAZY8UVbujFm2JaYa
   A==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524371"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:18:58 +0800
IronPort-SDR: KWP8RZHO89IHooLuVCLo4I0Vm2KiwXv5h3pUe5iv+DZIodZsfs3H4IAqFmLxNYg1e9k/mbcOyz
 JHzaDvCyfEfbcyxRq+9v6IZq/MKw/fAjPrERj1dwc0efgQHvlfqX/hLMj7Zd89/dyMY0QkU4hR
 Ra4xaJKC81XLThlPKoYz67w2EDCPaxvNOzBy5CsAUMnXR2n9UxAYVdtKgsTpq2b7NR4dPBLfs2
 W3NFe/3vjd3vvV2K0syPbLIgBk6sjh8x9FCWrLV9MWfTBah+wvZ6DDEyp/BKI7rGzZwo3pyZ+u
 LgE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:04 -0700
IronPort-SDR: Xd7EMD95+FIfZ4Rj8xl3d47SEJ95TaGdLk6X1DZzJg6gdMyZCMiG0h4wjREuovEPOvRsq0qdui
 5KvaFvNe5xDokyZ0/psK5s5C4fiSj6Zvu2Iq6W7e1PXORIXf3E0rGnJNHFvHMvR0xbVk3rhWI3
 dO+dWkoIM1ldAMN2wM8HqfpGoRNlKEF7BXEPD0qA4SXLdoMgZ7bqrmfiKa8QPCd7binogqU++K
 MOUT7mfr2u8+XobVAaY7inMTj3NnUHKR+c3DBRpO3+ZvLPZiubPej9YYlbdiYqLP2Hdjm984t3
 +gE=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:18:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/8] btrfs: zoned: defer advancing meta_write_pointer
Date:   Mon, 24 Jul 2023 13:18:31 +0900
Message-ID: <0c1e65736a8263e514ffb6f7ce8dd1047fbb916a.1690171333.git.naohiro.aota@wdc.com>
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

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 11 ++++++-----
 fs/btrfs/zoned.c     | 14 +++-----------
 fs/btrfs/zoned.h     |  8 --------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c7a88d2b5555..46a0b5357009 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1910,15 +1910,16 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	*eb_context = eb;
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(*bg_context, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
 	if (*bg_context) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
-		btrfs_schedule_zone_finish_bg(*bg_context, eb);
+		/* Implies write in zoned mode. */
+		struct btrfs_block_group *bg = *bg_context;
+
+		/* Mark the last eb in the block group. */
+		btrfs_schedule_zone_finish_bg(bg, eb);
+		bg->meta_write_pointer += eb->len;
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 58bd2de4026d..3f8f5e8c28a9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1773,23 +1773,15 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		*cache_ret = cache;
 	}
 
+	/* Someone already start writing this eb. */
+	if (cache->meta_write_pointer > eb->start)
+		return true;
 	if (cache->meta_write_pointer != eb->start)
 		return false;
-	cache->meta_write_pointer = eb->start + eb->len;
 
 	return true;
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
index 27322b926038..42a4df94dc29 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -61,8 +61,6 @@ void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group **cache_ret);
-void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
-				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
 int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 				  u64 physical_start, u64 physical_pos);
@@ -196,12 +194,6 @@ static inline bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 	return true;
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

