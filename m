Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3F428A93
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhJKKMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhJKKMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1369A1FDD0;
        Mon, 11 Oct 2021 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBX+Azrz587ByNkYjQXSH7bTqJuX8ggm5PSh1ozFl1U=;
        b=GpUN0cgjAb9NWH6EKM96QNRj4uln0dlmlae9eLfSW3yiBH9GS73FMma8Ph3lRexxdj9Ylv
        1GdkF3T873VsF+fCRhlX25/omFe065HnHyGV8EXm3C9uWbLH2iqPQdMFhKT7+MLGEYZAEg
        HvmOpfqxT47CzDtku/YuR90WtDDdY8s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C969313C4C;
        Mon, 11 Oct 2021 10:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aEaMLowNZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:20 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/5] btrfs: Rename root fields in delayed refs structs
Date:   Mon, 11 Oct 2021 13:10:15 +0300
Message-Id: <20211011101019.1409855-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011101019.1409855-1-nborisov@suse.com>
References: <20211011101019.1409855-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both data and metadata delayed ref structures have fields named
root/ref_root respectively. Those are somewhat cryptic and don't really
convey the real meaning. In fact those roots are really the original
owners of the respective block (i.e in case of a snapshot a data delref
will contain the original root that owns the given block). Rename those
fields accordingly and adjust comments.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.c | 13 +++++++------
 fs/btrfs/delayed-ref.h | 12 ++++++------
 fs/btrfs/extent-tree.c | 10 +++++-----
 fs/btrfs/ref-verify.c  |  4 ++--
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ca848b183474..53a80163c1d7 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -922,7 +922,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
 	    is_fstree(generic_ref->real_root) &&
-	    is_fstree(generic_ref->tree_ref.root) &&
+	    is_fstree(generic_ref->tree_ref.owning_root) &&
 	    !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
@@ -938,14 +938,15 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		ref_type = BTRFS_TREE_BLOCK_REF_KEY;
 
 	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
-				generic_ref->tree_ref.root, action, ref_type);
-	ref->root = generic_ref->tree_ref.root;
+				generic_ref->tree_ref.owning_root, action,
+				ref_type);
+	ref->root = generic_ref->tree_ref.owning_root;
 	ref->parent = parent;
 	ref->level = level;
 
 	init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
-			      generic_ref->tree_ref.root, 0, action, false,
-			      is_system);
+			      generic_ref->tree_ref.owning_root, 0, action,
+			      false, is_system);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -997,7 +998,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
-	u64 ref_root = generic_ref->data_ref.ref_root;
+	u64 ref_root = generic_ref->data_ref.owning_root;
 	u64 owner = generic_ref->data_ref.ino;
 	u64 offset = generic_ref->data_ref.offset;
 	u8 ref_type;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index e22fba272e4f..8826f3e2b809 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -186,8 +186,8 @@ enum btrfs_ref_type {
 struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
 
-	/* Root which refers to this data extent */
-	u64 ref_root;
+	/* Original root this data extent belongs to */
+	u64 owning_root;
 
 	/* Inode which refers to this data extent */
 	u64 ino;
@@ -210,11 +210,11 @@ struct btrfs_tree_ref {
 	int level;
 
 	/*
-	 * Root which refers to this tree block.
+	 * Root which owns this tree block.
 	 *
 	 * For TREE_BLOCK_REF (skinny metadata, either inline or keyed)
 	 */
-	u64 root;
+	u64 owning_root;
 
 	/* For non-skinny metadata, no special member needed */
 };
@@ -277,7 +277,7 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
 	if (!generic_ref->real_root)
 		generic_ref->real_root = root;
 	generic_ref->tree_ref.level = level;
-	generic_ref->tree_ref.root = root;
+	generic_ref->tree_ref.owning_root = root;
 	generic_ref->type = BTRFS_REF_METADATA;
 }
 
@@ -287,7 +287,7 @@ static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
 	/* If @real_root not set, use @root as fallback */
 	if (!generic_ref->real_root)
 		generic_ref->real_root = ref_root;
-	generic_ref->data_ref.ref_root = ref_root;
+	generic_ref->data_ref.owning_root = ref_root;
 	generic_ref->data_ref.ino = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ec5de19f0acd..de099de3829e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1396,7 +1396,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
 	       generic_ref->action);
 	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
-	       generic_ref->tree_ref.root == BTRFS_TREE_LOG_OBJECTID);
+	       generic_ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID);
 
 	if (generic_ref->type == BTRFS_REF_METADATA)
 		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
@@ -3372,9 +3372,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	 * tree, just update pinning info and exit early.
 	 */
 	if ((ref->type == BTRFS_REF_METADATA &&
-	     ref->tree_ref.root == BTRFS_TREE_LOG_OBJECTID) ||
+	     ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID) ||
 	    (ref->type == BTRFS_REF_DATA &&
-	     ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)) {
+	     ref->data_ref.owning_root == BTRFS_TREE_LOG_OBJECTID)) {
 		/* unlocks the pinned mutex */
 		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
 		ret = 0;
@@ -3385,9 +3385,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	}
 
 	if (!((ref->type == BTRFS_REF_METADATA &&
-	       ref->tree_ref.root == BTRFS_TREE_LOG_OBJECTID) ||
+	       ref->tree_ref.owning_root == BTRFS_TREE_LOG_OBJECTID) ||
 	      (ref->type == BTRFS_REF_DATA &&
-	       ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)))
+	       ref->data_ref.owning_root == BTRFS_TREE_LOG_OBJECTID)))
 		btrfs_ref_tree_mod(fs_info, ref);
 
 	return ret;
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index d2062d5f71dd..e2b9f8616501 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -678,10 +678,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 
 	if (generic_ref->type == BTRFS_REF_METADATA) {
 		if (!parent)
-			ref_root = generic_ref->tree_ref.root;
+			ref_root = generic_ref->tree_ref.owning_root;
 		owner = generic_ref->tree_ref.level;
 	} else if (!parent) {
-		ref_root = generic_ref->data_ref.ref_root;
+		ref_root = generic_ref->data_ref.owning_root;
 		owner = generic_ref->data_ref.ino;
 		offset = generic_ref->data_ref.offset;
 	}
-- 
2.25.1

