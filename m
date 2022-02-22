Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F34C0496
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiBVW1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBVW1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:27:00 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB03BB23
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:33 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d3so3590605qvb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KmF4M4hth6u1JTO3sX+FMnPfpHjjYKrQlsZhZPtRYzg=;
        b=726jzCpaOfSRimXcjdMVQBz9htM5szW+Gtu2NCUN34Sk9Tt0v9vyoz3Yqe6Mu8Y2hJ
         D4L7tGsA9a9lZNBgreWA/nFMDGTBiNUlJpSJVdje4c/dEzfQSw5Ljrs2W52cx1L07qtY
         4lOFT4b5D41/oF7tNYDu0hQjZ1aZt2FBcqkcJxgFUkGjEG8XQexqAZbBfeHED5AWQQZv
         Iihzf1KYkLzz5eXAOy9KeMLsORSO5itAOSmIPqrbDybqZKNdAU1mCv8e5P9gTv0Qg9aX
         PZyuNvypGp18jlM9sdqNiGsfF13zvm/DAmstZv9NmvNaT4RthJNoJjDc0f+40XwLbCn5
         mXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmF4M4hth6u1JTO3sX+FMnPfpHjjYKrQlsZhZPtRYzg=;
        b=6KVazefyS/eqF5eOlQgUUBv5ptKIltgmZMTa5J9cZVu+wyqPxNu/nGKiLydA75lBzA
         y6xRX0TOUM05MweQPw4hjFHqln6BaAfsX1nsjwNC1KbMiA4GV+MZQe5PWlkla+h+63AG
         jEgraxh7JDa7PhOidbiVNL40c2txOIvZuF5pODr2h0OeUOZAjW3E1u0eYjVnZl46YAU7
         fj10UiB7JJYbK2di+ksUkrJ+v2fo5rHRuD6j0e0DrVRn2SBGFCWkZcQ5F2yAge6w7i6E
         8qtdkM8OqaaKGDTK5o64TXskdcm+cPjZyfjWuC+oOMM3JXryqB1XxnGLOIQ7anI3odYV
         J91Q==
X-Gm-Message-State: AOAM533Mah8kuLjXe2+SzDFzWVlRzV0YY6UgxMVXrfM0QhioNRjlws+A
        VKEXCK2BVNgHpY02cmK7i/fRZOWs+qh9Isb7
X-Google-Smtp-Source: ABdhPJxKUp5zLaZCXotn3Z1hMyYm4kkZXYSJIbdCSfBo23sGSTT+GnjL5B8c/G+xgZAV5n2/ZhJDsA==
X-Received: by 2002:a0c:efcc:0:b0:432:42e6:e4ef with SMTP id a12-20020a0cefcc000000b0043242e6e4efmr3685516qvt.97.1645568792447;
        Tue, 22 Feb 2022 14:26:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm719021qtw.52.2022.02.22.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/13] btrfs-progs: btrfs_item_size_nr/btrfs_item_offset_nr everywhere
Date:   Tue, 22 Feb 2022 17:26:16 -0500
Message-Id: <fc4887f36095607112c2a37946d253436ab31226.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this pattern in a lot of places

	item = btrfs_item_nr(slot);
	btrfs_item_size(leaf, item);
	btrfs_item_offset(leaf, item);

when we could simply use

	btrfs_item_size_nr(leaf, slot);
	btrfs_item_offset_nr(leaf, slot);

Fix all callers of btrfs_item_size() and btrfs_item_offset() to use the
_nr variation of the helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c               |  8 ++++----
 image/main.c               |  2 +-
 kernel-shared/backref.c    |  4 +---
 kernel-shared/ctree.c      | 24 ++++++++++++------------
 kernel-shared/dir-item.c   |  6 ++----
 kernel-shared/inode-item.c |  4 +---
 kernel-shared/print-tree.c |  6 +++---
 7 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/check/main.c b/check/main.c
index e9ac94cc..76eb8d54 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4222,10 +4222,10 @@ static int swap_values(struct btrfs_root *root, struct btrfs_path *path,
 		item2 = btrfs_item_nr(slot + 1);
 		btrfs_item_key_to_cpu(buf, &k1, slot);
 		btrfs_item_key_to_cpu(buf, &k2, slot + 1);
-		item1_offset = btrfs_item_offset(buf, item1);
-		item2_offset = btrfs_item_offset(buf, item2);
-		item1_size = btrfs_item_size(buf, item1);
-		item2_size = btrfs_item_size(buf, item2);
+		item1_offset = btrfs_item_offset_nr(buf, slot);
+		item2_offset = btrfs_item_offset_nr(buf, slot + 1);
+		item1_size = btrfs_item_size_nr(buf, slot);
+		item2_size = btrfs_item_size_nr(buf, slot + 1);
 
 		item1_data = malloc(item1_size);
 		if (!item1_data)
diff --git a/image/main.c b/image/main.c
index 3125163d..e953d981 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1239,7 +1239,7 @@ static void truncate_item(struct extent_buffer *eb, int slot, u32 new_size)
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 		item = btrfs_item_nr(i);
-		ioff = btrfs_item_offset(eb, item);
+		ioff = btrfs_item_offset_nr(eb, i);
 		btrfs_set_item_offset(eb, item, ioff + size_diff);
 	}
 
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index f1a638ed..327599b7 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -1417,7 +1417,6 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 	u64 parent = 0;
 	int found = 0;
 	struct extent_buffer *eb;
-	struct btrfs_item *item;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_key found_key;
 
@@ -1442,10 +1441,9 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 		extent_buffer_get(eb);
 		btrfs_release_path(path);
 
-		item = btrfs_item_nr(slot);
 		iref = btrfs_item_ptr(eb, slot, struct btrfs_inode_ref);
 
-		for (cur = 0; cur < btrfs_item_size(eb, item); cur += len) {
+		for (cur = 0; cur < btrfs_item_size_nr(eb, slot); cur += len) {
 			name_len = btrfs_inode_ref_name_len(eb, iref);
 			/* path must be released before calling iterate()! */
 			pr_debug("following ref at offset %u for inode %llu in "
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 10b22b2c..fc661aeb 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2041,7 +2041,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		if (path->slots[0] == i)
 			push_space += data_size + sizeof(*item);
 
-		this_item_size = btrfs_item_size(left, item);
+		this_item_size = btrfs_item_size_nr(left, i);
 		if (this_item_size + sizeof(*item) + push_space > free_space)
 			break;
 		push_items++;
@@ -2092,7 +2092,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
 		item = btrfs_item_nr(i);
-		push_space -= btrfs_item_size(right, item);
+		push_space -= btrfs_item_size_nr(right, i);
 		btrfs_set_item_offset(right, item, push_space);
 	}
 
@@ -2187,7 +2187,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		if (path->slots[0] == i)
 			push_space += data_size + sizeof(*item);
 
-		this_item_size = btrfs_item_size(right, item);
+		this_item_size = btrfs_item_size_nr(right, i);
 		if (this_item_size + sizeof(*item) + push_space > free_space)
 			break;
 
@@ -2224,7 +2224,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		u32 ioff;
 
 		item = btrfs_item_nr(i);
-		ioff = btrfs_item_offset(left, item);
+		ioff = btrfs_item_offset_nr(left, i);
 		btrfs_set_item_offset(left, item,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(root->fs_info) -
 			      old_left_item_size));
@@ -2256,7 +2256,7 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 	push_space = BTRFS_LEAF_DATA_SIZE(root->fs_info);
 	for (i = 0; i < right_nritems; i++) {
 		item = btrfs_item_nr(i);
-		push_space = push_space - btrfs_item_size(right, item);
+		push_space = push_space - btrfs_item_size_nr(right, i);
 		btrfs_set_item_offset(right, item, push_space);
 	}
 
@@ -2319,7 +2319,7 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 
 	for (i = 0; i < nritems; i++) {
 		struct btrfs_item *item = btrfs_item_nr(i);
-		u32 ioff = btrfs_item_offset(right, item);
+		u32 ioff = btrfs_item_offset_nr(right, i);
 		btrfs_set_item_offset(right, item, ioff + rt_data_off);
 	}
 
@@ -2574,8 +2574,8 @@ int btrfs_split_item(struct btrfs_trans_handle *trans,
 
 split:
 	item = btrfs_item_nr(path->slots[0]);
-	orig_offset = btrfs_item_offset(leaf, item);
-	item_size = btrfs_item_size(leaf, item);
+	orig_offset = btrfs_item_offset_nr(leaf, path->slots[0]);
+	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
 
 
 	buf = kmalloc(item_size, GFP_NOFS);
@@ -2666,7 +2666,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 		item = btrfs_item_nr(i);
-		ioff = btrfs_item_offset(leaf, item);
+		ioff = btrfs_item_offset_nr(leaf, i);
 		btrfs_set_item_offset(leaf, item, ioff + size_diff);
 	}
 
@@ -2762,7 +2762,7 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 		item = btrfs_item_nr(i);
-		ioff = btrfs_item_offset(leaf, item);
+		ioff = btrfs_item_offset_nr(leaf, i);
 		btrfs_set_item_offset(leaf, item, ioff - data_size);
 	}
 
@@ -2854,7 +2854,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			u32 ioff;
 
 			item = btrfs_item_nr(i);
-			ioff = btrfs_item_offset(leaf, item);
+			ioff = btrfs_item_offset_nr(leaf, i);
 			btrfs_set_item_offset(leaf, item, ioff - total_data);
 		}
 
@@ -3029,7 +3029,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			u32 ioff;
 
 			item = btrfs_item_nr(i);
-			ioff = btrfs_item_offset(leaf, item);
+			ioff = btrfs_item_offset_nr(leaf, i);
 			btrfs_set_item_offset(leaf, item, ioff + dsize);
 		}
 
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 590b79a9..729d4308 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -32,7 +32,6 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 {
 	int ret;
 	char *ptr;
-	struct btrfs_item *item;
 	struct extent_buffer *leaf;
 
 	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
@@ -48,10 +47,9 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 		return ERR_PTR(ret);
 	WARN_ON(ret > 0);
 	leaf = path->nodes[0];
-	item = btrfs_item_nr(path->slots[0]);
 	ptr = btrfs_item_ptr(leaf, path->slots[0], char);
-	BUG_ON(data_size > btrfs_item_size(leaf, item));
-	ptr += btrfs_item_size(leaf, item) - data_size;
+	BUG_ON(data_size > btrfs_item_size_nr(leaf, path->slots[0]));
+	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - data_size;
 	return (struct btrfs_dir_item *)ptr;
 }
 
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index 67173eb1..7ca75f6d 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -336,7 +336,6 @@ int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct btrfs_item *item;
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
@@ -361,9 +360,8 @@ int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		goto out;
 
 	leaf = path->nodes[0];
-	item = btrfs_item_nr(path->slots[0]);
 	ptr = (unsigned long)btrfs_item_ptr(leaf, path->slots[0], char);
-	ptr += btrfs_item_size(leaf, item) - ins_len;
+	ptr += btrfs_item_size_nr(leaf, path->slots[0]) - ins_len;
 	extref = (struct btrfs_inode_extref *)ptr;
 
 	btrfs_set_inode_extref_name_len(path->nodes[0], extref, name_len);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 7308599f..6e601779 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1320,7 +1320,7 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 			break;
 		}
 		item = btrfs_item_nr(i);
-		item_size = btrfs_item_size(eb, item);
+		item_size = btrfs_item_size_nr(eb, i);
 		/* Untyped extraction of slot from btrfs_item_ptr */
 		ptr = btrfs_item_ptr(eb, i, void*);
 
@@ -1332,8 +1332,8 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		printf("\titem %u ", i);
 		btrfs_print_key(&disk_key);
 		printf(" itemoff %u itemsize %u\n",
-			btrfs_item_offset(eb, item),
-			btrfs_item_size(eb, item));
+			btrfs_item_offset_nr(eb, i),
+			btrfs_item_size_nr(eb, i));
 
 		if (type == 0 && objectid == BTRFS_FREE_SPACE_OBJECTID)
 			print_free_space_header(eb, i);
-- 
2.26.3

