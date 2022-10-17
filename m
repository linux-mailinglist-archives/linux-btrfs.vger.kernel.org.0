Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D1600E4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiJQLzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJQLzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF227DFA
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007742; x=1697543742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QwTr2YDafr/vlLux8dvXGGh9kFgdfwy+DSoCtaVbGuw=;
  b=Qc9ZpCvax6OFYu33FRP4np4HsJDGikPNNT00uvXC7SLbPbCU72BPzVRz
   PFrpynGQNClmjbVTDz9IVsPMoyGVJkqv5LC1tCINLOFo0OH688v19OMfI
   VqTEohJA60oXF6qSRLm0yi1/YmcDbvNDHGnA/+KkGBkkD7R/6T2vgHJlc
   ++Ll69AGEDacQJUo43y+kytZNQnJ2g2SKZhYGl+aWfHuLC/Fqs8L3Zu2s
   3nXSyITphUhBOJX6YL0YBVgm5hOKQ2oEIAVRm1cki8nBLgZtHiVtIz3ec
   dxlsuOdwR0s3PlX3con0nKf6Od5FSOJlqtT7kCNCGr912N0MNiJVadMSB
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337171"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:41 +0800
IronPort-SDR: 9sTjJgvAUL4yXtQosdPrEn12scpf2+SxL0k8dpHkUv3ngKYp/LzItnnSCIvBcPPR4cIer8JSrd
 +MDxy1QfONfh5mp90DZQt5nfCReCHSiKKeKYRLI1Gc8mP8aQREBYMPL5LPMy/394U9EwvSYmQq
 TVT5SJSWxuefQXWqeYleLa2GM/kYZyHG7C21D6Pj92mwlY1zfQgtjJKRFYga6Sj2J6PozGdxGt
 nu60uHwAaKhlsHwSI3xqdYKjBiezBxLBIES6lWKcc/RYdG4iKsBf6OCCldNJlp1hNPCyuGL/UJ
 KxUsUh+Jd+YvIyK0zVNqzAwV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:14 -0700
IronPort-SDR: al41+Wb5hXUiajWCNNN0f5WM1iiLGsyVb4l9IzZZ8XmNn4lwIWez7Hz12u/oyXgVWm4Eu0P6nc
 i8s/4vAmp5jjfTLNSDAHZpAjpz0auB2yiM6X+BQ1NJC6m3XxjiugEolEluImr7CXeMPUEVGmy6
 /bsrFNGp1tpA+79PUtG5JNJJX6HOKrsCTXrnkfrv7fZ9+WA7q8Seaf2gnJdrbn6gSu/xxZS7tw
 UOkbDek7s/dk9+o97OqMotGh9bW5Wtd5OmcfOgAHm4U2h0ajyYSjbmIB8UtCFvaDrGNjsD7cff
 ecY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 10/11] btrfs: check for leaks of ordered stripes on umount
Date:   Mon, 17 Oct 2022 04:55:28 -0700
Message-Id: <c939c2fdd361800a4361707bf9d5cc68e30e7907.1666007330.git.johannes.thumshirn@wdc.com>
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

Check if we're leaking any ordered stripes when unmounting a filesystem
with an stripe tree.

This check is gated behind CONFIG_BTRFS_DEBUG to not affect any production
type systems.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c          |  2 ++
 fs/btrfs/raid-stripe-tree.c | 29 +++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  1 +
 3 files changed, 32 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 190caabf5fb7..e479e9829c3e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -43,6 +43,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "subpage.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -1480,6 +1481,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
+	btrfs_check_ordered_stripe_leak(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 91e67600e01a..9a913c4cd44e 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -30,6 +30,35 @@ static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
 	return ordered_stripe_cmp(&stripe->logical, rbb);
 }
 
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info)
+{
+#ifdef CONFIG_BTRFS_DEBUG
+	struct rb_node *node;
+
+	if (!fs_info->stripe_root ||
+	    RB_EMPTY_ROOT(&fs_info->stripe_update_tree))
+		return;
+
+	mutex_lock(&fs_info->stripe_update_lock);
+	while ((node = rb_first_postorder(&fs_info->stripe_update_tree))
+	       != NULL) {
+		struct btrfs_ordered_stripe *stripe =
+			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+
+		mutex_unlock(&fs_info->stripe_update_lock);
+		btrfs_err(fs_info,
+			  "ordered_stripe [%llu, %llu] leaked, refcount=%d",
+			  stripe->logical, stripe->logical + stripe->num_bytes,
+			  refcount_read(&stripe->ref));
+		while (refcount_read(&stripe->ref) > 1)
+			btrfs_put_ordered_stripe(fs_info, stripe);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+		mutex_lock(&fs_info->stripe_update_lock);
+	}
+	mutex_unlock(&fs_info->stripe_update_lock);
+#endif
+}
+
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index d1885b428cd4..5ffb10bf219e 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -31,6 +31,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc);
 void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 					    struct btrfs_ordered_stripe *stripe);
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 						 u64 map_type)
-- 
2.37.3

