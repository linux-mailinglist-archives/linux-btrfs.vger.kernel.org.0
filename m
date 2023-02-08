Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE768ED66
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBHK6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHK57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:57:59 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855991350D
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853878; x=1707389878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRTeDJlDGNPZe4rmP93nfwwO1wDLXDmBxBioaGPke5Y=;
  b=nF19k6z4wSyGqsTwu9EmNH1LUN3b+Z6GFVllTkAfL06aZjFSgrc4u/tn
   3Jys3dIzAQnlXFHC0JPEFy70QypRw2RO0jcQUWttLa9aUK3Rli6RpjGlX
   sltSNo0zMUeVchdlMBwk6WLsj4bKHsGmJHO/EI0jk+pZ3ljJg1lbj6Fsw
   tsZB8xMQhTnuP0LxuSXpisI+pJFT6o1EgczK+2KGgmxVkI5C283hQRFT+
   kaGaxgLDzfTOW2/uSF5sq05n9PyOZjquTpFUzfIZsDC+iTwVFy7S6qERx
   zQGGLx/4EftslqCempnPFs4bhFDm8c6b58h0hAlWk2+v4PJKZxSCEE0KP
   g==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115628"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:57:57 +0800
IronPort-SDR: Jxk7W65zNm+qGEr3nZ03SwZbTxO6wQAR0ymv1hpq2Pf663n7c3OEybX6hLtkENOfXogum9yWcf
 c1Hzil8UL9Klp5+IpK3GBmfF2XSbxUCj7Lg2qiOex0CUT4KcOWZe0RWE4e+R20nGlJkYLXLcsU
 pgxBA532gijAy16FyDU/VKdrX18Cpt6BO/cdZqQAA8hakP6ADvezeWzabykpp7liuzdqKZbjqF
 7SISxFpIhze/ep09aCaBnReMkD335Hp/ThMWL6hFQmPouQeiEzLVe7IlhBiLZaslxsM/iPhn8Q
 Pu0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:13 -0800
IronPort-SDR: Nm/QL7lvzU3Yg+YbQCRySYApoGsVH7oc8fT4nwbwzM6S4XGQ9sWZWWQWPHvl1wIWqc0Hc7T2i8
 AjK6ZAi2fDB//M3JMPFxp+7VOR1zKL//Xilg+Bct9XWadyQZwLpMbQVl/uiXtRr2cfuD9uiY0x
 4pjRvb7O0hrKVKpuh4oiOx5utFbaVHSa1HhVG0U3fmJqxhvVOyVdHHDskJSyS/tlvHBnrfy0mG
 fQ9UtLkzzqPJ4/isC347Gr2Zv6wxXND3F1B4iTydaunjit41t2TUGy08c4sJl6ANax9eAH8MdA
 HrU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:57:58 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 03/13] btrfs: read raid-stripe-tree from disk
Date:   Wed,  8 Feb 2023 02:57:40 -0800
Message-Id: <5898b85677c784bf6af4e3a18d61bf261af3141a.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/disk-io.c         | 19 +++++++++++++++++++
 fs/btrfs/disk-io.h         |  5 +++++
 fs/btrfs/fs.h              |  1 +
 include/uapi/linux/btrfs.h |  1 +
 5 files changed, 27 insertions(+)

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
index 0da0bde347e5..ad64a79d052a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1454,6 +1454,9 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 
 		return btrfs_grab_root(root) ? root : ERR_PTR(-ENOENT);
 	}
+	if (objectid == BTRFS_RAID_STRIPE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->stripe_root) ?
+			fs_info->stripe_root : ERR_PTR(-ENOENT);
 	return NULL;
 }
 
@@ -1532,6 +1535,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2067,6 +2071,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2519,6 +2524,20 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 3b53fc29a858..a85a8922c3fd 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -106,6 +106,11 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
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
index 4c477eae6891..93f2499a9c5b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -367,6 +367,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b4f0f9531119..593fb7930a37 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -322,6 +322,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.39.0

