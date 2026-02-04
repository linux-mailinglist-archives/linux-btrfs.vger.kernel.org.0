Return-Path: <linux-btrfs+bounces-21373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O1cDexrg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21373-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:55:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F126BE9994
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1411301A923
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB5421F0C;
	Wed,  4 Feb 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX18NWfD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B633421F05
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220339; cv=none; b=KceGxtKRItwrfS2qxLWGQVAE7fUj5qBbxM0WfdcCZmHtfmzAW6BcnZuFBISXyiBvGLH0vRksbVZO7NS+9HRmPeu69Tvwwr2zJlK/OBCFtjqcJpvDO1iwRjMkTVq1pOMPCyoR7XDWtm82JCnxknIcxPbAVxDpvilyqQlaFscjF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220339; c=relaxed/simple;
	bh=2SQpGV7YVAH6BbP/c4t+mVXEgxSzxpPPOOx9rn8zCYc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kezAfVYLamYooiLfFARcnIPmCOcFEGkUjzGrsWZigi/DmIq7aQY1t3dJhOdqsKexpY9apmDu73oW7l8wKtie37lqghvV06L75kLYKZJ2bU8zvUaZ7PdOyLAxJZ3UilbsZDD2/F85wzCucEgcvZYsYV0PJ6NBaydCm/HfltnfkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX18NWfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B48EC116C6
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220338;
	bh=2SQpGV7YVAH6BbP/c4t+mVXEgxSzxpPPOOx9rn8zCYc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AX18NWfDeOTXuivvR9TvDOphPIKpZ1E+0mAXgfz9JKKoxT42Fpu1C2lM2okpZ9VLd
	 4oHJgq73y15zSeSY5qPMQIDGE8OO+EoXj0/mTh+/gw80TqMSOpegs5HPf1ViS30IGg
	 ooCJbNrI2LGXP6pJh05KRUhLae2XXXI5YjCD5gkjUNI2yDnSOfZ2u1RBsft3slciKx
	 c3qzZxE4TmDSdIvHkgjW+DKcJ5ia39igZMTlp2vRRhYDmKLaSerM/ywbbp7dR3EjOL
	 B5bRNIKYsM3fMpK932QyasOvaGYbb4Sdx87rPq+1UqOpNBCXnuSTuTn7P0Gmn+7lfK
	 Dr9pLs0tPgX3g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: remove max_mirrors argument from write_all_supers()
Date: Wed,  4 Feb 2026 15:52:03 +0000
Message-ID: <a7a8b95c9c2f5d5c6a481aea277194fa615b8390.1770212626.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21373-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F126BE9994
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass max_mirrors to write_all_supers() since from the
given transaction handle we can infer if we are in a transaction commit
or fsync context, so we can determine how many mirrors we need to use.

So remove the max_mirror argument from write_all_supers() and stop
adjusting it in the callees write_dev_supers() and wait_dev_supers(),
simplifying them besides the parameter list for write_all_supers().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c     | 24 +++++++++---------------
 fs/btrfs/disk-io.h     |  2 +-
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/tree-log.c    |  2 +-
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 19f7927a000d..cf4ab067be72 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3742,8 +3742,7 @@ static void btrfs_end_super_write(struct bio *bio)
  * Write superblock @sb to the @device. Do not wait for completion, all the
  * folios we use for writing are locked.
  *
- * Write @max_mirrors copies of the superblock, where 0 means default that fit
- * the expected device size at commit time. Note that max_mirrors must be
+ * Write @max_mirrors copies of the superblock. Note that max_mirrors must be
  * same for write and wait phases.
  *
  * Return number of errors when folio is not found or submission fails.
@@ -3759,9 +3758,6 @@ static int write_dev_supers(struct btrfs_device *device,
 
 	atomic_set(&device->sb_write_errors, 0);
 
-	if (max_mirrors == 0)
-		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
-
 	for (i = 0; i < max_mirrors; i++) {
 		struct folio *folio;
 		struct bio *bio;
@@ -3846,9 +3842,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	int ret;
 	u64 bytenr;
 
-	if (max_mirrors == 0)
-		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
-
 	for (i = 0; i < max_mirrors; i++) {
 		struct folio *folio;
 
@@ -4018,13 +4011,14 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 	return min_tolerated;
 }
 
-int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
+int write_all_supers(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct list_head *head;
 	struct btrfs_device *dev;
 	struct btrfs_super_block *sb;
 	struct btrfs_dev_item *dev_item;
+	int max_mirrors;
 	int ret;
 	int do_barriers;
 	int max_errors;
@@ -4033,13 +4027,13 @@ int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors)
 
 	do_barriers = !btrfs_test_opt(fs_info, NOBARRIER);
 
-	/*
-	 * max_mirrors == 0 indicates we're from commit_transaction,
-	 * not from fsync where the tree roots in fs_info have not
-	 * been consistent on disk.
-	 */
-	if (max_mirrors == 0)
+	if (trans->in_fsync) {
+		max_mirrors = 1;
+	} else {
+		/* We are called from transaction commit. */
+		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 		backup_super_roots(fs_info);
+	}
 
 	sb = fs_info->super_for_commit;
 	dev_item = &sb->dev_item;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 081a6860861c..163f5114973a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -58,7 +58,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num);
 int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
-int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors);
+int write_all_supers(struct btrfs_trans_handle *trans);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					const struct btrfs_key *key);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 08f691661874..aea84ac65ea7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2557,7 +2557,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
-	ret = write_all_supers(trans, 0);
+	ret = write_all_supers(trans);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
 	 * to go about their business
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ed5704e0a92c..e2806ca410f6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3569,7 +3569,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	btrfs_set_super_log_root(fs_info->super_for_commit, log_root_start);
 	btrfs_set_super_log_root_level(fs_info->super_for_commit, log_root_level);
-	ret = write_all_supers(trans, 1);
+	ret = write_all_supers(trans);
 	mutex_unlock(&fs_info->tree_log_mutex);
 	if (unlikely(ret)) {
 		btrfs_set_log_full_commit(trans);
-- 
2.47.2


