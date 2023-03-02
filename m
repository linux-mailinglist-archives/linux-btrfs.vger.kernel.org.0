Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92B6A7E5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCBJqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCBJqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:46:11 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B563D084
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750354; x=1709286354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=033sDHFu6R7zD4a7zJ1WuhelqYgIg3KNs4tJ9+KlXNU=;
  b=YbxFqEbG0Ujn/CPvzQ2qYd34gOhBFuulj0who7AB8OJUlbXKa9VOBada
   DWUp0MTF68ea8fSs8/vzC2aEzkCoqabcQxxGxH8QRoJuazuooPEJ5UIM6
   TCEs+O5b4Q6HYW0EON6yfxxksjVKxC3VD/3h3rqrc3xtokOpJlUkS10qW
   isRjStzPNishZZi2IZKNpjPLGQISm8CWyURpfiOTKh9sGvuxi1Ne/2RNS
   cRBrbmXQFokOofbrZ1N2Y8KTYag2WrVhd/xV4oB2FyFA/uQzchcqlnqbd
   LXqPO3I2T8UaGhtlR44uknjK/uiHJdeY32Cxuve8g4KPoVURx6pbUw42w
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:41 +0800
IronPort-SDR: cYjhM8LkeEM4F/OvGDvghXZtnhtJar3+02nX5/OO5kMhYINnivVQsvW+qRpJY8yCq9Ylx4ccah
 IauOaAx2H0FZyBeSWkREYPiwhTK/6xT/aNiK1/CvRcYZNvoSVYRBzMnyd1NRTSGH+tJe3DOcLM
 /M8gER95wmPriJj4OBQ+CvMQS/xsQN1Hzppn6sYruI/vlBOFUYmYbMaV6k0yYnMITVZr7OIRgo
 7qZSKJX6lhwyn0p+TacIy9wTbVxg6HwOEI4bYKSiOkk/RyLqU8+0bQtoBwdwSFTheXr2mUjCDY
 XT8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:46 -0800
IronPort-SDR: i6YxaM4ZxOlRzSBtGd5uQiHXaezK9ERsqi/VWvEjDepfEsAEST0cCOvvNUED7c+VQkPYSzmacg
 RSEGggsc0r+RDrr8ZCOqJCVG80POuxVty3IAZ8FJgn3EalMu3HqI3jfvaTUg7053TIWeR2KLiW
 MPIP4is5tufFkMUROYnSIbuR23LM/OEopDWz++X4PcAq3eGm8oNoS4j/Z7+Twkr2LVvBtDX617
 hiN9/cSdpOYD0oPGcOsO1UfJm2zmuapNRSER22Zy4Ve0tnCsWLBZsQ9mT40IoKahPHSW6PiSG9
 9W8=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:41 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v7 03/13] btrfs: read raid-stripe-tree from disk
Date:   Thu,  2 Mar 2023 01:45:25 -0800
Message-Id: <0934ca7511d7e3fbfc90bb8174e298cb42b008f2.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c       |  1 +
 fs/btrfs/disk-io.c         | 22 ++++++++++++++++++++++
 fs/btrfs/disk-io.h         |  5 +++++
 fs/btrfs/fs.h              |  4 ++++
 include/uapi/linux/btrfs.h |  1 +
 5 files changed, 33 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 5367a14d44d2..384987343a64 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -402,6 +402,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e0c30fe6df6..ac200b367ec8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1438,6 +1438,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 
 		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
 	}
+	if (objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->stripe_root) ?
+			fs_info->stripe_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1516,6 +1519,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2051,6 +2055,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2512,6 +2517,20 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		location.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->stripe_root = root;
+		}
+	}
+
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
@@ -3020,6 +3039,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
+
+	rwlock_init(&fs_info->stripe_update_lock);
+	fs_info->stripe_update_tree = RB_ROOT;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4d5772330110..c4de38374b62 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -107,6 +107,11 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 	return NULL;
 }
 
+static inline struct btrfs_root *btrfs_stripe_tree_root(struct btrfs_fs_info *fs_info)
+{
+	return fs_info->stripe_root;
+}
+
 void btrfs_put_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4c477eae6891..d0d80540b32b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -367,6 +367,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
@@ -790,6 +791,9 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
 
+	rwlock_t stripe_update_lock;
+	struct rb_root stripe_update_tree;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index ada0a489bf2b..df7b60483642 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -332,6 +332,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.39.1

