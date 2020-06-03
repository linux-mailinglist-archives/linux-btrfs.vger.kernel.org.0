Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5172D1EC919
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFCF4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgFCF4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:56:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7B76B013;
        Wed,  3 Jun 2020 05:56:02 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 37/46] btrfs: Make btrfs_qgroup_reserve_data take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:37 +0300
Message-Id: <20200603055546.3889-38-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only a single use of vfs_inode in a tracepoint so let's take btrfs_inode
directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/file.c           |  7 ++++---
 fs/btrfs/qgroup.c         | 10 +++++-----
 fs/btrfs/qgroup.h         |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 0ee25dde18d3..212dd9648b87 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -253,7 +253,7 @@ int btrfs_check_data_free_space(struct inode *inode,
 		return ret;

 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
-	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
+	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), reserved, start, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space_noquota(inode, start, len);
 	else
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index cd1bfd571749..2b3e935baabc 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3189,7 +3189,7 @@ static int btrfs_zero_range(struct inode *inode,
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
-		ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
+		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret)
 			goto out;
@@ -3363,8 +3363,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 				free_extent_map(em);
 				break;
 			}
-			ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
-					cur_offset, last_byte - cur_offset);
+			ret = btrfs_qgroup_reserve_data(BTRFS_I(inode),
+					&data_reserved, cur_offset,
+					last_byte - cur_offset);
 			if (ret < 0) {
 				cur_offset = last_byte;
 				free_extent_map(em);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c884f3ec89a0..e5fab553afb7 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3392,11 +3392,11 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
  *       same @reserved, caller must ensure when error happens it's OK
  *       to free *ALL* reserved space.
  */
-int btrfs_qgroup_reserve_data(struct inode *inode,
+int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved_ret, u64 start,
 			u64 len)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
 	struct extent_changeset *reserved;
@@ -3419,12 +3419,12 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 	reserved = *reserved_ret;
 	/* Record already reserved space */
 	orig_reserved = reserved->bytes_changed;
-	ret = set_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
+	ret = set_record_extent_bits(&inode->io_tree, start,
 			start + len -1, EXTENT_QGROUP_RESERVED, reserved);

 	/* Newly reserved space */
 	to_reserve = reserved->bytes_changed - orig_reserved;
-	trace_btrfs_qgroup_reserve_data(inode, start, len,
+	trace_btrfs_qgroup_reserve_data(&inode->vfs_inode, start, len,
 					to_reserve, QGROUP_RESERVE);
 	if (ret < 0)
 		goto cleanup;
@@ -3438,7 +3438,7 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 	/* cleanup *ALL* already reserved ranges */
 	ULIST_ITER_INIT(&uiter);
 	while ((unode = ulist_next(&reserved->range_changed, &uiter)))
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, unode->val,
+		clear_extent_bit(&inode->io_tree, unode->val,
 				 unode->aux, EXTENT_QGROUP_RESERVED, 0, 0, NULL);
 	/* Also free data bytes of already reserved one */
 	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid,
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 139cad24a95d..a22a1d3dae25 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -344,7 +344,7 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 #endif

 /* New io_tree based accurate qgroup reserve API */
-int btrfs_qgroup_reserve_data(struct inode *inode,
+int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
 int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len);
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
--
2.17.1

