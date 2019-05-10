Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6637E19C51
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfEJLQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:16:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727301AbfEJLP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52D83AF98
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 12/17] btrfs: add boilerplate code for directly including the crypto framework
Date:   Fri, 10 May 2019 13:15:42 +0200
Message-Id: <20190510111547.15310-13-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add boilerplate code for directly including the crypto framework.

This helps us flipping the switch for new algorithms.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.h   | 11 +++++++++++
 fs/btrfs/disk-io.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e62934fb8748..8733c55ed686 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -73,6 +73,7 @@ struct btrfs_ref;
 
 /* four bytes for CRC32 */
 static const int btrfs_csum_sizes[] = { 4 };
+static char *btrfs_csum_names[] = { "crc32c" };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
 
@@ -1165,6 +1166,8 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+	struct crypto_shash *csum_shash;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
@@ -2452,6 +2455,14 @@ static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
 	return btrfs_csum_sizes[t];
 }
 
+static inline char *btrfs_super_csum_name(const struct btrfs_super_block *s)
+{
+	u16 t = btrfs_super_csum_type(s);
+	/*
+	 * csum type is validated at mount time
+	 */
+	return btrfs_csum_names[t];
+}
 
 /*
  * The leaf data grows from end-to-front in the node.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21ae9daf52b7..d57adf3eaa85 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -19,6 +19,7 @@
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
+#include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -2261,6 +2262,30 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info,
+				struct btrfs_super_block *sb)
+{
+	struct crypto_shash *csum_shash;
+	const char *csum_name = btrfs_super_csum_name(sb);
+
+	csum_shash = crypto_alloc_shash(csum_name, 0, 0);
+
+	if (IS_ERR(csum_shash)) {
+		btrfs_err(fs_info, "error allocating %s hash for checksum\n",
+			  csum_name);
+		return PTR_ERR(csum_shash);
+	}
+
+	fs_info->csum_shash = csum_shash;
+
+	return 0;
+}
+
+static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
+{
+	crypto_free_shash(fs_info->csum_shash);
+}
+
 static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 			    struct btrfs_fs_devices *fs_devices)
 {
@@ -2819,6 +2844,14 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
+
+	ret = btrfs_init_csum_hash(fs_info, (struct btrfs_super_block *)
+							   bh->b_data);
+	if (ret) {
+		err = ret;
+		goto fail_alloc;
+	}
+
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
@@ -2827,7 +2860,7 @@ int open_ctree(struct super_block *sb,
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		err = -EINVAL;
 		brelse(bh);
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	/*
@@ -2864,11 +2897,11 @@ int open_ctree(struct super_block *sb,
 	if (ret) {
 		btrfs_err(fs_info, "superblock contains fatal errors");
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	if (!btrfs_super_root(disk_super))
-		goto fail_alloc;
+		goto fail_csum;
 
 	/* check FS state, whether FS is broken. */
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
@@ -2890,7 +2923,7 @@ int open_ctree(struct super_block *sb,
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
@@ -2900,7 +2933,7 @@ int open_ctree(struct super_block *sb,
 		    "cannot mount because of unsupported optional features (%llx)",
 		    features);
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	features = btrfs_super_incompat_flags(disk_super);
@@ -2944,7 +2977,7 @@ int open_ctree(struct super_block *sb,
 		btrfs_err(fs_info,
 "unequal nodesize/sectorsize (%u != %u) are not allowed for mixed block groups",
 			nodesize, sectorsize);
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	/*
@@ -2960,7 +2993,7 @@ int open_ctree(struct super_block *sb,
 	"cannot mount read-write because of unsupported optional features (%llx)",
 		       features);
 		err = -EINVAL;
-		goto fail_alloc;
+		goto fail_csum;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
@@ -3338,6 +3371,8 @@ int open_ctree(struct super_block *sb,
 fail_sb_buffer:
 	btrfs_stop_all_workers(fs_info);
 	btrfs_free_block_groups(fs_info);
+fail_csum:
+	btrfs_free_csum_hash(fs_info);
 fail_alloc:
 fail_iput:
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
-- 
2.16.4

