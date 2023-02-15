Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43E3697E6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBOOeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBOOeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:34:03 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB71E5E4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471632; x=1708007632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Md7z+O++on9hq21DjFwROq/auSTZ1KSWoOE9rpq39CU=;
  b=dKzOmIZM0nOjM614Zhxb8hVG3qDebrIxx08atai/TZJ2+Z2jrxc5AcuX
   IJECy7ogLa1FZh77RxLDXQMOewJE4+BXO/u9qcaDd+ARbV0DYv0plgJ0s
   PYgcn8uVBxE9BZZsmHb6Z3j9YRZbZwQpzB8OvMHiBtBiUWHlt1O4t6kSn
   ifVhgfQ9bIfLzM2i4uCHMuSays2qUuVnykZ4RyFc/MfoEnhvIVdekqwnT
   HEdfV3Ra8kViw5mQGnXA7PlzFdbNY33hoJm8SiIFaiDfTPrlPh5o4xYhS
   IL+hAW9HU2Vp5XsOVoQkVSNWaXJrPQ3YID/D3hSIrmGnttsTBWzgupUx4
   A==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394065"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:42 +0800
IronPort-SDR: 9ih6JRlMWys++pUpl0SMpaqC6UC9VVMhiNgSAiaMGJ1LdwgnSstSuRFfYUtBqimTHGctx7jAPa
 6/8LpHpnqWoziCW+CQ4vv4q2nsntcR2QlQNs/LW+kOPgKKkXdU+zk+bG75NJIrxWH/ixmdmq9V
 Yl5TqATqgfqtupltBj46NqR/EH8q0MIAfTxtFfbhl/qS5GMEDXCTPwGYpvD/D/wTH3A+7NdvQP
 EH/NjjcVPRvQalv3hUaxQGS+eNYQ058+8iW8MwzdVQZclC0hPIo8UFwjxdw8dgfPFhh8HemuCt
 AEs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:04 -0800
IronPort-SDR: g+zmDj3jHb1EfxnqgR+oJUv+Iowj6OMzM6mWRYWHJVFHflSSQkqzAkBY1PSHkyy2+/gJRufi84
 s1pep7tU8lD2HMp3shlJPXBgxI7d+XSn7NPDkRDNpmhwd08LCKGa6TCsctQ4X3ZLzmw4tPs8wL
 9svAEG47gHE2NRNs14G79KI7xgFqZ2VaqYVPgbjcO8f0tPbOlsfzMv7ygTtpLK8BmBebSTPwx4
 LUEHKSUPyr4bMg8ET2JR0M4H3j6ByjCWgSKLSnyx1qjmJQwxs4P6yISsD9lnKvC8fZZkx8rgum
 oXA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:42 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 03/13] btrfs: read raid-stripe-tree from disk
Date:   Wed, 15 Feb 2023 06:33:24 -0800
Message-Id: <9e67acf1f844749ff72e25c8e9ac99b76b126b12.1676470614.git.johannes.thumshirn@wdc.com>
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

If we find a raid-stripe-tree on mount, read it from disk.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
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
index b53f0e30ce2b..32d4b2c4a107 100644
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
@@ -2503,6 +2508,20 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
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

