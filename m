Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27FA7A4D82
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjIRPvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIRPvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:51:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432361BD3;
        Mon, 18 Sep 2023 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695052103; x=1726588103;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=O5cyP50gwkgqOrwJ8rNm2QYmSxf1jQpq+qrkq1ID4oI=;
  b=K/tpf7E3WWc7h9ToygioqyLe9MoOnV6WM27uE3RyG7QRUBxJA86VTkx4
   USZ2/uaHhMN93eTpaO6um/01ur32zPoxf0z2sz6R485pQpQhPM+tJjIgD
   8VWlaDPX71sjmX7X1ByP9MSgLD3pacYLZtgqppKtJSxxUlNMHKQFoO2xg
   n8s/Q2zgfQgBjipK6RddWFHE05hr6hSvHqxZ6iiySUxloFtGsWOCdlgBw
   zuDubHgFKHS/NK19uuJTqbx/CU8tlXA0XOam9CzF5aC9C3V8HsOsmz9Ab
   FXdO43HLnCRetLoWohnIzEkaVWKBofKf2/L4LYweHLZ7qLj1PRdQIyXT4
   A==;
X-CSE-ConnectionGUID: lKz+FT6wQ5eSON19KL26/Q==
X-CSE-MsgGUID: wY9+X9cuQPaaYK3mP0dPCg==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242446879"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:14:41 +0800
IronPort-SDR: Ouna9XENkYlQz5mEXa4u3PTzlRlA3H3qigikWoBALLnzw9SzV5mHCAFgeCF/NRb6mB5IFizmMQ
 OLP9a6MmZH/jVqhQHWinVJ0eSe/1By0D8k5cJHbCkAc9llOKwEXnG+iCIkY3quRP+WSdzH+pth
 9LRAMg2bsOG+HRK2onUhJP4lLaa4QRP2TSN38uRqOSQUdG1krLYX9SNaZ6QoeaWgVIcXndd4+W
 rb7i/lB2DTbBjmhVcdTIx6guzCQlw7HB4V6L9JgLsk6olKzeZOTMHVLKt1tOrFndnQw9KRbaB0
 7ig=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:21:38 -0700
IronPort-SDR: u/F+reRUu2JqSkfFbWoaVFsAGNifvNA7j9mwu9h7pjdIOLtEHcaKMo0rq49Ku6iR/xIvQXvruw
 KBQ6Jz6epg8ncR+TUvMyJkHLW69ZLCUtVJYiNN5AVjNw8NqgtS1+t+zYodxPgzTlX6ZmAC6E5I
 0LlHiMTAgZYpwkOhtmTsQFsl9Q3IWt4BEmS4gAAxWrfjUmvGCQpTm/o35xnY1u+UG/XEB9Brjw
 kyfGmRtkrDJltWkDBGoHiBj2GmPiLFbHxCEATsZTPF1c/j3l30xbYAVpF3xntrZIZHES3eihmJ
 ZRQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2023 07:14:40 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Mon, 18 Sep 2023 07:14:33 -0700
Subject: [PATCH 4/4] btrfs: add tree-checker for RAID-stripe-tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-rst-updates-v1-4-17686dc06859@wdc.com>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
In-Reply-To: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695046476; l=2260;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=O5cyP50gwkgqOrwJ8rNm2QYmSxf1jQpq+qrkq1ID4oI=;
 b=bonYvCSYrgSNpci9AGiGelZCGtiU/flfpx/xM23TmCEjQ6OdlIrogeHl8xNi2YTrlHCqarbyQ
 n/LfiuhpTllDVQ5UCOSRpPJWG2AwpBCet/iQtoWeyzQgLn0iRaRqQli
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a tree checker for RAID stripe tree items.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tree-checker.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 01bba79165e7..ea84ca2767e9 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -30,6 +30,7 @@
 #include "file-item.h"
 #include "inode-item.h"
 #include "dir-item.h"
+#include "raid-stripe-tree.h"
 
 /*
  * Error message should follow the following format:
@@ -1635,6 +1636,44 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_raid_stripe_extent(struct extent_buffer *leaf,
+				    struct btrfs_key *key, int slot)
+{
+	struct btrfs_stripe_extent *stripe_extent =
+		btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+		generic_err(leaf, slot,
+"invalid key objectid for raid stripe extent, have %llu expect aligned to %u",
+			    key->objectid, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+
+	if (unlikely(!btrfs_fs_incompat(leaf->fs_info, RAID_STRIPE_TREE))) {
+		generic_err(leaf, slot,
+	"RAID_STRIPE_EXTENT present but RAID_STRIPE_TREE incompat bit unset");
+		return -EUCLEAN;
+	}
+
+	switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
+	case BTRFS_STRIPE_RAID0:
+	case BTRFS_STRIPE_RAID1:
+	case BTRFS_STRIPE_DUP:
+	case BTRFS_STRIPE_RAID10:
+	case BTRFS_STRIPE_RAID5:
+	case BTRFS_STRIPE_RAID6:
+	case BTRFS_STRIPE_RAID1C3:
+	case BTRFS_STRIPE_RAID1C4:
+		break;
+	default:
+		generic_err(leaf, slot, "invalid raid stripe encoding %u",
+			    btrfs_stripe_extent_encoding(leaf, stripe_extent));
+		return -EUCLEAN;
+	}
+
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1689,6 +1728,9 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_EXTENT_DATA_REF_KEY:
 		ret = check_extent_data_ref(leaf, key, slot);
 		break;
+	case BTRFS_RAID_STRIPE_KEY:
+		ret = check_raid_stripe_extent(leaf, key, slot);
+		break;
 	}
 
 	if (ret)

-- 
2.41.0

