Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1A42A4B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhJLMlO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 08:41:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37251 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhJLMjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 08:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634042271; x=1665578271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+Ky5Zj3mT/2LEXE3jbD6zENYWokmd8KxxUmVPcUd/A=;
  b=b7DRXT9GPnmVuxHcTa6+o1/S1ZmR/uLBWkfSVpa8mQ+D6VkvOiXEAArQ
   MgQFP3+oDCLoJFhy9J/PfEiVVPC05BiGg25jTWx3NfSorj3SDJ9FMc4Xn
   bEjaWkxOOp69KVyWfKi2xTksCHzZN1TO6Z10Z49+jscrsIz5uXb7bg007
   HKz+X4Vc256xf/Tzzef8HDAkJg4aDJ7RzJCj6Gr2U3q9QlfG3qDG4qoAM
   +c2LAcNAObRV5XxPfzNaUw23WNWEj6ebUHFDNtmkMJz08XmdtSDIXG6L/
   KUTWzWxvj5iBbSX2Qoh0k36kdA5RJT8noe/kf5UhZqUfY0quBbmn9jVA5
   g==;
X-IronPort-AV: E=Sophos;i="5.85,367,1624291200"; 
   d="scan'208";a="181624109"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 20:37:50 +0800
IronPort-SDR: ReDFShGEwZ+sE+BuYQ6lDpYZ3ZJ7uiDQMBlAc+EPFNMUOIUvKDH5q0g350PoKtDhFgQXMs51BR
 1o4P2FBrJHsA5BCVyypBd6wg+/8EGeGJFM/t0/yYVPbCDB6hCsXNvI5VYgCmQQMj0LAKUPfug8
 GXecyB9ZtmJQ1AVuEHcGORfUl9+tJawMNq3a+JrrsrHsYgti5+2KuZ99lSVvTWABxQe3tXmfUO
 iOs9xcD+QlVXmHOdJpKU6LvP5Sx+m5goE2ZdvBKj00DQDRijpkP0H1rE7GjVvDFX5CgZviRN27
 CM/28kitvrKCurS/gbnlCpyW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 05:13:38 -0700
IronPort-SDR: /3kEPxrOZhtpDXghxK32RkikHqhxS/HLAQfJPQptx58UYG2A+8fRGBJndOcksSgBH/xL7mImNO
 /4H/npyId2ACma226LBOt4VUvWXpn7dQscBXb27fghnI0oPPGh4nekbAMHUoOIcpVlG1G1OhjJ
 EZ1tUsyCyr6mYQU+TGYABF79p2e+SIZq96VoGusmvgpC8pmL8qLW4qbgeX4K5BcYVjWHMXli4X
 t19odgBA4BxOm0UiOljS9wksXywTN3cCF6WT7X1QdW3KS73y9flErkTzRDUOiSodrYS8hpXW+l
 RnI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Oct 2021 05:37:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
Date:   Tue, 12 Oct 2021 21:37:45 +0900
Message-Id: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently auto reclaim of unusable zones reclaims the block-groups in the
order they have been added to the reclaim list.

Change this to a greedy algorithm by sorting the list so we have the
block-groups with the least amount of valid bytes reclaimed first.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes since v1:
-  Changed list_sort() comparator to 'boolean' style

Changes since RFC:
- Updated the patch description
- Don't sort the list under the spin_lock (David)
---
 fs/btrfs/block-group.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46fdef7bbe20..e9092eba71fe 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/list_sort.h>
+
 #include "misc.h"
 #include "ctree.h"
 #include "block-group.h"
@@ -1486,6 +1488,21 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+/*
+ * We want block groups with a low number of used bytes to be in the beginning
+ * of the list, so they will get reclaimed first.
+ */
+static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
+			   const struct list_head *b)
+{
+	const struct btrfs_block_group *bg1, *bg2;
+
+	bg1 = list_entry(a, struct btrfs_block_group, bg_list);
+	bg2 = list_entry(b, struct btrfs_block_group, bg_list);
+
+	return bg1->used > bg2->used;
+}
+
 void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
 	struct btrfs_fs_info *fs_info =
@@ -1493,6 +1510,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(again_list);
+	LIST_HEAD(reclaim_list);
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
@@ -1510,17 +1528,20 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	}
 
 	spin_lock(&fs_info->unused_bgs_lock);
-	while (!list_empty(&fs_info->reclaim_bgs)) {
+	list_splice_init(&fs_info->reclaim_bgs, &reclaim_list);
+	spin_unlock(&fs_info->unused_bgs_lock);
+
+	list_sort(NULL, &reclaim_list, reclaim_bgs_cmp);
+	while (!list_empty(&reclaim_list)) {
 		u64 zone_unusable;
 		int ret = 0;
 
-		bg = list_first_entry(&fs_info->reclaim_bgs,
+		bg = list_first_entry(&reclaim_list,
 				      struct btrfs_block_group,
 				      bg_list);
 		list_del_init(&bg->bg_list);
 
 		space_info = bg->space_info;
-		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/* Don't race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
@@ -1568,12 +1589,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				  bg->start);
 
 next:
-		spin_lock(&fs_info->unused_bgs_lock);
 		if (ret == -EAGAIN && list_empty(&bg->bg_list))
 			list_add_tail(&bg->bg_list, &again_list);
 		else
 			btrfs_put_block_group(bg);
 	}
+	spin_lock(&fs_info->unused_bgs_lock);
 	list_splice_tail(&again_list, &fs_info->reclaim_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
-- 
2.32.0

