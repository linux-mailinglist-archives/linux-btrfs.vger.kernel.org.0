Return-Path: <linux-btrfs+bounces-19875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98984CCE088
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 01:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25093033716
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 00:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A16F06A;
	Fri, 19 Dec 2025 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMx6hm3y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMx6hm3y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11B3D76
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103199; cv=none; b=PE31QGkNk7oIIUQiO2ZxUc8mYIleobamMm5L84CIXopCiKIQXzgSqY8BY63yaNjcJ8QtF/RcHHsiaX37kcDX6Pib6gIcW7hLKqjzSMssgNbM9rsiPt54qi5A9Q3ydEpSodZAIH7hx2s8cETMNNaTEj8ZHnPcuV8+xswFRpsGpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103199; c=relaxed/simple;
	bh=NYuSw9sIeaFTjeP0e4ZyzXteG/LUBmwzvuqn33Td3Gg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PkvQIfiL1O5zrMAsRxdq0maQ8aN63I3qcNamR9CuGeVnIhmHC6qn5YdpMDHONiaQqWvCYdSxZ2Cmg4fAPDcR7g9b9vFrw7X9b7T+y/68y+OTSaUJwvlcQeTz1curY8KobfcpApmoAQ7aTzW5LzLHiD+e/1V5nw5F0I75kMTnFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMx6hm3y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMx6hm3y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 065A05BD40
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766103191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3X6roCCwU46ADsb5nZGkmmwhCkGhnDiQQm+cjBRXkE=;
	b=oMx6hm3ytDa2bCoR0EiZ8EeLOqAjR7TixIIwkzG+3d5CC1gpS4JDyRTVUoD9lYvmvsKBOn
	KV7Dp08KrCbGPWoOnI3kMvtknGodyZSefwZY65WsZMu3+0tCXWvJvzCA7UT3eGm3HXx45D
	r9xWnbUu8Y3mEuRT22Bmzs7sdIYaQDM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766103191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/3X6roCCwU46ADsb5nZGkmmwhCkGhnDiQQm+cjBRXkE=;
	b=oMx6hm3ytDa2bCoR0EiZ8EeLOqAjR7TixIIwkzG+3d5CC1gpS4JDyRTVUoD9lYvmvsKBOn
	KV7Dp08KrCbGPWoOnI3kMvtknGodyZSefwZY65WsZMu3+0tCXWvJvzCA7UT3eGm3HXx45D
	r9xWnbUu8Y3mEuRT22Bmzs7sdIYaQDM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 426763EA63
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 00:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VGW1AZaYRGnBJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 00:13:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add mount time auto fix for orphan fst entries
Date: Fri, 19 Dec 2025 10:42:48 +1030
Message-ID: <5dae1d847245b578d71498adbd38bc1b588d3753.1766103074.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.68
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.403];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

[BUG]
Before btrfs-progs v6.16.1 release, mkfs.btrfs can leave free space tree
entries for deleted chunks:

 # mkfs.btrfs -f -O fst $dev
 # btrfs ins dump-tree -t chunk $dev
 btrfs-progs v6.16
 chunk tree
 leaf 22036480 items 4 free space 15781 generation 8 owner CHUNK_TREE
 leaf 22036480 flags 0x1(WRITTEN) backref revision 1
	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
        ^^^ The first chunk is at 13631488
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112

 # btrfs ins dump-tree -t free-space-tree $dev
 btrfs-progs v6.16
 free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
 leaf 30556160 items 13 free space 15918 generation 8 owner FREE_SPACE_TREE
 leaf 30556160 flags 0x1(WRITTEN) backref revision 1
 	item 0 key (1048576 FREE_SPACE_INFO 4194304) itemoff 16275 itemsize 8
		free space info extent count 1 flags 0
	item 1 key (1048576 FREE_SPACE_EXTENT 4194304) itemoff 16275 itemsize 0
		free space extent
	item 2 key (5242880 FREE_SPACE_INFO 8388608) itemoff 16267 itemsize 8
		free space info extent count 1 flags 0
	item 3 key (5242880 FREE_SPACE_EXTENT 8388608) itemoff 16267 itemsize 0
		free space extent
	^^^ Above 4 items are all before the first chunk.
	item 4 key (13631488 FREE_SPACE_INFO 8388608) itemoff 16259 itemsize 8
		free space info extent count 1 flags 0
	item 5 key (13631488 FREE_SPACE_EXTENT 8388608) itemoff 16259 itemsize 0
		free space extent
	...

This can trigger btrfs check errors.

[CAUSE]
It's a bug in free space tree implementation of btrfs-progs, which
doesn't delete involved fst entries for the to-be-deleted chunk/block
group.

[ENHANCEMENT]
The mostly common fix is to clear the space cache and rebuild it, but
that requires a ro->rw remount which may not be possible for rootfs,
and also relies on users to use "clear_cache" mount option manually.

Here introduce a kernel fix for it, which will delete any entries that
is before the first block group automatically at the first RW mount.

For fses without such problem, the overhead is just a single tree
search and no modification to the free space tree, thus the overhead
should be minimal.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Do not output the "deleted orphan free space tree entries" for error
- Do not return >0 for delete_orphan_free_space_entries()
  If we deleted a full leaf and the next item matches the first bg, we
  will return 1. This should not happen in the real world though.
- Add a comment for the inner for() loop break
  For double loop, we need to take care of which loop we're breaking
  out.
---
 fs/btrfs/disk-io.c         |  10 ++++
 fs/btrfs/free-space-tree.c | 102 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-tree.h |   1 +
 3 files changed, 113 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e5535bdc5b0c..ebef65f6ea12 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3034,6 +3034,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	/*
+	 * Before btrfs-progs v6.16.1 mkfs.btrfs can leave free space entries
+	 * for deleted temporary chunks.
+	 * Delete them if needed.
+	 */
+	ret = btrfs_fix_orphan_free_space_entries(fs_info);
+	if (ret < 0) {
+		btrfs_warn(fs_info, "failed to fix orphan free space tree entries: %d", ret);
+		goto out;
+	}
 	/*
 	 * btrfs_find_orphan_roots() is responsible for finding all the dead
 	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a66ce9ef3aff..e14e508cb125 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1710,3 +1710,105 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
 	else
 		return load_free_space_extents(caching_ctl, path, extent_count);
 }
+
+static int delete_orphan_free_space_entries(struct btrfs_root *fst_root,
+					    struct btrfs_path *path,
+					    u64 first_bg_bytenr)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_start_transaction(fst_root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	while (true) {
+		struct btrfs_key key = { 0 };
+		int i;
+
+		ret = btrfs_search_slot(trans, fst_root, &key, path, -1, 1);
+		if (ret < 0)
+			break;
+		ASSERT(ret > 0);
+		ret = 0;
+		for (i = 0; i < btrfs_header_nritems(path->nodes[0]); i++) {
+			btrfs_item_key_to_cpu(path->nodes[0], &key, i);
+			if (key.objectid >= first_bg_bytenr)
+				/*
+				 * Only break the for() loop and continue to
+				 * delete items.
+				 */
+				break;
+		}
+		/* No item to delete, finished. */
+		if (i == 0)
+			break;
+
+		ret = btrfs_del_items(trans, fst_root, path, 0, i);
+		if (ret < 0)
+			break;
+		btrfs_release_path(path);
+	}
+	btrfs_release_path(path);
+	btrfs_end_transaction(trans);
+	if (ret == 0)
+		btrfs_info(fst_root->fs_info, "deleted orphan free space tree entries");
+	return ret;
+}
+/* Remove any free space entry before the first block group. */
+int btrfs_fix_orphan_free_space_entries(struct btrfs_fs_info *fs_info)
+{
+	BTRFS_PATH_AUTO_RELEASE(path);
+	struct btrfs_key key = {
+		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = 0,
+	};
+	struct btrfs_root *root;
+	struct btrfs_block_group *bg;
+	u64 first_bg_bytenr;
+	int ret;
+
+	/*
+	 * Extent tree v2 have multiple global roots based on the block group.
+	 * This means we can not easily grab the global free space tree and locate
+	 * orphan items.
+	 * Furthermore this is still experimental, all users should use the latest
+	 * btrfs-progs anyway.
+	 */
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return 0;
+	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		return 0;
+	root = btrfs_global_root(fs_info, &key);
+	if (!root)
+		return 0;
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	bg = btrfs_lookup_first_block_group(fs_info, 0);
+	if (unlikely(!bg)) {
+		btrfs_err(fs_info, "no block group found");
+		return -EUCLEAN;
+	}
+	first_bg_bytenr = bg->start;
+	btrfs_put_block_group(bg);
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	/* There should not be an all-zero key in fst. */
+	ASSERT(ret > 0);
+
+	/* Empty free space tree. */
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+		return 0;
+
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	if (key.objectid >= first_bg_bytenr)
+		return 0;
+	btrfs_release_path(&path);
+	return delete_orphan_free_space_entries(root, &path, first_bg_bytenr);
+}
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 3d9a5d4477fc..c6958976e9c9 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				 u64 start, u64 size);
 int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				      u64 start, u64 size);
+int btrfs_fix_orphan_free_space_entries(struct btrfs_fs_info *fs_info);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
-- 
2.52.0


