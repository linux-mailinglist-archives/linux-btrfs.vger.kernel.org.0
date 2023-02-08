Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D468ED63
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBHK6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHK6A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:00 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2D12F22
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853879; x=1707389879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGz2sP9tKx3GxmURnJl4X80fN6nsh25j5xnfqy2FgM8=;
  b=H/4fRyHv6whEKjeUS39CMz5tchSzaH6+VqxnrKLJhrAVF2XMdNXFhfyV
   xVnuRGQbbVLnW21UvdImuFMCPF6ihFLhxQxvI909SGIT1AsWAufYsMBD2
   Hlxs6wjiwJ7cFYmlKOE3igkl6eRuZyodiNh6m/yqtCiqxBO/FBKWKIiSD
   faucoQnuACtzWKDuyyA7WiY/VieBNOLWNSG6ilgLDdjMrg4cO0mjoGzO3
   IhB/fXA80kq2Gy5jMnNyHwj6WTzBhMBvPQOkVayFzi2SZC6t/pT9qDi72
   0A+7cUWCuHCVeieqK5gfyFLfIVdNnEq5EYn4+qy2tmTCvs9/E02ym7K0S
   g==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115633"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:57:59 +0800
IronPort-SDR: dUPDoSOKDFEpoY3EHGbNjlUw5WxENudC9v9Ki1+i3MeWySDrinccrMaBoQnQthtA+Ff3m9QoRq
 9CCOlcKN6TPVNVgv5g+KRFK+E/SUR3TqfS+Iqrd6mflDozTWAQEN0XkA/bkNH3T+WlyIkf7QCv
 NKiF/n99G6UCT5IcRh/QHER3OihXNcM0kesRxLeJOwC0jKj+jBBf88odQt48F0jh76F82KDqWk
 iZIkSHUWMP8J0FbfP9iqdKCdYyWreGarI7fywvMSXYJJ5LUDrbK2QRDFqqGMQAmBFbmyU0/IfO
 n3s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:14 -0800
IronPort-SDR: o2FzghvbkRkjKSVFSnhnuSCsPhU1aqRp89JQZ9o5XmD8aNBgWke5l8wcphVVdasv12YzPvlNS7
 12sQDvlyE7J/Q8ytG7cvhmUqiXU2VdRsmfijthcPdZxjCQQCUIks+Q00NSedYuwVUOUr3fiLRN
 67rgb5fEmUfiHTZ33Q5WN9Ghz7Q//ktTaH1hBOAOhoeVWWbaY3GmIR6JQZV2jXLfV4HEMSNxjX
 uAqiHln9l1orujqWpUnwNbYs7iyvKu7VW/42oSGRHydiE2WdUt+wnHhf6YFVG+xJ++z4ExNP3G
 AEI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:57:59 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 05/13] btrfs: delete stripe extent on extent deletion
Date:   Wed,  8 Feb 2023 02:57:42 -0800
Message-Id: <28ff4b0398d52b27c93fac93297be8f0e2a18fab.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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
index 50b3a2c3c0dd..f08ee7d9211c 100644
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
index d184cd9dc96e..ff5787a19454 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -122,6 +122,37 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 	write_unlock(&fs_info->stripe_update_lock);
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

