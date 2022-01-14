Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6BF48E1C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiANAvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiANAvq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3EB491F3BC
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzTsx4BmsGOR5jiYD2tQwk5GPbjzgAP6ZZo8t4izrHo=;
        b=Q6nM/R2elPspiZLgv8T15qU1PXgEkIiZEiNysjzetpHhvZzl/q/senCE0D5gQbFI5BmDwo
        jaScy5D9EpsZWmFgqXTFGEgj5y3p3S0Cb4uoZFNJNZpsGAn6+1ivy/kDT7xTVqPSRIhX+E
        3RwwRnO3UrdFT6JWhjXafWP4rTYB+Fc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85BF61344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMrzEiDJ4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs-progs: check: don't calculate csum for preallocated file extents
Date:   Fri, 14 Jan 2022 08:51:21 +0800
Message-Id: <20220114005123.19426-4-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
References: <20220114005123.19426-1-wqu@suse.com>
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
However the fix is not that simple, we can not just generate csum for
non-preallocated range.

As the following case we still need csum for the un-referred part:
 xfs_io -f -c "pwrite 0 8K" -c "sync" -c "punch 0 4K"

So here we have to go another direction by:

- Always generate csum for the whole data extent
  This is the same as the old code

- Iterate the file extents, and delete csum for preallocated range
  or NODATASUM inodes

Issue: #430
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 106 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 1608dbdafa4c..4c6dca2d5973 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -22,6 +22,7 @@
 #include "common/utils.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/backref.h"
 #include "common/repair.h"
 #include "check/mode-common.h"
 
@@ -1338,6 +1339,92 @@ out:
 	return ret;
 }
 
+static int remove_csum_for_file_extent(u64 ino, u64 offset, u64 rootid, void *ctx)
+{
+	struct btrfs_trans_handle *trans = (struct btrfs_trans_handle *)ctx;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_inode_item *ii;
+	struct btrfs_path path = {};
+	struct btrfs_key key;
+	struct btrfs_root *root;
+	bool nocsum = false;
+	u8 type;
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
+	if (btrfs_inode_flags(path.nodes[0], ii) & BTRFS_INODE_NODATASUM)
+		nocsum = true;
+
+	btrfs_release_path(&path);
+
+	/* Check the file extent item and delete csum if needed */
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
+	type = btrfs_file_extent_type(path.nodes[0], fi);
+
+	if (btrfs_file_extent_disk_bytenr(path.nodes[0], fi) == 0)
+		goto out;
+
+	/* Compressed extent should have csum, skip it */
+	if (btrfs_file_extent_compression(path.nodes[0], fi) !=
+	    BTRFS_COMPRESS_NONE)
+		goto out;
+	/*
+	 * We only want to delete the csum range if the inode has NODATASUM
+	 * flag or it's a preallocated extent.
+	 */
+	if (!(nocsum || type == BTRFS_FILE_EXTENT_PREALLOC))
+		goto out;
+
+	/* If NODATASUM, we need to remove all csum for the extent */
+	if (nocsum) {
+		disk_bytenr = btrfs_file_extent_disk_bytenr(path.nodes[0], fi);
+		disk_len = btrfs_file_extent_disk_num_bytes(path.nodes[0], fi);
+	} else {
+		disk_bytenr = btrfs_file_extent_disk_bytenr(path.nodes[0], fi) +
+			      btrfs_file_extent_offset(path.nodes[0], fi);
+		disk_len = btrfs_file_extent_num_bytes(path.nodes[0], fi);
+	}
+	btrfs_release_path(&path);
+
+	/* Now delete the csum for the preallocated or nodatasum range */
+	ret = btrfs_del_csums(trans, disk_bytenr, disk_len);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *extent_root)
 {
@@ -1390,10 +1477,27 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 			path.slots[0]++;
 			continue;
 		}
-
+		/*
+		 * Generate the datasum unconditionally first.
+		 *
+		 * This will generate csum for preallocated extents, but that
+		 * will be later deleted.
+		 *
+		 * This is to address cases like this:
+		 *  fallocate 0 8K
+		 *  pwrite 0 4k
+		 *  sync
+		 *  punch 0 4k
+		 *
+		 * Above case we will have csum for [0, 4K) and that's valid.
+		 */
 		csum_root = btrfs_csum_root(gfs_info, key.objectid);
 		ret = populate_csum(trans, csum_root, buf, key.objectid,
 				    key.offset);
+		if (ret < 0)
+			break;
+		ret = iterate_extent_inodes(trans->fs_info, key.objectid, 0, 0,
+					    remove_csum_for_file_extent, trans);
 		if (ret)
 			break;
 		path.slots[0]++;
-- 
2.34.1

