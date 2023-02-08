Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99568ED64
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBHK6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBHK6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:58:02 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABC13523
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853880; x=1707389880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kS5bXobcd6NfCD1W2BItNtdkyqBgpEkjK5VH+u/635c=;
  b=bLFDE85owU//HefEWFoltxkZ4bSvecTuUck1eDgmDgRCtWjDfMqO2ye7
   pu8oJWCYu7mIpYaYRKnzna5EBBCKJY76ZRR/pAj616ynq+w7IQX5kNZtN
   2/mAq16okpBRyp9TLgQ/23vObhrUnZ9U3WlgUCB+R40zDbbfA8Ipxu/7M
   8UhaJnOkzuHpJyrgo7Pyg42cvPJLS0D+Q66DcLKQ0uA2LRolquBRJlBIK
   B9RQl+y6r9xq0D3391sYEdIAlFLF+GIAFHmKp2QH7zpeAgrn/lWprstBF
   MqIMobLCneRXWC2qY3EeYVy5CHQHfXvw/g2RK6EF1doPps2sjxIoj2FaF
   g==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115635"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:58:00 +0800
IronPort-SDR: xlJiOabWiv/rzEU1QFt+xNFFnlf8dd0TrFcGBkVYkVQTXnudunWzyoHsLbYljViZOkC8rwhzZE
 BihsPnbvlbQGAAsVeMzdVD0pjt5E85lZcGYaGmvpXT6wGuplRLVolDSGy+P7EIgsZVYlODpbUB
 qtEJSOr3yLq41btWRPfBLvz+zkJPIU1nFKYU9Ls/bKxGssyd1+qEVBoBRDICnrLVh15GX4EKZf
 YphU8K2yFBcKuUZbKUaCiA6y9iWrbMr6pJpfJFnkXkqgDUTIWEW39uMKH4gLhNdSI/4/JEZZKq
 ddg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:16 -0800
IronPort-SDR: fl/ednZ+FTDHc2969T8zYv41O7qDpDBeWLIwflV3AmRO+op0RdIwP/REgkLgUSGTK6hW63nrWD
 1eXD55Ofho1nQmAKr1gARD+flKs0y5woM9pyoSlwsIuEUmT1ZfXoEn/VSKlopSijzwg0ms5ann
 U2HW7R2HTUyjf3iWr2cIBzPx0tsDUKKTkUvMPNyaPbr4EG64t0Il0OYLEPadd8o3fYGCEjha5H
 wY2FpBEUfrVnt4OrCGkUa8bsrmMreB1/4DkNr2G+Izz6s+Pc7GO2Cpjbtzp6cjFQGUMH7frSJK
 Ftk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:58:00 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 07/13] btrfs: add raid stripe tree pretty printer
Date:   Wed,  8 Feb 2023 02:57:44 -0800
Message-Id: <64a6d9c550f9b1e52e3b3817e6f9d90668c2ae31.1675853489.git.johannes.thumshirn@wdc.com>
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
2.39.0

