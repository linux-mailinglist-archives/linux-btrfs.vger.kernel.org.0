Return-Path: <linux-btrfs+bounces-15200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F71AF5B2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7A31BC3D6E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C117307AF0;
	Wed,  2 Jul 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kl/Az01/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z5k9kuCO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBC307AD9
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Jul 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466849; cv=none; b=K40LIL6o6FM0mEFY9VfnHx9AH7sH29BLfxctgfnKQzx6+UxjXhlEWflZ3sdZzRhcV4IZY+paY/5QJRX7aZWxw8CvuoPsxomFV6PhLCXxx8b5yDSEiwmkNtE0YnVHO6Z1jtEyyXXSfpxSJw6TrA1xKz2VqZYM9o+qIFMrbeOptSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466849; c=relaxed/simple;
	bh=2/UEutgTQfflgTf1DLKa+/34CWva74L2+MlwiwC2SfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srK5jAseGFpzN2Jkb92aF1QuTe64C6RtjYoHfLuNr5BFMfe+/Dg1LWlACQFDJo0kOnP6eQifvK2TIIMcemDL68n55oGvV0VAm89ekhTzXkJOR55IORC9dJQVd5SpsNYjfsQSsRqZHGs9KYQx/YgSDtUeyuN9enXYiaeV/9KugCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kl/Az01/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z5k9kuCO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CED21F38D;
	Wed,  2 Jul 2025 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751466845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5bp79PfypN2Vx5YlgnEwv32DQfsLvdgioUHqALsiK70=;
	b=kl/Az01/LAKY7jK5rIyITmbh4lv7ZqAOhnp4QpO8vucMJy7FUdBXN/Sda1hvl0dKc2s2hi
	+jsh112JeiGqPCsbO7cjPmvcxr7uUDzmadQYSmk4hlFqc/8G8QBwLgFQd+26sCU5ckuZX7
	kaZVdmrU7/RtNh3R4uVaKLj+Gg23NPY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z5k9kuCO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751466844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5bp79PfypN2Vx5YlgnEwv32DQfsLvdgioUHqALsiK70=;
	b=Z5k9kuCOPyKWS4tjRBiuFSCA0vRgmqLOtRN/TzNt7eWewyNXCepct9xoGpL/764h98CNJS
	9te+mqsj9TCK0KB9DYgbH7P/pLjse9WMd5TmU/c/tMwl8gkt59BvhtMEBjIM3XA5Jv5QDe
	L0OZJHjqVRCx0jX6CwZeAi4HH3vNO64=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7586C13A24;
	Wed,  2 Jul 2025 14:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cj6vHFxDZWh8RwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 02 Jul 2025 14:34:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: convert several int parameters to bool
Date: Wed,  2 Jul 2025 16:34:03 +0200
Message-ID: <20250702143403.931542-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7CED21F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

We're almost done cleaning the misused int/bool parameters. Convert a
few of them, found by manual grepping as we don't have a tool for that.
Note that btrfs_sync_fs() needs an int as it' mandated by the struct
super_operations prototype.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/ctree.c          | 14 +++++++-------
 fs/btrfs/extent-io-tree.c |  2 +-
 fs/btrfs/extent-io-tree.h |  2 +-
 fs/btrfs/scrub.c          |  6 +++---
 fs/btrfs/scrub.h          |  2 +-
 fs/btrfs/transaction.c    |  2 +-
 fs/btrfs/volumes.c        |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fb62a8cf03b32a..9bfde605f00192 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1336,7 +1336,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
  * data in this block group. That check should be done by relocation routine,
  * not this function.
  */
-static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
+static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 74e6d7f3d2660e..a56ea3f5533e5a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -30,10 +30,10 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
 		      *root, struct btrfs_path *path, int level);
 static int split_leaf(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *ins_key, struct btrfs_path *path,
-		      int data_size, int extend);
+		      int data_size, bool extend);
 static int push_node_left(struct btrfs_trans_handle *trans,
 			  struct extent_buffer *dst,
-			  struct extent_buffer *src, int empty);
+			  struct extent_buffer *src, bool empty);
 static int balance_node_right(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *dst_buf,
 			      struct extent_buffer *src_buf);
@@ -2686,7 +2686,7 @@ static bool check_sibling_keys(const struct extent_buffer *left,
  */
 static int push_node_left(struct btrfs_trans_handle *trans,
 			  struct extent_buffer *dst,
-			  struct extent_buffer *src, int empty)
+			  struct extent_buffer *src, bool empty)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int push_items = 0;
@@ -3102,7 +3102,7 @@ int btrfs_leaf_free_space(const struct extent_buffer *leaf)
  */
 static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 				      struct btrfs_path *path,
-				      int data_size, int empty,
+				      int data_size, bool empty,
 				      struct extent_buffer *right,
 				      int free_space, u32 left_nritems,
 				      u32 min_slot)
@@ -3239,7 +3239,7 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 			   *root, struct btrfs_path *path,
 			   int min_data_size, int data_size,
-			   int empty, u32 min_slot)
+			   bool empty, u32 min_slot)
 {
 	struct extent_buffer *left = path->nodes[0];
 	struct extent_buffer *right;
@@ -3316,7 +3316,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
  */
 static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 				     struct btrfs_path *path, int data_size,
-				     int empty, struct extent_buffer *left,
+				     bool empty, struct extent_buffer *left,
 				     int free_space, u32 right_nritems,
 				     u32 max_slot)
 {
@@ -3642,7 +3642,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       const struct btrfs_key *ins_key,
 			       struct btrfs_path *path, int data_size,
-			       int extend)
+			       bool extend)
 {
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *l;
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 66361325f6dcea..0c58342c6125e1 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1664,7 +1664,7 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  */
 u64 btrfs_count_range_bits(struct extent_io_tree *tree,
 			   u64 *start, u64 search_end, u64 max_bytes,
-			   u32 bits, int contig,
+			   u32 bits, bool contig,
 			   struct extent_state **cached_state)
 {
 	struct extent_state *state = NULL;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 819da07bff0950..676283889b890e 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -163,7 +163,7 @@ void __cold btrfs_extent_state_free_cachep(void);
 
 u64 btrfs_count_range_bits(struct extent_io_tree *tree,
 			   u64 *start, u64 search_end,
-			   u64 max_bytes, u32 bits, int contig,
+			   u64 max_bytes, u32 bits, bool contig,
 			   struct extent_state **cached_state);
 
 void btrfs_free_extent_state(struct extent_state *state);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 6776e6ab8d1080..ce5f6732bfb585 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -206,7 +206,7 @@ struct scrub_ctx {
 	ktime_t			throttle_deadline;
 	u64			throttle_sent;
 
-	int			is_dev_replace;
+	bool			is_dev_replace;
 	u64			write_pointer;
 
 	struct mutex            wr_lock;
@@ -446,7 +446,7 @@ static void scrub_put_ctx(struct scrub_ctx *sctx)
 }
 
 static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
-		struct btrfs_fs_info *fs_info, int is_dev_replace)
+		struct btrfs_fs_info *fs_info, bool is_dev_replace)
 {
 	struct scrub_ctx *sctx;
 	int		i;
@@ -3013,7 +3013,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
-		    int readonly, int is_dev_replace)
+		    bool readonly, bool is_dev_replace)
 {
 	struct btrfs_dev_lookup_args args = { .devid = devid };
 	struct scrub_ctx *sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index f0df597b75c7c7..aa68b6ebaf555c 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -11,7 +11,7 @@ struct btrfs_scrub_progress;
 
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
-		    int readonly, int is_dev_replace);
+		    bool readonly, bool is_dev_replace);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2e07c90be5cd15..bc840dceaef010 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -404,7 +404,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
  */
 static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
-			       int force)
+			       bool force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 21b1fbc741c472..819ba22cd1cea1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4262,7 +4262,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
  * @flags:     profile to validate
  * @extended:  if true @flags is treated as an extended profile
  */
-static int alloc_profile_is_valid(u64 flags, int extended)
+static int alloc_profile_is_valid(u64 flags, bool extended)
 {
 	u64 mask = (extended ? BTRFS_EXTENDED_PROFILE_MASK :
 			       BTRFS_BLOCK_GROUP_PROFILE_MASK);
-- 
2.49.0


