Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308F3772A40
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHGQNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHGQM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBF9F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424776; x=1722960776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vS6UpWDau4rkkIX3UvgCeTQWa6nwnKETvvTacCIdFvI=;
  b=glwqf9aDist8HWsqJ3EHylKTJsj9IVwMSTDhnEpUUEA0DhmozTQlFbgr
   vXIZ1n690pQRPuHeIXOpQuV6Qocu7cjqxk5OPIRcKJqWXt1gFItpVVZ7C
   PXZUGA775OtNK+fxRP3HCjZ++pg7BS2i2o+cCvcbBYZi0nVZqrMufoXK2
   tx0JR1Tsfp67+5xSTlV90D+ehLv9W+VqUfLAf2WvgxDxlzzCZcCkKRnWl
   ZhdqEVKuPKNcsvea9nLS2kHnOZN0rbQXBKrwkn6mLVcBdW1HNB1hmme/f
   yY06lyxuNFVMDZ6cMOWpPsY5Unju3DEo2TmcoIjE1Xx0evrAd67avzxPL
   g==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240711007"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:55 +0800
IronPort-SDR: M9s1t6FZ9Nzm/3gmDs2Xc4bLQ3RI6nihsYuC52kPmeAD7JZMQshb4EXNHVHFQnHM2bEP95plTB
 QrtLSl6wHNJSe8eo1KOxf0O8ZI3UQn51biySM4kIG4OSFuUKwowqfVZNZYrueCrg22Oq8Sh9tV
 H+dN5+XQPbrcvdNUyn6h7tkb4nbVzcY/di9h4IzyzK4DLPMcg4HPPz87qHYCioPgJd+RLW7dL8
 OdGd9Fk+EOWPYqFZOitOnddrNpuDt1VrrgemCRlpAGJ6dbJECsYOE70DO4ekuWau8TXAAD1LEo
 Aq0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:24 -0700
IronPort-SDR: WSPL5gH14JRSR0y6WHD2nkK46sgpHC9wTRj/2XOf33ljZSVedcitaibcdBubwI3X0bCteYvReQ
 qtXeyFaabLxWfCDZIRiV0i6NpSp6x1UkGCniRTI2givhv2a61C7Ea8jhjv7vXTW4Rn/sHlQjML
 XYXfRN1xodSUJ1viBUmdsx79uaeLnCv/fDeFCRYyL3J+dzUt79kpMFKEaTIXrtpd5nBM9CvpcA
 lGtVSYVefu/DtGnyMFTt0N69rqXFnUg6yHp3AQ2Y/5Ge36g6kBmIzAlC1ptZOXXKwQXMn6ydSg
 Upg=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 09/10] btrfs: zoned: don't activate non-DATA BG on allocation
Date:   Tue,  8 Aug 2023 01:12:39 +0900
Message-ID: <96804a0b3e944ce19a5eb786017db0e49defdbd6.1691424260.git.naohiro.aota@wdc.com>
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

Now that, a non-DATA block group is activated at write time. Don't activate
it on allocation time.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/extent-tree.c |  8 +++++++-
 fs/btrfs/space-info.c  | 28 ----------------------------
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b0e432c30e1d..0cb1dee965a0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4089,7 +4089,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	if (IS_ERR(ret_bg)) {
 		ret = PTR_ERR(ret_bg);
-	} else if (from_extent_allocation) {
+	} else if (from_extent_allocation && (flags & BTRFS_BLOCK_GROUP_DATA)) {
 		/*
 		 * New block group is likely to be used soon. Try to activate
 		 * it now. Failure is OK for now.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 12bd8dc37385..92eccb0cd487 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3690,7 +3690,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	}
 	spin_unlock(&block_group->lock);
 
-	if (!ret && !btrfs_zone_activate(block_group)) {
+	/* Metadata block group is activated on write time. */
+	if (!ret && (block_group->flags & BTRFS_BLOCK_GROUP_DATA) &&
+	    !btrfs_zone_activate(block_group)) {
 		ret = 1;
 		/*
 		 * May need to clear fs_info->{treelog,data_reloc}_bg.
@@ -3870,6 +3872,10 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl)
 {
+	/* Block group's activeness is not a requirement for METADATA block groups. */
+	if (!(ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
+
 	/* If we can activate new zone, just allocate a chunk and use it */
 	if (btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
 		return 0;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17c86db7b1b1..356638f54fef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -761,18 +761,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
-		/*
-		 * For metadata space on zoned filesystem, reaching here means we
-		 * don't have enough space left in active_total_bytes. Try to
-		 * activate a block group first, because we may have inactive
-		 * block group already allocated.
-		 */
-		ret = btrfs_zoned_activate_one_bg(fs_info, space_info, false);
-		if (ret < 0)
-			break;
-		else if (ret == 1)
-			break;
-
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -784,22 +772,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
 
-		/*
-		 * For metadata space on zoned filesystem, allocating a new chunk
-		 * is not enough. We still need to activate the block * group.
-		 * Active the newly allocated block group by (maybe) finishing
-		 * a block group.
-		 */
-		if (ret == 1) {
-			ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
-			/*
-			 * Revert to the original ret regardless we could finish
-			 * one block group or not.
-			 */
-			if (ret >= 0)
-				ret = 1;
-		}
-
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
-- 
2.41.0

