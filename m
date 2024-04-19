Return-Path: <linux-btrfs+bounces-4422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D968AA8A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9668C1C2107C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 06:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC493D546;
	Fri, 19 Apr 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CYBqqxin";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CYBqqxin"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DB38382
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509445; cv=none; b=qwzxakv2rfgY/BptsqVWOYFxKo3bnnX1Wg6xY7S2nVJl+2f2cnmTuRZIXyzFejUBdB0Nbj6MwZqOy1nqJW64Rq8v4UfHX7fJWBAp/K3bjZcr144CVK6nlsMjuTT0b6TTXMr1qY9VbWYnuM2mROHhmRNCSe6NkD8vfC8bs7sAOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509445; c=relaxed/simple;
	bh=FnpXfu2u2k1I2wD8ie8G1Es3Zfy3y09PnOhykwf/2XY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvXiHKQEjdI7iiVSvguBkBs9sqyL/RoT9iivq0BRqBFZUJSGzrfW01UFwoPumCOn3xdB41PJ7p3bo5hgXLIXAc66INfhjxOAGY+di5kGZhDRnxFfkk0g0jER4/bNb8/+RrpHYk0OiwmquTaVP/j1KpjV1O3YVe6jH0EQ+8lI/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CYBqqxin; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CYBqqxin; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 197DA374DF
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713509442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xt4wIaZAcrhOLPLfdS2OqbxSZ4DDbeiP5fQTaAnPCPM=;
	b=CYBqqxinw7WmNAXcwCI8bvaxPeSjAO9kdUfgSkz+RyMVOcsN5DJc2r+IPqerW1W19gEp9r
	tKcW4STuF86JGbnAWf7rM0BFYzwO9okp9PTcgk4E5iAXw/iIcEkvqWJf03v7tn1oRGt4VH
	Vhak6ZYcpguM7TrlQ2IzdJuZo8J6qVM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CYBqqxin
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713509442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xt4wIaZAcrhOLPLfdS2OqbxSZ4DDbeiP5fQTaAnPCPM=;
	b=CYBqqxinw7WmNAXcwCI8bvaxPeSjAO9kdUfgSkz+RyMVOcsN5DJc2r+IPqerW1W19gEp9r
	tKcW4STuF86JGbnAWf7rM0BFYzwO9okp9PTcgk4E5iAXw/iIcEkvqWJf03v7tn1oRGt4VH
	Vhak6ZYcpguM7TrlQ2IzdJuZo8J6qVM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3523E13687
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ONFNkAUImb7RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 06:50:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: automatically remove the subvolume qgroup
Date: Fri, 19 Apr 2024 16:20:19 +0930
Message-ID: <1319f7cc00fcb5eb7ccf4a6a450b54eb8b059533.1713508989.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713508989.git.wqu@suse.com>
References: <cover.1713508989.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 197DA374DF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:url];
	DKIM_TRACE(0.00)[suse.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]

Currently if we fully removed a subvolume (not only unlinked, but fully
dropped its root item), its qgroup would not be removed.

Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.

This patch changes the behavior by automatically removing the qgroup of
a fully dropped subvolume.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1222847
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c |  9 +++++++++
 fs/btrfs/qgroup.c      | 28 ++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h      |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 023920d0d971..f4887f05a819 100644
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
@@ -6064,6 +6065,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	kfree(wc);
 	btrfs_free_path(path);
 out:
+	if (!err && root_dropped) {
+		ret = btrfs_qgroup_cleanup_dropped_subvolume(fs_info, rootid);
+		if (ret < 0) {
+			btrfs_warn_rl(fs_info,
+				      "failed to cleanup qgroup 0/%llu: %d",
+				      rootid, ret);
+		}
+	}
 	/*
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e6fcce4372a4..8690e212ba2a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1838,6 +1838,34 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
+	/* Commit current transaction to ensure the root item is removed. */
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
2.44.0


