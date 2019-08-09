Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2075886F3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 03:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405296AbfHIBYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 21:24:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404958AbfHIBYe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 21:24:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3F30AEA4
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 01:24:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.2 3/3] btrfs: tree-checker: Add EXTENT_DATA_REF check
Date:   Fri,  9 Aug 2019 09:24:24 +0800
Message-Id: <20190809012424.11420-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809012424.11420-1-wqu@suse.com>
References: <20190809012424.11420-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

EXTENT_DATA_REF is a little like DIR_ITEM which contains hash in its
key->offset.

This patch will check the following contents:
- Key->objectid
  Basic alignment check.

- Hash
  Hash of each extent_data_ref item must match key->offset.

- Offset
  Basic alignment check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h        |  1 +
 fs/btrfs/extent-tree.c  |  2 +-
 fs/btrfs/tree-checker.c | 48 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..710ea3a6608c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2679,6 +2679,7 @@ enum btrfs_inline_ref_type {
 int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     struct btrfs_extent_inline_ref *iref,
 				     enum btrfs_inline_ref_type is_data);
+u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
 u64 btrfs_csum_bytes_to_leaves(struct btrfs_fs_info *fs_info, u64 csum_bytes);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b4e9e36b65f1..c0888ed503df 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1114,7 +1114,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 	return BTRFS_REF_TYPE_INVALID;
 }
 
-static u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
+u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
 {
 	u32 high_crc = ~(u32)0;
 	u32 low_crc = ~(u32)0;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 39d10b553c5f..2a0624bf7789 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1178,6 +1178,51 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_extent_data_ref(struct extent_buffer *leaf,
+				 struct btrfs_key *key, int slot)
+{
+	struct btrfs_extent_data_ref *dref;
+	unsigned long ptr = btrfs_item_ptr_offset(leaf, slot);
+	unsigned long end = ptr + btrfs_item_size_nr(leaf, slot);
+
+	if (btrfs_item_size_nr(leaf, slot) % sizeof(*dref) != 0) {
+		generic_err(leaf, slot,
+	"invalid item size, have %u expect aligned to %zu for key type %u",
+			    btrfs_item_size_nr(leaf, slot),
+			    sizeof(*dref), key->type);
+	}
+	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
+		generic_err(leaf, slot,
+"invalid key objectid for shared block ref, have %llu expect aligned to %u",
+			    key->objectid, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	for (; ptr < end; ptr += sizeof(*dref)) {
+		u64 root_objectid;
+		u64 owner;
+		u64 offset;
+		u64 hash;
+
+		dref = (struct btrfs_extent_data_ref *)ptr;
+		root_objectid = btrfs_extent_data_ref_root(leaf, dref);
+		owner = btrfs_extent_data_ref_objectid(leaf, dref);
+		offset = btrfs_extent_data_ref_offset(leaf, dref);
+		hash = hash_extent_data_ref(root_objectid, owner, offset);
+		if (hash != key->offset) {
+			extent_err(leaf, slot,
+	"invalid extent data ref hash, item have 0x%016llx key have 0x%016llx",
+				   hash, key->offset);
+			return -EUCLEAN;
+		}
+		if (!IS_ALIGNED(offset, leaf->fs_info->sectorsize)) {
+			extent_err(leaf, slot,
+	"invalid extent data backref offset, have %llu expect aligned to %u",
+				   offset, leaf->fs_info->sectorsize);
+		}
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1225,6 +1270,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_SHARED_BLOCK_REF_KEY:
 		ret = check_simple_keyed_refs(leaf, key, slot);
 		break;
+	case BTRFS_EXTENT_DATA_REF_KEY:
+		ret = check_extent_data_ref(leaf, key, slot);
+		break;
 	}
 	return ret;
 }
-- 
2.22.0

