Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476D69E140
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjBUNZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 08:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjBUNZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 08:25:43 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69327D7D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676985940; x=1708521940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xyhGkC7Vw7Y1A3rrvxna+IRsA2Xfq7LRCzEK7HDp2jQ=;
  b=id60LPtfKRMajbKQ/K4GriAoM1CdmJh+zMJGz2aftEUwiwJ58uegTJg6
   9OO9RcYl2xcWN8bXj3VN4N2Xdw4i4leYNHYXvNMLqGhNYDoyYLmMziL2c
   CO292i0Dnd9IA/98CNxKJEaMz9jdsNEi4HVWhnJVq/CmQdSTRvrkj37Bc
   n0XhWDJVKCmNbkozZHo/Wk0ts5+0ZgdMBK7uF8SYxLQAGUrIpJaBp2viW
   256Dcpct9WnXdTqh8hf79isUKhcAM1uoG2EpYa6bP52ZnHCjaga5w5r9O
   GPDPixwsSlGIpQxV9URJwzra/947y5WPnRyIK/iwUgTHGrEz2UhPld4Uy
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="335782965"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 21:25:40 +0800
IronPort-SDR: tE+XLQ8iIKXLqdhx4YtP+E2DvXtbE91AAxWRz36JqbRxUGKOYHJPVJgVorvJlgIJkGJ3MZ8YT5
 53KWNWhIyNvVl0vrLtVWcmydW4XdfMhL2pdsZ0FIrC0Nb9gmFvZysnawkJJMdFINOYSjWd9Z9T
 wHyJMdQgaJMk22VcFnSXdWXgzLyxqigTinbW18RTVScaKCjo5rlt10vyWzQrOtuu1BJFLZmtv+
 DI6IGgBqIsuACQGXrYgwGe17dOgzIs3dvSYQVii9dZ+4HWvmbgO/EgvYeqz3gB/lxwgXFn6eRP
 RQg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 04:36:55 -0800
IronPort-SDR: pUhxRuqFR2DEqo4s9YcwZRHbI0CbHQL6KP1MGat6Tlt9FwE0akVkITfR2/qhNxhuIIDRq2hIo9
 j38xv2/kd5+XoHHpb3jM7cjanyblmi2tTGUXJ+RovTOrhLfIaGZvZJzXNB6sWi1MUxCEeu6L1w
 PB6Q6qzVCnj8vrKog9cLww1MySeETN+zT3zuOmrbszsYQHlwDy+b5EMEWL5qLOMsWZIGUSmqmF
 hKrvaRNbapbguyYmnDFHvIvQ6u/mSw4lf0k7m2rskUaqnypwztLWgKL7+K31pyyFlT+aaU5Gy0
 mHs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Feb 2023 05:25:39 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: reflow calc_bio_boundaries
Date:   Tue, 21 Feb 2023 05:25:36 -0800
Message-Id: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

calc_bio_boundaries() is only used for guaranteeing the one bio equals to one
ordered extent rule for uncompressed Zone Append bios.

Re-flow the function to exit early in case we're not operating on an
uncompressed Zone Append and then calculate the boundary.

This imposes no functional changes but improves readability.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c25fa74d7615..c0442f2ed150 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -956,19 +956,22 @@ static void calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * Compressed bios aren't submitted directly, so it doesn't apply to
 	 * them.
 	 */
-	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio))) {
-		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
-		if (ordered) {
-			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
+	bio_ctrl->len_to_oe_boundary = U32_MAX;
+
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
+		return;
+
+	if (!btrfs_use_zone_append(btrfs_bio(bio_ctrl->bio)))
+		return;
+
+	ordered = btrfs_lookup_ordered_extent(inode, file_offset);
+	if (!ordered)
+		return;
+
+	bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
-			btrfs_put_ordered_extent(ordered);
-			return;
-		}
-	}
-
-	bio_ctrl->len_to_oe_boundary = U32_MAX;
+	btrfs_put_ordered_extent(ordered);
 }
 
 static void alloc_new_bio(struct btrfs_inode *inode,
-- 
2.39.1

