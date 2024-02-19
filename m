Return-Path: <linux-btrfs+bounces-2499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9F85A1B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13A91C21382
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE42C1A9;
	Mon, 19 Feb 2024 11:13:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082B2C191
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341227; cv=none; b=FNuSL2wtqnfvBPtY37/SJb46omjNgWXhYMZt1w56jDxRdrN9Nt+CUhMALnk0gSa0Scsxsp4vpgRGkdtn5rTLdZfwacWzQoAIqUC6MaPwzflPGVysKh023/+sa8kcBjUz/2UGkUQZWFCOeupQ4PhacLkj5U8OYgLBM0Dl13UYgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341227; c=relaxed/simple;
	bh=cwNcwjT7+njmqq0pKHWs4e4PXY4G+IOEYhi5GVntrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVIZ73neZe9CsVUOQnwshQsIIt0PDkJVUdX+5AS2yJA0ATTU22+lCmAFYWhKWww8ljmzBH9o9VCrxF2FxkURrdZAgEcrS/l2+Ef+WYAIWEz9AicObj+zTKMgiDDhPZO++ILwN3Gf50EnF+WhvVOTCDcllV1W15bmVHH20ifdscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10F231F7F2;
	Mon, 19 Feb 2024 11:13:44 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0F7139C6;
	Mon, 19 Feb 2024 11:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NjyxAug302WqZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/10] btrfs: uninline some static inline helpers from delayed-ref.h
Date: Mon, 19 Feb 2024 12:13:08 +0100
Message-ID: <ca15fcd3cd66392c15241199d588668f2f79a237.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 10F231F7F2
X-Spam-Flag: NO

The helpers are doing an initialization or release work, none of which
is performance critical that it would require a static inline, so move
them to the .c file.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-ref.c | 65 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h | 72 ++++--------------------------------------
 2 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 891ea2fa263c..7cfaec5dc806 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1004,6 +1004,52 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&ref->add_list);
 }
 
+void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u64 bytenr,
+			    u64 len, u64 parent, u64 owning_root)
+{
+	generic_ref->action = action;
+	generic_ref->bytenr = bytenr;
+	generic_ref->len = len;
+	generic_ref->parent = parent;
+	generic_ref->owning_root = owning_root;
+}
+
+void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
+			 u64 mod_root, bool skip_qgroup)
+{
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	/* If @real_root not set, use @root as fallback */
+	generic_ref->real_root = mod_root ?: root;
+#endif
+	generic_ref->tree_ref.level = level;
+	generic_ref->tree_ref.ref_root = root;
+	generic_ref->type = BTRFS_REF_METADATA;
+	if (skip_qgroup || !(is_fstree(root) &&
+			     (!mod_root || is_fstree(mod_root))))
+		generic_ref->skip_qgroup = true;
+	else
+		generic_ref->skip_qgroup = false;
+
+}
+
+void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u64 ino,
+			 u64 offset, u64 mod_root, bool skip_qgroup)
+{
+#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+	/* If @real_root not set, use @root as fallback */
+	generic_ref->real_root = mod_root ?: ref_root;
+#endif
+	generic_ref->data_ref.ref_root = ref_root;
+	generic_ref->data_ref.ino = ino;
+	generic_ref->data_ref.offset = offset;
+	generic_ref->type = BTRFS_REF_DATA;
+	if (skip_qgroup || !(is_fstree(ref_root) &&
+			     (!mod_root || is_fstree(mod_root))))
+		generic_ref->skip_qgroup = true;
+	else
+		generic_ref->skip_qgroup = false;
+}
+
 /*
  * add a delayed tree ref.  This does all of the accounting required
  * to make sure the delayed ref is eventually processed before this
@@ -1220,6 +1266,25 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
+{
+	if (refcount_dec_and_test(&ref->refs)) {
+		WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
+		switch (ref->type) {
+		case BTRFS_TREE_BLOCK_REF_KEY:
+		case BTRFS_SHARED_BLOCK_REF_KEY:
+			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
+			break;
+		case BTRFS_EXTENT_DATA_REF_KEY:
+		case BTRFS_SHARED_DATA_REF_KEY:
+			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
+			break;
+		default:
+			BUG();
+		}
+	}
+}
+
 /*
  * This does a simple search for the head node for a given extent.  Returns the
  * head node if found, or NULL if not.
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index cbd632f145f0..b291147cb8ab 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -318,53 +318,12 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes(const struct btrfs_fs_info *
 	return btrfs_calc_metadata_size(fs_info, num_csum_items);
 }
 
-static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
-					  int action, u64 bytenr, u64 len,
-					  u64 parent, u64 owning_root)
-{
-	generic_ref->action = action;
-	generic_ref->bytenr = bytenr;
-	generic_ref->len = len;
-	generic_ref->parent = parent;
-	generic_ref->owning_root = owning_root;
-}
-
-static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level,
-				       u64 root, u64 mod_root, bool skip_qgroup)
-{
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	/* If @real_root not set, use @root as fallback */
-	generic_ref->real_root = mod_root ?: root;
-#endif
-	generic_ref->tree_ref.level = level;
-	generic_ref->tree_ref.ref_root = root;
-	generic_ref->type = BTRFS_REF_METADATA;
-	if (skip_qgroup || !(is_fstree(root) &&
-			     (!mod_root || is_fstree(mod_root))))
-		generic_ref->skip_qgroup = true;
-	else
-		generic_ref->skip_qgroup = false;
-
-}
-
-static inline void btrfs_init_data_ref(struct btrfs_ref *generic_ref,
-				u64 ref_root, u64 ino, u64 offset, u64 mod_root,
-				bool skip_qgroup)
-{
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
-	/* If @real_root not set, use @root as fallback */
-	generic_ref->real_root = mod_root ?: ref_root;
-#endif
-	generic_ref->data_ref.ref_root = ref_root;
-	generic_ref->data_ref.ino = ino;
-	generic_ref->data_ref.offset = offset;
-	generic_ref->type = BTRFS_REF_DATA;
-	if (skip_qgroup || !(is_fstree(ref_root) &&
-			     (!mod_root || is_fstree(mod_root))))
-		generic_ref->skip_qgroup = true;
-	else
-		generic_ref->skip_qgroup = false;
-}
+void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u64 bytenr,
+			    u64 len, u64 parent, u64 owning_root);
+void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 root,
+			 u64 mod_root, bool skip_qgroup);
+void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u64 ino,
+			 u64 offset, u64 mod_root, bool skip_qgroup);
 
 static inline struct btrfs_delayed_extent_op *
 btrfs_alloc_delayed_extent_op(void)
@@ -379,24 +338,7 @@ btrfs_free_delayed_extent_op(struct btrfs_delayed_extent_op *op)
 		kmem_cache_free(btrfs_delayed_extent_op_cachep, op);
 }
 
-static inline void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
-{
-	if (refcount_dec_and_test(&ref->refs)) {
-		WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
-		switch (ref->type) {
-		case BTRFS_TREE_BLOCK_REF_KEY:
-		case BTRFS_SHARED_BLOCK_REF_KEY:
-			kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
-			break;
-		case BTRFS_EXTENT_DATA_REF_KEY:
-		case BTRFS_SHARED_DATA_REF_KEY:
-			kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
-			break;
-		default:
-			BUG();
-		}
-	}
-}
+void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref);
 
 static inline u64 btrfs_ref_head_to_space_flags(
 				struct btrfs_delayed_ref_head *head_ref)
-- 
2.42.1


