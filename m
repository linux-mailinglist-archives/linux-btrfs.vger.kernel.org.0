Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4901E5A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 01:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfENXdx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 19:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbfENXdx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 19:33:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FE0BAD7B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 23:33:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: extent-tree: Refactor add_pinned_bytes() to add|sub_pinned_bytes()
Date:   Wed, 15 May 2019 07:33:48 +0800
Message-Id: <20190514233348.10696-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of using @sign to determine whether we're adding or subtracting.
Even it only has 3 callers, it's still (and in fact already caused
problem in the past) confusing to use.

Refactor add_pinned_bytes() to add_pinned_bytes() and sub_pinned_bytes()
to explicitly show what we're doing.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
To David,

Would you please fold this patch to "btrfs: extent-tree: Fix a bug that
btrfs is unable to add pinned bytes" in misc-next branch?

Thanks,
Qu
---
 fs/btrfs/extent-tree.c | 43 ++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1aee51a9f3bf..aa8c5e3247fc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -756,27 +756,38 @@ static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
 	return NULL;
 }
 
-static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_ref *ref, int sign)
+static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
 {
-	struct btrfs_space_info *space_info;
-	s64 num_bytes;
-	u64 flags;
-
-	ASSERT(sign == 1 || sign == -1);
-	num_bytes = sign * ref->len;
 	if (ref->type == BTRFS_REF_METADATA) {
 		if (ref->tree_ref.root == BTRFS_CHUNK_TREE_OBJECTID)
-			flags = BTRFS_BLOCK_GROUP_SYSTEM;
+			return BTRFS_BLOCK_GROUP_SYSTEM;
 		else
-			flags = BTRFS_BLOCK_GROUP_METADATA;
-	} else {
-		flags = BTRFS_BLOCK_GROUP_DATA;
+			return BTRFS_BLOCK_GROUP_METADATA;
 	}
+	return BTRFS_BLOCK_GROUP_DATA;
+}
+
+static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
+			     struct btrfs_ref *ref)
+{
+	struct btrfs_space_info *space_info;
+	u64 flags = generic_ref_to_space_flags(ref);
+
+	space_info = __find_space_info(fs_info, flags);
+	ASSERT(space_info);
+	percpu_counter_add_batch(&space_info->total_bytes_pinned, ref->len,
+		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
+}
+
+static void sub_pinned_bytes(struct btrfs_fs_info *fs_info,
+			     struct btrfs_ref *ref)
+{
+	struct btrfs_space_info *space_info;
+	u64 flags = generic_ref_to_space_flags(ref);
 
 	space_info = __find_space_info(fs_info, flags);
 	ASSERT(space_info);
-	percpu_counter_add_batch(&space_info->total_bytes_pinned, num_bytes,
+	percpu_counter_add_batch(&space_info->total_bytes_pinned, -ref->len,
 		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
 }
 
@@ -2065,7 +2076,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_ref_tree_mod(fs_info, generic_ref);
 
 	if (ret == 0 && old_ref_mod < 0 && new_ref_mod >= 0)
-		add_pinned_bytes(fs_info, generic_ref, -1);
+		sub_pinned_bytes(fs_info, generic_ref);
 
 	return ret;
 }
@@ -7191,7 +7202,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	}
 out:
 	if (pin)
-		add_pinned_bytes(fs_info, &generic_ref, 1);
+		add_pinned_bytes(fs_info, &generic_ref);
 
 	if (last_ref) {
 		/*
@@ -7239,7 +7250,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 		btrfs_ref_tree_mod(fs_info, ref);
 
 	if (ret == 0 && old_ref_mod >= 0 && new_ref_mod < 0)
-		add_pinned_bytes(fs_info, ref, 1);
+		add_pinned_bytes(fs_info, ref);
 
 	return ret;
 }
-- 
2.21.0

