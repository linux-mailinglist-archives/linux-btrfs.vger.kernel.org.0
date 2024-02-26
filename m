Return-Path: <linux-btrfs+bounces-2761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B618668DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 04:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C287F1F2168C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3A1947E;
	Mon, 26 Feb 2024 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NZJ5i8lu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NZJ5i8lu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017117BC5
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919501; cv=none; b=o32ynyiBrj2dNJA6tmPvmyvvPKaVTVMEOBcJLPjOki6Q4/nxzPLBdp8Zu4dSduE9/SExCQ89qcIhhvNm/C4kzMuWiyQdVXr/2kiVQDTjcyAY0RTHmqIzRvLz8aNzfGZrUj7jl5qtbaylqcAR126+cFj2XOdCEe0EKeUtnUHWGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919501; c=relaxed/simple;
	bh=pKyVge5VqPBfaS/4O6phgFUwsUoDMcpmUN4gs/K+lTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mpp8rbx2hf8YwaEgrw+GRQXyd6hbUsFYqsGjdf4SgcVUHaATaJR9hYjkZ+QjE1YwUjLBE7f9LiI2Eyk8hhzSS+TrnY5ZvaNQMTgyuO7XBpb7JqlfAkCnwHfDYEbrCYsoSjov2vAhKW0cQdyXPZhf3CSAjZvOSDahGFkYTxpsJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NZJ5i8lu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NZJ5i8lu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0913822487
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 03:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708919497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUAfAG+DjBJ7RaWWsWeq4EmyydSaBfn6Y8f5eH3MwNk=;
	b=NZJ5i8luyj+0tWvAWeP2p/rTXiR2QOfTotBYbwE4o45EVEFUeFiogY3Z9jLBkmhSiXL0NW
	ys4g3LCc5jLMpAV369WLDHMSDbOMVPT+D6Md9s012hPhnCRanUCKfrb3KOD+wFjWmeOoWY
	a2gz+FJcx2B0JyvMjSwH6h3WmraBnMk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708919497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JUAfAG+DjBJ7RaWWsWeq4EmyydSaBfn6Y8f5eH3MwNk=;
	b=NZJ5i8luyj+0tWvAWeP2p/rTXiR2QOfTotBYbwE4o45EVEFUeFiogY3Z9jLBkmhSiXL0NW
	ys4g3LCc5jLMpAV369WLDHMSDbOMVPT+D6Md9s012hPhnCRanUCKfrb3KOD+wFjWmeOoWY
	a2gz+FJcx2B0JyvMjSwH6h3WmraBnMk=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEF713A71
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 03:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sA3RNMcK3GUDVgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 03:51:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: allow quick inherit if a snapshot if created and added to the same parent
Date: Mon, 26 Feb 2024 14:21:13 +1030
Message-ID: <5dea98d4f3749f895402164c3cba61b176ff3b2e.1708919464.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Currently "btrfs subvolume snapshot -i <qgroupid>" would always mark the
qgroup inconsistent.

This can be annoying if the fs has a lot of snapshots, and needs qgroup
to get the accounting for the amount of bytes it can free for each
snapshot.

Although we have the new simple quote as a solution, there is also a
case where we can skip the full scan, if all the following conditions
are met:

- The source subvolume belongs to a higher level parent qgroup
- The parent qgroup already owns all its bytes exclusively
- The new snapshot is also added to the same parent qgroup

In that case, we only need to add nodesize to the parent qgroup and
avoid a full rescan.

This patch would add the extra quick accounting update for such inherit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b3bf08fc2a39..4fa83c76b37b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3087,6 +3087,56 @@ static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * If @src has a single @parent, and that @parent is owning all its bytes
+ * exclusively, we can skip the full rescan, by just adding nodesize to
+ * the @parent's excl/rfer.
+ *
+ * Return <0 for fatal errors (like srcid/parentid has no qgroup).
+ * Return 0 if a quick inherit is done.
+ * Return >0 if a quick inherit is not possible, and a full rescan is needed.
+ */
+static int qgroup_snapshot_quick_inherit(struct btrfs_fs_info *fs_info,
+					 u64 srcid, u64 parentid)
+{
+	struct btrfs_qgroup *src;
+	struct btrfs_qgroup *parent;
+	struct btrfs_qgroup_list *list;
+	int nr_parents = 0;
+
+	src = find_qgroup_rb(fs_info, srcid);
+	if (!src)
+		return -ENOENT;
+	parent = find_qgroup_rb(fs_info, parentid);
+	if (!parent)
+		return -ENOENT;
+
+	list_for_each_entry(list, &src->groups, next_group) {
+		/* The parent is not the same, quick update not possible. */
+		if (list->group->qgroupid != parentid)
+			return 1;
+		nr_parents++;
+	}
+	/*
+	 * The source has multiple parents, do not bother it and require a
+	 * full rescan.
+	 */
+	if (nr_parents != 1)
+		return 1;
+
+	/*
+	 * The parent is not exclusively owning all its bytes.
+	 * We're not sure if the source has any bytes not fully owned
+	 * by the parent.
+	 */
+	if (parent->excl != parent->rfer)
+		return 1;
+
+	parent->excl += fs_info->nodesize;
+	parent->rfer += fs_info->nodesize;
+	return 0;
+}
+
 /*
  * Copy the accounting information between qgroups. This is necessary
  * when a snapshot or a subvolume is created. Throwing an error will
@@ -3255,6 +3305,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		qgroup_dirty(fs_info, dstgroup);
 		qgroup_dirty(fs_info, srcgroup);
+
+		/*
+		 * If the source qgroup has parent but the new one doesn't,
+		 * we need a full rescan.
+		 */
+		if (!inherit && !list_empty(&srcgroup->groups))
+			need_rescan = true;
 	}
 
 	if (!inherit)
@@ -3269,14 +3326,17 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 			if (ret)
 				goto unlock;
 		}
+		if (srcid) {
+			/* Check if we can do a quick inherit. */
+			ret = qgroup_snapshot_quick_inherit(fs_info, srcid,
+							    *i_qgroups);
+			if (ret < 0)
+				goto unlock;
+			if (ret > 0)
+				need_rescan = true;
+			ret = 0;
+		}
 		++i_qgroups;
-
-		/*
-		 * If we're doing a snapshot, and adding the snapshot to a new
-		 * qgroup, the numbers are guaranteed to be incorrect.
-		 */
-		if (srcid)
-			need_rescan = true;
 	}
 
 	for (i = 0; i <  inherit->num_ref_copies; ++i, i_qgroups += 2) {
-- 
2.43.2


