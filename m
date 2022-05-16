Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4FD528714
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiEPOcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiEPOby (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:54 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417826127
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711512; x=1684247512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Su3JHLpizdjoIf6xF+rz+MdEM4xqxCp+FWNsJQq4uIk=;
  b=ovKry8EgXlPBwlLGLSw6WvL3JLQB+K3jc7LoEGrYwSF7UoB+/SRtMcjs
   WzX/3pTM+mkBe0DsGwgvsqcnmrqLPg5/FuYWKA5Dddkj72vDC2YoNBMOG
   TN3TuYbc4hgKTRskkxmvDWyMO6FfnxqnqAfFWgJV15VQ7/9jATI2UNGI/
   tO7LHXLkYAzMFklA1Ys1hHDZ8BlgXjgL3VA6P4S3dfoZLwcVf50SUrETI
   8fSuARJfTOjTzt5X9sp6gYoUu7AQSUhldFc/q86DEBIGN4uTcXcuPpyxM
   MtdHiezrUd9lj1gT0b+KV8GkuimPOOh4FaGwEZxiwX/B05XyNlfmp1TjF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309219"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:52 +0800
IronPort-SDR: g9QjzzNG7TeNyeOBPDXYSWdfHHUxKX5grvJvOTTKh83QCZaulInKWCPmXDjdDb8o3z/JTfeS/T
 dX5wGHaJW21wPadolc4/IQgk98BnTycGZkO1c9KEa22pPeca3Nhgk6SJqRRvZl+OShoE4Csm6S
 bd0UQ9+8QHjnacLBkNC0aHXLB3Ev/sakf1Z3ejNrEu32IDDgim4OUX4oJjeacsF25Lz4n/bLAb
 J8AjOZxZuB5Vh8MOOslEPWIKfmnOKy/b1861laaMV1UwdXpUnWPiu2jm0NgpSSoWPGfEvzizb5
 ft8M9FU0Wky94xpvvtkeTFAt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:34 -0700
IronPort-SDR: dg1EJxnVWBwvbGAFbzD4mhuBiiCjz8kGZQFuhLiBAMjC+08lZOEWLva6HtycT/2sqhrqF1Evk1
 TYUQJnlKEy3r1Mpata52NiTMtXdpTZmCriGx13HbsoAool0Tp9j3VeaojlUcP07nkyqAXZ+uGD
 5uSBLmRmjCalWEHx/VxabJKo2xwfO+kSe4wvTAcWXeaMo4vvug1VflufTqXpe5YNSOQULavxYf
 lfsrbEwJj2aO1DZXDR+50SE3KECqUz2MlQcEWscPBVOSJc7rXVwNzau2n+8bsP8efKjFG65yx4
 m78=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:52 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 8/8] btrfs: add raid stripe tree pretty printer
Date:   Mon, 16 May 2022 07:31:43 -0700
Message-Id: <40c1d1679ee4a847dfcd95eab797222a320da905.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..1ee06b511951 100644
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
+	num_stripes = btrfs_num_raid_stripes(item_size);
+
+	for (i = 0; i < num_stripes; i++)
+		pr_info("\t\t\tstripe %d devid %llu offset %llu\n", i,
+			btrfs_stripe_extent_devid_nr(eb, stripe, i),
+			btrfs_stripe_extent_offset_nr(eb, stripe, i));
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
2.35.1

