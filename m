Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45585697E6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBOOeG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBOOeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:03 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFBA27481
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471637; x=1708007637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPLwugiUN11C/hYVLmrycfTWQUaMYko3yQ9Silebc68=;
  b=ppJSuIdeLL4iD6NGy0BvNd/2Y6o+6DbQIEzmDKdHiDWrM/XKfh3boIdQ
   10Be7pMyxRq/dwbwnyaZsW8zl6ddLhoZ2+eclBglLuc3psSp0plAxEq4F
   MU71NfXtE+k/vYGzvPNhDOE1dAddhL3hsNA2qleeOOnn7TeB6kxBMG9e9
   rwhMpzXn3D2delLdwM+0yKOkUm3ZbH209SqzqAVxw/WzDdzlC6xkCqqn8
   vA6tFWeD9rfiaO36fE1Qnb4jCvkbnybxbaEHToMnq645/KIFpxExdM5Vu
   5a4b2Gkxd4kqAdHbApPrwzbtkD+cg3IUAl7bX2TPxry1D6LJUY77ck7Cn
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394067"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:43 +0800
IronPort-SDR: qDTgJHuT6guBClUQARt7muABuRYpkG8ZdsUhzvcP7AtxJGJSjqShonNosLAK2ZJRsNDOZmLca+
 OQyTrWaGErRmhMP+dbcVvHDw1XyH3ZlH+9C79mw1ckPEefE2Z6QA7WtLMETrfDk4ur/OAehP3n
 vW3NBkQU2u4NlZtmsUMGIGC50JlL8mArNh8Cb2nimX9mCe8VZfJA+JDTvBhXA55ITXQtQX5Jrw
 UKxPpBJvEA3jpVDo93qL/s6Ak+weUJ5Rh/roGrA7flYKYaHA/slhhygDCKY9owK8+PHsyl8VHz
 Xts=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:05 -0800
IronPort-SDR: mWPHSLHwnbQKJZcp5jsuNAvPAjnhRRMaZqv4QdbXSuURumdIdR4cvsrWeWmDRPhLVDcXR/CLF+
 rfUm/lYi39mXDrD/XvmATdwoiU/v83tfeCTe4jW4qnxVJLlb0dBgADUTcJ58XjhbZChglRGdVy
 BJUMzQ0xcc81GCvhPG+bN4BIz360lma0m/qV0WfjTwPPLWtsPfBrRECNmzIIW3D2y7kf1IfQlc
 o6fI6yiGIl2DOdve2SWomt4efBqEihDf4yU5wFRC09J/ISr/WRzebPX6u68dA4Z62nL14ge7jm
 CJo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:44 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 05/13] btrfs: delete stripe extent on extent deletion
Date:   Wed, 15 Feb 2023 06:33:26 -0800
Message-Id: <0f6a7e34d297565230d92c253418f2addc4849ad.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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

As each stripe extent is tied to an extent item, delete the stripe extent
once the corresponding extent item is deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c      |  8 ++++++++
 fs/btrfs/raid-stripe-tree.c | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36a1476cc901..10827b7db13c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3238,6 +3238,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		}
 
+		if (is_data) {
+			ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+		}
+
 		ret = btrfs_del_items(trans, extent_root, path, path->slots[0],
 				      num_to_del);
 		if (ret) {
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9d3e7bffe6f8..8912389d7c2f 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -124,6 +124,37 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 	}
 }
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	struct btrfs_path *path;
+	struct btrfs_key stripe_key;
+	int ret;
+
+	if (!stripe_root)
+		return 0;
+
+	stripe_key.objectid = start;
+	stripe_key.type = BTRFS_RAID_STRIPE_KEY;
+	stripe_key.offset = length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_del_item(trans, stripe_root, path);
+out:
+	btrfs_free_path(path);
+	return ret;
+
+}
+
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 len)
 {
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 60d3f8489cc9..12d2f588b22d 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -22,6 +22,8 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe);
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
-- 
2.39.0

