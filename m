Return-Path: <linux-btrfs+bounces-234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9227F2E44
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A8C28272B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B732D601;
	Tue, 21 Nov 2023 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L6SELW9R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC71D4F
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 05:27:25 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7BB01218FA;
	Tue, 21 Nov 2023 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700573243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RGR9XuOf/XjeK/kO7LX8Idr8qsgrqLn6h9hMf8kDXE=;
	b=L6SELW9Ru1VErdpmY0zBR38uzfI0PvX9c6R5JEELEmIKpgmjmGLfiKCxGXhnnaB43ir9Qp
	4yn3m6tksfyM/9HI6XLkER9sC55PUjhfjR/Dx99hR6Fp95AQ8YqYiqaDS8FbGIsn6Yr0AT
	RqVnCkAD3XiWm0aidoWuxQMjVtBc/qk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 6D3F02C146;
	Tue, 21 Nov 2023 13:27:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 72FD2DA86C; Tue, 21 Nov 2023 14:20:15 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: move lockdep class setting out of extent_io_tree_init
Date: Tue, 21 Nov 2023 14:20:15 +0100
Message-ID: <48497cb85be9e71663ed25f23c68ee9fd37aa8ba.1700572232.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700572232.git.dsterba@suse.com>
References: <cover.1700572232.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [22.00 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 22.00
X-Rspamd-Queue-Id: 7BB01218FA

The per-inode file extent tree was added in 41a2ee75aab0 ("btrfs:
introduce per-inode file extent tree"), it's the only tree type
that requires the lockdep class. Move it to the file where it is
actually used.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 10 ----------
 fs/btrfs/inode.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 76061245a46b..56be64e656da 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -78,14 +78,6 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
-/*
- * For the file_extent_tree, we want to hold the inode lock when we lookup and
- * update the disk_i_size, but lockdep will complain because our io_tree we hold
- * the tree lock and get the inode lock when setting delalloc.  These two things
- * are unrelated, so make a class for the file_extent_tree so we don't get the
- * two locking patterns mixed up.
- */
-static struct lock_class_key file_extent_tree_class;
 
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner)
@@ -95,8 +87,6 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&tree->lock);
 	tree->inode = NULL;
 	tree->owner = owner;
-	if (owner == IO_TREE_INODE_FILE_EXTENT)
-		lockdep_set_class(&tree->lock, &file_extent_tree_class);
 }
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 844e800160f1..9e7b44c2fbce 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -114,6 +114,15 @@ struct data_reloc_warn {
 	int mirror_num;
 };
 
+/*
+ * For the file_extent_tree, we want to hold the inode lock when we lookup and
+ * update the disk_i_size, but lockdep will complain because our io_tree we hold
+ * the tree lock and get the inode lock when setting delalloc. These two things
+ * are unrelated, so make a class for the file_extent_tree so we don't get the
+ * two locking patterns mixed up.
+ */
+static struct lock_class_key file_extent_tree_class;
+
 static const struct inode_operations btrfs_dir_inode_operations;
 static const struct inode_operations btrfs_symlink_inode_operations;
 static const struct inode_operations btrfs_special_inode_operations;
@@ -8506,6 +8515,8 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_tree.inode = ei;
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT);
+	/* Lockdep class is set only for the file extent tree. */
+	lockdep_set_class(&ei->file_extent_tree.lock, &file_extent_tree_class);
 	mutex_init(&ei->log_mutex);
 	spin_lock_init(&ei->ordered_tree_lock);
 	ei->ordered_tree = RB_ROOT;
-- 
2.42.1


