Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BB769F45
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGaRUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjGaRUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00E1BF2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823940; x=1722359940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyqrTeHzvvtU36YSw3C99zKH2XHPaRtcO8cHr1T7Kk8=;
  b=d3RlOYnLHvnYgU/DuCko6oof1GW8RDlnLqswlS2BxHM9Ib7QNY27HPcH
   EJpf519E0nMFf7bTxC5zd1XzIV98Sg19lfYFQcn3WkUyJ7ZZwxeI8tMp2
   8/bEyRFFwS8EU3BwCKVTWNoGlRZnjoKC2Mx/Bv8MqpMdyjfhfQSDX29o2
   gQv8tQWqEMZlJezvQUAPV69GFy2ggMJ9N6ViuMg/S1Apm3gNgrG4jcMEP
   RwCrH7UB2Wt7HJBEQXOHSlzE7p/FG0WO3CvIh8mhpGYX4f8XDaXOzAISP
   6YZF43KWYubkvrEU8hltwg5+oVv36rBWsFUeP6iqQp25FNq4fdHNLRKDj
   w==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269560"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:36 +0800
IronPort-SDR: 9RhgvoJhCcN+NS1CE1hZI/pbaYR4hNzX5qasFDZ6gIBoKVoZMM8l6MsvmTTMDN4XbUcDkR4nxR
 vTly25KcAX69Fx5EIGAIzUTwNb46ctqjf4ra1Mu0lQRyzIrmp/rvdO8Fb80+IT/HgNiFLHoCn2
 3/Yi1dq5Xp/+LPuXPCXNMPmJ3kbFF4GcP+PyzuWTh6RoFqkmc/TkM29B4+w12wXhJC2Ou5hXHA
 4OfKLrPlc0q84XH42GrWbmYAcDU86XBJH0VG6ZjG1TsJAoXXM93UZD3DScOglV3Q78hIe/TuwY
 6fI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:13 -0700
IronPort-SDR: JzEbITZ011VqK7Rk/q88OlnuWmyPR2g8D0wH+qe96hOxcrET1bu0B/Ue/0BSj2inJpMIfQiwdB
 ROFFBxpEzZYaHaCZZWYBW3/NU79AAVJXt/bbHo4IY3yWiRMk/IWiDrVR0wXMqZ8CMJDxLMAuUV
 aZoyOc5laAC2j6GuKtoAejwDsPfOP1OSycRjCslhcm2qWbRndKdzxY3Djt0W33y8a6KgcegvQW
 y2kzzySWGQuubHtffM1tfnACifFOvZnmcGaPXadfQDVP78aBQa+y9911adlkR9FSDSuoHqR4d4
 P1M=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 04/10] btrfs: zoned: defer advancing meta_write_pointer
Date:   Tue,  1 Aug 2023 02:17:13 +0900
Message-ID: <b33f5b9b41cf80665f8df12c7094e260a38938bb.1690823282.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c |  8 ++++----
 fs/btrfs/zoned.c     | 15 +--------------
 fs/btrfs/zoned.h     |  8 --------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 012f2853b835..5388c2c3c6f4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1834,15 +1834,15 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	}
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
-		btrfs_revert_meta_write_pointer(ctx->block_group, eb);
 		free_extent_buffer(eb);
 		return 0;
 	}
 	if (ctx->block_group) {
-		/*
-		 * Implies write in zoned mode. Mark the last eb in a block group.
-		 */
+		/* Implies write in zoned mode. */
+
+		/* Mark the last eb in the block group. */
 		btrfs_schedule_zone_finish_bg(ctx->block_group, eb);
+		ctx->block_group->meta_write_pointer += eb->len;
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0aa32b19adb5..fa595eca39ca 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1781,11 +1781,8 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->block_group = block_group;
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

