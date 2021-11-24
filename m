Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2E45B77F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhKXJe3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32195 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhKXJeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746274; x=1669282274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOWJ0uVY+RtYQtyf7nNZwH9SrwTp78cwLbJOhBMcLf0=;
  b=NS3t6FE5r0x6uo7RT5EP39n2b9qWgk2pMllopraY6/+P5T7qgxHikCTh
   ualQR5pacZeCSFVEVf0Q9lUPz9IkHKuL/YvbzbHtzY/JGjG1Nqeu7RhrN
   nJvkMY6JaN59OFkVkOSq/sj2f7dRoyBMnLA99nxJAUg5/an4wL7rSdAq/
   eLfBR+7cVGFEWAgIRAUcmzhon1ROBnBni71QhcfuTUBiWXYYY5aT60hEd
   mb+jZxgerfqs5YvRKorrlZNloxsgtFQu3Ox7BVIVowXGytvwa6bOsc5AD
   cQmkY3kowgeK1U8p1KySpcNPcE02UcjEzjDcU6fbnWSZE5+jleDUbwNE/
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499397"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:13 +0800
IronPort-SDR: kzP+UJWo127eLNxfFiVxCrS1+ZADx7hU97Xa0d2zVnFnf0ExWN6JkVis/k9ou+Z/Y4aYHeJBaq
 5tSiy3pKBJFvelos+6EBx5tl3HFiTRaUF5kavhTspopAkN62nN5ff+TAl0j2s+DHP8qZ1g9dEB
 9fLGlCj23UQuj5VeHNrSdZjWX5tU7XkqKtbVAzkojabkuvKghyKppR9vi4p34ro/xXVvDeJsDz
 eTU2QL+KzD3PmNiCgeRH+Ba4dHzR4KL8uMbQ0t6P1UIMr4BBhRb2maFQCYTdhaqkyVSDM68u9q
 snNSgnzZ+i7kiTRX6YoMmftN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:06 -0800
IronPort-SDR: +6Sm69ye5U7+H1jdgPTaAZ1DwExcZgYXJ224ik98GPcN32Dyb/mP9o+eoThcz2CXCDoGEoDKif
 xPnRUQeI6m0U0Tu0izoa1aI6rmT50jr+XpeofqI2v2uxbTNP5lpIlIVtP3ld0eJ8qYtRwO84DF
 rLVIIKO8ThWB9ZfU8dQeeWuxdpabL4GmBFU6zn84KksQXf0+nFFMXng98ueEJpQwbizVBYNBTz
 zX3WNFSxLGfpFhKKV4n5EjzsPt+UmSO2CDWx19vx103T29BvoJ5GCtvxWl7g99jDSFwjS3yXT8
 CJg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:13 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 15/21] btrfs: zoned: move finish_extent_writes_for_zoned to zoned code
Date:   Wed, 24 Nov 2021 01:30:41 -0800
Message-Id: <29caf2db50aa495339a2ae3d52b3248fcc19405e.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

finish_extent_writes_for_zoned() is only used on zoned filesystems so move
it to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 21 +--------------------
 fs/btrfs/zoned.c | 19 +++++++++++++++++++
 fs/btrfs/zoned.h |  8 ++++++++
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2e3ad26d30e30..97e19eca8da14 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3523,25 +3523,6 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static int finish_extent_writes_for_zoned(struct btrfs_root *root,
-					  struct btrfs_block_group *cache)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_trans_handle *trans;
-
-	if (!btrfs_is_zoned(fs_info))
-		return 0;
-
-	btrfs_wait_block_group_reservations(cache);
-	btrfs_wait_nocow_writers(cache);
-	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
-
-	trans = btrfs_join_transaction(root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-	return btrfs_commit_transaction(trans);
-}
-
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -3695,7 +3676,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 */
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
 		if (!ret && sctx->is_dev_replace) {
-			ret = finish_extent_writes_for_zoned(root, cache);
+			ret = btrfs_finish_extent_writes_for_zoned(root, cache);
 			if (ret) {
 				btrfs_dec_block_group_ro(cache);
 				scrub_pause_off(fs_info);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bf0837e46592f..df84840eac4c0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2296,3 +2296,22 @@ void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx)
 
 	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
 }
+
+int btrfs_finish_extent_writes_for_zoned(struct btrfs_root *root,
+					 struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	btrfs_wait_block_group_reservations(cache);
+	btrfs_wait_nocow_writers(cache);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 53bf05be143a4..83e11f7ec31e8 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -89,6 +89,8 @@ int btrfs_fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical);
 int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 				       u64 physical, u64 physical_end);
 void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx);
+int btrfs_finish_extent_writes_for_zoned(struct btrfs_root *root,
+					 struct btrfs_block_group *cache);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -280,6 +282,12 @@ static inline int btrfs_sync_write_pointer_for_zoned(struct scrub_ctx *sctx,
 }
 
 static inline void btrfs_sync_replace_for_zoned(struct scrub_ctx *sctx) { }
+
+static inline int btrfs_finish_extent_writes_for_zoned(struct btrfs_root *root,
+					       struct btrfs_block_group *cache)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

