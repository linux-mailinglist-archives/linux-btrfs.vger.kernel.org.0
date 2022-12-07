Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0341645C63
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLGOXI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiLGOWe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:34 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7D5D688
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422951; x=1701958951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1TdCfQ/3buqVZrbMMs0uHH8GCt6xmrjvMU7AKgOuw2w=;
  b=jMmXcHVUe6INtsS1TbIRNrU9Epdt+V3PhSz43FgAYmIke5MCP2dB4PBG
   ouGIIJujkxgQ22WbdluiIJaLfoLntfSdHYeEqQE98M6Ih+N2g2eO4BJTI
   8/pduDBrMSPeUaP95O8o38Sb4qZ81xFRd80BcMP8LShGolcwsoxHVJbPo
   Cxa2zGsyJNpYllJG+6tzqsJ6Zv2RQQWqTSN3yVDo/Vec1jm4XLp+oceg3
   RbSq4oJh6P6ktiHxC0OICKPjcJSDMJKfAOeEi2+A/pfnG+FOQmZWTNGzm
   zE6rLDSV5vtat+zTlhgn7RWdnGIse5+MIcyaeiqoezcnKfW+zspnCTxpV
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099482"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:30 +0800
IronPort-SDR: jvLnqsRKnubEXRlyjjR2HblFQsRglT1ItdwVbmMV/F2IBtaK1ws2rWGgrg5u4dAIOtYfN+dM1W
 pC6Ba9LplqB/4aM0VoNdsnL86GC1KW+iR7ZDOBpvyfEKpvP0pB5ZX00QFQ6owukQ3oxy2hVFLq
 ZghZaucogc8iBojvXQLAih+a5jYMqjbhoVQA6iXFK5N9loLwhTLpxCTizrseR0Wjw/s2VbTmnP
 bIXC3e597N1XlcB/rNKBEZcRlz0BezvJYsq6Oa7ZPIDIQO5QgvO0LSKYuSIWsrlL8vy6glkXQl
 Tyg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:17 -0800
IronPort-SDR: K1yclPl7ToGBZsyj//YAdf9ePWBncBvx+8qiGscPVw+ki+2edbj+xgvjVmfEwI4OtGKYRvSWHT
 Zw2o79GHxWPbIOpwikyYnVVNjZ9f8s9Uz11beZ6ZRsPfT5wAKhUW6k9OcJykwUCT4AiFtJWSus
 6vt+TjqkXa5kOLt5t5kGEvMjVkK95Nzqj0f5eIgSQZi+hzrJisrBwHNtlx1XL/ET5YP9/iWZUw
 e9/5QuqTK2jJHrc3oc/IjRHnj64uT3MoJNS9gVi1Ldpj/fCmJ2GJdPKup7hM9ySdYjI2YwWiqF
 n0w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:30 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 4/9] btrfs: delete stripe extent on extent deletion
Date:   Wed,  7 Dec 2022 06:22:13 -0800
Message-Id: <f45f124c9c13fb6242f4ed790a2b048864d1a02a.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
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
index de479af062fd..3840ff52dcbc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3225,6 +3225,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
index aa60f784fb1f..4f516f71c4cf 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -115,6 +115,37 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
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
index 807d9123270c..2b1e3fd9029e 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -21,6 +21,8 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe);
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
-- 
2.38.1

