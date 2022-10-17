Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0774B600E44
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJQLzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJQLzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADABE4DF23
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007739; x=1697543739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ka1JTubPu+2SbPMq+18cp2USPIzHB7XUKzYqYyESwdo=;
  b=Ii4QQ/AnciCXtHX3Lm6qqX+fubYOZ8z0tRW1c2J5A3A0Od2FaqsjFc7N
   gEQ2fTN7J3/70qrjq8lg06EtB7DoEp1NTPoa10KmDwZ1LsnguVBAennbP
   dBfwtR99dYVTV8NogOEMSg/QfPXSoIL2yPm4oNyVq5+AqP+Lx3NqaBbsi
   otMGlAso1mWkktKdnCer3cLWGfs1SkWU8N/XWKzxKxVbmc70WamLBAvTH
   smM6Mrcqd0nskno/bxFwknkfEUI+XiOA+wy/RzDpofdLE8ycsmaJ58YZd
   b9vsvQWsZscZeCCNFtTJ2GKjXfhhCZGXIIyUYldOmIu+PMstoX7j/vULI
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337159"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:37 +0800
IronPort-SDR: gckuMW1Ul9nZ67F7qEd08nl1/Y/loHkqXpgozhcZSKVPGsS+FjtIl7oxfVQK792M8znPTCz8Po
 /XX0Kdj1xLtLNVoT9bnpVpCyKTcqoAnUDk43C0FEz7pZCbeGPUr3v2QbrctuW4H0XTTdf+YXK6
 1Ci3NEEtb7P1JMOKe7WTIJy5IvHZS0uacVcIaavXMZxW9+5537tTTEXEjgUmK0de4kkusQQPDB
 S6jFR/76PcDrp3xqOUdzhtVYkzVVLil0THA38v2MbRMgXfmKTCHY5Ye8SJH7rBZxmnLYMhvWAe
 9HVvUwSxBOFFezhjoCzAzCm9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:10 -0700
IronPort-SDR: SCtOkIYPYQzIhROkLwXY4zJSmryBRuacLml7ozToHAmPGl2UA4cfCUsJ+yQaJ5DxPKpyK/qOSU
 SpdKFRRlTg/Nw24bm2qBxJw8CrWs+VUa5CAf689KqnzZmFeG0+jkZf+aQEiU5w5ERZZp5/+2qV
 i2sK5v6182+qTDECia3ggXuYTxrniMyhnujJs6IQCqKTg+JbJdvwuSa1yVWkxX58qHi3XXRrPu
 1/zLe3MK7hwqJDqsiFeWeNewApYAc/SjTrMHpyNoEBdAR0PMJ8TwqbuP5kevhmWwKUsEbjBKy+
 O3w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 04/11] btrfs: delete stripe extent on extent deletion
Date:   Mon, 17 Oct 2022 04:55:22 -0700
Message-Id: <f3b70e2036b28ceefa0b17eb5732e5c01c65f345.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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
index 061296bcdfb4..d6f52e101d5a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3211,6 +3211,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
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
index d8a69060b54b..5750857c2a75 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -109,6 +109,37 @@ void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 	mutex_unlock(&fs_info->stripe_update_lock);
 }
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
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
index fdcaad405742..3456251d0739 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -16,6 +16,8 @@ struct btrfs_ordered_stripe {
 	refcount_t ref;
 };
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe);
 int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
-- 
2.37.3

