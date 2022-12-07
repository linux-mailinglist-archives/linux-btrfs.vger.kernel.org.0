Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0096E645C67
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLGOXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiLGOWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:36 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC5FE4
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422955; x=1701958955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6feXqmbRXKfzereRbANVntRtfNxaa3TC4t0I7icKBK8=;
  b=cAak6KkWAxBu29Y/4iNAG8jNsUIwjWBbaulBhjvzBUUnM8SJ2dvY0o8T
   299TsgRa0d9Z+TWvruJIn0ncuxpd+xWqPSWtu6C6vEgd/wQZuGVWg2xkk
   WKbn8ZpTcLo1p/NzbaBwdC9eRhxPxa/6YHTLMpsxUWaw6ZsGZa6Z+uFgM
   Vc9GhDm49s75OqPXHx2Ihh2hsY+RNRsgSjO7W42f2GCejtlve++I5nWRn
   iPFJItGZkN5Jxn+I7lgfK8IMv+0FAttdX07R3QHhGrDKU2Pp2ufb+3Cfu
   xw02RiQxwovX/ztul38buwVEjYBIaslA7Ewtk5PPDzLi0dkzka6AcKO98
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099492"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:34 +0800
IronPort-SDR: 3EJLUruJRmXx8a6fqd8UBqs4pSDvmCvqWMH3oV4ocU8jl8wG0Va4NB1pA13t4N0u9iZ89SqUNC
 yxK5fHHYn9U4pOUT19AD+Tk/aUAoOn8hUUM8xdho/A3LkNujHnhHbxINhGwNNfoxgP/h8K9uPI
 bB2NcDNJCTfPdbPtk9VKUvI874RtwSlC6zDfAdrVq/gJ8rlnI3WZ4UChYzs4TtVHv9i0Wuwehg
 2vQ4i3Kka86lyJ9xMKLsITZIHX9wC8UD2tXU9iGRcVkg9WanfbKS+0hvHBGPRq+kFJpctJSdis
 7lc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:20 -0800
IronPort-SDR: kwd1aPeHY0N2BoPfx5/7Tq5qjxucrZDcubUV+tm13b6Vc3Hw9k6gCfWCs9wUkATRLbV3JTVAHK
 qR9i3CWHeImNgdoY0TsKySmUR52iVXaKrhSYL/Xyo2SWyyWvWwf79crkAc1Aw59WG3BmKbs3fe
 CJvCjjI9WDIhyPCc2DuROmb808PvePCcsThJ5JUbuJv2ytDDZSwbR9YZkcwM8Nea0HtubWY7cj
 ry3PmW7/WH1u1qZBKgD3sAcBvWJl5OvASkgJ5aftgCleyDNebwQaCFGQnb+M0rY1y+lfI281C1
 RqM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:33 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 8/9] btrfs: check for leaks of ordered stripes on umount
Date:   Wed,  7 Dec 2022 06:22:17 -0800
Message-Id: <95ab3c07ec7c40d31cb1833c46c1d43d801c3138.1670422590.git.johannes.thumshirn@wdc.com>
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

Check if we're leaking any ordered stripes when unmounting a filesystem
with an stripe tree.

This check is gated behind CONFIG_BTRFS_DEBUG to not affect any production
type systems.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c          |  2 ++
 fs/btrfs/raid-stripe-tree.c | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/raid-stripe-tree.h |  1 +
 3 files changed, 33 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bdef4e2e4ea3..85c24d8b3bc8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,6 +52,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "raid-stripe-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -1528,6 +1529,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
+	btrfs_check_ordered_stripe_leak(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kfree(fs_info->subpage_info);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index c57dfe9f5c86..ed13b30001e0 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -36,6 +36,36 @@ static int ordered_stripe_less(struct rb_node *rba, const struct rb_node *rbb)
 	return ordered_stripe_cmp(&stripe->logical, rbb);
 }
 
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info)
+{
+#ifdef CONFIG_BTRFS_DEBUG
+	struct rb_node *node;
+
+	if (!btrfs_stripe_tree_root(fs_info) ||
+	    RB_EMPTY_ROOT(&fs_info->stripe_update_tree))
+		return;
+
+	WARN_ON_ONCE(1);
+	write_lock(&fs_info->stripe_update_lock);
+	while ((node = rb_first_postorder(&fs_info->stripe_update_tree))
+	       != NULL) {
+		struct btrfs_ordered_stripe *stripe =
+			rb_entry(node, struct btrfs_ordered_stripe, rb_node);
+
+		write_unlock(&fs_info->stripe_update_lock);
+		btrfs_err(fs_info,
+			  "ordered_stripe [%llu, %llu] leaked, refcount=%d",
+			  stripe->logical, stripe->logical + stripe->num_bytes,
+			  refcount_read(&stripe->ref));
+		while (refcount_read(&stripe->ref) > 1)
+			btrfs_put_ordered_stripe(fs_info, stripe);
+		btrfs_put_ordered_stripe(fs_info, stripe);
+		write_lock(&fs_info->stripe_update_lock);
+	}
+	write_unlock(&fs_info->stripe_update_lock);
+#endif
+}
+
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 73167c775f66..cf07f9c8bb9f 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -36,6 +36,7 @@ struct btrfs_ordered_stripe *btrfs_lookup_ordered_stripe(
 int btrfs_add_ordered_stripe(struct btrfs_io_context *bioc);
 void btrfs_put_ordered_stripe(struct btrfs_fs_info *fs_info,
 					    struct btrfs_ordered_stripe *stripe);
+void btrfs_check_ordered_stripe_leak(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 						 u64 map_type)
-- 
2.38.1

