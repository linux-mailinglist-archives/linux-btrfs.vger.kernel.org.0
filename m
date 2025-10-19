Return-Path: <linux-btrfs+bounces-18004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB63BEDD78
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11CB407964
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254614EC62;
	Sun, 19 Oct 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MZyFZsLb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fn1bFq2/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BE354AC1
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760834776; cv=none; b=QErd/K0uwXlm2DH+/+ZCDm+xTcIbX5P3+qfpjtnHZvnxeSVxBkYswHFrQBzzuOZzh10B73bB23spxJCHyR4LpGuUsfaqKrMUf/jUWOcd8H0q4uF5CLjBzGVI4hrBFLCjifKljO4gnJCeTCLzCrDPUtkTeO0ngqycyPrKmpLmYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760834776; c=relaxed/simple;
	bh=3SrDCxrjul68DYvzrFw+GOO1Zf8svVBL/prl/3L1rgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ9A/bNq3w1DTSv/cxamfpOTW0Bsn9OPd44pjupay3DScagMzDPsAJL2j3o8EBBxzodNGvmTN2du4Dd+KIwEeL4oMwORdjpVziwbmzICLn45anVMstqMEHdsXTk8s/kt+nvZHXT5Bgi6yfyY+G4UM83OqLbhEqkJu10XLiytv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MZyFZsLb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fn1bFq2/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC8201FFC7;
	Sun, 19 Oct 2025 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWzWN3Vf5Xr2vCC4gY687mhGW5/h0aIYSsAMMgYwlRE=;
	b=MZyFZsLbrSgsLt4yBmkKIRSBsjyXhK1SITiZymCxOP0V8/HCDmvc/RBIGcZAjTCbGx0jpC
	CaPVfRg9nfrNDnTzXRsgaaXYgP5wURpwcvsJ+2662ziOlN3QoG/ZsaYmRsYoR4sNYm8SXm
	JjdIwFU0T/4AGur9dwcixrrpNjaDyL0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Fn1bFq2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWzWN3Vf5Xr2vCC4gY687mhGW5/h0aIYSsAMMgYwlRE=;
	b=Fn1bFq2/VgjIQZGYqANKgCx1mvv8Lq2l61jkknxBTgO4yYYPjVDtJIJ3RZohMZkzdv2Dfz
	Bh/HfzRCD1UF9x7bSWhZ4vwdEPhUE4XSqp+EFObSO5TxVZpAVrA1JzMd6GF8QfyfBHV1KF
	2Yu3xFssQet1Hb36hgFXROoljXdqpxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746C013AEB;
	Sun, 19 Oct 2025 00:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KLXnDcU09GhlNgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 19 Oct 2025 00:45:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: safinaskar@gmail.com,
	Filipe Manana <fdmanana@suse.com>,
	Chris Murphy <lists@colorremedies.com>
Subject: [PATCH v3 2/3] btrfs: scrub: cancel the run if the process or fs is being frozen
Date: Sun, 19 Oct 2025 11:15:27 +1030
Message-ID: <26eb8fe77f33107b2762abd048c36c63c33271c2.1760834294.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760834294.git.wqu@suse.com>
References: <cover.1760834294.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EC8201FFC7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,colorremedies.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -3.01

It's a known bug that btrfs scrub/dev-replace can prevent the system
from suspending.

There are at least two factors involved:

- Holding super_block::s_writers for the whole scrub/dev-replace
  duration
  We hold that percpu rw semaphore through mnt_want_write_file() for the
  whole scrub/dev-replace duration.

  That will prevent the fs being frozen, which can be initiated by
  either the user (e.g. fsfreeze) or power management suspension/hiberation.

- Stuck in the kernel space for a long time
  During suspension all user processes (and some kernel threads) will
  be frozen.
  But if a user space progress has fallen into kernel (scrub ioctl) and
  do not return for a long time, it will make process freezing time out.

  Unfortunately scrub/dev-replace is a long running ioctl, and it will
  prevent the btrfs process from returning to the user space, thus make pm
  suspension/hiberation time out.

Address them in one go:

- Introduce a new helper should_cancel_scrub()
  Which includes the existing cancel request and new fs/process freezing
  checks.

  Here we have to check both fs and process freezing for pm
  suspension/hiberation.

  Pm can be configured to freeze fses before processes.
  (The current default is not to freeze fses, but planned to freeze the
  fses as the new default)

  Checking only fs freezing will fail pm without fs freezing, as the
  process freezing will time out.

  Checking only process freezing will fail pm with fs freezing since the
  fs freezing happens before process freezing.

  And the return value will indicate the reason, -ECANCLED for the
  explicitly canceled runs, and -EINTR for fs freeze or pm reasons.

- Cancel the run if should_cancel_scrub() is true
  Unfortunately canceling is the only feasible solution here, pausing is
  not possible as we will still stay in the kernel space thus will still
  prevent the process from being frozen.

This will cause a user impacting behavior change:

  Dev-replace can be interrupted by pm, and there is no way to resume
  but start from the beginning again.

This means dev-replace may fail on newer kernels, and end users will
need extra steps like using systemd-inhibit to prevent
suspension/hibernation, to get back the old uninterrupted behavior.

This behavior change will need extra documentation updates and
communication with projects involving scrub/dev-replace including
btrfs-progs.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Link: https://lore.kernel.org/linux-btrfs/d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com/
Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c3e7e543d350..bbd5793c2a16 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2069,6 +2069,47 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	return 0;
 }
 
+/*
+ * Return 0 if we should not cancel the scrub.
+ * Return <0 if we need to cancel the scrub, returned value will
+ * indicate the reason:
+ * - -ECANCELED
+ *   Being explicitly canceled through ioctl.
+ * - -EINTR
+ *   Being interrupted by fs/process freezing.
+ */
+static int should_cancel_scrub(const struct scrub_ctx *sctx)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+
+	if (atomic_read(&fs_info->scrub_cancel_req) ||
+	    atomic_read(&sctx->cancel_req))
+		return -ECANCELED;
+
+	/*
+	 * The user (e.g. fsfreeze command) or power management (pm)
+	 * suspension/hibernation can freeze the fs.
+	 * And pm suspension/hibernation will also freeze all user processes.
+	 *
+	 * A user process can only be frozen when it is in the user space, thus
+	 * we have to cancel the run so that the process can return to the user
+	 * space.
+	 *
+	 * Furthermore we have to check both fs and process freezing, as pm can
+	 * be configured to freeze the fses before processes.
+	 *
+	 * If we only check fs freezing, then suspension without fs freezing
+	 * will timeout, as the process is still in the kernel space.
+	 *
+	 * If we only check process freezing, then suspension with fs freezing
+	 * will timeout, as the running scrub will prevent the fs from being frozen.
+	 */
+	if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
+	    freezing(current))
+		return -EINTR;
+	return 0;
+}
+
 static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				      struct btrfs_device *scrub_dev,
 				      struct btrfs_block_group *bg,
@@ -2091,9 +2132,9 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	ASSERT(sctx->raid56_data_stripes);
 
-	if (atomic_read(&fs_info->scrub_cancel_req) ||
-	    atomic_read(&sctx->cancel_req))
-		return -ECANCELED;
+	ret = should_cancel_scrub(sctx);
+	if (ret < 0)
+		return ret;
 
 	if (atomic_read(&fs_info->scrub_pause_req))
 		scrub_blocked_if_needed(fs_info);
@@ -2275,11 +2316,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
-		if (atomic_read(&fs_info->scrub_cancel_req) ||
-		    atomic_read(&sctx->cancel_req)) {
-			ret = -ECANCELED;
+		ret = should_cancel_scrub(sctx);
+		if (ret < 0)
 			break;
-		}
 
 		if (atomic_read(&fs_info->scrub_pause_req))
 			scrub_blocked_if_needed(fs_info);
-- 
2.51.0


