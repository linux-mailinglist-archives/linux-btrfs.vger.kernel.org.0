Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607EC9CABE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 09:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfHZHkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 03:40:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbfHZHks (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 03:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7E7BB052
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 07:40:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: tree-checker: Add check for INODE_REF
Date:   Mon, 26 Aug 2019 15:40:39 +0800
Message-Id: <20190826074039.28517-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826074039.28517-1-wqu@suse.com>
References: <20190826074039.28517-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For INODE_REF we will check:
- Objectid (ino) against previous key
  To detect missing INODE_ITEM.

- No overflow/padding in the data payload
  Much like DIR_ITEM, but with less members to check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 636ce1b4566e..3ce447eb591c 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -842,6 +842,56 @@ static int check_inode_item(struct extent_buffer *leaf,
 	return 0;
 }
 
+#define inode_ref_err(fs_info, eb, slot, fmt, ...)		\
+	inode_item_err(fs_info, eb, slot, fmt, __VA_ARGS__)
+static int check_inode_ref(struct extent_buffer *leaf,
+			   struct btrfs_key *key, struct btrfs_key *prev_key,
+			   int slot)
+{
+	struct btrfs_inode_ref *iref;
+	unsigned long ptr;
+	unsigned long end;
+
+	/* namelen can't be 0, so item_size == sizeof() is also invalid */
+	if (btrfs_item_size_nr(leaf, slot) <= sizeof(*iref)) {
+		inode_ref_err(fs_info, leaf, slot,
+		"invalid item size, have %u expect (%zu, %u)",
+			btrfs_item_size_nr(leaf, slot),
+			sizeof(*iref), BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
+		return -EUCLEAN;
+	}
+
+	ptr = btrfs_item_ptr_offset(leaf, slot);
+	end = ptr + btrfs_item_size_nr(leaf, slot);
+	while (ptr < end) {
+		u16 namelen;
+
+		if (ptr + sizeof(iref) > end) {
+			inode_ref_err(fs_info, leaf, slot,
+		"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
+				ptr, end, sizeof(iref));
+			return -EUCLEAN;
+		}
+
+		iref = (struct btrfs_inode_ref *)ptr;
+		namelen = btrfs_inode_ref_name_len(leaf, iref);
+		if (ptr + sizeof(*iref) + namelen > end) {
+			inode_ref_err(fs_info, leaf, slot,
+		"inode ref overflow, ptr %lu end %lu namelen %u",
+				ptr, end, namelen);
+			return -EUCLEAN;
+		}
+
+		/*
+		 * NOTE: In theory we should record all found index number
+		 * to find any duplicated index. But that will be too time
+		 * consuming for inodes with too many hard links.
+		 */
+		ptr += sizeof(*iref) + namelen;
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -864,6 +914,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_XATTR_ITEM_KEY:
 		ret = check_dir_item(leaf, key, prev_key, slot);
 		break;
+	case BTRFS_INODE_REF_KEY:
+		ret = check_inode_ref(leaf, key, prev_key, slot);
+		break;
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(leaf, key, slot);
 		break;
-- 
2.23.0

