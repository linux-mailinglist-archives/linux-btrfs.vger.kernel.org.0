Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB892738CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 04:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgIVChH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 22:37:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgIVChG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 22:37:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600742225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EF3FmnK752coUBHd7BkrBiD8aHm8sgqjasNtrBnIdCI=;
        b=inneviJsokCG+aYrohngfmJDAJfyrzto1dcvB48ZVx9xLRBANteZtSa01hcuoFy6uKssY0
        tLvWgW36Kd3VaFP4SMa7qq10lxC7bQY8FBB2b/bTF2Bhiq994CwMXM3ynQXiA1o533ijY/
        jzYD7l6fmRTIeS9+6Y+ov2B8XEHGE6c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D9B4AB3E;
        Tue, 22 Sep 2020 02:37:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Martin Steigerwald <martin@lichtvoll.de>
Subject: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
Date:   Tue, 22 Sep 2020 10:37:01 +0800
Message-Id: <20200922023701.32654-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
introduced btrfs root item size check, however btrfs root item has two
format, the legacy one which just ends before generation_v2 member, is
smaller than current btrfs root item size.

This caused btrfs kernel to reject valid but old tree root leaves.

Fix this problem by also allowing legacy root item, since kernel can
already handle them pretty well and upgrade to newer root item format
when needed.

Reported-by: Martin Steigerwald <martin@lichtvoll.de>
Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c         | 17 ++++++++++++-----
 include/uapi/linux/btrfs_tree.h |  9 +++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7b1fee630f97..6f794aca48d3 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1035,7 +1035,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_root_item ri;
+	struct btrfs_root_item ri = { 0 };
 	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
 				     BTRFS_ROOT_SUBVOL_DEAD;
 	int ret;
@@ -1044,14 +1044,21 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	if (ret < 0)
 		return ret;
 
-	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri)) {
+	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri) &&
+	    btrfs_item_size_nr(leaf, slot) != btrfs_legacy_root_item_size()) {
 		generic_err(leaf, slot,
-			    "invalid root item size, have %u expect %zu",
-			    btrfs_item_size_nr(leaf, slot), sizeof(ri));
+			    "invalid root item size, have %u expect %zu or %zu",
+			    btrfs_item_size_nr(leaf, slot), sizeof(ri),
+			    btrfs_legacy_root_item_size());
 	}
 
+	/*
+	 * For legacy root item, the members starting at generation_v2 will be
+	 * all filled with 0.
+	 * And since we allow geneartion_v2 as 0, it will still pass the check.
+	 */
 	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(ri));
+			   btrfs_item_size_nr(leaf, slot));
 
 	/* Generation related */
 	if (btrfs_root_generation(&ri) >
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 9ba64ca6b4ac..464095a28b18 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -644,6 +644,15 @@ struct btrfs_root_item {
 	__le64 reserved[8]; /* for future */
 } __attribute__ ((__packed__));
 
+/*
+ * Btrfs root item used to be smaller than current size.
+ * The old format ends at where member generation_v2 is.
+ */
+static inline size_t btrfs_legacy_root_item_size(void)
+{
+	return offsetof(struct btrfs_root_item, generation_v2);
+}
+
 /*
  * this is used for both forward and backward root refs
  */
-- 
2.28.0

