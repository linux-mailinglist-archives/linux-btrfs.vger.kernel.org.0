Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62447EBD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Dec 2021 06:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351412AbhLXFum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Dec 2021 00:50:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbhLXFum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Dec 2021 00:50:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 323AE2112B
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640325041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VR7jTqS1RQfSq0LM7t7Ex8w78yWY5ghPeMWphEdnMhI=;
        b=b4U79aN+YhnYOzjsY1bnoLOx6y+Sy2RE8ohc9yYcoC0lJ+MnJF+k9ABXHD06Ask1px2CtQ
        LGohuS/ik00QKYjOjewc8SoJGFosEaXbylpdE2k+vSakBQ3SiWG43lX8B4ajUevv4u6Cqf
        EUbb/AHQsMZ4sT9kPvNavX/wUXhyYik=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77F3013A97
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CPSFD7BfxWGCGQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs-progs: check: don't calculate csum for preallocated file extents
Date:   Fri, 24 Dec 2021 13:50:17 +0800
Message-Id: <20211224055019.51555-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211224055019.51555-1-wqu@suse.com>
References: <20211224055019.51555-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
If a btrfs filesystem has preallocated file extents, `btrfs check
--init-csum-tree` will create csum item for preallocated extents, and
cause error:

  # mkfs.btrfs -f test.img
  # mount test.img /mnt/btrfs
  # fallocate -l 32K /mnt/btrfs/file
  # umount /mnt/btrfs
  # btrfs check --init-csum-tree --force test.img
  ...
  [4/7] checking fs roots
  root 5 inode 257 errors 800, odd csum item
  ERROR: errors found in fs roots
  found 376832 bytes used, error(s) found

And the csum tree is not empty, containing csum for the preallocated
extent:

  $ btrfs ins dump-tree -t csum test.img
  btrfs-progs v5.15.1
  checksum tree key (CSUM_TREE ROOT_ITEM 0)
  leaf 30408704 items 1 free space 16226 generation 9 owner CSUM_TREE
  leaf 30408704 flags 0x1(WRITTEN) backref revision 1
  fs uuid ecc79835-5611-4609-b985-e4ccd6f15b54
  chunk uuid b1c75553-5b82-4aa6-bbbe-e7f50643b1a8
  	item 0 key (EXTENT_CSUM EXTENT_CSUM 13631488) itemoff 16251 itemsize 32
  		range start 13631488 end 13664256 length 32768

[CAUSE]
For `--init-csum-tree` alone, we will use extent tree to iterate each
data extent, and calcluate csum for them.

But extent items alone can not tell us if the file extent belongs to a
NODATASUM inode, nor if it's preallocated.

Thus we create csums for those data extents, and cause the problem.

[FIX]
Fix it by iterate all inode items and file extent items to skip the
following cases:

- Inodes with NODATASUM flags
- Preallocated/hole file extents

Issue: #430
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 103 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 299d66d644e7..dd0b1d695bfa 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -22,6 +22,7 @@
 #include "common/utils.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/backref.h"
 #include "common/repair.h"
 #include "check/mode-common.h"
 
@@ -1338,14 +1339,99 @@ out:
 	return ret;
 }
 
+static int fill_csum_for_file_extent(u64 ino, u64 offset, u64 rootid, void *ctx)
+{
+	struct btrfs_trans_handle *trans = (struct btrfs_trans_handle *)ctx;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_inode_item *ii;
+	struct btrfs_path path = {};
+	struct btrfs_key key;
+	struct btrfs_root *root;
+	struct btrfs_root *csum_root;
+	char *buf;
+	u64 disk_bytenr;
+	u64 disk_len;
+	int ret = 0;
+
+	key.objectid = rootid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto out;
+	}
+
+	/* Check if the inode has NODATASUM flag */
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_inode_item);
+	if (btrfs_inode_flags(path.nodes[0], ii) & BTRFS_INODE_NODATASUM) {
+		/* The inode has NODATASUM flag, not need to calculate csum */
+		ret = 0;
+		goto out;
+	}
+
+	btrfs_release_path(&path);
+
+	/* Check the file extent item to make sure it's not preallocated */
+	key.objectid = ino;
+	key.type = BTRFS_EXTENT_DATA_KEY;
+	key.offset = offset;
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+	fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_file_extent_item);
+	if (btrfs_file_extent_type(path.nodes[0], fi) != BTRFS_FILE_EXTENT_REG)
+		goto out;
+	disk_bytenr = btrfs_file_extent_disk_bytenr(path.nodes[0], fi);
+	disk_len = btrfs_file_extent_disk_num_bytes(path.nodes[0], fi);
+	if (!disk_bytenr)
+		goto out;
+
+	/*
+	 * Now it's non-hole regular file extents, get its real on-disk bytenr
+	 * for csum population.
+	 */
+	if (btrfs_file_extent_compression(path.nodes[0], fi) ==
+	    BTRFS_COMPRESS_NONE) {
+		disk_bytenr += btrfs_file_extent_offset(path.nodes[0], fi);
+		disk_len = btrfs_file_extent_num_bytes(path.nodes[0], fi);
+	}
+	btrfs_release_path(&path);
+
+	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
+	buf = malloc(fs_info->sectorsize);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* Insert the csum */
+	ret = populate_csum(trans, csum_root, buf, disk_bytenr, disk_len);
+	free(buf);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *extent_root)
 {
-	struct btrfs_root *csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct extent_buffer *leaf;
-	char *buf;
 	struct btrfs_key key;
 	int ret;
 
@@ -1359,12 +1445,6 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	buf = malloc(gfs_info->sectorsize);
-	if (!buf) {
-		btrfs_release_path(&path);
-		return -ENOMEM;
-	}
-
 	while (1) {
 		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
 			ret = btrfs_next_leaf(extent_root, &path);
@@ -1390,17 +1470,14 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 			path.slots[0]++;
 			continue;
 		}
-
-		csum_root = btrfs_csum_root(gfs_info, key.objectid);
-		ret = populate_csum(trans, csum_root, buf, key.objectid,
-				    key.offset);
+		ret = iterate_extent_inodes(trans->fs_info, key.objectid, 0, 0,
+					    fill_csum_for_file_extent, trans);
 		if (ret)
 			break;
 		path.slots[0]++;
 	}
 
 	btrfs_release_path(&path);
-	free(buf);
 	return ret;
 }
 
-- 
2.34.1

