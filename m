Return-Path: <linux-btrfs+bounces-4428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E114D8AABB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4291F21E32
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572057D3E3;
	Fri, 19 Apr 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tpselb68";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tpselb68"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391973518
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520039; cv=none; b=IZGxp96sNEbS62/6/2ByYkFpjCP1qRpzUbRnSo4AXFyOcS/Xhci2HgO6ywzmvIoykNdgQ/gWIuBxEWGfuWMeIiuzedbP37XLuxy8bSJkhSWJr3wnBp40E3Kht6bv4/b4OxPLM6NYxXX8fYmvnDSs/qSqI+ClmH6Rw9kfh856Ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520039; c=relaxed/simple;
	bh=f/U1szLkBGHFXMq+lvd9GhRPLqKrauZXVQOZeRxbIzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VErTwqd9+zbCRmuH2LbsEggDQZoaNrO8ihspjV6zyzXj8709PoEL0IHhxH6qRQtUjCmGoJkvs+LBPzwz0s6WoijCN3vyzmaPilpHJnXT9IasQsPkGzWztb2+3d5/1fMytU5djEmfvOIvrPECC/1mnzo7/Yh/fvppPxEMPKHR2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tpselb68; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tpselb68; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE6A734780;
	Fri, 19 Apr 2024 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLfRv8qfTsvXd+JRd1weImNR+GTlHS1oA12goDKcSuA=;
	b=tpselb68DrKx2QRhHK3VUHAhR8C43ORkIxFeIbs1zrwNcs0c03GAdvA4GbaqvZfOY+IN0b
	i+aq5kUDbVyizMzY43KwcfWKlKkF/Agjchj6ESnn7hn8KigIfoI65rgx+qKHUFGRYOQLRP
	rDr/nvBTq1uhFU9dxonak6nk6KLZmsY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tpselb68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLfRv8qfTsvXd+JRd1weImNR+GTlHS1oA12goDKcSuA=;
	b=tpselb68DrKx2QRhHK3VUHAhR8C43ORkIxFeIbs1zrwNcs0c03GAdvA4GbaqvZfOY+IN0b
	i+aq5kUDbVyizMzY43KwcfWKlKkF/Agjchj6ESnn7hn8KigIfoI65rgx+qKHUFGRYOQLRP
	rDr/nvBTq1uhFU9dxonak6nk6KLZmsY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A431C136CF;
	Fri, 19 Apr 2024 09:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIKFGaI9ImafBwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Apr 2024 09:47:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: boris@bur.io
Subject: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Date: Fri, 19 Apr 2024 19:16:53 +0930
Message-ID: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713519718.git.wqu@suse.com>
References: <cover.1713519718.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE6A734780
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email,suse.com:url];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]

Currently if we fully removed a subvolume (not only unlinked, but fully
dropped its root item), its qgroup would not be removed.

Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.

This patch changes the behavior by automatically removing the qgroup of
a fully dropped subvolume.

There is an exception for simple quota, that btrfs_record_squota_delta()
has to handle missing qgroup case, where the target delta belongs to an
automatically deleted subvolume.
In that case since the subvolume is already gone, no need to treat it as
an error.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/qgroup.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/qgroup.h      |  2 ++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 023920d0d971..1e2caa234146 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5834,6 +5834,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct walk_control *wc;
 	struct btrfs_key key;
+	const u64 rootid = btrfs_root_id(root);
 	int err = 0;
 	int ret;
 	int level;
@@ -6064,6 +6065,13 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
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
index 2ea16a07a7d4..9aeb740388ab 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1859,6 +1859,39 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
+	 * If our qgroup is consistent, commit current transaction to make sure
+	 * all the rfer/excl numbers get updated to 0 before deleting.
+	 */
+	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
+		trans = btrfs_start_transaction(fs_info->quota_root, 0);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		ret = btrfs_commit_transaction(trans);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Start new trans to delete the qgroup info and limit items. */
+	trans = btrfs_start_transaction(fs_info->quota_root, 2);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	ret = btrfs_remove_qgroup(trans, subvolid);
+	btrfs_end_transaction(trans);
+	return ret;
+}
+
 int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit)
 {
@@ -4877,7 +4910,11 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = find_qgroup_rb(fs_info, root);
 	if (!qgroup) {
-		ret = -ENOENT;
+		/*
+		 * The qgroup can be auto deleted by subvolume deleting.
+		 * In that case do not consider it an error.
+		 */
+		ret = 0;
 		goto out;
 	}
 
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
2.44.0


