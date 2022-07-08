Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1256C513
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 02:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbiGHXTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 19:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239103AbiGHXTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 19:19:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888841990;
        Fri,  8 Jul 2022 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657322355; x=1688858355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWsC8S1XVZEWAEOxATs4DJI0HoCKwzC9L3mVldmQCbE=;
  b=dgA2TjCgIfd5gP4iO7QdGfDzXqXzuC3LGm4m0p7q0Z22EHydwMgcRWdW
   xNo6ljj04qXzEBM0M20Mgj4fjlrSZzg3JAR65za+lfVbcVmD2OggSum2E
   XbstU7WyA95BL2Q0FsQi5bNJMgbs2iDL+JFLtbjRbte/TYpWojUpVzNzc
   kiinWFHoipZ3XGXz0qHN0crRnliYgEV6BqWHX2OzxV0DpKllwLKfpWYsw
   ijlIt0rTkXeN9kLPVNED8mJZC3xh3mCN4AJxV5KItyw7dFifESBzQudEe
   fRsCxXcdLl5bSbOaZHfo0wc5QQ4Y2JKiFwP5sKCkeB8rHdLA1vgdUT/Hr
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,256,1650902400"; 
   d="scan'208";a="203871833"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 07:19:14 +0800
IronPort-SDR: xusOVtWDzUbiP2AMp4fpe2ZmLKps5zvhd6glGK1Dv6+yLW8+XWTmqusPPmYqIvD+nO4HMof1yn
 6CILPOn7n0p8Tf0hEjyKQk1CsMXFOkGbmBukOHd5vHV7eMtYADpDAv2TWSIVLTIXBFfkcQMybN
 sfM+Bm0KsAHTbOccmM4dIXnctv2tUJdyYegjHaqln+4zbmYC3bnah0EK4UJZX6ra+qbtBUTDRd
 f1NKopB4GaKc5y25B2Cb1d14w0mrhJKZyOlFajQtMMn0qno36zye6GFUS+EfGE2Rth4Kdd29Wt
 o1UnfCQ56u5qLwojRUrP3QHq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2022 15:36:20 -0700
IronPort-SDR: Reyb4YtgL1zgwxjjMn0rPIdrWEuLhb4OTpsEDAFALPZMckVorPLdfGLIa/OYF1JQD8iBzkTGxy
 /+3wIOFX6nlomAD5lISaP0vu1aKmoPg14TcNZ7+FC9RrVUlINRJIovQC/MhuQk6sbdlPyjibgE
 RLr/j7PfRYs7HV4UzUbhfA+14BSSWyQXMeueVfgP4x+l2lUGvuw323UfJ36oTyyxs3dTLiwXGc
 XZZaCTOvRT++ol/mJ9gkjU/i340U4Zouqml72j+t2crxV4Jnl9rfmNXdAYz9TtcwlA+UBbwg8C
 ufw=
WDCIronportException: Internal
Received: from phd010370.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.250])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2022 16:19:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/13] btrfs: zoned: activate metadata BG on flush_space
Date:   Sat,  9 Jul 2022 08:18:47 +0900
Message-Id: <9356a688352bf220fba3dda1deff0486055d42ee.1657321126.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657321126.git.naohiro.aota@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
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

For metadata space on zoned btrfs, reaching ALLOC_CHUNK{,_FORCE} means we
don't have enough space left in the active_total_bytes. Before allocating a
new chunk, we can try to activate an existing block group in this case.

Also, allocating a chunk is not enough to grant a ticket for metadata space
on zoned btrfs. We need to activate the block group to increase the
active_total_bytes.

btrfs_zoned_activate_one_bg() implements the activation feature. It will
activate a block group by (maybe) finishing a block group. It will give up
activating a block group if it cannot finish any block group.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 30 ++++++++++++++++++++++++
 fs/btrfs/zoned.c      | 53 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      | 10 ++++++++
 3 files changed, 93 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7183a8dc9b34..b99e3c32c07d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -9,6 +9,7 @@
 #include "ordered-data.h"
 #include "transaction.h"
 #include "block-group.h"
+#include "zoned.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
@@ -724,6 +725,18 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
+		/*
+		 * For metadata space on zoned btrfs, reaching here means we
+		 * don't have enough space left in active_total_bytes. Try to
+		 * activate a block group first, because we may have inactive
+		 * block group already allocated.
+		 */
+		ret = btrfs_zoned_activate_one_bg(fs_info, space_info, false);
+		if (ret < 0)
+			break;
+		else if (ret == 1)
+			break;
+
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -734,6 +747,23 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
+
+		/*
+		 * For metadata space on zoned btrfs, allocating a new chunk is
+		 * not enough. We still need to activate the block group. Active
+		 * the newly allocated block group by (maybe) finishing a block
+		 * group.
+		 */
+		if (ret == 1) {
+			ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+			/*
+			 * Revert to the original ret regardless we could finish
+			 * one block group or not.
+			 */
+			if (ret >= 0)
+				ret = 1;
+		}
+
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 44a4b9e7dae9..67098f3fcd14 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2225,3 +2225,56 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 	return ret < 0 ? ret : 1;
 }
+
+int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info,
+				bool do_finish)
+{
+	struct btrfs_block_group *bg;
+	bool need_finish;
+	int index;
+
+	if (!btrfs_is_zoned(fs_info) || (space_info->flags & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
+
+	/* No more block group to activate */
+	if (space_info->active_total_bytes == space_info->total_bytes)
+		return 0;
+
+	for (;;) {
+		int ret;
+
+		need_finish = false;
+		down_read(&space_info->groups_sem);
+		for (index = 0; index < BTRFS_NR_RAID_TYPES; index++) {
+			list_for_each_entry(bg, &space_info->block_groups[index], list) {
+				if (!spin_trylock(&bg->lock))
+					continue;
+				if (btrfs_zoned_bg_is_full(bg) || bg->zone_is_active) {
+					spin_unlock(&bg->lock);
+					continue;
+				}
+				spin_unlock(&bg->lock);
+
+				if (btrfs_zone_activate(bg)) {
+					up_read(&space_info->groups_sem);
+					return 1;
+				}
+
+				need_finish = true;
+			}
+		}
+		up_read(&space_info->groups_sem);
+
+		if (!do_finish || !need_finish)
+			break;
+
+		ret = btrfs_zone_finish_one_bg(fs_info);
+		if (ret == 0)
+			break;
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 329d28e2fd8d..f7b0b9035fd6 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -81,6 +81,8 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
+int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+				struct btrfs_space_info *space_info, bool do_finish);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -256,6 +258,14 @@ static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return 1;
 }
 
+static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+					      struct btrfs_space_info *space_info,
+					      bool do_finish)
+{
+	/* Consider all the BGs are active */
+	return 0;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

