Return-Path: <linux-btrfs+bounces-17878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7032BE278C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2CE4FC45B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2A3191B5;
	Thu, 16 Oct 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXDlN/Tz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXDlN/Tz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F182192EA
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607782; cv=none; b=fyK6dS/8F4u9SCIHd4wj7wqG9jAWZf4DfH6hxS7FelarK/88FPW7l4CK5x0C4ZhdvvaafMCiYbPvdiR93cLH0pHd4vKHjmgOKbAitCKnkO1GPtSp7vwsgiu17RX7f0TxnOZ50MsWdKNeduloLT5XtVGJcg+TQ6MZoF/1vZdRDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607782; c=relaxed/simple;
	bh=FnWfxjRpvIOeBF4V18A7O1xXSCAiGWvBBnvYZ7dcLNI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CvNWYkN1Qm5c0DcmC63035NyAUVQIL0uT/KPo001KiYJYNAgnfTy0icfr8TjNm9BCGSKbWqmfj26fomTPDteRtpd8mf+h1Gi/32CpNyHMQNaeFPIkW05S1A1ZDzfIaa4Wb0wf67hgvY6lHYKwISsEls4Kjoo7ETYcY3t9UCUI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXDlN/Tz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXDlN/Tz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 429DC21DBD
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JRDUqeeKoxO0/+doZ61WjtRJ46xAVLmrLHPGrvrXZHs=;
	b=rXDlN/TzV6qYz+BpYOF5mbsKlTukQTDIR/OXrLk4LSEsZOlbtpEE5931sLWoEh186cNiVW
	q8gQ2MNrh7VbtHRhyRmD+1gzPyqnwQN7jUnwQZ4DdP9T9EB7nzDRaCx81MhKZzQr7ci1Ys
	QF0yjVp/WXfr76aIwJKnfS65qZ3eipY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="rXDlN/Tz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760607777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JRDUqeeKoxO0/+doZ61WjtRJ46xAVLmrLHPGrvrXZHs=;
	b=rXDlN/TzV6qYz+BpYOF5mbsKlTukQTDIR/OXrLk4LSEsZOlbtpEE5931sLWoEh186cNiVW
	q8gQ2MNrh7VbtHRhyRmD+1gzPyqnwQN7jUnwQZ4DdP9T9EB7nzDRaCx81MhKZzQr7ci1Ys
	QF0yjVp/WXfr76aIwJKnfS65qZ3eipY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79BAD1340C
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6w6uDiC+8GgjYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 09:42:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Thu, 16 Oct 2025 20:12:35 +1030
Message-ID: <cover.1760607566.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 429DC21DBD
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
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Remove copy-pasted comments that are too obvious in the first place
  Also remove a stale comment in the old code.

- Add extra explanation on why both fs and process freezing need to be
  checked
  Mostly due to the configurable behavior of pm suspension/hiberation,
  thus we have to handle both cases.

It's a long known bug that when scrub/dev-replace is running, power
management suspension will time out and fail.

After more debugging and helps from Askar Safin, it turns out there are
at least 3 components involved:

- Process freezing
  This is at the preparation for suspension, which requires all user
  space processes (and some kthreads) to be frozen, which requires the
  process return to user space.

  Thus if the process (normally btrfs command) is falling into a long
  running ioctl (like scrub/dev-replace) it will not be frozen thus
  breaking the pm suspension.

  This mean paused scrub is not feasible, as paused scrub will still
  make the ioctl executing process trapped inside kernel space.

- Filesystem freezing
  It's an optional behavior during pm suspension, previously I submitted
  one patch detecting such situation, and so far it works as expected.
  But this fs freezing is only optional, not yet default behavior of pm
  suspension.

- Systemd slice freezing
  This is the most complex part that I have not yet fully pinned down,
  but during the tests it looks like systemd is sending some signals to
  the processes under the user slice.

  Thus if the process is falling into the kernel for a long time, it will
  not return to the user space and no chance to handle the signal.

To address all those problems, the series will:

- Add extra cancel/pause/removed bg checks for raid56 parity stripes
  Mostly to reduce delay for RAID56 cases, and make the behavior more
  consistent.

- Cancel the scrub if the fs or process is being frozen
  Please note that here we have to check both fs and process freezing,
  please refer to the changelog and comment of the second patch for the
  reason.

- Cancel the scrub if there is a pending signal
  This is mostly for the systemd slice handling, which affects users
  running the scrub inside a user slice. This can cause an obvious
  delay during pm suspension/hiberation and power off/restart.

Qu Wenruo (3):
  btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity
    stripes
  btrfs: scrub: cancel the run if the process or fs is being frozen
  btrfs: scrub: cancel the run if there is a pending signal

 fs/btrfs/scrub.c | 64 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

-- 
2.51.0


