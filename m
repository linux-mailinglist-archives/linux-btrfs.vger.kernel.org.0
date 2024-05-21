Return-Path: <linux-btrfs+bounces-5139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B938CA6A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 05:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C441F217B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 03:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25F17545;
	Tue, 21 May 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bxJ0kymN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bxJ0kymN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F891B948
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260613; cv=none; b=mQ+6Oe/DCeXW1VLKIO9P1WT1ZeyHHsqTT3084aGxLQ0l4esR6xp5t76OHE/v/gvRnYYdPK/eT2GvXXkImGZ2WX/FXzj5COZEuFKWE4knd+4m+wZ9/iLr88mEgkM6eCxgtaXAVCQoHei67mnB5mK5V0Vn3+OTA/l0JDaLQNc2X3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260613; c=relaxed/simple;
	bh=iEEOAIsQ/jv97ufZDncSy6/4PyeRjPhq390LcG3x5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELE4Y07KuQ4nzhJnmc/IIs/trXQczzrTDqUmCmXZWweWGjrliZUJuC6IdtNEubS7bw6wU4tNzceB5Dr++pwgsxT2zStpznj+hQsTnoZvfOPrFghboPSVa+Aa+KDrHa0A/IfZgqZYk/IGbyoLb8tcrNIDb/E2YSVOcARsX6O4mPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bxJ0kymN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bxJ0kymN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AB015BE03;
	Tue, 21 May 2024 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716260609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58qXQpTHwTmu8DQjDhJ839Cv0awGPGtjZ7E9OfkU50w=;
	b=bxJ0kymNgjUfS0rN+X8SFf1tS1GDcPQptjWO5W0kAxWduA5g79dU2QXsGb2Ujt66XREWaZ
	z9zg3c48tNbOOH1c8om9gEu6qYaKhakbQxYkFePRHtv3QG+eaUI1IQKkPCjgOdTphs3fXs
	ESXp0g2YLiRMCemxN3vQBgr9UGjP8nM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716260609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58qXQpTHwTmu8DQjDhJ839Cv0awGPGtjZ7E9OfkU50w=;
	b=bxJ0kymNgjUfS0rN+X8SFf1tS1GDcPQptjWO5W0kAxWduA5g79dU2QXsGb2Ujt66XREWaZ
	z9zg3c48tNbOOH1c8om9gEu6qYaKhakbQxYkFePRHtv3QG+eaUI1IQKkPCjgOdTphs3fXs
	ESXp0g2YLiRMCemxN3vQBgr9UGjP8nM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ABD313A1E;
	Tue, 21 May 2024 03:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IaCDf8OTGYcKwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 21 May 2024 03:03:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 2/2] btrfs: automatically remove the subvolume qgroup
Date: Tue, 21 May 2024 12:33:17 +0930
Message-ID: <a87417408c6ad5d552e165b2781f11e601198bd5.1716260404.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716260404.git.wqu@suse.com>
References: <cover.1716260404.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently if we fully removed a subvolume (not only unlinked, but fully
dropped its root item), its qgroup would not be removed.

Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.

This patch changes the behavior by automatically removing the qgroup of
a fully dropped subvolume when possible:

- Full qgroup but still consistent
  We can and should remove the qgroup.
  The qgroup numbers should be 0, without any rsv.

- Full qgroup but inconsistent
  Can happen with drop_subtree_threshold feature (skip accounting
  and mark qgroup inconsistent).

  We can and should remove the qgroup.
  Higher level qgroup numbers will be incorrect, but since qgroup
  is already inconsistent, it should not be a problem.

- Squota mode
  This is the special case, we can only drop the qgroup if its numbers
  are all 0.

  This would be handled by can_delete_qgroup(), so we only need to check
  the return value and ignore the -EBUSY error.

Reviewed-by: Boris Burkov <boris@bur.io>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/qgroup.c      | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h      |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3774c191e36d..32f03c0a7b9e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5833,6 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
+	const u64 rootid = btrfs_root_id(root);
 	int err = 0;
 	int ret;
 	int level;
@@ -6063,6 +6064,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	kfree(wc);
 	btrfs_free_path(path);
 out:
+	if (!err && root_dropped) {
+		ret = btrfs_qgroup_cleanup_dropped_subvolume(fs_info, rootid);
+		if (ret < 0)
+			btrfs_warn_rl(fs_info,
+				      "failed to cleanup qgroup 0/%llu: %d",
+				      rootid, ret);
+	}
 	/*
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9b4de1b43298..826d972a7c75 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1893,6 +1893,44 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info,
+					   u64 subvolid)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	if (!is_fstree(subvolid) || !btrfs_qgroup_enabled(fs_info) ||
+	    !fs_info->quota_root)
+		return 0;
+
+	/*
+	 * Commit current transaction to make sure all the rfer/excl numbers
+	 * get updated.
+	 */
+	trans = btrfs_start_transaction(fs_info->quota_root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret < 0)
+		return ret;
+
+	/* Start new trans to delete the qgroup info and limit items. */
+	trans = btrfs_start_transaction(fs_info->quota_root, 2);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	ret = btrfs_remove_qgroup(trans, subvolid);
+	btrfs_end_transaction(trans);
+	/*
+	 * It's squota and the subvolume still has numbers needed
+	 * for future accounting, in this case we can not delete.
+	 * Just skip it.
+	 */
+	if (ret == -EBUSY)
+		ret = 0;
+	return ret;
+}
+
 int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit)
 {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 706640be0ec2..3f93856a02e1 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -327,6 +327,8 @@ int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 			      u64 dst);
 int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
+int btrfs_qgroup_cleanup_dropped_subvolume(struct btrfs_fs_info *fs_info,
+					   u64 subvolid);
 int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit);
 int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info);
-- 
2.45.1


