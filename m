Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB679BCAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356165AbjIKWDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjIKMwh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:37 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B7ECEB;
        Mon, 11 Sep 2023 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436753; x=1725972753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE+UPzVtXzF+bHxJkcZdCTF60ml4yxdyGi02OCjQOuI=;
  b=FE6YfLi5wayFhQzNpoYeNXT+qNi34BY6BgHJHEHbEGcW+nXkX+dArov5
   B1rQ7jVbcgPjUmOD0vpwXNQOHK8BiMpi00L6yAMRixtfEziuCih7R9ULb
   aCw00osomak4AW9zhpHGhgmNWzueYAhxD1bWqCdSGRBAnnD1FPf+Eh4NQ
   AcafDxiYEHjDTdn8TWyDDZAXDxv7iXxTq8zMmC1XIY+FgibbSvyFeXavQ
   o9eehrr/RKyK+R82iS5C5zi+8c1BzM1g/3Rn+zdDviUexmsTEYQj20ivE
   iM2tK+ObJMZeoqvgY7Tl9kAPNIS1QQoXovykoA1Ojn3/hk/3m8zRVmNml
   Q==;
X-CSE-ConnectionGUID: QE+c5Mf9S7Ot5r94N5aiGA==
X-CSE-MsgGUID: SC5pS0z4Qd+dU5/hOKvhHg==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594391"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:33 +0800
IronPort-SDR: V27pBxFFsKDgNgl0RZOKJXHd6hZvW2wTf5KnjPrEuxJaHWKDncyy7V7r6iTUrPZCuDPHIh6gkS
 AtHw+MtAxQaQfEobLnGu+CoEb8x/p3ncBhGaAvavDqiq0dvf4PxTZlntsoGVghtwBDHBLrUAOW
 t/VXqRQ+43HsB1Ye4TsiXt+2dcCWalS0f/bTADSEy9BEhL6BrJtqXjQffe8l7onRSf3xNItiGK
 h9l+gEvwPMlC7W2GdMcu3sJhMZrENzVgbubG/FZGgzsKbdgPO7P0veMKIfy0yI3QMo6MG+ITf5
 lXg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:38 -0700
IronPort-SDR: b0sxTakIdX+U2kkYMpn6AA3uc/Dl4KC/NlPw48XyyKrSKPXXVE7ibDuQ+n6ABs2mNuR3TS5k+B
 zVFb5PYiyvZm0IZhrx2sQJKWj/BfUAjhziHBPm/+ud0gBjMHQfQ4BQs4yQj0uVkioHI8TQ/KxU
 vEgEtI70v9/n8NX5oTZ45SxDRYlIoiblZjfH42WyLjdcsBnaP4b32YBd62vTAUCWTEedasEUqL
 QWj+fy5wNPv8OppHe3n6bOEHQZi71mte+NdRdyIdDeVqDS5XmBx6Ys/UVQ8FuA/R8SLMFv4die
 Y3w=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:29 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/11] btrfs: delete stripe extent on extent deletion
Date:   Mon, 11 Sep 2023 05:52:05 -0700
Message-ID: <20230911-raid-stripe-tree-v8-4-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=3110; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=cE+UPzVtXzF+bHxJkcZdCTF60ml4yxdyGi02OCjQOuI=; b=NvUPztervxuijkZ/xcqpNHmK/91BLMtrbrcV2Mx/zouu8TkB1jznaW3mX5GOfGkGkixB4rF8f 35LIibF5YohBRtd5ZOFKWtpxbtD+4/YIGUHymPSpcklN3yuYLz8MIZ0
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As each stripe extent is tied to an extent item, delete the stripe extent
once the corresponding extent item is deleted.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c      |  6 +++++
 fs/btrfs/raid-stripe-tree.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2e11a699ab77..c64dd3fd4463 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2857,6 +2857,12 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 			btrfs_abort_transaction(trans, ret);
 			return ret;
 		}
+
+		ret = btrfs_delete_raid_extent(trans, bytenr, num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 
 	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 2415698a8fef..5b12f40877b5 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -15,6 +15,66 @@
 #include "misc.h"
 #include "print-tree.h"
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = btrfs_stripe_tree_root(fs_info);
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	u64 found_start;
+	u64 found_end;
+	u64 end = start + length;
+	int slot;
+	int ret;
+
+	if (!stripe_root)
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (1) {
+
+		key.objectid = start;
+		key.type = BTRFS_RAID_STRIPE_KEY;
+		key.offset = length;
+
+		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			ret = 0;
+			if (path->slots[0] == 0)
+				break;
+			path->slots[0]--;
+		}
+
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		found_start = key.objectid;
+		found_end = found_start + key.offset;
+
+		/* That stripe ends before we start, we're done */
+		if (found_end <= start)
+			break;
+
+		ASSERT(found_start >= start && found_end <= end);
+		ret = btrfs_del_item(trans, stripe_root, path);
+		if (ret)
+			break;
+
+		btrfs_release_path(path);
+	}
+
+	btrfs_free_path(path);
+	return ret;
+
+}
+
 static u8 btrfs_bg_type_to_raid_encoding(u64 map_type)
 {
 	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index f36e4c2d46b0..7560dc501a65 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -11,6 +11,8 @@
 struct btrfs_io_context;
 struct btrfs_io_stripe;
 
+int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
+			     u64 length);
 int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_ordered_extent *ordered_extent);
 

-- 
2.41.0

