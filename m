Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120174117EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 17:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhITPMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 11:12:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6297 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhITPMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 11:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632150672; x=1663686672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rgp4DgRotkTKGPuMcQf4kMIpOqblMyheE1wm6oc5n44=;
  b=PkEgk01yxgYHD6cq97u3q1o6TtaDN89B/UymEL9HhmShOzVB87lydLuJ
   lsJ7m0fku71/TtaUCZ9o7zcvwC1y2tOZ8lcTpphPL1wd6Ro0XG1jy73QY
   6aOMSx5NfFqWYIHLr0WiTe/aZXyKdQpxbPiJmFlYxPKPyXpRmGAH0PX7F
   gTyfHMHdjhIKq/olfkgx0k+QN/VOcmgpsUCs6CEfidu0ggo+SYgloBWVe
   EnZwYW61XxlgkSBzRxwZIgmcph6u9ENJD2CdnUmHEVJhh2EP1RDuIFUhT
   XbQ6SBCJarVb3VMd5ZZCaUWaJyT7Fi7/9aKikA3+JjzqCWzk3BfZWMkzX
   A==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180970517"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 23:11:12 +0800
IronPort-SDR: WuW0/6s3S8lWEDxulr7HQzhVXTIwkuJ5TLp6uGVrtkQuSSyUmQnQqxx0h96vvmyW+vP8AhTiVc
 JungYhHhaVR7BFpbjuWy35rWahJiDZHsreZuX5CZF2kU766uGpxE5MP7n3AHpt+3vrLmkI7Z5k
 enUL39SB1W6JuxFNzn3uuAsl7h6S0ZeRx60XPTGZYgye31CKThfT25/ZsN3OvoTaSWtjWNrV58
 FF5xrs74qfnBeqknO3q+1gQ81nq7U87CIQCguuiTQgfYs/Fb7/tbY1ckhqD+CGjqv6aea3ZfJR
 omWUMMuZbHbK+XzoolTjAnzD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 07:45:53 -0700
IronPort-SDR: Q/FX5JthfWt4yVxBKSeeXlAbsEnO6EzS80t+uOw7DPtXplSiCpfoL/UWS8goqvxOiR3agA7EZP
 HHCNc+T5RDJm0LHhd1dW3GOFOO4Qa5oiaNH+7sv19peQEWChGwrruO4g9JfMlXYUM+7/gAH/QU
 5HqinFFpGZVp4n6ETUxqBzeped89NdtKFEjxNiPaDqF2exgs3b1qErqbFFgAcmmGA5F/BwoveT
 R0uNm1ic42zvuQfAu/wXMJBr2vshAt3VF6YCBtp2ZlvZW2RAJGsdCpWHwsxnYh6H6w1ZNe6MDm
 P04=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Sep 2021 08:11:10 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [RFC PATCH] btrfs: zoned: auto reclaim low mostly full block-groups first
Date:   Tue, 21 Sep 2021 00:11:01 +0900
Message-Id: <a5b7e730eeeeebd701d807f7aa950dc1f52caade.1632150570.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently auto reclaim of unusable zones reclaims the block-groups in the
order they have been added to the reclaim list.

Sort the list so  we have the block-groups with the least amount of bytes
to preserve at the beginning before starting the garbage collection loop.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46fdef7bbe20..d90297fb99e1 100644
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
@@ -1510,6 +1527,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	}
 
 	spin_lock(&fs_info->unused_bgs_lock);
+	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
 		int ret = 0;
-- 
2.32.0

