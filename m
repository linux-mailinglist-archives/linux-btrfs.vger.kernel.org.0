Return-Path: <linux-btrfs+bounces-18518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D90C29D9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 03:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278B5188F71F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 02:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4727FB1E;
	Mon,  3 Nov 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rnDUAfnN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ilcqtiXy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A882184524
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136479; cv=none; b=PVYUR3B7pJjn7wZ0FSv2n5kvtKc3WP08yTl4CWjZXRgD0crsqnBY8yRiJPr73uUe85Fh5WDAboHLqc8oCntv8O0sNr37p1JnTWj2u1KrbyXVlqG+wnlWzwdyCq8Wam3IJxqVAeGKldUHr99YLUbO1ecl7jz20xSRIUqk1jYRaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136479; c=relaxed/simple;
	bh=16Cqi4Fak5Tv9ik1RQPypulZ7KICVSVK6FEmC5zcc/A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P+kbx4yIUy0i70QyI1q6TdHoODPXhwTVCU/tiBYPfW+jZujLZSyW4Id5YsRz7zDoOJ4L9MQ4ZH7zl8sEZrGv72bGng41wppIu6GsA/r0P4INyQTZhTqDHFaWhnuyTk9r144BGLIKnpMTnr9WT3+pqHsemDbZCI9vFAfhk78uFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rnDUAfnN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ilcqtiXy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72D7621DD7
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 02:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762136474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Snp1Y6WrRkwMFpWJi8aXGuzqBr/SzGyDWbfmR4jH9l4=;
	b=rnDUAfnNT32g5yWjX81BH2Vmi/kxgimf9MB8GC/vNCdWrOlrBcgy7O1YJt6RfQ1P48Smh6
	n0MVkv+ds5z7yKYzcnTtX/AzEUUBZK3QpgGQxFzC0/UDOYmaDAxpzVK1wdDAG2NIb24hL2
	w5/O1CJR/QQzf7jPHzE+CGtflMl+rEg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762136473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Snp1Y6WrRkwMFpWJi8aXGuzqBr/SzGyDWbfmR4jH9l4=;
	b=ilcqtiXyfKIMvuVVQVJ5Y/2OqPYmdykza0z22uVuc1peGcVRt+nvqRjOuahUMqSPLjAas7
	oP9Ucnto8FbEF0a+TTw2HWN8hsV52TpAY93sE8hz5RSPs8ThRA5HpMlUSwCYWMQg8869NQ
	rdDg6SGFmQFH1wXfXyKfv/Zs09oDBzI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA16C139A9
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 02:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3XdPGpgRCGkNHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 02:21:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: always update btrfs_scrub_progress::last_physical
Date: Mon,  3 Nov 2025 12:51:09 +1030
Message-ID: <5e19e3656afeb899f91a1c81367d7e79215bee01.1762136447.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
When a scrub failed immediately without any byte scrubbed, the returned
btrfs_scrub_progress::last_physical will always be 0, even if there is a
non-zero @start passed into btrfs_scrub_dev() for resume cases.

This will reset the progress and make later scrub resume start from the
beginning.

[CAUSE]
The function btrfs_scrub_dev() accepts a @progress parameter to copy its
updated progress to the caller, there are cases where we either don't
touch progress::last_physical at all or copy 0 into last_physical:

- last_physical not updated at all
  If some error happened before scrubbing any super block or chunk, we
  will not copy the progress, leaving the @last_physical untouched.

  E.g. failed to allocate @sctx, scrubbing a missing device or even
  there is already a running scrub and so on.

  All those cases won't touch @progress at all, resulting the
  last_physical untouched and will be left as 0 for most cases.

- Error out before scrubbing any bytes
  In those case we allocated @sctx, and sctx->stat.last_physical is all
  zero (initialized by kvzalloc()).
  Unfortunately some critical errors happened during
  scrub_enumerate_chunks() or scrub_supers() before any stripe is really
  scrubbed.

  In that case although we will copy sctx->stat back to @progress, since
  no byte is really scrubbed, last_physical will be overwritten to 0.

[FIX]
Make sure the parameter @progress always has its @last_physical member
updated to @start parameter inside btrfs_scrub_dev().

At the very beginning of the function, set @progress->last_physical to
@start, so that even if we error out without doing progress copying,
last_physical is still at @start.

Then after we got @sctx allocated, set sctx->stat.last_physical to
@start, this will make sure even if we didn't get any byte scrubbed, at
the progress copying stage the @last_physical is not left as zero.

This should resolve the resume progress reset problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4951022ab402..f6678d06004d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3040,6 +3040,10 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	unsigned int nofs_flag;
 	bool need_commit = false;
 
+	/* Set the basic fallback @last_physical before we got a sctx. */
+	if (progress)
+		progress->last_physical = start;
+
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
 
@@ -3058,6 +3062,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
+	sctx->stat.last_physical = start;
 
 	ret = scrub_workers_get(fs_info);
 	if (ret)
-- 
2.51.2


