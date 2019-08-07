Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A044784E47
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfHGOIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 10:08:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:52968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387924AbfHGOIw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 10:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2537B023
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2019 14:08:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 2/3] btrfs: tree-checker: Add simple keyed refs check
Date:   Wed,  7 Aug 2019 22:08:42 +0800
Message-Id: <20190807140843.2728-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190807140843.2728-1-wqu@suse.com>
References: <20190807140843.2728-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For TREE_BLOCK_REF, SHARED_DATA_REF and SHARED_BLOCK_REF we need to
check:
              | TREE_BLOCK_REF | SHARED_BLOCK_REF | SHARED_BLOCK_REF
--------------+----------------+-----------------+------------------
key->objectid |    Alignment   |     Alignment    |    Alignment
key->offset   |    Any value   |     Alignment    |    Alignment
item_size     |        0       |        0         |   sizeof(le32) (*)

*: sizeof(struct btrfs_shared_data_ref)

So introduce a check to check all these 3 key types together.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c1b241aab595..6aaf3650b13d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -912,7 +912,9 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 
 	btrfs_item_key_to_cpu(eb, &key, slot);
 	bytenr = key.objectid;
-	if (key.type == BTRFS_METADATA_ITEM_KEY)
+	if (key.type == BTRFS_METADATA_ITEM_KEY ||
+	    key.type == BTRFS_TREE_BLOCK_REF_KEY ||
+	    key.type == BTRFS_SHARED_BLOCK_REF_KEY)
 		len = eb->fs_info->nodesize;
 	else
 		len = key.offset;
@@ -1145,6 +1147,37 @@ static int check_extent_item(struct extent_buffer *leaf,
 	return -EUCLEAN;
 }
 
+static int check_simple_keyed_refs(struct extent_buffer *leaf,
+				   struct btrfs_key *key, int slot)
+{
+	u32 expect_item_size = 0;
+
+	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
+		expect_item_size = sizeof(struct btrfs_shared_data_ref);
+
+	if (btrfs_item_size_nr(leaf, slot) != expect_item_size) {
+		generic_err(leaf, slot,
+	"invalid item size, have %u expect %u for key type %u",
+			    btrfs_item_size_nr(leaf, slot),
+			    expect_item_size, key->type);
+		return -EUCLEAN;
+	}
+	if (!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize)) {
+		generic_err(leaf, slot,
+"invalid key objectid for shared block ref, have %llu expect aligned to %u",
+			    key->objectid, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	if (key->type != BTRFS_TREE_BLOCK_REF_KEY &&
+	    !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize)) {
+		extent_err(leaf, slot,
+		"invalid tree parent bytenr, have %llu expect aligned to %u",
+			   key->offset, leaf->fs_info->sectorsize);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1187,6 +1220,11 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_METADATA_ITEM_KEY:
 		ret = check_extent_item(leaf, key, slot);
 		break;
+	case BTRFS_TREE_BLOCK_REF_KEY:
+	case BTRFS_SHARED_DATA_REF_KEY:
+	case BTRFS_SHARED_BLOCK_REF_KEY:
+		ret = check_simple_keyed_refs(leaf, key, slot);
+		break;
 	}
 	return ret;
 }
-- 
2.22.0

