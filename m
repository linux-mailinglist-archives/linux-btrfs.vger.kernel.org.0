Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C273564CDD
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiGDE66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiGDE6z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98F60EA
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910734; x=1688446734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmAAo5Vyq6rDLdzjWp3X2BgjBlXR286KTzWnkPad9WE=;
  b=p2xmuqOMxI1NXwWIjUJbvs7aSPuZDbhYDzTpRUP4I8BX7Bi9zj7chRWC
   WklL4Qc9x4is4PF0QEyjQYKGarQSTsOztwgwjGS9UnnsgjKC508WRShGG
   xQ1Q7vFqqY66bE1ang/m1thWAHT32IkFWlRimtFE/IR5KEsr5TlRmT8qw
   chJBGFRsMErLFdO08HlG5n1rYaxqmZnsSu7G7bh1Hlt4JyeS8dMRCS7cQ
   poR0QpAx9/BSq6V0loapFGd8RQXm6iF1bxWJgSbAiTJvKdv41TBBsBDgk
   C1lUU/KDO21l9Gjyj78OUarWo/EIINCRXDS0+dT0GGh1N+8tZyaVjJ5LK
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732413"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:54 +0800
IronPort-SDR: i7o3NibT7HIIDF7ZSvad8BZgUt1MXm1HX7rcDc+O6XKysIdqts4ly62KCoJEFOtDcTp8KpLvke
 n+AL11DrtA4dyC4XixZJV2SNhaxMgEpr2+aV/cE15eUHjxabJWjWATl5ZLgel4KP5EZnEPUnly
 zKJwplc6MLuJwc/97OybK6w9r2ONwEhJfP0AITLMoQ+SwmEEqJbR2cwHdBUiig8SBjiVQgwFG2
 mdJdJAV+o0QfYYqwWUz+myUd2AYWf+taVjww/0C+VWtgniI40iG2uyLgxLcNqLY05+LhJWEA78
 w0CD11/sm0tuqfHRWHlixPvS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:47 -0700
IronPort-SDR: YQmn1QRq20CgdXoeuk1FW4Y1IR/cjv3+PCt9GkYUbkCia5x9JWUQywqnCKb88YLtRp1acRQuYS
 KKF141+F5PHDFzuErptl7f4MgKXN+YgVN2SeZ50m0AU6ARxGDVvsQS3hG35QHCzFV9skdCrjfR
 qRwqudQdfDMPbeW8Ca+HbjsY16f6LRANkBTaJwVogs967u91wJJZNrs8Cp7saUuL8rZOjY7UrO
 1mvMaDQSlF3bOaSt9UvUOLxTuKAAIer31RuY4xk5Muyt1TuwH+7mrq0LkAGSStBkn7ESmVeC7/
 7uM=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/13] btrfs: zoned: activate metadata BG on flush_space
Date:   Mon,  4 Jul 2022 13:58:14 +0900
Message-Id: <bedcc3526ff4acc1e83ce7fdd6aa4fd41d3d0461.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
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
 fs/btrfs/space-info.c | 20 +++++++++++++++++++
 fs/btrfs/zoned.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      | 10 ++++++++++
 3 files changed, 75 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4ce9dfbabd97..f35f36d89660 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -9,6 +9,7 @@
 #include "ordered-data.h"
 #include "transaction.h"
 #include "block-group.h"
+#include "zoned.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
@@ -724,6 +725,15 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
+		/*
+		 * For metadata space on zoned btrfs, reaching here means we
+		 * don't have enough space left in active_total_bytes. Try to
+		 * activate a block group first, because we may have inactive
+		 * block group already allocated.
+		 */
+		if (btrfs_zoned_activate_one_bg(fs_info, space_info, false))
+			break;
+
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -734,6 +744,16 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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
+		if (ret == 1)
+			btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9cabf088b800..6441a311e658 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2234,3 +2234,48 @@ bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 	return ret == 0;
 }
+
+bool btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info,
+				 bool do_finish)
+{
+	struct btrfs_block_group *bg;
+	bool need_finish;
+	int index;
+
+	if (!btrfs_is_zoned(fs_info) || (space_info->flags & BTRFS_BLOCK_GROUP_DATA))
+		return false;
+
+	/* No more block group to activate */
+	if (space_info->active_total_bytes == space_info->total_bytes)
+		return false;
+
+	for (;;) {
+		need_finish = false;
+		down_read(&space_info->groups_sem);
+		for (index = 0; index < BTRFS_NR_RAID_TYPES; index++) {
+			list_for_each_entry(bg, &space_info->block_groups[index], list) {
+				if (!spin_trylock(&bg->lock))
+					continue;
+				if (bg->zone_is_active) {
+					spin_unlock(&bg->lock);
+					continue;
+				}
+				spin_unlock(&bg->lock);
+
+				if (btrfs_zone_activate(bg)) {
+					up_read(&space_info->groups_sem);
+					return true;
+				}
+
+				need_finish = true;
+			}
+		}
+		up_read(&space_info->groups_sem);
+
+		if (!do_finish || !need_finish || !btrfs_finish_one_bg(fs_info))
+			break;
+	}
+
+	return false;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 09a19772ee68..1beca00c69fc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -81,6 +81,8 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info);
+bool btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+				 struct btrfs_space_info *space_info, bool do_finish);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -256,6 +258,14 @@ static inline bool btrfs_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return true;
 }
 
+static inline bool btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
+					       struct btrfs_space_info *space_info,
+					       bool do_finish)
+{
+	/* Consider all the BGs are active */
+	return false;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.35.1

