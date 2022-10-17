Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6F600E43
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJQLzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJQLzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8957C4D254
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007738; x=1697543738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k823U7GWnY2UFKJOyrEMfCA0sDZ3rRiSWmqcNjBhcC4=;
  b=rsNE4KMpZwRc8xVieweVEKLIM8LzmLhqfjNDJd4m/OfS+7GWxkDoUtpW
   KQj2Y9qx2li9sQmvz9Ubzpa6dFgss+snj19YgPR/9OBh98WvFAeCu4Hk5
   WvGoYMIMeyQvYVmz4Aulx2e3Au3d4Gn0NFqaHtQ+gmsZFyFBQYtwQCarw
   VliKdfzHl1DQR0GAg93D7GfH+INU7mhQqhUs8T6tOaP9CWrxmdiQn7abK
   hRaGEtfKgBwochdRm+mEsflnLU9ipBBb/wMbYXil8mwL90Q/T9s3zV5rk
   QTgc6FjUrjYv/JClDjiXo/jk85zwNgJ563TGnIMfGEJIuHuel7aZm0Ly+
   g==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337155"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:36 +0800
IronPort-SDR: zjjb86uNBivFq0ZMjjAyRfJKPglSBvNVMS4oTjyyg18+rT/S0A0/2AFjHyTImBYlzLVhwiAyj2
 qAfZYwHNknNPUhl9fKp4H0fvsDvdW++RL9W2uylNDXb93/br9XAkJ3kgYC9dktbCZWy6VLWAIF
 13jZQq9cLiSGPJ4QzOEv2pSU38JJxfErvvoSf2hAneQC61/iMR4Csc/HklX8hiz8f8LD63XdbD
 FeNX3YyV2zwZJsG9ibbdsyCKteoHxBIcfHmuNwjDlWBbKQ9KsvjyBlpKWBgOc4qrN5mAykerK+
 c6VTADc9k0MEGdTx8Wycs4Mz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:09 -0700
IronPort-SDR: m3JS3Wx08vn0tJyZMJrTVscrwH8rYPIU0MhkwIna/P8yaNJGp891Q9Z4TrCI+DJIOy3QJUM3pE
 AYfttwgbOb21b5MctwwKWwrky3k1I+29gzrLvo5kWDhyNGno4uXha9O2N4t8eB1B+Eip1RDRSi
 MuRjfHOnJGVgdie1LFV9TsD+DsxZ3Rd2Bo1nsrWx8WC4qaEMBi5h0V3hWoeiUnQoLZEEo0gDZE
 YQHVxNSSm/XJGxNw5uYXtAXiavoMGMY+RU+W0kisxjUYOKoaxEHE63k8kS7awGCZnKXDKFrcB4
 SMo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 02/11] btrfs: read raid-stripe-tree from disk
Date:   Mon, 17 Oct 2022 04:55:20 -0700
Message-Id: <578b525f70185756de6cccf4443c95d8dc262e0e.1666007330.git.johannes.thumshirn@wdc.com>
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

If we find a raid-stripe-tree on mount, read it from disk.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c       |  1 +
 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/disk-io.c         | 12 ++++++++++++
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 6ce704d3bdd2..6794443cb0e8 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -425,6 +425,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 80ead27299dc..430f224743a9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -680,6 +680,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7bb00a010c74..a166b2602c40 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1396,6 +1396,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 
 		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
 	}
+	if (objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->stripe_root) ?
+			fs_info->stripe_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1474,6 +1477,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2008,6 +2012,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2457,6 +2462,13 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
+	location.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+	root = btrfs_read_tree_root(tree_root, &location);
+	if (!IS_ERR(root)) {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->stripe_root = root;
+	}
+
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c413fca6f581..74508dee2878 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -316,6 +316,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.37.3

