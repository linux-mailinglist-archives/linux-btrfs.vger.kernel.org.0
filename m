Return-Path: <linux-btrfs+bounces-426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C67F7FC7F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 22:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D65282E3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F744C71;
	Tue, 28 Nov 2023 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eLtc0C9J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53231BE6
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 13:30:26 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2472E1F899;
	Tue, 28 Nov 2023 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701207025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PZByOGeqk0VNkXziy/598j4MXu+H3cA961oYugFQ768=;
	b=eLtc0C9JyLeyZ/YQcmj88ZcrdSQfhsXGSQU6ZnGjEuziprM0ybDi6tg6lcR+qw0JV2wAML
	Rhp3Y9SdFnCyGxVw88MxYL8uvpA8kJx10Hvfk0KivdcBZU7fDzIbR8mpHtyen5gtM542hp
	vppt+xzNvTezZkp1zKSs6XFpGtAGGBc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 32F5A2C17D;
	Tue, 28 Nov 2023 21:30:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 67391DA86C; Tue, 28 Nov 2023 22:23:12 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: allocate btrfs_inode::file_extent_tree only without NO_HOLES
Date: Tue, 28 Nov 2023 22:23:06 +0100
Message-ID: <20231128212307.1838-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++
X-Spam-Score: 22.09
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=pass (smtp-out2.suse.de: domain of dsterba@suse.cz designates 149.44.160.134 as permitted sender) smtp.mailfrom=dsterba@suse.cz;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 2472E1F899
X-Spamd-Result: default: False [22.09 / 50.00];
	 RDNS_NONE(1.00)[];
	 BAYES_SPAM(5.10)[99.99%];
	 SPAMHAUS_XBL(0.00)[149.44.160.134:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 R_SPF_ALLOW(-0.20)[+ip4:149.44.0.0/16];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
	 R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u),ip(RLkk1mdgxgu4i4849a6y)];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_HAM_SHORT(-0.20)[-0.975];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 RDNS_DNSFAIL(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 HFILTER_HOSTNAME_UNKNOWN(2.50)[]

The file_extent_tree was added in 41a2ee75aab0 ("btrfs: introduce
per-inode file extent tree") so we have an explicit mapping of the file
extents to know where it is safe to update i_size. When the feature
NO_HOLES is enabled, and it's been a mkfs default since 5.15, the tree
is not necessary.

To save some space in the inode, allocate the tree only when necessary.
This reduces size by 16 bytes from 1096 to 1080 on a x86_64 release
config.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h    |  6 ++++--
 fs/btrfs/extent-io-tree.c |  2 ++
 fs/btrfs/file-item.c      |  6 +++---
 fs/btrfs/inode.c          | 23 ++++++++++++++++++-----
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 5572ae52444e..bfbd0d896fcf 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -107,9 +107,11 @@ struct btrfs_inode {
 
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
-	 * make sure the i_size adjustments are accurate
+	 * make sure the i_size adjustments are accurate. Not required when the
+	 * filesystem is NO_HOLES, the status can't be set while mounted as
+	 * it's a mkfs-time feature.
 	 */
-	struct extent_io_tree file_extent_tree;
+	struct extent_io_tree *file_extent_tree;
 
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index dbd201a99693..e3ee5449cc4a 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -962,6 +962,8 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 	struct extent_state *state;
 	int ret = 1;
 
+	ASSERT(!btrfs_fs_incompat(extent_io_tree_to_fs_info(tree), NO_HOLES));
+
 	spin_lock(&tree->lock);
 	state = find_first_extent_bit_state(tree, start, bits);
 	if (state) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 45cae356e89b..1f0110f48353 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -59,7 +59,7 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 		goto out_unlock;
 	}
 
-	ret = find_contiguous_extent_bit(&inode->file_extent_tree, 0, &start,
+	ret = find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
 					 &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
 		i_size = min(i_size, end + 1);
@@ -94,7 +94,7 @@ int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
-	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1,
+	return set_extent_bit(inode->file_extent_tree, start, start + len - 1,
 			      EXTENT_DIRTY, NULL);
 }
 
@@ -123,7 +123,7 @@ int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
 
 	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
 		return 0;
-	return clear_extent_bit(&inode->file_extent_tree, start,
+	return clear_extent_bit(inode->file_extent_tree, start,
 				start + len - 1, EXTENT_DIRTY, NULL);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 096b3004a19f..04bbcb6bf34b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8472,10 +8472,20 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_inode *ei;
 	struct inode *inode;
+	struct extent_io_tree *file_extent_tree = NULL;
+
+	/* Self tests may pass a NULL fs_info. */
+	if (fs_info && !btrfs_fs_incompat(fs_info, NO_HOLES)) {
+		file_extent_tree = kmalloc(sizeof(struct extent_io_tree), GFP_KERNEL);
+		if (!file_extent_tree)
+			return NULL;
+	}
 
 	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
-	if (!ei)
+	if (!ei) {
+		kfree(file_extent_tree);
 		return NULL;
+	}
 
 	ei->root = NULL;
 	ei->generation = 0;
@@ -8516,10 +8526,13 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO);
 	ei->io_tree.inode = ei;
 
-	extent_io_tree_init(fs_info, &ei->file_extent_tree,
-			    IO_TREE_INODE_FILE_EXTENT);
-	/* Lockdep class is set only for the file extent tree. */
-	lockdep_set_class(&ei->file_extent_tree.lock, &file_extent_tree_class);
+	ei->file_extent_tree = file_extent_tree;
+	if (file_extent_tree) {
+		extent_io_tree_init(fs_info, ei->file_extent_tree,
+				    IO_TREE_INODE_FILE_EXTENT);
+		/* Lockdep class is set only for the file extent tree. */
+		lockdep_set_class(&ei->file_extent_tree->lock, &file_extent_tree_class);
+	}
 	mutex_init(&ei->log_mutex);
 	spin_lock_init(&ei->ordered_tree_lock);
 	ei->ordered_tree = RB_ROOT;
-- 
2.42.1


