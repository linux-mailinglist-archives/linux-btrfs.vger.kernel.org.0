Return-Path: <linux-btrfs+bounces-18005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11BBEDD75
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 02:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207771896363
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE61531E8;
	Sun, 19 Oct 2025 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aM7Myb5M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RpkaLjzb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE82354AC1
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760834783; cv=none; b=GXYFa90b7i4tDgft94tHlAG2EIe7CxbU+lIjuZyQalbK/6ZJo12Na63uPd1/NxcjJXUKR+/L+jgn28DmHcb0XDy6JwwWYOD2cjeOdeRDJ4furptNestZNMEP7uuPNMDRCl9k7HPKHB2q4rAZ2EDRoA2SCJpR026Ke+rvxpln05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760834783; c=relaxed/simple;
	bh=HSJn7MDA3zt+culcxGBGBIiqZd1H5g58SkYVO3Yu74k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jedcT17bFDOl7TiOVTYxMhUzrrNbJdoRQxGW2niT/eL93CCr4Xh1PI1emr0fyvam1k92Fme0P+A8MxnnXNB5LrBju0gBxUFCEFxAI0D1btDQKmGdxHlaJytBSW39r1U5yu55O/xB97pqwavP617cWmeGmaGn3ie3bOGZZkJ6png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aM7Myb5M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RpkaLjzb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5000200F2;
	Sun, 19 Oct 2025 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVzyVRWqgo18u2XlKzeZO1UC1OJEhNUCeLJW1pws3V8=;
	b=aM7Myb5MAxKMXrsXz9Ge2nwOxI9O56MZHR+HkwwJLEFECl9s2bvUys0vYIxPc/CAKZVlys
	8vIctC/TF0hpH6Vjyo3/Mjt1c5NnChggXIaLBw04mQXOLS0hMSO2hZ5jNdphHhcWRsHsaj
	4U+GLV+kUM2gLjELU8A4a9jlwWN16T8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVzyVRWqgo18u2XlKzeZO1UC1OJEhNUCeLJW1pws3V8=;
	b=RpkaLjzbbzvFV8HBlrM0QWvgK/Ew+g3TYeqn5hxqDfO/kDMfkwj4UQL0UTwcYHMZC8bfPm
	yKPBPqbZWFbApiKzeFF8x1HI//kle0G5RmuWe2e0STHau/LB1H7Xn/mku8vOrUBMq0xaym
	S/P2rwizMbsaKFzX1gFoMuN2FiMnsvk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66E6713B03;
	Sun, 19 Oct 2025 00:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PujCsc09GhlNgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 19 Oct 2025 00:45:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: safinaskar@gmail.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 3/3] btrfs: scrub: cancel the run if there is a pending signal
Date: Sun, 19 Oct 2025 11:15:28 +1030
Message-ID: <77ccf440bc8a95d0d26a76f13fd61f353091b497.1760834294.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Unlike relocation, scrub never checks pending signals, and even for
relocation is only explicitly checking for fatal signal (SIGKILL), not
for regular ones.

Thankfully relocation can still be interrupted by regular signals by
the usage of wait_on_bit(), which is called with TASK_INTERRUPTIBLE.

Do the same for scrub/dev-replace, so that regular signals can also
cancel the scrub/replace run, and more importantly handle v2 cgroup
freezing which is based on signal handling code inside the kernel, and
freezing() function will not return true for v2 cgroup freezing.

This will address the problem that systemd slice freezing will timeout
on long running scrub/dev-replace.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bbd5793c2a16..05241324edd3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2076,7 +2076,7 @@ static int queue_scrub_stripe(struct scrub_ctx *sctx, struct btrfs_block_group *
  * - -ECANCELED
  *   Being explicitly canceled through ioctl.
  * - -EINTR
- *   Being interrupted by fs/process freezing.
+ *   Being interrupted by signal or fs/process freezing.
  */
 static int should_cancel_scrub(const struct scrub_ctx *sctx)
 {
@@ -2105,7 +2105,7 @@ static int should_cancel_scrub(const struct scrub_ctx *sctx)
 	 * will timeout, as the running scrub will prevent the fs from being frozen.
 	 */
 	if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
-	    freezing(current))
+	    freezing(current) || signal_pending(current))
 		return -EINTR;
 	return 0;
 }
-- 
2.51.0


