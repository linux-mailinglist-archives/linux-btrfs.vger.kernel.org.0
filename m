Return-Path: <linux-btrfs+bounces-14559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE2AD1C58
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 13:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC505188BB72
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A90253920;
	Mon,  9 Jun 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sEDhmtn1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sEDhmtn1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BC28F3
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467804; cv=none; b=Ugy55TFP5KtR5wrk5vjygUhL8WlpazzXiuq/42Op9mHI8HoPjAguYalUhx+Kg0M9Y70KoHL3gywedpUIN8aq985hw3H8TOoxwiEyv87ZHtykQntS5RXfXoyd0WN6WgTEeN5Jh5NpENLpIm8WOWtfLuOziEuaLm5cmxx87VJnf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467804; c=relaxed/simple;
	bh=1fwIV8e5zt624J7d023LZEUu65ie7B+zAsHeAckuEQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dl3JCJUESH+D18mlVbBxD5zjDutvwY9KxFJpmUVUrgr9/H1ZFE/7w8LlrFlP1F/rfb7vR9x49pmCxOVbXajyYCjsIVeXuL8iUGoioUyi95VyodeK8l2MbXJ5MtFIyptoqKbc7i+Lh0aX0l8m/rk9D27FvEJp2YuWdqKsGcP6y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sEDhmtn1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sEDhmtn1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 321C61F38F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749467800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c3C0WbQzWX2B11jWPtN5EwzPRKV6bTt7djF4EVP0ju0=;
	b=sEDhmtn1aTery99/BfWiYlGPU9izkV8wZLCwZPoLO0sDaWe9VWP9Uz2ODSXkwny3fV7E1L
	qDxYVI6lt4C8GGNFMCK3pYebomqXBU34zRZudxfFkHx82lZb1uZz4QCQvE1aqyA5Ha9KwX
	z6EQ0Hoze10wJ7fM/oaRiEwtYkM16vA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sEDhmtn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749467800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c3C0WbQzWX2B11jWPtN5EwzPRKV6bTt7djF4EVP0ju0=;
	b=sEDhmtn1aTery99/BfWiYlGPU9izkV8wZLCwZPoLO0sDaWe9VWP9Uz2ODSXkwny3fV7E1L
	qDxYVI6lt4C8GGNFMCK3pYebomqXBU34zRZudxfFkHx82lZb1uZz4QCQvE1aqyA5Ha9KwX
	z6EQ0Hoze10wJ7fM/oaRiEwtYkM16vA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 627E613A85
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 11:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXRICZfCRmj8OAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 11:16:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RESEND] btrfs: add extra warning when qgroup is marked inconsistent
Date: Mon,  9 Jun 2025 20:46:21 +0930
Message-ID: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 321C61F38F
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Unlike qgroup rescan, which always shows whether it cleared the
inconsistent flag, we do not have a proper way to show if qgroup is
marked inconsistent.

This was not a big deal before as there aren't that many locations that
can mark qgroup  inconsistent.

But with the introduction of drop_subtree_threshold, qgroup can be
marked inconsistent very frequently, especially for dropping large
subvolume.

Although most user space tools relying on qgroup should do their own
checks and queue a rescan if needed, we have no idea when qgroup is
marked inconsistent, and will be much harder to debug.

So this patch will add an extra warning (btrfs_warn_rl()) when the
qgroup flag is flipped into inconsistent for the first time.

Combined with the existing qgroup rescan messages, it should provide
some clues for debugging.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Pure resent, I thought it was already merged but it's not the case.
It will be very helpful for debugging qgroup related problems caused by
qgroup being marked inconsistent.
---
 fs/btrfs/qgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a1afc549c404..45f587bd9ce6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
 {
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
 		return;
+	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT))
+		btrfs_warn_rl(fs_info, "qgroup marked inconsistent");
 	fs_info->qgroup_flags |= (BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
 				  BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN |
 				  BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING);
-- 
2.49.0


