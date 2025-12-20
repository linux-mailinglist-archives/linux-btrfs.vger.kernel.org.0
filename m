Return-Path: <linux-btrfs+bounces-19914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3ACD25BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 03:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A703300F3AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3243B19F;
	Sat, 20 Dec 2025 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SOVdsuxx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F/jm1owX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB4211290
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766198295; cv=none; b=Y7jEFCtld8lgZX021r/vGeB4ts6TzcbTrEVeMEUmLzDoC33fUZt6Qqy2Pl/lQws9Kxd0VUEQgV/72Vgcahi5BS6CL5OAHJbYrWrL3BoEiCrL/MayvFT/CK4k6e0fgvIti8N/AC059SQSmnwk3UVRN3yovpfWdoJbRCH5xf47Bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766198295; c=relaxed/simple;
	bh=jq330hVbjCTcJ9dvBSQ5TtMbv6N5v1z+1vs0MpY2X+w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a71VCtvcdHe3oXPty9gNwT0oGSB7z9UFr47w36nNWtZZQQZfoHBg7Vsd1KEIsxbdKOvitHcpGMooYfFfjy4svIl1oW5aGilPuIDqUZf+I7zXsG56MU6JB+Rs3C5CmLTIhoqaoCp0AoZsgo4xCldPeGG/B3PibB378cJRBwz03T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SOVdsuxx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F/jm1owX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 625365BCD3
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766198288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8s70FmD1I5K/C9Ed29L7KqtDu9wrtMd3GASzoa6A6FU=;
	b=SOVdsuxx5FtugFHoej5qyYpJGEgi9GlNHegdJUbrRSKskmbOGR3rjjWG7CFrPUlucfdKay
	r30cn/zQxhZiLxnBmqc3BKs8vA6zJ5JRW0vVnUzHOOzeAnw8iifMPF4uOVmEIrIGQt8HBT
	WR+0hpgfnT+2hQwZslaAb34irZt4rdc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="F/jm1owX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766198287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8s70FmD1I5K/C9Ed29L7KqtDu9wrtMd3GASzoa6A6FU=;
	b=F/jm1owX2b4rKnIGUmcl8RDcj1hqg0CVJt/OmZcQ1WyLbpKWZWyz8CdYl9cjQJU2+zPT0e
	hjV9XB6hXrIYHYaAwEtWYf36Ol4DRpSx6xyA36a8sqf6ZcCFt84QNbflcGau28BIs93+NX
	IdoC780+XkA4BXo7RNedSffVMCRWG64=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ABED1376C
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 02:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXrtFg4MRmlQRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 02:38:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: add mount time auto fix for orphan fst entries
Date: Sat, 20 Dec 2025 13:07:40 +1030
Message-ID: <f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 625365BCD3
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

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
v3:
- Rename the exported function to btrfs_delete_orphan_free_space_entries()
  And minor rewords.
- Use btrfs_err() if we failed to delete the orphan fst entries
- Various grammar and code style fixes

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
 fs/btrfs/free-space-tree.c | 104 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/free-space-tree.h |   1 +
 3 files changed, 115 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e5535bdc5b0c..1015185c80ae 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3034,6 +3034,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	/*
+	 * Before btrfs-progs v6.16.1 mkfs.btrfs can leave free space entries
+	 * for deleted temporary chunks.
+	 * Delete them if they exist.
+	 */
+	ret = btrfs_delete_orphan_free_space_entries(fs_info);
+	if (ret < 0) {
+		btrfs_err(fs_info, "failed to delete orphan free space tree entries: %d", ret);
+		goto out;
+	}
 	/*
 	 * btrfs_find_orphan_roots() is responsible for finding all the dead
 	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a66ce9ef3aff..e949dc3e5cd0 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1710,3 +1710,107 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
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
+			if (key.objectid >= first_bg_bytenr) {
+				/*
+				 * Only break the for() loop and continue to
+				 * delete items.
+				 */
+				break;
+			}
+		}
+		/* No items to delete, finished. */
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
+
+/* Remove any free space entry before the first block group. */
+int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info)
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
+	 * Extent tree v2 has multiple global roots based on the block group.
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
index 3d9a5d4477fc..ca04fc7cf29e 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 				 u64 start, u64 size);
 int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 				      u64 start, u64 size);
+int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_free_space_info *
-- 
2.52.0


