Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039F7A0A41
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbjINQFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjINQFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:05:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042361BDD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707544; x=1726243544;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8l6KkYM203DFih2M1SwkGYZVANo7hCju5ir8jwjt/Io=;
  b=Ss5ff0DdAbpb22WOKTpw5GbeHZ3R8oWnT1ANgly60aKOS+nFYMZfDSCu
   UTyWXTnLgNqeN1QwbQaH7UMlaW4Ww4E4Z0LFo4log72Hm0r7y2oi5QFm8
   IivSbt15uf0JdstIrZ6kifdIv0SyBzzsF4xZyM5lIeHG3cC1vJaHgj7rx
   r3s322hV6WYBA/vuqLp2Am/gx+qJ7vkg7gM/3S2g1fIlBvLB44q/Av4J8
   NMLHoT5FH2SUJSTcEOsLkVAraZygtLujh6l+E5Gw3WL1/HctBGAeF6tFC
   bljLxDtybqrj0u52JOhelPgjhJ+7k+fHYrdxlW+jkWrw589sa1055lWl+
   g==;
X-CSE-ConnectionGUID: QkHT+gIIQX2eR96KblqWCA==
X-CSE-MsgGUID: 9e8ye/yISo28qw/xlgFEcA==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="242196082"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:05:42 +0800
IronPort-SDR: f5xeKcma3OJ95KXDukHkIjfmkDN/lJ/YzHbym1XIqDKPLYZ3f7SXEQhZthRr/9AvIt3pj51G3e
 WqKuDxg49F9lC23NXaN585c1g14cmQFCo9Z8BuYiBut13pmc/v2M3d0yDGBxtzWYf2EOGUybhf
 sFVZnIO9truSW7z5u2JLQwx0DfbkjaPVY+Me+8+P5siCjAJqYcSSJk6jPNWiCR3SvxR9N5wfJn
 +7TUEJFgIpIA+49i+gCt3r9bBY6z8trHN/GyMI+mK3YXpQuUQvZc/+7LDodZNhsVTyWg50szXV
 d2g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:18:25 -0700
IronPort-SDR: +uHHR4y7Cae5QU772a4/1WH2PvLsKr31XBa3K+ANIyorKuAUQw8CsiUlDmcMS+o2nMAnjRd+mI
 5ABNvJK3EUxdS5ntD1WwzZQm6kSFsCZoLx2GtoURHA0jrv7oKGaJ8F6BDTCFH4YB4tBQuWWg9g
 ZASK9I8MYIxb7cjmQlictH3sm/3Lc05+YUiztCfRY29qcwhMndnGslkHdJQVNp5APkDvcT40Tp
 QLg/gDFN9M3PrwN2hyjAhYYHRW/LqiJT7h3x9uYh0Hwtd258vrPfj9QoGxagb/60GUXDyOGyM9
 hJ4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:05:43 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:05:33 -0700
Subject: [PATCH v4 2/6] btrfs-progs: read fs with stripe tree from disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v4-2-c921c15ec052@wdc.com>
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707540; l=5277;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=8l6KkYM203DFih2M1SwkGYZVANo7hCju5ir8jwjt/Io=;
 b=Q3WwvKrYEBGpTH2x5RK20S6jEZe0Uox0ogXmYYeRw8nRk3MGB8IM4YIgjS0zSBMNMO5tndItI
 XeiqD3YeV2dDenuaM6VJehZuetX7s4TYsSQNNBquL5l+fRy6XYkOHo3
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When encountering a filesystem formatted with the raid stripe tree
feature, read it from disk.

Also add the incompat declaration to the tree printer.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/ctree.h           |  1 +
 kernel-shared/disk-io.c         | 28 +++++++++++++++++++++++++++-
 kernel-shared/print-tree.c      |  1 +
 kernel-shared/uapi/btrfs.h      |  1 +
 kernel-shared/uapi/btrfs_tree.h |  3 +++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 5d3392ae82a6..035358436d8f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -298,6 +298,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	struct rb_root global_roots_tree;
 	struct rb_root fs_root_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 442d3af8bc01..3ab32f7ad910 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -790,6 +790,10 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->block_group_root ? fs_info->block_group_root :
 						ERR_PTR(-ENOENT);
 
+	if (location->objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return fs_info->stripe_root ? fs_info->stripe_root :
+			ERR_PTR(-ENOENT);
+
 	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
 	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
@@ -822,6 +826,9 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	if (fs_info->quota_root)
 		free(fs_info->quota_root);
 
+	if (fs_info->stripe_root)
+		free(fs_info->stripe_root);
+
 	free_global_roots_tree(&fs_info->global_roots_tree);
 	free(fs_info->tree_root);
 	free(fs_info->chunk_root);
@@ -846,12 +853,14 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->dev_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->quota_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->uuid_root = calloc(1, sizeof(struct btrfs_root));
+	fs_info->stripe_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->block_group_root = calloc(1, sizeof(struct btrfs_root));
 	fs_info->super_copy = calloc(1, BTRFS_SUPER_INFO_SIZE);
 
 	if (!fs_info->tree_root || !fs_info->chunk_root || !fs_info->dev_root ||
 	    !fs_info->quota_root || !fs_info->uuid_root ||
-	    !fs_info->block_group_root || !fs_info->super_copy)
+	    !fs_info->block_group_root || !fs_info->super_copy ||
+	    !fs_info->stripe_root)
 		goto free_all;
 
 	extent_buffer_init_cache(fs_info);
@@ -1260,6 +1269,21 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 			return -EIO;
 	}
 
+#if EXPERIMENTAL
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		ret = btrfs_find_and_setup_root(root, fs_info,
+						BTRFS_RAID_STRIPE_TREE_OBJECTID,
+						fs_info->stripe_root);
+		if (ret) {
+			free(fs_info->stripe_root);
+			fs_info->stripe_root = NULL;
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY,
+				&fs_info->stripe_root->state);
+		}
+	}
+#endif
+
 	if (maybe_load_block_groups(fs_info, flags)) {
 		ret = btrfs_read_block_groups(fs_info);
 		/*
@@ -1317,6 +1341,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(fs_info->chunk_root->node);
 	if (fs_info->uuid_root)
 		free_extent_buffer(fs_info->uuid_root->node);
+	if (fs_info->stripe_root)
+		free_extent_buffer(fs_info->stripe_root->node);
 }
 
 static void free_map_lookup(struct cache_extent *ce)
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..3eff82b364ef 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1708,6 +1708,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
+	DEF_INCOMPAT_FLAG_ENTRY(RAID_STRIPE_TREE),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 85b04f89a2a9..c750b7aa921f 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -356,6 +356,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE (1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 73411a8697ce..b76b1660f38b 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -73,6 +73,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* holds raid stripe entries */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 

-- 
2.41.0

