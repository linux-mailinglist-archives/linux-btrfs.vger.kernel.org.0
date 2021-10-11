Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAA428BCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhJKLNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 07:13:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22214 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhJKLNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 07:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633950708; x=1665486708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WCnPgiVOxTh+lEAJksccg/9MiOsUPs5pa4vQkV0YOHE=;
  b=mX8m4Vt90jCmMZ8RRLLsb7ADg+Lx2Z4WN6t3opP7SJFIsjpr69+uf6Rz
   7DG5vxxYWLBCt0Gck9zSNcFAGH0ZkZRu8fz7kBT+mWZoQGZ6yyxwxyxW0
   9KYQc0s0cu8aR17H0E+gV7h13KW1iG0bfv6xwmpCafFnhcTs1EbySxIsj
   zHOzAlv09ED8VA26QsWfn78Sw3iNRZ/EFftMxGOK1o1qjgVrPdMPmSc7K
   AkjO9aZa5HmVN2C85TIq0PILBrsHC5A1fGv0d89nSUh020RPSZOuIReIG
   AUbc4oSSSxRr7e7Zd9qmhlhY9DKmZ9SUC5hNSwcNSlUcVOodNSD1WdWZh
   A==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="294205260"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 19:11:48 +0800
IronPort-SDR: +4BpNDhDFho0C2eiOsavGyql3O45nqyLc/H3ZlNywacXcGCvQK9NbiUKz8pljAcTWD45lpCryR
 g92ZgCuLtk1wOGBzWHiAWZ/EEdZI2mj5D8gE2OoxzUuzcKZtLDEdsBdMnA51JNKzkcsMSrVEK8
 wJYlxXSq9GVK4E7j0WWdRRjVAzxGZVtf9kyw/JQjFt2hge2Bp2rY1W2s5p4iEJynCmr8IdnIUO
 Akx61BVxtg18f2xEFxLsmVeTS5mJlWK+FjSVUeCxWaDxQqxm7xoIAyD03G4HozMPXKKk6nmLwY
 8tKMn/8r364LSIxJhc56VMe6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 03:47:37 -0700
IronPort-SDR: riF2uDVJud8gC6lYsyaZtSzcr4YEsFfR/h9K2FBnVZHAeJKo6jZfCpwwz5H2/fes30gLRGY555
 SidylgHSSSOzqyMudxrYnbdhPijqiHflNVzTIOkmFKWPNhVNNx9B5CtN5bGuCxZWIh0yVMPmoZ
 nIJudlNvdiVfQqReEjYOslj+WBbuMbHU/te+J323jNZxfEsL4l5Y2KtEO7x3/d8ESv7kxt+qVC
 5zi/0sRl9Tqy1BwFzZPPiRtaRXze5xmJpah8FEyTtGALGCADr4dCe01dEv2oZ6VWB/hHPpakdH
 19g=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Oct 2021 04:11:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: use greedy gc for auto reclaim
Date:   Mon, 11 Oct 2021 20:11:32 +0900
Message-Id: <d09710513b6f8ad50973d894129b1dd441f2ab83.1633950641.git.johannes.thumshirn@wdc.com>
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
Changes since RFC:
- Updated the patch description
- Don't sort the list under the spin_lock (David)
---
 fs/btrfs/block-group.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46fdef7bbe20..930c07cdad81 100644
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
+	return bg1->used - bg2->used;
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

