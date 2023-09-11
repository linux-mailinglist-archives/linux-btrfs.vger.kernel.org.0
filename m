Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A379BB3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356002AbjIKWCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjIKMwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2834CEB;
        Mon, 11 Sep 2023 05:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436758; x=1725972758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=blUMJPeL6YvItniPDnwd2Sx2aR4JMUlJ/5zDYysXEpc=;
  b=Zk4/EwiiheTs1sbZY7x0BJ9cuZHhBZBkz4MlMk28FoPTLs3BQuszdUPj
   SvjhMuhPJ4f8NG58X7o+pfDjbwAgc22G4O6RI8vNRsG9VCHvvctcUiA9v
   PWMffpDrqulXyeERh96pcWo0gzB9J1XqHW1Qy3h09s9xUyGb8oMODAAxF
   T4Ie76i2rwJieOg/4khgEWhwCy2nFQ0q+tcWHpGEPAsnBK0jD9u9scWbv
   Vjs1O1V1NZMQ9recC4vqArQWF5YDe1Q1N+GBQqIE6Ef+i8ev9Z9sHLOMO
   hxMXRn9ki9b0SSiktyMdxhEFJHBP4FKoo2Hj+0xbg3vXdeKpdaFxjFvhk
   Q==;
X-CSE-ConnectionGUID: BvFzMaHXTzuqYHA4p28mUA==
X-CSE-MsgGUID: 8RJiqPC1QZCggXguRveDTg==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594402"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:38 +0800
IronPort-SDR: Rjt450QVq0yWlIXc8XS/k3WOTmcrPse3mw+K7RVQS1tecXkLUsX1rsyKaA3xq4uJK2rWHFRt/k
 N4R98EmsRxrs2+FzRTPrCfaxJKJERGjEb4rhv0kmmK090YV9pvC8wXcFOS3C+qSUpdlsNYL57R
 2hNoZY1WoKZ3LyoOgHu4G3h+snvR5Uch2CGpE8jSX6wvS0/PdAB2ziyXqpF06/NEyHenO4ITG4
 7lIIUOAlQt3nwAgwNAZfM6LOtplgd66ahcjgqiC+uwfd4LkBJGccmIzLaRaZRWt2COqdla1Jo5
 5/k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:05:23 -0700
IronPort-SDR: Fyfa7eUvrHGFYP9TvU9jTEgWTyjXsdRRxOHbXJRn8Kagg/Ww1JH/aLXrhrpdUYA2ERK16UQRyP
 II/5p2xW7t5QaLAnD4tjzleWuZ+JHpswQQ1yDqHlCAEFnTghJap/BoAKDKKnaI8BST37b/gXoN
 iP2EXLFpGVQiVNrH650cZehUm3wAIHTXusZRUmPp3sBfYBNJN1s/4wtbgzgjPRvMgrcdLcouVN
 uHJ2CNqpMh6Y3JFx/9bAAgSTss3zw3Ol2hZQtv6vwyBU6zPMHQPYUtutxR9c3NoSuU8BESttoG
 EvI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/11] btrfs: add raid stripe tree pretty printer
Date:   Mon, 11 Sep 2023 05:52:09 -0700
Message-ID: <20230911-raid-stripe-tree-v8-8-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=2829; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=blUMJPeL6YvItniPDnwd2Sx2aR4JMUlJ/5zDYysXEpc=; b=1TyvAmCP3+Bry6GkpTBFhfbqSm4lYgiH+0Hv5z5zxVk024KvG+gwsgdaNHDzc/R36iSLJAlHQ Y2PqYga/8XsC4ZAUxwQWjDhEkyK5i0uIGHOYuBhkn4qhIrdnHA2AYV8
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 0c93439e929f..f01919e4bb37 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -9,6 +9,7 @@
 #include "print-tree.h"
 #include "accessors.h"
 #include "tree-checker.h"
+#include "raid-stripe-tree.h"
 
 struct root_name_map {
 	u64 id;
@@ -28,6 +29,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
+	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
 };
 
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
@@ -189,6 +191,48 @@ static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
 	}
 }
 
+struct raid_encoding_map {
+	u8 encoding;
+	char name[16];
+};
+
+static const struct raid_encoding_map raid_map[] = {
+	{ BTRFS_STRIPE_DUP,	"DUP" },
+	{ BTRFS_STRIPE_RAID0,	"RAID0" },
+	{ BTRFS_STRIPE_RAID1,	"RAID1" },
+	{ BTRFS_STRIPE_RAID1C3,	"RAID1C3" },
+	{ BTRFS_STRIPE_RAID1C4, "RAID1C4" },
+	{ BTRFS_STRIPE_RAID5,	"RAID5" },
+	{ BTRFS_STRIPE_RAID6,	"RAID6" },
+	{ BTRFS_STRIPE_RAID10,	"RAID10" }
+};
+
+static const char *stripe_encoding_name(u8 encoding)
+{
+	for (int i = 0; i < ARRAY_SIZE(raid_map); i++) {
+		if (raid_map[i].encoding == encoding)
+			return raid_map[i].name;
+	}
+
+	return "UNKNOWN";
+}
+
+static void print_raid_stripe_key(const struct extent_buffer *eb, u32 item_size,
+				  struct btrfs_stripe_extent *stripe)
+{
+	int num_stripes = btrfs_num_raid_stripes(item_size);
+	u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
+	int i;
+
+	pr_info("\t\t\tencoding: %s\n", stripe_encoding_name(encoding));
+
+	for (i = 0; i < num_stripes; i++)
+		pr_info("\t\t\tstride %d devid %llu physical %llu length %llu\n",
+			i, btrfs_raid_stride_devid(eb, &stripe->strides[i]),
+			btrfs_raid_stride_physical(eb, &stripe->strides[i]),
+			btrfs_raid_stride_length(eb, &stripe->strides[i]));
+}
+
 /*
  * Helper to output refs and locking status of extent buffer.  Useful to debug
  * race condition related problems.
@@ -349,6 +393,11 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size(l, i));
 			break;
+		case BTRFS_RAID_STRIPE_KEY:
+			print_raid_stripe_key(l, btrfs_item_size(l, i),
+					      btrfs_item_ptr(l, i,
+							     struct btrfs_stripe_extent));
+			break;
 		}
 	}
 }

-- 
2.41.0

