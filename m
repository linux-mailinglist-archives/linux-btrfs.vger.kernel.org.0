Return-Path: <linux-btrfs+bounces-5138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B898CA69F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 05:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2601D1C214D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BC1BF31;
	Tue, 21 May 2024 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bmt3kSPm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iwO6qwe6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101F13AD8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260611; cv=none; b=aPRqa17/nLMnMCx2Zm9abvAqtQyO18VLnKKsTCHtlEi8eIRJReuJTUKfAW7BsIrg4GLubg7C22YWBiriJQuBq4CcMjaPCHEalWFxOdPlxv//DgzzfNDiv4/vmgq5BqGQFIZxmA8/kS6TXzkvzUbEqT+0+XcVzK8cj1XtVQ9Z59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260611; c=relaxed/simple;
	bh=PDCd+5Z9mrbFfmxUgmjB2ADWXu0H2LAq/+ZOx4Dv6o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGrshrkIRnhDceULb2SHibQdzPOGtNn5cY1rOX9V0n296awyjrZE3wA175IvTEtayQUZh6SOEh4kEItiwS4SfNyNnYwZBh9BqJiMGaI/Xn41HLMKGFDA5pB9n/UlbUXYAVY5lmQfW9GguQr/nAXOcWxa0SK4z4krPMBuRWMEe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bmt3kSPm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iwO6qwe6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBEAE20CA7;
	Tue, 21 May 2024 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716260607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dYQbiZdlg0/GwkdBWXLzZz6aisvAnh5yzFmWvAccNw=;
	b=Bmt3kSPm1Jsd7h+qS2YwzBLewRBjjuNEv8arExCrJmMJXBE8Hlqnj4bJovh2ii8Dm+AAr+
	PpitgdeRKKFyLugFrw9aUeIoPKyA1cCVUsyoBrA/fCJws49VdSkI0V+ct6aRSLMSWu3KWZ
	cox8/v9QLuGyRzzJg/oE/4pLTHqIWs4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716260606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dYQbiZdlg0/GwkdBWXLzZz6aisvAnh5yzFmWvAccNw=;
	b=iwO6qwe6J/KtVE07tlOA5vlP2sJ+lOPyR2hLfTYaam2LN33cEF/d4KuZ+m4Ge2nmuZaCDo
	j3mvRqDQdO2fetBaOndhN8e7bgCaaUZx7YRWeyTxCz85M+Nhg7kQAcq87Qhxnl8mv5DcWV
	z3GK+78uSx8eeX+IwVitbBbxIXdwKHQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8FD13A1E;
	Tue, 21 May 2024 03:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJk9LvwOTGYcKwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 21 May 2024 03:03:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 1/2] btrfs: slightly loose the requirement for qgroup removal
Date: Tue, 21 May 2024 12:33:16 +0930
Message-ID: <1887f99e2848cf6a1981ad23b909adcb21c3c183.1716260404.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
Currently if one is utilizing "qgroups/drop_subtree_threshold" sysfs,
and a snapshot with level higher than that value is dropped, btrfs will
not be able to delete the qgroup until next qgroup rescan:

  uuid=ffffffff-eeee-dddd-cccc-000000000000

  wipefs -fa $dev
  mkfs.btrfs -f $dev -O quota -s 4k -n 4k -U $uuid
  mount $dev $mnt

  btrfs subvolume create $mnt/subv1/
  for (( i = 0; i < 1024; i++ )); do
  	xfs_io -f -c "pwrite 0 2k" $mnt/subv1/file_$i > /dev/null
  done
  sync
  btrfs subv snapshot $mnt/subv1 $mnt/snapshot
  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt
  sync
  echo 1 > /sys/fs/btrfs/$uuid/qgroups/drop_subtree_threshold
  btrfs subvolume delete $mnt/snapshot
  btrfs subv sync $mnt
  btrfs qgroup show -prce --sync $mnt
  btrfs qgroup destroy 0/257 $mnt
  umount $mnt

The final qgroup removal would fail with the following error:

  ERROR: unable to destroy quota group: Device or resource busy

[CAUSE]
The above script would generate a subvolume of level 2, then snapshot
it, enable qgroup, set the drop_subtree_threshold, then drop the
snapshot.

Since the subvolume drop would meet the threshold, qgroup would be
marked inconsistent and skip accounting to avoid hanging the system at
transaction commit.

But currently we do not allow a qgroup with any rfer/excl numbers to be
dropped, and this is not really compatible with the new
drop_subtree_threshold behavior.

[FIX]
Only require the strong zero rfer/excl/rfer_cmpr/excl_cmpr for squota
mode.
This is due to the fact that squota can never go inconsistent, and it
can have dropped subvolume but with non-zero qgroup numbers for future
accounting.

For full qgroup mode, we only check if there is a subvolume for it.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 91 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fc2a7ea26354..9b4de1b43298 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1748,13 +1748,57 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
-static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+/*
+ * Return 0 if we can not delete the qgroup (not empty or has children etc).
+ * Return >0 if we can delete the qgroup.
+ * Return <0 for other errors during tree search.
+ */
+static int can_delete_qgroup(struct btrfs_fs_info *fs_info,
+			     struct btrfs_qgroup *qgroup)
 {
-	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
-		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+	struct btrfs_key key;
+	struct btrfs_path *path;
+	int ret;
+
+	/*
+	 * Squota would never be inconsistent, but there can still be
+	 * case where a dropped subvolume still has qgroup numbers, and
+	 * squota relies on such qgroup for future accounting.
+	 *
+	 * So for squota, do not allow dropping any non-zero qgroup.
+	 */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE &&
+	    (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr ||
+	     qgroup->rfer_cmpr))
+		return 0;
+
+	/* For higher level qgroup, we can only delete it if it has no child. */
+	if (btrfs_qgroup_level(qgroup->qgroupid)) {
+		if (!list_empty(&qgroup->members))
+			return 0;
+		return 1;
+	}
+
+	/*
+	 * For level-0 qgroups, we can only delete it if it has no subvolume
+	 * for it.
+	 * This means even a subvolume is unlinked but not yet fully dropped,
+	 * we can not delete the qgroup.
+	 */
+	key.objectid = qgroup->qgroupid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = -1ULL;
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
+	btrfs_free_path(path);
+	/*
+	 * The @ret from btrfs_find_root() exactly matches our definition for
+	 * the return value, thus can be returned directly.
+	 */
+	return ret;
 }
 
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
@@ -1776,7 +1820,10 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
-	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+	ret = can_delete_qgroup(fs_info, qgroup);
+	if (ret < 0)
+		goto out;
+	if (ret == 0) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1801,6 +1848,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
+	/*
+	 * Warn on reserved space. The subvolume should has no child nor
+	 * corresponding subvolume.
+	 * Thus its reserved space should all be zero, no matter if qgroup
+	 * is consistent or the mode.
+	 */
+	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+	/*
+	 * The same for rfer/excl numbers, but that's only if our qgroup is
+	 * consistent and if it's in regular qgroup mode.
+	 * For simple mode it's not as accurate thus we can hit non-zero values
+	 * very frequently.
+	 */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
+	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
+		if (WARN_ON(qgroup->rfer || qgroup->excl ||
+			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
+			btrfs_warn_rl(fs_info,
+"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
+				      btrfs_qgroup_level(qgroup->qgroupid),
+				      btrfs_qgroup_subvolid(qgroup->qgroupid),
+				      qgroup->rfer,
+				      qgroup->rfer_cmpr,
+				      qgroup->excl,
+				      qgroup->excl_cmpr);
+			qgroup_mark_inconsistent(fs_info);
+		}
+	}
 	del_qgroup_rb(fs_info, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
 
-- 
2.45.1


