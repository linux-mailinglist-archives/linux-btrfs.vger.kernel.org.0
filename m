Return-Path: <linux-btrfs+bounces-17880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A679CBE2795
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FAB34E5AD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD15464F;
	Thu, 16 Oct 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MRx9Ez6l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MRx9Ez6l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A3192D97
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607796; cv=none; b=XoSoJ9enB5J9JIfOPxWRZbhI6XeX0Y8xaLusdJJ5/oGzPWXDOfyFqddvN9tLljH155IlGJKON2L2JarxbmN7Tghvo3BA1zupYxQin2XjsmkWM7FZhkZGflPg6zbyEElSdnPj6P1BrM7QQDfTCvc24T6Bxx09WttnOG2Tbo/HwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607796; c=relaxed/simple;
	bh=LL31NtauttPvFtz5cU6NR5mBhpXYdqrP+zIy3v3xw7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NErPAtdZgQ6cGR3Kf7hdfIVJggADrEAesKcKbAERpnGXS0+pJIJrgPuqio6iBTRQ6Mxw7sXtqIK8o3onADwmJ6sR8gjj/B8LSugaxfRlUVX/TrXSR1fvQmjV+7tH+ZSMX5ckk9/lboHwrjkpwjI7DTYy9GlLZnX1T8AAXwW/8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MRx9Ez6l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MRx9Ez6l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1085121DC1
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yCsKcmmLwNkhHv+bqpzVKiWKxqk2Uj3eA65uIhg7uk=;
	b=MRx9Ez6llIvgG7eXUXl4abPw39quVJHCiXiO560LXzHwGtJYBTiC4Ih+dTZEIuCgArcoFS
	snoWrZTaJwH23qkATVcstXfT2O0vjPFODtLVzIa+acNSxAjkV/v9d2xjVMzGEAW4tGzuVk
	m57N1QKm0VjqXJewgPM1e/kiPhQMIzk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yCsKcmmLwNkhHv+bqpzVKiWKxqk2Uj3eA65uIhg7uk=;
	b=MRx9Ez6llIvgG7eXUXl4abPw39quVJHCiXiO560LXzHwGtJYBTiC4Ih+dTZEIuCgArcoFS
	snoWrZTaJwH23qkATVcstXfT2O0vjPFODtLVzIa+acNSxAjkV/v9d2xjVMzGEAW4tGzuVk
	m57N1QKm0VjqXJewgPM1e/kiPhQMIzk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 482C01340C
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iM+lAiO+8GgjYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: scrub: cancel the run if the process or fs is being frozen
Date: Thu, 16 Oct 2025 20:12:37 +1030
Message-ID: <0cce8f800341d8bb55ed128b0b45afb345964816.1760607566.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760607566.git.wqu@suse.com>
References: <cover.1760607566.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

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

- Cancel the run if should_cancel_scrub() is true
  Unfortunately canceling is the only feasible solution here, pausing is
  not possible as we will still stay in the kernel space thus will still
  prevent the process from being frozen.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c3e7e543d350..214285b216ec 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2069,6 +2069,38 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	return 0;
 }
 
+static bool should_cancel_scrub(struct scrub_ctx *sctx)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+
+	if (atomic_read(&fs_info->scrub_cancel_req) ||
+	    atomic_read(&sctx->cancel_req))
+		return true;
+
+	/*
+	 * The user (e.g. fsfreeze command) or power management (pm)
+	 * suspension/hibernation can freeze the fs.
+	 * And pm suspension/hibernation will also freeze all user processes.
+	 *
+	 * A process can only be frozen when it is in the user space, thus we
+	 * have to cancel the run so that the process can return to the user
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
+		return true;
+	return false;
+}
+
 static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 				      struct btrfs_device *scrub_dev,
 				      struct btrfs_block_group *bg,
@@ -2091,8 +2123,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	ASSERT(sctx->raid56_data_stripes);
 
-	if (atomic_read(&fs_info->scrub_cancel_req) ||
-	    atomic_read(&sctx->cancel_req))
+	if (should_cancel_scrub(sctx))
 		return -ECANCELED;
 
 	if (atomic_read(&fs_info->scrub_pause_req))
@@ -2275,8 +2306,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		u64 found_logical = U64_MAX;
 		u64 cur_physical = physical + cur_logical - logical_start;
 
-		if (atomic_read(&fs_info->scrub_cancel_req) ||
-		    atomic_read(&sctx->cancel_req)) {
+		if (should_cancel_scrub(sctx)) {
 			ret = -ECANCELED;
 			break;
 		}
-- 
2.51.0


