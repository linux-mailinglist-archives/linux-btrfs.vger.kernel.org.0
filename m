Return-Path: <linux-btrfs+bounces-9403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E79C349A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 21:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D0E1C20E6E
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2024 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429E14B08A;
	Sun, 10 Nov 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OVU8//Gq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OVU8//Gq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EB13C670
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272370; cv=none; b=irLWnnFF8s/rLmRqHZ5nQcqW1ywRz12J3RLrXY0J5AKybdOxYM02UYtUBWyLMGKdc2ZDvJ6q/CsFI4EeJa2ilj2La+/6J5bLnY29VIS/q39C1JGsMrSTtJ6gU/niSe3c8D3MUl3yhMCnaqnm1n6x8DpPDpvokemlFRVmQbLP9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272370; c=relaxed/simple;
	bh=7MhT6Ldv9+HnA40qL8oCoUVtyjf4euWioArJJ14JVRA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XBJ+P3OhLzRffaDd0/F7b/60GpXmkYAUFl/o4p8amIFW8uFXegLSgXW2DQZ7Lnk9z/hLNYOIn84WTN2FvlcKnDycUgRKHSDc8VOpWyQKrELhQ6A2MX8764CQJzKkJC56CF68pVt6QahHN+v6eTfgorhIjuDQMwft/P6+v0Q+zO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OVU8//Gq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OVU8//Gq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29BC41F38E
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 20:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731272366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nNVuuD6qN1wl5r0tflYjKdlNh6iYk08YQtLVxr5p8qk=;
	b=OVU8//GqRFK+7/EADSU8zyY11fPjYSu2Lf+0J1QvQtY+jJSDlOGusj1gn0UiBdfSFQizay
	mfachtRaVLsNYP89NRTjP/A6r5OtEe/NcpshQkJBGOOhSOt95BM6aMqErFzHcQMIhnqRWm
	G/B+P89IloFRroyF7tMeSQMUoH4juOg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731272366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nNVuuD6qN1wl5r0tflYjKdlNh6iYk08YQtLVxr5p8qk=;
	b=OVU8//GqRFK+7/EADSU8zyY11fPjYSu2Lf+0J1QvQtY+jJSDlOGusj1gn0UiBdfSFQizay
	mfachtRaVLsNYP89NRTjP/A6r5OtEe/NcpshQkJBGOOhSOt95BM6aMqErFzHcQMIhnqRWm
	G/B+P89IloFRroyF7tMeSQMUoH4juOg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CDCB137FB
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 20:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EUMrOaweMWfPOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Nov 2024 20:59:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: improve the warning and error message for btrfs_remove_qgroup()
Date: Mon, 11 Nov 2024 07:29:07 +1030
Message-ID: <b33c149624408ed79068df8bd2b5d5670176120d.1731272337.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[WARNING]
There are several warnings about the recently introduced qgroup
auto-removal that it triggers WARN_ON() for the non-zero rfer/excl
numbers, e.g:

 ------------[ cut here ]------------
 WARNING: CPU: 67 PID: 2882 at fs/btrfs/qgroup.c:1854 btrfs_remove_qgroup+0x3df/0x450
 CPU: 67 UID: 0 PID: 2882 Comm: btrfs-cleaner Kdump: loaded Not tainted 6.11.6-300.fc41.x86_64 #1
 RIP: 0010:btrfs_remove_qgroup+0x3df/0x450
 Call Trace:
  <TASK>
  btrfs_qgroup_cleanup_dropped_subvolume+0x97/0xc0
  btrfs_drop_snapshot+0x44e/0xa80
  btrfs_clean_one_deleted_snapshot+0xc3/0x110
  cleaner_kthread+0xd8/0x130
  kthread+0xd2/0x100
  ret_from_fork+0x34/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---
 BTRFS warning (device sda): to be deleted qgroup 0/319 has non-zero numbers, rfer 258478080 rfer_cmpr 258478080 excl 0 excl_cmpr 0

[CAUSE]
Although the root cause is still unclear, as if qgroup is consistent a
fully dropped subvolume (with extra transaction committed) should lead
to all zero numbers for the qgroup.

My current guess is the subvolume drop triggered the new subtree drop
threshold thus marked qgroup inconsistent, then rescan cleared it but
some corner case is not properly handled during subvolume dropping.

But at least for this particular case, since it's only the rfer/excl not
properly reset to 0, and qgroup is already marked inconsistent, there is
nothing to be worried for the end users.

The user space tool utilizing qgroup would queue a rescan to handle
everything, so the kernel wanring is a little overkilled.

[ENHANCEMENT]
Enhance the warning inside btrfs_remove_qgroup() by:

- Only do WARN() if CONFIG_BTRFS_DEBUG is enabled
  As explained the kernel can handle inconsistent qgroups by simply do a
  rescan, there is nothing to bother the end users.

- Treat the reserved space leak the same as non-zero numbers
  By outputting the values and trigger a WARN() if it's a debug build.
  So far I haven't experienced any case related to reserved space so I
  hope we will never need to bother them.

Fixes: 839d6ea4f86d ("btrfs: automatically remove the subvolume qgroup")
Link: https://github.com/kdave/btrfs-progs/issues/922
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a6f92836c9b1..c82df56fbf3d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1839,9 +1839,19 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	 * Thus its reserved space should all be zero, no matter if qgroup
 	 * is consistent or the mode.
 	 */
-	WARN_ON(qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
-		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+	if (qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] ||
+	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] ||
+	    qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_warn_rl(fs_info,
+"to be deleted qgroup %u/%llu has non-zero numbers, data %llu meta prealloc %llu meta pertrans %llu",
+			      btrfs_qgroup_level(qgroup->qgroupid),
+			      btrfs_qgroup_subvolid(qgroup->qgroupid),
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA],
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC],
+			      qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS]);
+
+	}
 	/*
 	 * The same for rfer/excl numbers, but that's only if our qgroup is
 	 * consistent and if it's in regular qgroup mode.
@@ -1850,8 +1860,9 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	 */
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_FULL &&
 	    !(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT)) {
-		if (WARN_ON(qgroup->rfer || qgroup->excl ||
-			    qgroup->rfer_cmpr || qgroup->excl_cmpr)) {
+		if (qgroup->rfer || qgroup->excl ||
+		    qgroup->rfer_cmpr || qgroup->excl_cmpr) {
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 			btrfs_warn_rl(fs_info,
 "to be deleted qgroup %u/%llu has non-zero numbers, rfer %llu rfer_cmpr %llu excl %llu excl_cmpr %llu",
 				      btrfs_qgroup_level(qgroup->qgroupid),
-- 
2.47.0


