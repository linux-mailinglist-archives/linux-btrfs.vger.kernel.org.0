Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930E645C66
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLGOXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiLGOWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B532AF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422952; x=1701958952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/6BtanRwbpVUUvGm2AZLK46NOj0PxlMpVPQwXeKufQ=;
  b=L7w51h0fx4lmLZdwaeRsQulK8TklkZItZ5zpc9Eess2ApSwMZxfPpBid
   a9UYMUfmLqgUie01BweN16HE2OvuU+mUZKXH4ActrOBNPceaafSG9X/Iq
   o+cywJEgoCqMcsV/8sxxobM+/j772SI/lyN2X3vMJlNkV5hrbZ9qY7CZc
   eJcd57lYo8xppsNDNcALRX9XvaJCpzx7jReSdYQAOGUAGEKDaQBm04bHd
   PCOTMyC3qDiVx/3iO2gaV4h/rpB2CWuSOKEQUtFyawl6Cj98c+Zgy5kly
   B5fNtyRT5kMVAtuG3CKy84M1HGrxUCKWVhn12cZvvQCQ1E+XA349qEGQ/
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099487"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:32 +0800
IronPort-SDR: xSxTTudn0czah8gVeORWljgERHzS8W7nSF3f2sZ8WRQbIae41vNdVOWsGrFOrM8wdKcwiFi7QZ
 +hSdEjb19CuP+CuvvEZZQuDR1CNQJJFj5CcpG5cxvIg9tjsesiDjRveWq+Cvn4giWSbSUCMveG
 pYkfOlbahl/ydQiqHYS+X7lIK90xB/gtAoMnK51LuAJ6wsKcRtjTE1Vuet9vHfB6ljCLQowNug
 JQmGFMCDtPnFttVa6wX/YfSswWjRU6J1DFIzDxbqrsYvK7xN7pHSc57OkkXte6601ccrSmJIwx
 e3k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:18 -0800
IronPort-SDR: N4XV9Z/zgMP5+IxwFAVQN1tcvY/Thbsum+qAaOPkRNGvhB5K6NjXeyhP/pKlI6htYc7ttuliaU
 P0Z0hNfKdtkerHDE0aIydP6VWepD3haaA9nk7QDELTSeuNELeTfnZNALpuKowf/MMmlWApn6ag
 WIyMe6lLUbgMmdCiPVmxEx3Hf0xtTyjs9a4V74pDOaOLDx/c46HwWgQF+2cEPoNKvf693Pd1ZY
 x0gThPa/EALamk5/4f9/1MXpvd0adObY2mWYif5DEV4SYOmgEZX5Pn63JSiSBX4VmGXF/FCsc5
 HgA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 6/9] btrfs: add raid stripe tree pretty printer
Date:   Wed,  7 Dec 2022 06:22:15 -0800
Message-Id: <c33b40c20d49b08eaf9f066597e38dd2145b0284.1670422590.git.johannes.thumshirn@wdc.com>
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index b93c96213304..b70e0bfe8c84 100644
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
+		pr_info("\t\t\tstrde %d devid %llu physical %llu\n", i,
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
2.38.1

