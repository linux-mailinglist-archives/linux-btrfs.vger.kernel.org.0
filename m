Return-Path: <linux-btrfs+bounces-17863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE9BE16D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F3342519B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 04:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BA920C00A;
	Thu, 16 Oct 2025 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rxB9dEAM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rxB9dEAM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22418872A
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760589175; cv=none; b=krMmpCuGcUaDbZGUjyzIJ95IzzrMY1yZahkHmDPPePFPVZJU6O3Z8Sr4a4uz6qiuI+R+XlX+eIT/pGuDhRdfb26VtMZz76T3adTgYu/GGhk5xel83/7Ys3fgb6w9AW4Lu4KErJBHjor/UkpMmXh/2TKhW85hr2MRMTQF1eTMRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760589175; c=relaxed/simple;
	bh=SWObmIbQ5F/wTZFCmBXOiuAUBZhXbHehIYUm9ITThyM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o3fNbfaTWKv4W3GjtymvRLsLGWilm5cFTMOVRC4VyiHLLvhsJyrWBZP7po+BrRAP8ehgoghlJCtehcpVwgeEhjKqeK0V0ZPjug9SfazwzNJ625WNgqsa0dSOTAHfyw2+MWG9XS3CC+DENdlxg0fjMMxj9qyOSNAnMppUHBZLT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rxB9dEAM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rxB9dEAM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60BFC219AC
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=leZ6StmQ2zTGvvvN6HjTaYpbH82gvvnjpta1x3njKpk=;
	b=rxB9dEAMQJajnm2XmlHh/+/gRpOEo0PeuFc0K8v0vwjN9cu09RC8jwPDgacYDL8mp86KVi
	AwDGany6tvl52mOrM36At+1Zn7G8neMYsQn70CEQX0YPVI4pScArgxwdyjoJjxZri/VGiv
	9vWvtvMPaoS9fauG266ixtWNRFXBchg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rxB9dEAM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760589170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=leZ6StmQ2zTGvvvN6HjTaYpbH82gvvnjpta1x3njKpk=;
	b=rxB9dEAMQJajnm2XmlHh/+/gRpOEo0PeuFc0K8v0vwjN9cu09RC8jwPDgacYDL8mp86KVi
	AwDGany6tvl52mOrM36At+1Zn7G8neMYsQn70CEQX0YPVI4pScArgxwdyjoJjxZri/VGiv
	9vWvtvMPaoS9fauG266ixtWNRFXBchg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 888551376E
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dW8EEnF18GiqNQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 04:32:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Thu, 16 Oct 2025 15:02:28 +1030
Message-ID: <cover.1760588662.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 60BFC219AC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

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
  This is the most complex part that I have not yet fully pinned down.

To address the first 2 problems, the series will:

- Add extra cancel/pause/removed bg checks for raid56 parity stripes
  Mostly to reduce delay for RAID56 cases, and make the behavior more
  consistent.

- Cancel the scrub if the fs/process is being frozen

- Cancel the scrub if there is a pending signal
  For the systemd slice situation I have no idea how slice freezing is
  done, but at least we should check pending signals (not only fatal
  ones), which will align the behavior to relocation.

Qu Wenruo (3):
  btrfs: scrub: add cancel/pause/removed bg checks for raid56 parity
    stripes
  btrfs: scrub: cancel the run if the process or fs is being frozen
  btrfs: scrub: cancel the run if there is a pending signal

 fs/btrfs/scrub.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

-- 
2.51.0


