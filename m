Return-Path: <linux-btrfs+bounces-4798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F038BDBF4
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 08:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB891C21A6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C57A702;
	Tue,  7 May 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aS9gPml6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aS9gPml6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49D78C8A
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065119; cv=none; b=iIOR63RqMefuYQCzIxJxwH75h48ruIgiVhllRN0Q/1RHdiH6J5XvBPxbZHFAuFaWkMGiWjtqPA3yFnx73wFlX55n9N8DcnC4mS4r+PAqxzDEdLrsPf5gTaFBt8WXMeiw1wTRugyjcfROcSNEebytfPUFni3L+82YuT9YJTbD73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065119; c=relaxed/simple;
	bh=VmPQCViTBl9+jXM+kgpT441+PxQQey7XqNFzZoPOL2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPOVPDHwfzavShuR9Ldzc6oBXJNOhwELSkIfnLnB0qIQaq+5PV4g7jc0UzZSfsJoy2YJgDZPIMAA8LfowwaPqxTyck/3+eFQ6pK+0IxobdYpa7Kl/4D6SEK4nlJ7lB8F3oA9dF2LaY6e2dhl/e/9gyeKJ8PUg6vedXvvtoJn5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aS9gPml6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aS9gPml6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A65933A81
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4rDEY/FPAs42ZhLwFqTq2vBLet3/myxXDT5K28dtdk=;
	b=aS9gPml641O0DWzxC5E5dVpUzMgqzHuDF/J1ucfHM38Y1AFgyxfKH/yVcWVb/4EYZpbdw7
	vbbAd90Y9Bs7mMqGziofkt6pVx8PCbm1oBFEYYDBVDxdreP2geYUVs7fl2LrZQaQ0ncWe0
	t80hMyz1PnPiU/gjF3UcC/tFKMPyZ8c=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aS9gPml6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4rDEY/FPAs42ZhLwFqTq2vBLet3/myxXDT5K28dtdk=;
	b=aS9gPml641O0DWzxC5E5dVpUzMgqzHuDF/J1ucfHM38Y1AFgyxfKH/yVcWVb/4EYZpbdw7
	vbbAd90Y9Bs7mMqGziofkt6pVx8PCbm1oBFEYYDBVDxdreP2geYUVs7fl2LrZQaQ0ncWe0
	t80hMyz1PnPiU/gjF3UcC/tFKMPyZ8c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85B7E139CB
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WEF2DhjROWbSGAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 06:58:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: automatically remove the subvolume qgroup
Date: Tue,  7 May 2024 16:28:11 +0930
Message-ID: <90a4ae6ae4be63ef4df3d020707fb7b1ae004634.1715064550.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715064550.git.wqu@suse.com>
References: <cover.1715064550.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:url,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6A65933A81
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

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

Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/qgroup.c      | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h      |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47d48233b592..21e07b698625 100644
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
index d89f16366a1c..d894a7e2bf30 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1864,6 +1864,44 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
2.45.0


