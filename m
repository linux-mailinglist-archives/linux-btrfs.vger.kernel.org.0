Return-Path: <linux-btrfs+bounces-18002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A6BEDD72
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 02:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A481406131
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C741991D2;
	Sun, 19 Oct 2025 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OTfgkvRu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hFWHgpl/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A6354AD4
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760834769; cv=none; b=NZhcIKOCHyO5rwPQISQcyFpyENGw3sXOqoSCnJtv0WKXLVlF1JuhsM2ZHVqyJIf6/W8z38YjvSlDjFzSmGdD/cBhmMWg2SpD7aqKPkXOg4n309bH4YH0ITCRZ7KdDdr+ghjLBx1Ge3Dkif7UfIfhC5LrrKPuAgjKV8V5JSO2mTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760834769; c=relaxed/simple;
	bh=KioUkVBHbyEbV8dRBfEw7Tzf7ZHoLb1DzPagUv+eJTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTPXtdr9/ULDlZGLDUkuK47hACRj59j0EaQxl2Djf4N/ZiicJXYkl+juQDU65KcJ/Os8HA24iVTWhmlnkCm+SAPks6RzwmPQCuAc5HXyYQ+lo7HUFylxO9cG6iaizVeUPYa5QlFP8eV7WndfpREHPdWAGaG6uKzPh2nezeJa3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OTfgkvRu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hFWHgpl/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 496401FF7A;
	Sun, 19 Oct 2025 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QQsmq/rspyjPpF7+MzVi4fJI86Ybs0iyw8krRJ4qefg=;
	b=OTfgkvRuKchixcVVonfvU0CEUW3pr8kcFzoz6AB3Y0izvKaO8UrE1/7FaIMYUuVEa58Fq8
	lDz6hkJrTR+2j/P3SXObzZR4H3ALq7fScAM2xCpYzI6X396m9a+o2hgIjqcHdXpI1+y2tE
	cZEnJO4m7zjKXm3XZUNQGwYnQE0O/AU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="hFWHgpl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760834755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QQsmq/rspyjPpF7+MzVi4fJI86Ybs0iyw8krRJ4qefg=;
	b=hFWHgpl/+5CSI60lc59dFDX+8go4dODALQZfZ91WuOH3LR0cZe6RK61OYU75oYjq0k9Uqt
	etoTRy4WzJKZeRdou7e3fH1JtyxlWK6lwij3Ymbx3Tzw1B25TtJwBh1S+274QpFJCXSmYG
	YCIKqfPncL4hrY5FAhsJr8bNsQnfoKU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 496C113A1F;
	Sun, 19 Oct 2025 00:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w1JkA8I09GhlNgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 19 Oct 2025 00:45:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: safinaskar@gmail.com
Subject: [PATCH v3 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Sun, 19 Oct 2025 11:15:25 +1030
Message-ID: <cover.1760834294.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 496401FF7A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
v3:
- Update the commit message and cover letter to indicate a behavior
  change
  Btrfs-progs updates will follow soon after merge into for-next.
  This will includes docs update, and maybe an automatic resume behavior
  (with new options to toggle).

- Update the commit message of the last patch to explain why v2 cgroup
  freezing is depending on signals
  Unlike legacy freezer of v1 cgroup, v2 cgroup freezer is fully based
  on signal handling, thus freezing through v2 cgroup looks exactly like
  a pending non-fatal signal. And freezing() will not return true in
  this case.

- Add the reviewed-by tag from Filipe

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
  Systemd slice freezing utilize cgroup freezer, and the freezing()
  checks will not return true until the whole cgroup is marked frozen.

  But before that a wakeup signal is sent to the user process, and
  during the kernel signal handling that process will be frozen.
  So until the process returned to user space, it will not be marked
  frozen.

  Thus we have to do regular pending signal checks to prevent cgroup
  freezing time out.

To address all those problems, the series will:

- Add extra cancel/pause/removed bg checks for raid56 parity stripes
  Mostly to reduce delay for RAID56 cases, and make the behavior more
  consistent.

- Cancel the scrub if the fs or process is being frozen
  Please note that here we have to check both fs and process freezing,
  please refer to the changelog and comment of the second patch for the
  reason.

- Cancel the scrub if there is a pending signal
  This allows regular signal to interrupt scrub/dev-replace, without the
  extra signal handling hack in btrfs-progs (but that existing handling
  won't hurt either).

  This also address the time out during systemd slice freezing. Unlike
  pm freezing, v2 cgroup freezing is fully based on signal handling thus
  freezing() function will not return true during v2 cgroup freeing.

  So when v2 cgroup is freezing the processing running scrub/replace, we
  will properly detect a pending signal and abort the scrub/replace so
  that freezing can be done when the process returned to the user space.

[BEHAVIOR CHANGE]
Unfortunately this will bring a behavior change, and will mostly
affecting dev-replace:

  Dev-replace will be interrupted by pm, and can not be resumed but only
  starts from the beginning.

The same dev-replace now will fail due to pm, breaking the old
expectation. End users will need extra steps to prevent
suspension/hibernation instead.

And btrfs-progs also needs to be updated to handle the new -EINTR
error (maybe restart the operation if possible).


Qu Wenruo (3):
  btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity
    stripes
  btrfs: scrub: cancel the run if the process or fs is being frozen
  btrfs: scrub: cancel the run if there is a pending signal

 fs/btrfs/scrub.c | 70 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

-- 
2.51.0


