Return-Path: <linux-btrfs+bounces-2901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A03F86BF82
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 04:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF001C2101B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 03:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14735374F9;
	Thu, 29 Feb 2024 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHnCKVrK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aHnCKVrK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC337169
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177713; cv=none; b=Ud2+Ma1Fsfv7Muu8CRtofxfIZdZqZcZaxyDgZvfjc4q/sEi9W/FSJVbEbil29FunQWamfCMkAyzbAvBAXwK8FWN8mik2KzJ7jLF44ZNpxy3wTyu8yTq6aHq3Hzp4j8Dwo93qwVybddxsR1zNtoblExg34xk3MF/HsaDZoNXZjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177713; c=relaxed/simple;
	bh=s9hINVslaT1BUPH8zNbaKJD8J70x42ZoeLsywD/QZ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kx17JCZsuOgERXeQZ2elHTGg7NDmVMiJZiWIvnEs2/YCvpiYpXzNiZpojeSrK+MdxSfeApXebH/vXjpeachOAt0z/1tp5vs+A/R1B7l2rB/DleBimlvdvUzFZTMYYHgKolZMTZX0hz5q/I2240FOV+4bcNtxUjs7MhuR2xLW4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHnCKVrK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aHnCKVrK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 839431FBB3;
	Thu, 29 Feb 2024 03:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709177707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KsDgfms1Dv2goe6qbWKBvrDskasSaufU40FxwoaGkwA=;
	b=aHnCKVrK6Eq5cGS8EiV8APaIhqqxfPGu9IqnYURLQq+52CpcYge2Eu5MyjwZ/QaqJ39KFf
	rr3puJCilDYvCzJ6Kcg9OgDb8VTMuEJ5R0Si1mMxcuKErxYbL1AdEdLOKE6TgeIh2kPQZC
	l9HdyJgHqdPkY0i49/B2U0x/6P1XUTo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709177707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KsDgfms1Dv2goe6qbWKBvrDskasSaufU40FxwoaGkwA=;
	b=aHnCKVrK6Eq5cGS8EiV8APaIhqqxfPGu9IqnYURLQq+52CpcYge2Eu5MyjwZ/QaqJ39KFf
	rr3puJCilDYvCzJ6Kcg9OgDb8VTMuEJ5R0Si1mMxcuKErxYbL1AdEdLOKE6TgeIh2kPQZC
	l9HdyJgHqdPkY0i49/B2U0x/6P1XUTo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7826813446;
	Thu, 29 Feb 2024 03:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2R8rCWr732WWIwAAn2gu4w
	(envelope-from <wqu@suse.com>); Thu, 29 Feb 2024 03:35:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: qgroup: allow quick inherit if a snapshot if created and added to the same parent
Date: Thu, 29 Feb 2024 14:04:44 +1030
Message-ID: <77ffdac5a4f20ae19c35142f03f59fb1a086495b.1709177609.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aHnCKVrK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 839431FBB3
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

Add the extra quick accounting update for such inherit.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)
---
Changelog:
v2:
- Move the case of source subvolume without a parent into
  qgroup_snapshot_quick_inherit()

- Exit early if the source subvolume has too many parents

- Small commit message update on the last sentence

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b3bf08fc2a39..4fa513a6c91e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3087,6 +3087,63 @@ static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
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
+	/*
+	 * Source has no parent qgroup, but our new qgroup would have one.
+	 * Qgroup numbers would go inconsistent.
+	 */
+	if (list_empty(&src->groups))
+		return 1;
+
+	list_for_each_entry(list, &src->groups, next_group) {
+		/* The parent is not the same, quick update not possible. */
+		if (list->group->qgroupid != parentid)
+			return 1;
+		nr_parents++;
+		/*
+		 * More than one parent qgroups, we're not sure about if qgroup
+		 * would be inconsistent.
+		 */
+		if (nr_parents > 1)
+			return 1;
+	}
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
2.44.0


