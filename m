Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75CF600E4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJQLzq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJQLzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:41 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA64E40E
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007740; x=1697543740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJk2w/eXaKUKwsaTLp1KsGm2AQ02EBWBtnYP5LkgHqY=;
  b=O37zJjafEweNC3/E+LuHnQNUjpCMFrCCdYBqDPwktOH6X3lg3zlDhrAc
   tuCHJJ1AFrS7dozrhgX5wLhezXbW88b3f1O2o7H5tSh25pfct8Lqy3IMl
   hgNjzJv+TLp/SKQl6p2bpZ6TApZIXYZbH04G42JmL03MaJ3+aP7vdV9Mj
   dVGpPJIXbM3UELHjxqe4jPk6T/MR210tUeHZDZz7vbZB86pI81jwjnE5X
   o5OIjTVKikOSHFNTWdkQK2uR0fhTfWqUN0q3zTqp8AhmZ5HvlKJiCZDBg
   4vr3agrZ3IJSrCzHFjbHqGP5m/pUM2oGj3ICJXxBp3Jnxi+IfK1EXo8No
   w==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337162"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:39 +0800
IronPort-SDR: VlgzzNA5uHvNXUGLp/zWYXk/G670gSJMhmpkh/o3Pi8+h+VuJIosQYdfjfOiCjRhcQWkQgiXA/
 HL1cdMMvctRMp37vzJIMxuMg8AHTtiDfC5jv2Sz7RFPKXuR+o/eye7fVm1hjeMZgaRnyrXT3Qp
 ZRq14taa9e26OSDVJg8F28eztQ8FtYE4iqQMEzaMDTBIdiklA7mbr4Gp9k16EDNVw/pxF1cYKU
 6YoaU9W6C4WZTYsmFvl9Eadvrey3FlfhlkjiswLpcBEorwwnm9I0tt5ZcOsx6C+XmlN6fbsN36
 hkXEeoB+FPWT8366z+jWyUUp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:12 -0700
IronPort-SDR: csKLicCDmhC03tLyxsX1zw3tS44Bz5fOR73rMCK2fp4O6zga8G9AeYauBHfoVAFZDNcoFN4S9+
 6m61nlmHiXwLvSgxsFyUs3vUNFLnzj2JN0AduF/UY6/fgCMadS68rZxJX7EKfOHHaArfCXuPRP
 qAYGiSP39eKPMIbgJZun4IPsJnmjP6AbpGukXKbW6ilMGeMwWm3Cv0DotY1h2I94wlk0akkesp
 0YT324w1zevScxJudO26uTRC98NPrUfSfr3ov1ftzv+P8M8Nnx8/GeuU+enRlGei9FXujNnJAi
 bmE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 06/11] btrfs: add raid stripe tree pretty printer
Date:   Mon, 17 Oct 2022 04:55:24 -0700
Message-Id: <5574796b1656045504f2d5c52bab4e85fb9d1b8d.1666007330.git.johannes.thumshirn@wdc.com>
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..1c781a30fd60 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -6,6 +6,7 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "print-tree.h"
+#include "raid-stripe-tree.h"
 
 struct root_name_map {
 	u64 id;
@@ -25,6 +26,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
+	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
 };
 
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
@@ -184,6 +186,20 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 	}
 }
 
+static void print_raid_stripe_key(struct extent_buffer *eb, u32 item_size,
+				  struct btrfs_dp_stripe *stripe)
+{
+	int num_stripes;
+	int i;
+
+	num_stripes = item_size / sizeof(struct btrfs_stripe_extent);
+
+	for (i = 0; i < num_stripes; i++)
+		pr_info("\t\t\tstripe %d devid %llu physical %llu\n", i,
+			btrfs_stripe_extent_devid_nr(eb, stripe, i),
+			btrfs_stripe_extent_physical_nr(eb, stripe, i));
+}
+
 /*
  * Helper to output refs and locking status of extent buffer.  Useful to debug
  * race condition related problems.
@@ -348,6 +364,11 @@ void btrfs_print_leaf(struct extent_buffer *l)
 			print_uuid_item(l, btrfs_item_ptr_offset(l, i),
 					btrfs_item_size(l, i));
 			break;
+		case BTRFS_RAID_STRIPE_KEY:
+			print_raid_stripe_key(l, btrfs_item_size(l, i),
+					      btrfs_item_ptr(l, i,
+							     struct btrfs_dp_stripe));
+			break;
 		}
 	}
 }
-- 
2.37.3

