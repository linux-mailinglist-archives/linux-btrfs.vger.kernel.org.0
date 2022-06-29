Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42EC560359
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiF2Olf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiF2Olc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 10:41:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFD39148
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656513691; x=1688049691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmW9eaWEWURaAWpxdVDrx0yLNbWXZ5OjFLUdIZkTrHU=;
  b=GsVZxVRfPbtnFcv4Ve8I/2M06nHG0GFwkiXRf9f6N5BbS86Y+/TGlyyv
   QrND2yey5wdewHSXIQHiF9tLiUbgtZUApcKJRkJhcgdU+AWdQ/x1K4pQc
   a6eezxynapMGIUFVjwu0DpDQ+zKHxbXIwg/KSAQqgJCF4XtmRMT24iKrD
   V7PnhoCu43d6gw3uEzvdGiOfAchZZoDuuk9foOf/sUOhFleilsC6fq2H4
   MgiQUVYfum5yvCUf/fH6TBeXj+VFODMSOGFr2f2ht8YkISq6ik4v419Ib
   ElbxBz67eWSQdkEgNsd/CCok6sf7RJ9IvrNY77bRtm7cpsdCMK2MahXge
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="203064905"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 22:41:31 +0800
IronPort-SDR: NlMHzXvtPuKZxJUcAvM9xdpL9S4eCnO0COLhbSJtfQbtHT5HX5ceS+4SbkZdW5+1egMBnwU8rU
 3Lylc7HwfJc61Gqb6Zx2ivBX3bNJBxfPLwCZTonZ5oWklKmOIv+3Zwaf2KM6ghjpxWyoULq+Z+
 wHZuV2n2IdpvW8M/y+yTsTmn5YjQJQoqTt6OCKFeRcWwe3ltie/kt7ZdEiBs9AyWzzstz4Gahr
 zP30cTEys6eXcTDTLZj4i6w0UpLag48M+HUymlEWChd81FVfBi2ZDWLW/lkWMmss9Ju7lhuwbH
 uOkwNcbIvlhHGVTNVkZmm5xI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 06:59:09 -0700
IronPort-SDR: kZeYM2OML04M4vgZ99e2c08eGrvHwPkw3Kc/9VY0BKq2EeVQduDKsAsYEiNb/bB2efYXn4Z3fc
 cUsp6BqKTnLLhwvSGjHcm/5pDO3U3odRcLy3sXooN5C2kCAoqG6/3h4yfznnNXv4tgydjgAElU
 z4OAk5K9/N4eiFyF1Qq4DXsmVhVgdDrB/nB5lxZvRuNBSUgwjrB+4NM1S5Yf5Ar8y1JNwWH5Vt
 Zgz4s8TZt4QAKH7t6Tv9/UTUR6b3G8TkNEcpqHYwUhPuMPsP4CYUuvuZdI9Hcm5siZwQcegXpl
 tZ0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2022 07:41:30 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC v2 8/8] btrfs: add raid stripe tree pretty printer
Date:   Wed, 29 Jun 2022 07:41:14 -0700
Message-Id: <62ec7adca017d2e9081cf053f00ed55fb3468143.1656513331.git.johannes.thumshirn@wdc.com>
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

Decode raid-stripe-tree entries on btrfs_print_tree().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/print-tree.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..10a39d5a7e40 100644
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
2.35.3

