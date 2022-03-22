Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC84E3B7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiCVJNK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiCVJNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 05:13:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57317E58F
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647940302; x=1679476302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8PRPkdeztiEzhYUyRDFN7bKsqOuhb8wCas+JJvunWE=;
  b=PjsGnt5cQrV8zBxOZ19Y8+TfLd9oCNL3VivtxQoo5qKg+OpQTcwsOTr+
   rcbcsqlTTD8G4DNIxbLRNo/FInRI6HI4ACCE+YXQe4uSBP8kx0BhDw7cQ
   KTrbjCJdTX4Z+xV8cEoBE75/fSagwpZ0Yr/LbhvALY3TTc50X3nwa/px3
   Gb9Kg2kvCEFCYfWa5zROiAzW+qXIvRaaweZVD43AcdgNAxoZuzQYel+Xd
   AiOkMIcn1Ye/fS7ygGX36HhhkpYpAzjFiv65GT5gqj5Jm8Y5nJI8TJBX2
   q/kj0dw6rEDdHd5KIf5Zbx6avFmiFxD3oSFN/5pawlPm7Xazy+jwHKUBr
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="300094317"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 17:11:41 +0800
IronPort-SDR: M/V3tYM4YCPzJ+W6Loj4XTQQGUSFVFKUHx5LY/Okf3WzZGaKynanOBWT+cKfadCguO4+Y7zVDJ
 F8br4hu4RQ4Y+dyq70gjlRPne188DfxdkR7WIF9Z2sEMOR1oS+E4HPNBIM7rDYyccvAltthku7
 zIV0hkHaOLSt3OMHoCvvTUjstcfzvudppoJy1f2DhzVrkPFUVSP8m4OCKsBBY8UtHCE4V+NVD8
 lr518p3ql2cUV3lNr3ef2N3UeBMBRSFuTyjCs76zZkwd+6Q5dhH8WpOruW4Kk2uNdeNn/e59th
 5moqltz08oLdBL7PotINEWC8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:43:37 -0700
IronPort-SDR: S+GG/DLMI0BarKSz4a0y6fBjNDrrKr1T3tPsp6LaWQMBdYQBW2a9CXHG0eAjLMJYiUnjrTBtpY
 l5XJv6r6GrYc/T9FK8qrKeM5A9avS5ObdrsbwfCr1ay333f6GzefrJ7ZoHgM5AJFlppcJlU9xO
 3vxT6VGPKgOObQm81y7aDk8LOeMkFNw1wbuyLxQ04hdFnlo4LJnLbgcjvpDReILKGkEA7BfS8X
 5Stbg9NsVbO81RyYCDV51IRGuoYWEm03hYVysV1ikO/hUDjw+rJ2xP25CVcDrwpuwIYbGTuqve
 NW8=
WDCIronportException: Internal
Received: from cqpt8y2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.186])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Mar 2022 02:11:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: activate block group only for extent allocation
Date:   Tue, 22 Mar 2022 18:11:34 +0900
Message-Id: <9d491b6ea2d2628eb9632f4dfc43e52b8bfb7057.1647936783.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647936783.git.naohiro.aota@wdc.com>
References: <cover.1647936783.git.naohiro.aota@wdc.com>
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

In btrfs_make_block_group(), we activate the allocated block group,
expecting that the block group is soon used for allocation. However, the
chunk allocation from flush_space() context broke the assumption. There can
be a large time gap between the chunk allocation time and the extent
allocation time from the chunk.

Activating the empty block groups pre-allocated from flush_space() context
can exhaust the active zone counter of a device. Once we use all the active
zone counts for empty pre-allocated BGs, we cannot activate new BG for the
other things: metadata, tree-log, or data relocation BG. That failure
results in a fake -ENOSPC.

This patch introduces CHUNK_ALLOC_FORCE_FOR_EXTENT to distinguish the chunk
allocation from find_free_extent(). Now, the new block group is activated
only in that context.

Fixes: eb66a010d518 ("btrfs: zoned: activate new block group")
Cc: stable@vger.kernel.org # 5.16+: c7d1b9109dd0: btrfs: return allocated block group from do_chunk_alloc()
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 24 ++++++++++++++++--------
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent-tree.c |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d4ac1c76f539..84c97d76de92 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2481,12 +2481,6 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 		return ERR_PTR(ret);
 	}
 
-	/*
-	 * New block group is likely to be used soon. Try to activate it now.
-	 * Failure is OK for now.
-	 */
-	btrfs_zone_activate(cache);
-
 	ret = exclude_super_stripes(cache);
 	if (ret) {
 		/* We may have excluded something, so call this just in case */
@@ -3642,8 +3636,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
+	bool from_extent_allocation = false;
 	int ret = 0;
 
+	if (force == CHUNK_ALLOC_FORCE_FOR_EXTENT) {
+		from_extent_allocation = true;
+		force = CHUNK_ALLOC_FORCE;
+	}
+
 	/* Don't re-enter if we're already allocating a chunk */
 	if (trans->allocating_chunk)
 		return -ENOSPC;
@@ -3736,9 +3736,17 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	ret_bg = do_chunk_alloc(trans, flags);
 	trans->allocating_chunk = false;
 
-	if (IS_ERR(ret_bg))
+	if (IS_ERR(ret_bg)) {
 		ret = PTR_ERR(ret_bg);
-	else
+	} else if (from_extent_allocation) {
+		/*
+		 * New block group is likely to be used soon. Try to activate
+		 * it now. Failure is OK for now.
+		 */
+		btrfs_zone_activate(ret_bg);
+	}
+
+	if (!ret)
 		btrfs_put_block_group(ret_bg);
 
 	spin_lock(&space_info->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 93aabc68bb6a..9c822367c432 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -40,6 +40,7 @@ enum btrfs_chunk_alloc_enum {
 	CHUNK_ALLOC_NO_FORCE,
 	CHUNK_ALLOC_LIMITED,
 	CHUNK_ALLOC_FORCE,
+	CHUNK_ALLOC_FORCE_FOR_EXTENT,
 };
 
 struct btrfs_caching_control {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac2..6aa92f84f465 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4082,7 +4082,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			}
 
 			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
-						CHUNK_ALLOC_FORCE);
+						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
 			if (ret == -ENOSPC)
-- 
2.35.1

