Return-Path: <linux-btrfs+bounces-4796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0F8BDBF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A691C2195D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA878C97;
	Tue,  7 May 2024 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qpk1pMTZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M9QWFzuX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCA78C8A
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065116; cv=none; b=KAOEHodSoECHKOb700jAZG+H+WJuOap6Diab3jsXVCrYt8gUT5kWMcoy+GfmF4ClWimhGejKzMNWFtb1DqsK3IMNex6HdOSik5c1/Fl4jl/77Tufdz/R41SC+MHc40j4FEsZTarqYXB8++T4XTT607RXdXX+6vAbetqJn3T1ZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065116; c=relaxed/simple;
	bh=cFXhdBV3P3AqRiB8GvW1aeLuu6uqqHmAawg/o4FqkjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYJZQmoyqZklbmZQ677du/3BMMVYWKgYphfjWbEYsWxLs96sX31eb6aS2diQFi45RD2t7uJMC7z+cfwQtRhCNg5grSNdj/akUlThl2Q8i4SqZ2A3a8pG5yP96xbJz7xiSAOptLQkCYT0MlCIVY0Ymg58WbBdpGtGH8Mw1oWIio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qpk1pMTZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M9QWFzuX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8DC620523
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG9yacwtdxOZnU5gBAmVCm3FsQbVGjr9w4WOOL68bUs=;
	b=qpk1pMTZ+35QaQ1GATpdGqEEr83qARjnTLPNEH59TAB7NtTJDJaO0YjRse+dTaP/cs9cGe
	yevO+S4QDkaMXZQvryi5DJsIlpBDCR9UwmnSDW9R2QdvEx/oqwgmuTBIv2ONIPNdVLSCqb
	2JqINcqn+ALzAMj3LkW7idrbQsIaGpg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG9yacwtdxOZnU5gBAmVCm3FsQbVGjr9w4WOOL68bUs=;
	b=M9QWFzuX+ZwkfrZepkwG+BxH/u1BNnUkApCmhVF93EUdjT+Z+tZLiD4YM4ZkEYbLJYaRYo
	RUrRiIzjSkCoRx0zdo89gl3Sgdt8iwPbhvc2Skmm8rGnTZKKGTY1DAT1TcAdvRxnCp6M5A
	5zZY137HUsS+xj7FcXCRgFM2kFwYMq4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02BA0139CB
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 06:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AM2KhbROWbSGAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 06:58:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: slightly loose the requirement for qgroup removal
Date: Tue,  7 May 2024 16:28:10 +0930
Message-ID: <16337d00a7946336cd742573327c8714db278331.1715064550.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 82 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index eb28141d5c37..d89f16366a1c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1728,13 +1728,51 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
-static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+static bool can_delete_qgroup(struct btrfs_fs_info *fs_info,
+			      struct btrfs_qgroup *qgroup)
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
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
+		if (qgroup->rfer || qgroup->excl || qgroup->excl_cmpr ||
+		    qgroup->rfer_cmpr)
+			return false;
+	}
+
+	/* For higher level qgroup, we can only delete it if it has no child. */
+	if (btrfs_qgroup_level(qgroup->qgroupid)) {
+		if (!list_empty(&qgroup->members))
+			return false;
+		return true;
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
+		return false;
+
+	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
+	btrfs_free_path(path);
+	if (ret > 0)
+		return true;
+	return false;
 }
 
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
@@ -1756,7 +1794,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
-	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+	if (!can_delete_qgroup(fs_info, qgroup)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1781,6 +1819,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
2.45.0


