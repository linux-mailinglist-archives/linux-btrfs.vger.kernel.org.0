Return-Path: <linux-btrfs+bounces-5827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A497390F4D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CECB21FD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45EC155398;
	Wed, 19 Jun 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tAH3vv3m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tAH3vv3m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14494155738
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816961; cv=none; b=cz+aK8lW50tJL7zmXRx+sl4Amr3AkwF5EvnsHbbczvtQ05iCHh6KWhQ0DdKZp4KAtxJC6TIR5hZ1AQKc7zY0vtQmt0IDyysg12d/rDuTuS9riWLcc8KAObZkUgRHt4BGkLsB5vsXpZ+Yj5rk5a5GyxPEzbTKI/YqRjNjAI/EnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816961; c=relaxed/simple;
	bh=e4Yce0l7+RP87BVaWhQA7WB8wDkRGtnypxt6hpn6HOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP5xvUs28X5UtJEf3+qQRwKPgaf/V2YKE3cDGS1P8Wn366qyeA3ZDXN+TJ5hOFJGlnGXi4rsuZzYiAgmYYWMW2tWofEZtz6fTFHLgZw8M240i9zAJUQJ3rdTd9Ngj09ghAUenscPWuQ9ZVjJUzOAhM05ZsYevdx0wUepAQd/T80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tAH3vv3m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tAH3vv3m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27B99219F5;
	Wed, 19 Jun 2024 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCXkReH4dcfcSDRkr07Bo2SBhAKvkGBf6FLtJXVUiE0=;
	b=tAH3vv3mkqpFCmGVm+1bMdDJvrsSs6LR+45kgQQkxdA3yUPyTGU1I9vl8RAv/trSWkd7Mg
	Xeoj6JI7etcFwOsPdorth6oMwFyRsrzYO0aYjR5cp3d8WR4xiuXX1F0MMFgCboBxQVJ1wx
	FmvArSbRHd6/T9ZdCFxxSNO1XSlGJb8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCXkReH4dcfcSDRkr07Bo2SBhAKvkGBf6FLtJXVUiE0=;
	b=tAH3vv3mkqpFCmGVm+1bMdDJvrsSs6LR+45kgQQkxdA3yUPyTGU1I9vl8RAv/trSWkd7Mg
	Xeoj6JI7etcFwOsPdorth6oMwFyRsrzYO0aYjR5cp3d8WR4xiuXX1F0MMFgCboBxQVJ1wx
	FmvArSbRHd6/T9ZdCFxxSNO1XSlGJb8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21EE913668;
	Wed, 19 Jun 2024 17:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZpFCL4Qc2aNQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:09:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: qgroup: preallocate memory before adding a relation
Date: Wed, 19 Jun 2024 19:09:17 +0200
Message-ID: <950a5c2128b1ea79be6c7c438649b71201db00dc.1718816796.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1718816796.git.dsterba@suse.com>
References: <cover.1718816796.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

There's a transaction joined in the qgroup relation add/remove ioctl and
any error will lead to abort/error. We could lift the allocation from
btrfs_add_qgroup_relation() and move it outside of the transaction
context. The relation deletion does not need that.

The ownership of the structure is moved to the add relation handler.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c  | 20 ++++++++++++++++----
 fs/btrfs/qgroup.c | 25 ++++++++-----------------
 fs/btrfs/qgroup.h | 11 ++++++++++-
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d28ebabe3720..31c4aea8b93a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3829,6 +3829,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_qgroup_assign_args *sa;
+	struct btrfs_qgroup_list *prealloc = NULL;
 	struct btrfs_trans_handle *trans;
 	int ret;
 	int err;
@@ -3849,17 +3850,27 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		goto drop_write;
 	}
 
+	prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
+	if (!prealloc) {
+		ret = -ENOMEM;
+		goto drop_write;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
 	}
 
-	if (sa->assign) {
-		ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst);
-	} else {
+	/*
+	 * Prealloc ownership is moved to the relation handler, there it's used
+	 * or freed on error.
+	 */
+	if (sa->assign)
+		ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
+	else
 		ret = btrfs_del_qgroup_relation(trans, sa->src, sa->dst);
-	}
+	prealloc = NULL;
 
 	/* update qgroup status and info */
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
@@ -3873,6 +3884,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 		ret = err;
 
 out:
+	kfree(prealloc);
 	kfree(sa);
 drop_write:
 	mnt_drop_write_file(file);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3edbe5bb19c6..4ae01c87e418 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -155,16 +155,6 @@ static inline u64 btrfs_qgroup_get_new_refcnt(const struct btrfs_qgroup *qg, u64
 	return qg->new_refcnt - seq;
 }
 
-/*
- * glue structure to represent the relations between qgroups.
- */
-struct btrfs_qgroup_list {
-	struct list_head next_group;
-	struct list_head next_member;
-	struct btrfs_qgroup *group;
-	struct btrfs_qgroup *member;
-};
-
 static int
 qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		   int init_flags);
@@ -1568,15 +1558,21 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
+/*
+ * Add relation between @src and @dst qgroup. The @prealloc is allocated by the
+ * callers and transferred here (either used or freed on error).
+ */
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst,
+			      struct btrfs_qgroup_list *prealloc)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
-	struct btrfs_qgroup_list *prealloc = NULL;
 	int ret = 0;
 
+	ASSERT(prealloc);
+
 	/* Check the level of src and dst first */
 	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
 		return -EINVAL;
@@ -1601,11 +1597,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 		}
 	}
 
-	prealloc = kzalloc(sizeof(*list), GFP_NOFS);
-	if (!prealloc) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	ret = add_qgroup_relation_item(trans, src, dst);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 95881dcab684..deb479d176a9 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -278,6 +278,14 @@ struct btrfs_qgroup {
 	struct kobject kobj;
 };
 
+/* Glue structure to represent the relations between qgroups. */
+struct btrfs_qgroup_list {
+	struct list_head next_group;
+	struct list_head next_member;
+	struct btrfs_qgroup *group;
+	struct btrfs_qgroup *member;
+};
+
 struct btrfs_squota_delta {
 	/* The fstree root this delta counts against. */
 	u64 root;
@@ -321,7 +329,8 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 				     bool interruptible);
-int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
+int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst,
+			      struct btrfs_qgroup_list *prealloc);
 int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst);
 int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
-- 
2.45.0


