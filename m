Return-Path: <linux-btrfs+bounces-4427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FD8AABB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601F91C210EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5147D091;
	Fri, 19 Apr 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D2R3px77";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D2R3px77"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A47BAF9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520037; cv=none; b=sITt1IeB4vbFkEdWiHt9NP9zoMW534imjkpVbUzIbYTVTGVL7lMXFE/H2C2WCMwjFoIUt66x+lLrmVnEw3U1QesLpoxiLa3fwtFTefrpjLmF3iIIz3PfB1fAwN+eL5qM+b4ZsIuIqEIMS3V9wYMBL7hvq8ebigpWe4S/EFsfii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520037; c=relaxed/simple;
	bh=4sMC9YBCD3qE4ChhEaluT/a/9or7vgKHE6Xs57Z5eDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFv0qL9JCo5TCAFMer4G9yjXlj99FtHzfdd8LZOa6z6rXiPgDaxWxjvK0ZKSdMHX3l6XMeS14Ejhs2ZyCjy4D0P/S5PbvIyfE9StPM1RRusiLnRvkBdp/5oEqXAXVUufLqm1Ar85slsGuJlg1R6d8DzB38HnTAC4c4t2wytEhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D2R3px77; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D2R3px77; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E4615D528;
	Fri, 19 Apr 2024 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrVMVpNjjukzUvhp3zM2PiBbGNSMhFc908EevnYD4no=;
	b=D2R3px77kyCaYq/b5uWrVw7Y3PELjd7uya72EsHRy374rv5STLfRHdZaQFN+WiM26/Ihhg
	tH6mYSxwC9zFLoloBXamoMjtHMJMrWTU1E1y8kVirufFGHFDWewZKhqXWIWU0TBGDIEsEV
	qkuEw533XjDv0H0EUZajc6j3ByxpmaU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713520034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrVMVpNjjukzUvhp3zM2PiBbGNSMhFc908EevnYD4no=;
	b=D2R3px77kyCaYq/b5uWrVw7Y3PELjd7uya72EsHRy374rv5STLfRHdZaQFN+WiM26/Ihhg
	tH6mYSxwC9zFLoloBXamoMjtHMJMrWTU1E1y8kVirufFGHFDWewZKhqXWIWU0TBGDIEsEV
	qkuEw533XjDv0H0EUZajc6j3ByxpmaU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F95136CF;
	Fri, 19 Apr 2024 09:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKvJIqA9ImafBwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 19 Apr 2024 09:47:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: boris@bur.io
Subject: [PATCH v2 1/2] btrfs: slightly loose the requirement for qgroup removal
Date: Fri, 19 Apr 2024 19:16:52 +0930
Message-ID: <3fa525bceeec6096ddd131da98036e07b9947c9c.1713519718.git.wqu@suse.com>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

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
Instead of a strong requirement for zero rfer/excl numbers, just check
if there is any child for higher level qgroup, and for subvolume qgroups
check if there is a corresponding subvolume for it.

For rsv values, do extra warnings, and for rfer/excl numbers, only do the
warning if we're in full accounting mode and the qgroup is consistent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9a9f84c4d3b8..2ea16a07a7d4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1736,13 +1736,38 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
@@ -1764,7 +1789,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
-	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+	if (!can_delete_qgroup(fs_info, qgroup)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1789,6 +1814,36 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
2.44.0


