Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A06A7E6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCBJq0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCBJqU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:20 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A83D936
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750373; x=1709286373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wCuSxw95aH1suzVvBS/aXESuKb2fqgaXz5cjhC7nqfw=;
  b=V5UiGWNAnEXbrlG4YjQ3km5KrcBk8GDBULMQdQ1bUmEJrzqPnYMDcTuK
   v4NJ+vjnwwPTqixaGU4hZPEqRz93zlpEode64QC5ChUoWwf2zJxkINlcf
   yOHuUfIda75rKpiq+uQFXe3kLhN0/UKyKUU5yeTI0Jc5gjEERrPBYmwnQ
   BhXE2j6KZhISBo0ktjMfY3WzVehr4TxqX9W6XMUfC7DjCn31fBM5dYj+V
   9Y5p+EJ6p+uwp5EpkBURtN8DGs/ncTZx5OvBsS4bReiVEa+sb6RbxuzJf
   DiuJYyrUXQkrJbYDQHXK27qW4A5Prv7WMCex+4Zvy35BqTZoDcJvt7pXz
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939194"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:45 +0800
IronPort-SDR: DdwKxoCG5dRd8bwXElm+5h9Gxltpe4jD0HvK+y9XDLjuon6tihVIwNqnlCtzeJZAxQFRZXkk6P
 JDdkN+mvT9kOHPxN+hcxSM7TJcantKVFVXfTCzNOYSfHYY15Cy4ZfuhtYcK8m67DtXC+7NgtKX
 n0pz4J76WC3smW3vdoWdKJTLBeLnBzTQL/gmLJRk6eoDdCFSHAJPh+UYVQJQFlqqxX8rzStZ7u
 ME03vta6WEu5BMOHgrq4W7Pd7i9X/rAcE01ijwbl2YoCpgEUbywNa657IBJiiKVF1je2xdtR8b
 fU4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:50 -0800
IronPort-SDR: P/MrUKkfkSuyMuxniz2UD3JgPCn5UiSLyDbE3P/+Y6frsxedOYXIGXXc6j0hGRYSrW2/PAtBs/
 HFmUWK80FsyKX1zsD+tXPJhSxJu6uwYGxNbUed7l2gL89zsYXJPx6KyJlqdlp+ZkPVtyxfLTJb
 SL8gsWcwHCbpwz390suHdp9FrOLmw3NpdYmmo3ogmj0s0Ueb23aWgcYSpsAT6oulLyC5550aOz
 8HO28vKuSOtt27o0X2l7byRjdT/Zghn+qgeskIVA5yTRcy0xJCrTdZXOVIdfwny/5Pm9CrUZZa
 dtg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:46 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 07/13] btrfs: add raid stripe tree pretty printer
Date:   Thu,  2 Mar 2023 01:45:29 -0800
Message-Id: <1843ab1ff73ccc92a589d5b961a541760b5f339f.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index b93c96213304..d9506d54298b 100644
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
@@ -187,6 +189,20 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 	}
 }
 
+static void print_raid_stripe_key(struct extent_buffer *eb, u32 item_size,
+				  struct btrfs_stripe_extent *stripe)
+{
+	int num_stripes;
+	int i;
+
+	num_stripes = item_size / sizeof(struct btrfs_raid_stride);
+
+	for (i = 0; i < num_stripes; i++)
+		pr_info("\t\t\tstride %d devid %llu physical %llu\n", i,
+			btrfs_raid_stride_devid_nr(eb, stripe, i),
+			btrfs_raid_stride_physical_nr(eb, stripe, i));
+}
+
 /*
  * Helper to output refs and locking status of extent buffer.  Useful to debug
  * race condition related problems.
@@ -351,6 +367,11 @@ void btrfs_print_leaf(struct extent_buffer *l)
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
2.39.1

