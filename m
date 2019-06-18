Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48B24AB6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfFRUJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46207 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so16973119qtn.13
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=elX8wBAUHKUuSBe4AGNXisVkPZdRC8GaCCE5YXcPbd0=;
        b=k9kJ+nDlJaJA37Deih3yow1lisl7dZc8fghiX8fWQ6X8Cys0h3GJxv4bJA8BIsyqi2
         akDtfUlVVFTaBxJIEcr8qVTzevy6apjVWHC8tTpG91zScjLBHVhGrb2nprsaEX56sycV
         beYoGV6VHiQQ4tqdqVJoGFS4zc8O2MlydafF7Ks3bm0vARA0IlY8i84XrTBH0PQy+KYf
         NtfwCdjNPNZNkEgSFidtrJb9u6xrmvdTuXmy78rR5zyZ+ZuI4wYwEPYlUg1quBwq159B
         T1eohISHXbc5B99cuyV3A1sWqX3V5BT+MxiRjN62l/AvW/CyINzXJfsGxR+k5qeJVHIC
         t2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=elX8wBAUHKUuSBe4AGNXisVkPZdRC8GaCCE5YXcPbd0=;
        b=BdqEgoBnPhID6tIzOJVrOM8ObP2ygo38e/vFojYH+U0K/jE/D4pK/TSM6nqmjJ8XsT
         U7imy7nk+Zi7LWeZnTOGUyLM8EKinMi4dVrLkOKRGL2hl5EpqnLU8Ch+8OYla6Lw1z/j
         E7Vu298ZMZvUYbMjx+yLot0xE3RcHqUECXlN/CGaN0lg8QY8wsvHzWDltvLdzfqvH9c6
         Yu2SA633vhFcawNiFU+lJfQqakQu8+Onk3S4BXhe2zeXZ2On2zYHjjdyeeXjNVCHhcvm
         iPCFgrUkwu6Rf8KDcbmvqIOy2yNflNAgrbs478EBnnE3+kndmy/FGas5Q0eom5cOYgac
         KWjQ==
X-Gm-Message-State: APjAAAXHMqRNzxHVQjEfr6WSlYYN5Vb37skEUdTeMKxX9I++kUeEAqSz
        +82spMJbFsIC8zn+z3MRSWCFb8xVlJ3lJw==
X-Google-Smtp-Source: APXvYqxDSNF9xsNN9FnpxrIjqELIDOHhIWXoNEt5TYhUq42QAo3+0kTIQOAcoY2L/Ug/f1wfMzWvGg==
X-Received: by 2002:ac8:26d9:: with SMTP id 25mr65010486qtp.377.1560888573583;
        Tue, 18 Jun 2019 13:09:33 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y129sm8580054qkc.63.2019.06.18.13.09.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: rename do_chunk_alloc to btrfs_chunk_alloc
Date:   Tue, 18 Jun 2019 16:09:17 -0400
Message-Id: <20190618200926.3352-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Really we just need the enum, but as we break more things up it'll help
to have this external to extent-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 22 ++++++++++++++++++++++
 fs/btrfs/extent-tree.c | 50 ++++++++++++++------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0936db74d3e3..cceb1b5fab33 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2764,6 +2764,28 @@ enum btrfs_flush_state {
 	COMMIT_TRANS		=	9,
 };
 
+/*
+ * control flags for do_chunk_alloc's force field
+ * CHUNK_ALLOC_NO_FORCE means to only allocate a chunk
+ * if we really need one.
+ *
+ * CHUNK_ALLOC_LIMITED means to only try and allocate one
+ * if we have very few chunks already allocated.  This is
+ * used as part of the clustering code to help make sure
+ * we have a good pool of storage to cluster in, without
+ * filling the FS with empty chunks
+ *
+ * CHUNK_ALLOC_FORCE means it must try to allocate one
+ *
+ */
+enum btrfs_chunk_alloc_enum {
+	CHUNK_ALLOC_NO_FORCE = 0,
+	CHUNK_ALLOC_LIMITED = 1,
+	CHUNK_ALLOC_FORCE = 2,
+};
+
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+		      enum btrfs_chunk_alloc_enum force);
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
 int btrfs_check_data_free_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fbd173ebc4be..7b4232ee48a0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -32,26 +32,6 @@
 
 #undef SCRAMBLE_DELAYED_REFS
 
-/*
- * control flags for do_chunk_alloc's force field
- * CHUNK_ALLOC_NO_FORCE means to only allocate a chunk
- * if we really need one.
- *
- * CHUNK_ALLOC_LIMITED means to only try and allocate one
- * if we have very few chunks already allocated.  This is
- * used as part of the clustering code to help make sure
- * we have a good pool of storage to cluster in, without
- * filling the FS with empty chunks
- *
- * CHUNK_ALLOC_FORCE means it must try to allocate one
- *
- */
-enum {
-	CHUNK_ALLOC_NO_FORCE = 0,
-	CHUNK_ALLOC_LIMITED = 1,
-	CHUNK_ALLOC_FORCE = 2,
-};
-
 /*
  * Declare a helper function to detect underflow of various space info members
  */
@@ -88,8 +68,6 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_ref_node *node,
 				     struct btrfs_delayed_extent_op *extent_op);
-static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
-			  int force);
 static int find_next_key(struct btrfs_path *path, int level,
 			 struct btrfs_key *key);
 static void dump_space_info(struct btrfs_fs_info *fs_info,
@@ -4143,8 +4121,8 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 			if (IS_ERR(trans))
 				return PTR_ERR(trans);
 
-			ret = do_chunk_alloc(trans, alloc_target,
-					     CHUNK_ALLOC_NO_FORCE);
+			ret = btrfs_chunk_alloc(trans, alloc_target,
+						CHUNK_ALLOC_NO_FORCE);
 			btrfs_end_transaction(trans);
 			if (ret < 0) {
 				if (ret != -ENOSPC)
@@ -4414,8 +4392,8 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
  */
-static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
-			  int force)
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+		      enum btrfs_chunk_alloc_enum force)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_space_info *space_info;
@@ -4879,10 +4857,10 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = do_chunk_alloc(trans,
-				     btrfs_metadata_alloc_profile(fs_info),
-				     (state == ALLOC_CHUNK) ?
-				      CHUNK_ALLOC_NO_FORCE : CHUNK_ALLOC_FORCE);
+		ret = btrfs_chunk_alloc(trans,
+				btrfs_metadata_alloc_profile(fs_info),
+				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
+					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
@@ -7674,8 +7652,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = do_chunk_alloc(trans, ffe_ctl->flags,
-					     CHUNK_ALLOC_FORCE);
+			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+						CHUNK_ALLOC_FORCE);
 
 			/*
 			 * If we can't allocate a new chunk we've already looped
@@ -9691,8 +9669,8 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	 */
 	alloc_flags = update_block_group_flags(fs_info, cache->flags);
 	if (alloc_flags != cache->flags) {
-		ret = do_chunk_alloc(trans, alloc_flags,
-				     CHUNK_ALLOC_FORCE);
+		ret = btrfs_chunk_alloc(trans, alloc_flags,
+					CHUNK_ALLOC_FORCE);
 		/*
 		 * ENOSPC is allowed here, we may have enough space
 		 * already allocated at the new raid level to
@@ -9708,7 +9686,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 	if (!ret)
 		goto out;
 	alloc_flags = get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = do_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	ret = inc_block_group_ro(cache, 0);
@@ -9729,7 +9707,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = get_alloc_profile(trans->fs_info, type);
 
-	return do_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 /*
-- 
2.14.3

