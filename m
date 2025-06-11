Return-Path: <linux-btrfs+bounces-14593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954CBAD47D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 03:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EBF189F9B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25022145A05;
	Wed, 11 Jun 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ifuz4NWS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ifuz4NWS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E81029D0E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749604947; cv=none; b=VIaXcJihuQ9MljRuu3FhYzlyuE8RF6V0v9bEJARyLirzaDZRJUj4vcl1LsDtIO/pMfr0wMb7IA9QKCbCqQtWQD3r6d5twNDOXOp/HOy5rbZRC/hP2nNMstq8c3ochvFfor0SiHMzxHMbl21WObp2VfxX0cuOTEZN0OTHb9+/nfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749604947; c=relaxed/simple;
	bh=QwnVWpd4lLJz/QOPopx7apSMhpTGOZhCKHqzA4PGoO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cbz06X48n+kFvlcXfiflVPDJkOHGwvUfMdqqRrjOCmrRUA90A3aicfGDfj+cjMbNVSEVN5sgJ0I8pMSwU4HUZ8PmUfi2JOtsOjnI2oXrSqyEjS+Zv2UOm+3kgg05xxMB6tirShcWwxX1M2CUkb75ONaeI2o/WkWF0LZIGxNCsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ifuz4NWS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ifuz4NWS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A0F921A07
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749604942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yx8F9zFe72Fs3ZQygV/1HEvB2UBHNQGkYm51Xra982k=;
	b=Ifuz4NWSzAYVCNp6Hy/CQSriesibonI14X0nbW+2t+O0keeFDjysKpEmTr2Mf2XPObV66V
	+tWI6NhnnnFH/kTH8m3PFGsxz4keicH5IORIxMV7CAHqH98vHH7ySmbBuwZtW+/tCgi/OT
	QO8A6ocRDhw9r6n44iWpBjFYOZiQLD8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ifuz4NWS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749604942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yx8F9zFe72Fs3ZQygV/1HEvB2UBHNQGkYm51Xra982k=;
	b=Ifuz4NWSzAYVCNp6Hy/CQSriesibonI14X0nbW+2t+O0keeFDjysKpEmTr2Mf2XPObV66V
	+tWI6NhnnnFH/kTH8m3PFGsxz4keicH5IORIxMV7CAHqH98vHH7ySmbBuwZtW+/tCgi/OT
	QO8A6ocRDhw9r6n44iWpBjFYOZiQLD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71BAF13485
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2fRMC03aSGjvcwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 01:22:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add extra warning when qgroup is marked inconsistent
Date: Wed, 11 Jun 2025 10:52:03 +0930
Message-ID: <511dad96b50657c84f9926a3a2d370419be93722.1749604913.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A0F921A07
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Unlike qgroup rescan, which always shows whether it cleared the
inconsistent flag, we do not have a proper way to show if qgroup is
marked inconsistent.

This was not a big deal before as there aren't that many locations that
can mark qgroup inconsistent.

But with the introduction of drop_subtree_threshold, qgroup can be
marked inconsistent very frequently, especially for dropping large
subvolume.

Although most user space tools relying on qgroup should do their own
checks and queue a rescan if needed, we have no idea when qgroup is
marked inconsistent, and will be much harder to debug.

So this patch will add an extra warning (btrfs_warn_rl()) when the
qgroup flag is flipped into inconsistent for the first time.
And add extra reason why qgroup flips inconsistent.

This means we can move the error message immediately before
qgroup_inconsistent_warning() into that function.

For call sites without an obvious reason, or is a shared error handling,
output the function that failed and the error code instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add a reason format string for qgroup_inconsistent_warning()
  This can replace the existing error messages, and provide a much
  better help for debugging.
---
 fs/btrfs/qgroup.c | 87 ++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a1afc549c404..6d8d06f6b8f3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -346,13 +346,27 @@ int btrfs_verify_qgroup_counts(const struct btrfs_fs_info *fs_info, u64 qgroupid
 }
 #endif
 
-static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
+__printf(2, 3)
+static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
+	bool old_inconsistent = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
 		return;
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
+	if (!old_inconsistent) {
+		struct va_format vaf;
+		va_list args;
+
+		va_start(args, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		btrfs_warn_rl(fs_info, "qgroup marked inconsistent, %pV", &vaf);
+		va_end(args);
+	}
 }
 
 static void qgroup_read_enable_gen(struct btrfs_fs_info *fs_info,
@@ -431,13 +445,10 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				goto out;
 			}
 			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
-			if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE) {
+			if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE)
 				qgroup_read_enable_gen(fs_info, l, slot, ptr);
-			} else if (btrfs_qgroup_status_generation(l, ptr) != fs_info->generation) {
-				qgroup_mark_inconsistent(fs_info);
-				btrfs_err(fs_info,
-					"qgroup generation mismatch, marked as inconsistent");
-			}
+			else if (btrfs_qgroup_status_generation(l, ptr) != fs_info->generation)
+				qgroup_mark_inconsistent(fs_info, "qgroup generation mismatch");
 			rescan_progress = btrfs_qgroup_status_rescan(l, ptr);
 			goto next1;
 		}
@@ -448,10 +459,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 
 		qgroup = find_qgroup_rb(fs_info, found_key.offset);
 		if ((qgroup && found_key.type == BTRFS_QGROUP_INFO_KEY) ||
-		    (!qgroup && found_key.type == BTRFS_QGROUP_LIMIT_KEY)) {
-			btrfs_err(fs_info, "inconsistent qgroup config");
-			qgroup_mark_inconsistent(fs_info);
-		}
+		    (!qgroup && found_key.type == BTRFS_QGROUP_LIMIT_KEY))
+			qgroup_mark_inconsistent(fs_info,
+						 "inconsistent qgroup config");
 		if (!qgroup) {
 			struct btrfs_qgroup *prealloc;
 			struct btrfs_root *tree_root = fs_info->tree_root;
@@ -1841,13 +1851,12 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		if (qgroup->rfer || qgroup->excl ||
 		    qgroup->rfer_cmpr || qgroup->excl_cmpr) {
 			DEBUG_WARN();
-			btrfs_warn_rl(fs_info,
-"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
-				      btrfs_qgroup_level(qgroup->qgroupid),
-				      btrfs_qgroup_subvolid(qgroup->qgroupid),
-				      qgroup->rfer, qgroup->rfer_cmpr,
-				      qgroup->excl, qgroup->excl_cmpr);
-			qgroup_mark_inconsistent(fs_info);
+			qgroup_mark_inconsistent(fs_info,
+				"to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
+				btrfs_qgroup_level(qgroup->qgroupid),
+				btrfs_qgroup_subvolid(qgroup->qgroupid),
+				qgroup->rfer, qgroup->rfer_cmpr,
+				qgroup->excl, qgroup->excl_cmpr);
 		}
 	}
 	del_qgroup_rb(fs_info, qgroupid);
@@ -1965,11 +1974,9 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 	spin_unlock(&fs_info->qgroup_lock);
 
 	ret = update_qgroup_limit_item(trans, qgroup);
-	if (ret) {
-		qgroup_mark_inconsistent(fs_info);
-		btrfs_info(fs_info, "unable to update quota limit for %llu",
-		       qgroupid);
-	}
+	if (ret)
+		qgroup_mark_inconsistent(fs_info, "qgroup item update error %d",
+					 ret);
 
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
@@ -2024,7 +2031,8 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 	ret = __xa_store(&delayed_refs->dirty_extents, index, record, GFP_ATOMIC);
 	xa_unlock(&delayed_refs->dirty_extents);
 	if (xa_is_err(ret)) {
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info,
+					 "xarray insert error: %d", xa_err(ret));
 		return xa_err(ret);
 	}
 
@@ -2091,10 +2099,8 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_find_all_roots(&ctx, true);
 	if (ret < 0) {
-		qgroup_mark_inconsistent(fs_info);
-		btrfs_warn(fs_info,
-"error accounting new delayed refs extent (err code: %d), quota inconsistent",
-			ret);
+		qgroup_mark_inconsistent(fs_info,
+				"error accounting new delayed refs extent: %d", ret);
 		return 0;
 	}
 
@@ -2586,7 +2592,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
 out:
 	btrfs_free_path(dst_path);
 	if (ret < 0)
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info, "%s error: %d", __func__, ret);
 	return ret;
 }
 
@@ -2630,7 +2636,8 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	 * mark qgroup inconsistent.
 	 */
 	if (root_level >= drop_subptree_thres) {
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info,
+					 "subtree level reached threshold");
 		return 0;
 	}
 
@@ -3130,10 +3137,12 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		spin_unlock(&fs_info->qgroup_lock);
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
-			qgroup_mark_inconsistent(fs_info);
+			qgroup_mark_inconsistent(fs_info,
+						 "qgroup item update error %d", ret);
 		ret = update_qgroup_limit_item(trans, qgroup);
 		if (ret)
-			qgroup_mark_inconsistent(fs_info);
+			qgroup_mark_inconsistent(fs_info,
+						 "qgroup item update error %d", ret);
 		spin_lock(&fs_info->qgroup_lock);
 	}
 	if (btrfs_qgroup_enabled(fs_info))
@@ -3144,7 +3153,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 
 	ret = update_qgroup_status_item(trans);
 	if (ret)
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info,
+					 "qgroup item update error %d", ret);
 
 	return ret;
 }
@@ -3551,7 +3561,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info, "qgroup inherit needs a rescan");
 	if (qlist_prealloc) {
 		for (int i = 0; i < inherit->num_qgroups; i++)
 			kfree(qlist_prealloc[i]);
@@ -4785,7 +4795,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_root *subvol_root,
 	spin_unlock(&blocks->lock);
 out:
 	if (ret < 0)
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info, "%s error: %d", __func__, ret);
 	return ret;
 }
 
@@ -4863,10 +4873,9 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	free_extent_buffer(reloc_eb);
 out:
 	if (ret < 0) {
-		btrfs_err_rl(fs_info,
-			     "failed to account subtree at bytenr %llu: %d",
-			     subvol_eb->start, ret);
-		qgroup_mark_inconsistent(fs_info);
+		qgroup_mark_inconsistent(fs_info,
+				"failed to account subtree at bytenr %llu: %d",
+				subvol_eb->start, ret);
 	}
 	return ret;
 }
-- 
2.49.0


