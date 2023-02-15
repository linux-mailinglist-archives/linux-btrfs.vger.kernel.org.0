Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B402697E73
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBOOeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBOOeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C6638B55
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471643; x=1708007643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kS5bXobcd6NfCD1W2BItNtdkyqBgpEkjK5VH+u/635c=;
  b=OMpEDmnLa2leJudFrazYyC4AprQTJA1YG7D/7t5iuSzUj36NC6oy67th
   no39q/5U4WEvZn+O8FJLhY1Ue8+XOumX+79LdDsblWNtRgqqe3JSOUtdH
   XrNvwXjbgbbHBXsntOYTUKD674DRYu4zHUqlJqIrMVKVb6t5LstlAZB8o
   CxcI04ILTGe0i0BKozG2epJQFN8Ju7AOVahysEwSx1hxEtxjrdY8O8bV/
   Z/V3WsczIUov8fw1ii+x21c/D3Jn4RdztMXLPJQKztFobOQAGVuPPwlmR
   wChVPdPaiEEP1eZj/7mZU025PqFM2eTE+sQF0y68SpbkGpQJeOeQZ9AZW
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394070"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:45 +0800
IronPort-SDR: GKP185ch+wHvtAfttY0muq0PoV/Tg+qZtJbnjAFm0bd5sY019qWoIienQKqVvIvmaBxl1IRnZL
 0i5NVkPZ+rN4lPxwDzQpGcuUJ4Ly8BAnkDgF/VM/WxIsM3+PJQfqtmV6zTR9yqAICrMtyK1jKm
 mTHAY2hXsJ5qjCdWyDIX2h31wS24FebKvJMzHtg3GQcH5DfbSP3ceibKcJ3o2sItPN9tUUO7dt
 /7uXWSPnNO50qrh+kUetn12aOmZkypGB3AgoygdwAu34BcHKdnY89FZj/D8HwdI/ET7Xk5/PMl
 URI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:07 -0800
IronPort-SDR: WxYeXRGazjwyEXPSlIx/I+717PsBjxK4VHr8n5VrcVZ371TqXIetNxEf9yUqRg549m7A7HM/Y9
 nt+WbQrzCiBOSZAUxwaOK3/x3vjplV1SfRcKGwUWQTfQjZhqUG0eYFi2geLBCl5Xx6is5tQUli
 h7VUX02JffDY4zto7xcpKjN7Yk7tWtJdMKHKqR+cjDIUCs4Slmq5F8OZZ/ZmhlhoBfLXVJUblD
 V1vb1wyROgwbeGVbXbFFImauWCz70rS4Ho3TfzE/9N2z7JJfzS9DdA/sC2SY1Jg5JIPwFaracR
 Ap4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:45 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 07/13] btrfs: add raid stripe tree pretty printer
Date:   Wed, 15 Feb 2023 06:33:28 -0800
Message-Id: <2faac5aa69f3f74b33d3573084143485b5198971.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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

