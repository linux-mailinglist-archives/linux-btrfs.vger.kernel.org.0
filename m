Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D456035A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiF2Ol3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiF2Ol1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C93A1AD
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513686; x=1688049686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fDGlOEPYf8FRGIBDJNTU3gjuOSx06L1yIinxMPGK/ps=;
  b=Bs57sXpZtNsqlSntBWkjsXiruHEV8zLXPRGlPa0iaTq9odfpRdN/4mni
   BnS/4i3Atd6Zkc+tjGv8Br7Nkw0/yYnobw0IgHcJMEFYE4ymLc8rLpF4r
   KLkUUafqECXfTfQwPzuEgSzsFyjisTfvgi6WrPydvNxzx4WXZfS6CXgG5
   huPRLZRGOBkqeT9adCn/spu+CvPpskdy0sPYmSzvhWPzdnFN25lBQaxVR
   VGg6XgBwV5Z9WYzzooo0WeXnJhcMfw4ppAWjNW70tm+MARKCs6vBFS890
   RUObvj5z9nTo+K9azsFtGvP8+gzu3dBsYAOSNu1Dcv0oZP5GVauxy5jH1
   A==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064889"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:25 +0800
IronPort-SDR: 78dHaPmm5+0h8ZhZv4w3R5HnzmlmhXnxJgeivI9Qtxn2oYM+ic4KM2Mj7Pyt6WxLABX0tqHH4I
 OUQmaPaBVEP5aX8zap4e+N/89vliQVgWNcPRQ95vOzn4PA8sFHXewqi+PBMdfmKZimF8U4o+VK
 9KjskJ+7lv8qDsXYqiSC4lWTHzYieMd0uPuqEeqU0g+mmMFi7BHm4Ho2v1Le4pk+5ZDHWgDDzd
 ZNYHXrg9iZH6g6mzjf81kZeFfn5Ri/y/jCSBM5uWulW6WBGoH3viBN5ujydW7XVXVAAP9xds4X
 perTrDWIzWswQWtJo12V+qAa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:04 -0700
IronPort-SDR: jrDuosRxT2h77ncGTOj8aBwC2A1tLpX33iOR2cjGM6eNxQnKW3K3AWANjJ96xrhBuGKJUTNVWg
 GNrxLcHGOZxcvXSrzX04uAzVm/ToNyF8C4qWzMddRMq9fUkVnukr9ARd185YhpCuzGrAT4GCFa
 qf/1XtpHYk20lv2A85LG7FrMscLof8jo++vSoRu/0n1srKodOpVd2uavZxFO7tuY9IAWLUBoCC
 XXf4AVcvOtw8YRAucfNVnIH7oiZyLt9H+XXa2/Vn3LaWFhMXpimX5oeEKQhdp5WKKAqKazIqDQ
 wNg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 4/8] btrfs: add boilerplate code to insert stripe entries for preallocated extents
Date:   Wed, 29 Jun 2022 07:41:10 -0700
Message-Id: <63f578dd3ad1061561ecb761202a08d6092310d2.1656513330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656513330.git.johannes.thumshirn@wdc.com>
References: <cover.1656513330.git.johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c            |  6 ++++++
 fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9890782fe932..97e218a45165 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "raid-stripe-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -9901,6 +9902,11 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	if (qgroup_released < 0)
 		return ERR_PTR(qgroup_released);
 
+	ret = btrfs_insert_preallocated_raid_stripe(inode->root->fs_info,
+						    start, len);
+	if (ret)
+		goto free_qgroup;
+
 	if (trans) {
 		ret = insert_reserved_file_extent(trans, inode,
 						  file_offset, &stack_fi,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 360046a104c7..85d08f052a64 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -124,6 +124,40 @@ void btrfs_remove_ordered_stripe(struct btrfs_fs_info *fs_info,
 	kfree(stripe);
 }
 
+int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
+					  u64 start, u64 len)
+{
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_ordered_stripe *stripe;
+	u64 map_length = len;
+	int ret;
+
+	if (!fs_info->stripe_root)
+		return 0;
+
+	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, start, &map_length,
+			      &bioc, 0);
+	if (ret)
+		return ret;
+
+	stripe = btrfs_lookup_ordered_stripe(fs_info, start);
+	if (!stripe) {
+		stripe = btrfs_add_ordered_stripe(fs_info, start, len,
+						  bioc->num_stripes,
+						  bioc->stripes);
+		if (IS_ERR(stripe))
+			return PTR_ERR(stripe);
+	} else {
+		spin_lock(&stripe->lock);
+		memcpy(stripe->stripes, bioc->stripes,
+		       bioc->num_stripes * sizeof(struct btrfs_io_stripe));
+		spin_unlock(&stripe->lock);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+	}
+
+	return 0;
+}
+
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe)
 {
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index b9c40ef26dfa..1644515fcecb 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -18,6 +18,8 @@ struct btrfs_ordered_stripe {
 
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_stripe *stripe);
+int btrfs_insert_preallocated_raid_stripe(struct btrfs_fs_info *fs_info,
+					  u64 start, u64 len);
 void btrfs_raid_stripe_update(struct work_struct *work);
 struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
 						 struct btrfs_fs_info *fs_info,
-- 
2.35.3

