Return-Path: <linux-btrfs+bounces-17865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0971FBE16DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976A0425060
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 04:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0518872A;
	Thu, 16 Oct 2025 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MK9zyzVy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MK9zyzVy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F3B19644B
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589183; cv=none; b=j1I6Dwriiuh+tzAogVJpQaFi8hgpCM3xBzhhT7i19QK4Pd5mdNEtJC/HZIOhHoa3JH7bBSfk8oXh33oqdBWLzFaLCoGYEudcf/hNUoDFlTi4U/EcvYNMiLU6+Ny0Npq6uLfqzS/Z9jD/vkPie7zaXMb1j23gKrEhko3twxHl1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589183; c=relaxed/simple;
	bh=NNXb3ZehHlqfd7cKmxnV9T6UMML0HpWxgx12zl4etwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVixTU/CcJVr7tF8Bs2tN9HaDISjiHGItc6icc3BBF8nQ0XttAYJNxVEg/He2GBbQnx0nwC+pkPgqCt8n0WSuQl7lxmEoQ6ND1i90QsoeuSKImv7mPJ2GMDiqS7XqqgyFRd6mx4yyDCzvh3SfN4zavPZoO/rA1jnCoV7wZJBMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MK9zyzVy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MK9zyzVy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1BD71F7B9
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLhQiCe2HipVMvbsrETe6qtmLUhqb9Q6Bvh2k4RGyl0=;
	b=MK9zyzVyezikYfzim5f9n8XcuJRcZSwGbUJC0tGEGjjWaBMYeMFCPcv0jMsy3OExT42FHV
	X0iwktYjeg/9SpJ3M1F4Uo1WMAQkCSoTzhd/tpn9vWS354WB0Qp/CzkRn5ZvH2W3nSmy0P
	VrkxYsyd4UfWrJ4ifKNdefg1Snu+NY0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MK9zyzVy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLhQiCe2HipVMvbsrETe6qtmLUhqb9Q6Bvh2k4RGyl0=;
	b=MK9zyzVyezikYfzim5f9n8XcuJRcZSwGbUJC0tGEGjjWaBMYeMFCPcv0jMsy3OExT42FHV
	X0iwktYjeg/9SpJ3M1F4Uo1WMAQkCSoTzhd/tpn9vWS354WB0Qp/CzkRn5ZvH2W3nSmy0P
	VrkxYsyd4UfWrJ4ifKNdefg1Snu+NY0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 144011376E
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gEeOMXN18GiqNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is being frozen
Date: Thu, 16 Oct 2025 15:02:30 +1030
Message-ID: <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760588662.git.wqu@suse.com>
References: <cover.1760588662.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D1BD71F7B9
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

It's a known bug that btrfs scrub/dev-replace can prevent the system
from suspending.

There are at least two factors involved:

- Holding super_block::s_writers for the whole scrub/dev-replace
  duration
  We hold that mutex through mnt_want_write_file() for the whole
  scrub/dev-replace duration.

  That will prevent the fs being frozen.
  It's tunable for the kernel to suspend all fses before suspending, if
  that's the case, a running scrub will refuse to be frozen and prevent
  suspension.

- Stuck in kernel space for a long time
  During suspension all user processes (and some kernel threads) will
  be frozen.
  But if a user space progress has fallen into kernel (scrub ioctl) and
  do not return for a long time, it will make suspension time out.

  Unfortunately scrub/dev-replace is a long running ioctl, and it will
  prevent the btrfs process from returning to user space.

Address them in one go:

- Introduce a new helper should_cancel_scrub()
  Which checks both fs and process freezing.

- Cancel the run if should_cancel_scrub() is true
  The check is done at scrub_simple_mirror() and
  scrub_raid56_parity_stripe().

  Unfortunately canceling is the only feasible solution here, pausing is
  not possible as we will still stay in the kernel state thus will still
  prevent the process from being frozen.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index facbaf3cc231..728d4e666054 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2069,6 +2069,20 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
 	return 0;
 }
 
+static bool should_cancel_scrub(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * For fs and process freezing case, it can be preparation
+	 * for a incoming pm suspension.
+	 * In that case we have to return to the user space, thus
+	 * canceling is the only feasible solution.
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
@@ -2093,7 +2107,8 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 
 	/* Canceled? */
 	if (atomic_read(&fs_info->scrub_cancel_req) ||
-	    atomic_read(&sctx->cancel_req))
+	    atomic_read(&sctx->cancel_req) ||
+	    should_cancel_scrub(fs_info))
 		return -ECANCELED;
 
 	/* Paused? */
@@ -2281,7 +2296,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
-		    atomic_read(&sctx->cancel_req)) {
+		    atomic_read(&sctx->cancel_req) ||
+		    should_cancel_scrub(fs_info)) {
 			ret = -ECANCELED;
 			break;
 		}
-- 
2.51.0


