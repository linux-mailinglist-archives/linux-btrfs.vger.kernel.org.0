Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C65560357
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiF2Olb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiF2Ol3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:29 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08903AA4B
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513687; x=1688049687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rbiMmQZXSgKSX0UGG9T3A1/tEj32uac0hbWUvI6I84=;
  b=TZ2WzVWpeDoqUelTEL6V47Xeq5XcswqFXPWXORS8aqRDLG4Rejag6bP+
   MizuShGLYMwCWQNdpXtEgvPojbbeWx8NnYHhYuzeDjxsWMmaSVRyiboFF
   E0nXQoSNmRIMViucXhG5nNzeX+5rrv68LPODzOV1NiCR5gAuftTlujpka
   lrQ7h3giYF2sgpf4rkP4Fdsgw/3OJ/KkRpHfleQ3JdaSrWs8CpqYzeQaU
   ck3gPmkC88IgEm2+q30a4ksh8uiiI/q7DQyjuNt5mdA3PJY5h9vC4S1Dt
   hl7piN+yuteurQfVdT1MkNQnHCt4xZCKX4V3kYRn11qF1mftJ9rSWPT+Q
   A==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064891"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:27 +0800
IronPort-SDR: vBTRQ8ycOPVYKNNjvu0lhMK+vZpJhKX+a2OpBgHvZ7D1oTsX1ARpQmrFdfQKhauQJZXXajtz/7
 mZCNpcPJMD09ChNISUA3VGOPPk4xRsfzMs+RrDUEX8GECHjyn6KYm/cJRgMNE+XYplzVwUtukF
 vG941T76uuEcOQS7K6YVK47NKPnJ98nZZ/Yapg7r7PPVaTe2H6qt3tAIJG3g6HmIGMjVnKgaVX
 3HGPeJo4i5oz2u5mZmc5m1nf/V/I3qGFec27YFEh/hgbgX3kZ7iqk6H7jYC7kjCwen3RswdfkJ
 tBWIJf9w2afGYmXyQcmE/IOL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:05 -0700
IronPort-SDR: EU7bB+5xgwlciFOmWkoN7QD8T6rFbwItwoW5P+fVSFtgQuPPse9gu1Y6fag8/P1oBjEYHdmFJP
 Cq041tzmJLh7ZOoA4bOTiaNVRjC4aroXiypV/rbW7lHND5O5Og93W0FgAX+f8x6mXKYLXl6mEy
 fakjuHkvf0NN0CTWoXZ1W8Ysv0PTPgZwf3T4P5HWoPdSA8z5wUtkljOeBskNbSxC2qudLpf3S6
 QZ1ohqVpOLOKVYZT79gem1/77N85Any6p0P+zjfok+YpItJuIlPsRJ5T8AtEQDDpm3PE88a2gn
 /hg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:26 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 5/8] btrfs: add code to delete raid extent
Date:   Wed, 29 Jun 2022 07:41:11 -0700
Message-Id: <4e276266a91ba03a027e68316f9853d353672020.1656513330.git.johannes.thumshirn@wdc.com>
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

Add boilerplate code to delete entries from the raid-stripe-tree if the
corresponding file extent got deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c      |  8 ++++++++
 fs/btrfs/raid-stripe-tree.c | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e1738b3dfb21..f62036790c2f 100644
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
index 85d08f052a64..a673aaf8e703 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -124,6 +124,37 @@ void btrfs_remove_ordered_stripe(struct btrfs_fs_info *fs_info,
 	kfree(stripe);
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
+	if (ret)
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
index 1644515fcecb..d3cc24e37de1 100644
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
2.35.3

