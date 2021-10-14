Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41342D63F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNJlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 05:41:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26573 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJlM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 05:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634204346; x=1665740346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AUoVQVV8Z5qlRVvylGh1Inkrd6TQEoOnJxLtEr8sHoE=;
  b=QNteZGYp1EQLUXP9gt6cifWa+R3vpI5u0gzjCPvGWf3ngoqGV8epnBmb
   G8AmroYY+0Xy8+/OWTpTGNvSGSX3e40rGiq/kSvYZtgFz8zuD3y5FQL00
   YIs2yHyNuwZ7G9+//GMowjMSy5aZReOx8L6dVD6DZ2+p5+xSNrxYxg8bc
   kzbyeM6HiNP/stlOS/XUUrRRHzdcIte9IOF6zucNrgeSm5FXCrkMOirMM
   uuDWPv0B2LnLRjzlA7QqaoFDRJEHJyvZnQtPmN9K4MJRMCbo5cdA9n9QS
   UUavO8J9L+VcZdm60eQJwoxD+s2LZBq98RI1zeULZqMX1zVvvHfLDmCej
   A==;
X-IronPort-AV: E=Sophos;i="5.85,372,1624291200"; 
   d="scan'208";a="187601076"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 17:39:06 +0800
IronPort-SDR: MHqyI12pqYNmHDdbWKf92FcKkuhGlnetDEIv/tijrjuHoa8uzTfRhQLkAA5fzKRxlkmOLgEwas
 bEB6oQjYorA6DXZhbF/GfQIHnKAp+AstVoAwCUiOLSVLgsTDJnzWrgPoRo8NfcPkvOtSm4LQil
 Pu5wdPgGlK13H1PZGmf433k9rRMDv5mal7c8j2Dua5h/anKZnktyAhbII3IRl9hwgzYCOtkqvP
 XYnxtUiEXmVNGny5g2R9d62QDgDTxwvf3SLshFxmPA1qbFxZ2XHDz8Tg4rLoa3Er4l9oFMk2Xn
 cnYAqnviHv4mNe4eNBn1WlW7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 02:13:19 -0700
IronPort-SDR: 0TwPFP2KplIFgVccF6hbCyPPfMZdwRQ0yArR5wJLkG9RgQKdTB0RBOcHn9LqjU4AYzwnZi0vOV
 52yG3VRhfcjWcoJbOJD3uVYHa6UizNlhcj3+THh2krMogtZkMU5/da3/dq6Sl3PI0dWzRf0uYd
 l2ciZ8gmjbBwACLwX8uEJ/mnsrafmPA9TyKF5q1F/vKPf7GhSehYiHBTuFGZKO0L0RAcDtc0kG
 VainogDqp5BnSB9enU7psrCCLEhhOOUFjQcpY0LZBJOXo6cTsJVZ4zNX4Y7LRrEAngBCP63rdb
 PiA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Oct 2021 02:39:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto reclaim
Date:   Thu, 14 Oct 2021 18:39:02 +0900
Message-Id: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
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
Changes since v2:
- Go back to the RFC state, as we must not access ->bg_list
  without taking the lock. (Nikolay)

Changes since v1:
-  Changed list_sort() comparator to 'boolean' style

Changes since RFC:
- Updated the patch description
- Don't sort the list under the spin_lock (David)
---
 fs/btrfs/block-group.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7dba9028c80c..77e6224866c1 100644
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

