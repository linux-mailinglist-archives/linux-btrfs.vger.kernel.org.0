Return-Path: <linux-btrfs+bounces-8410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D598CAFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 03:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B76286196
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948F5C96;
	Wed,  2 Oct 2024 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rB67/oXz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JsDCPK1E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98AEBE
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833979; cv=none; b=AA6BPPeU12M9WgLl22y7y0EG4hzhIIk24kcVPyNYBvMEMsoz6TVgsV6pOe80If/2aA/2UDj22BTrSBUYph+mDjc2hF+pn2i2XVv0mTkdZVZTi2vNSM+TkgNl3oA5hI2yrTRjnoT0O6HCFMEnB5csp8q37S7aL5kTtUbvLe214hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833979; c=relaxed/simple;
	bh=TgB556EA5oAOi1v4WUsVjCLYwOo3KLuMJvc68Og4jcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N9+7OCYWmmlXOFju5g3K6HHkSjM0N/XP8mga3QzFzP6XtYiOKMIXUYLRNFoOS3UM0g594ATg8axkpjuHkb5Kq5+7wcnRi/xEx3qzd85gk6bUuGOK+4FwwpJ98Ms6UddjjhkyN5ILV8uNYA+y3NR7VJFRuDtlB8YbIVPN6MBuAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rB67/oXz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JsDCPK1E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DAFB1F82A
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NC0ZODL6IFg7Xq20roCYpdQJLzv8qY3zNa1ynKE6YhQ=;
	b=rB67/oXz0TQ25g4P3aB3FHbLM6JkKqyvHKDZAVTJhutM1KQxhHUzYhY/kw7YZe7C+TePPA
	LQI/MYCOtbl2NziiUeTFRLZjk/1H/XNjCLc6OaeCUDlTLPKKUPoq2/BC/0kWNwxlFFuMCA
	B0Oosb5uw80BeM+pHK89JhxW45BkAEA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JsDCPK1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NC0ZODL6IFg7Xq20roCYpdQJLzv8qY3zNa1ynKE6YhQ=;
	b=JsDCPK1EZsnBZ16JqTKJX8c97r0bNc3lezcP6siE/1Q3J5kBs0HPPHdvU2GB/qAmqT3/8/
	tq7xWlV4/Ex+Wjm6OykOO6jC6tu60WuqfLrC6QLllRr9GjZTDlRpIB6QbySFEVNiYbPOkl
	2EO46cJDsGyrbMeS/YFU7RTdempb7HE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD56513A51
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0BahInSn/GaHVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 01:52:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix generic/563 failures with sectorsize < PAGE_SIZE
Date: Wed,  2 Oct 2024 11:22:32 +0930
Message-ID: <cover.1727833878.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DAFB1F82A
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The test case generic/563 always fail on 64K page sized systems with
btrfs, however there are two different causes:

- sector size == page size
  In that case, it's the test case not using aligned block size, causing
  the btrfs (and ext4) to read out the full page before buffered write.

  This is fixed by the following patch:
  https://lore.kernel.org/linux-btrfs/20240929235038.24497-1-wqu@suse.com/

- sector size < page size
  This is a problem inside btrfs, which can not handle partial uptodate
  pages, thus even if the buffered write covers a full sector, btrfs
  will still read the full page, causing unnecessary IO.
  This is btrfs specific, and ext4/xfs doesn't not have this problem.

This patchset fix the sector size < page size case for btrfs, by:

- Changing btrfs_do_readpage() to do block-by-block read
  This allows btrfs to do per-sector uptodate check, not just relying on
  the extent map checks.

- Changing both buffered read and write path to handle partial uptodate
  pages
  For the buffered write path, it's pretty straight forward, just skip
  the full page read if the range covers full sectors.

  It's the buffered read path needs the extra work, by skipping any read
  into the already uptodate sectors.

  Or we can have a dirtied range, and read (from holes) re-fill the
  dirtied range with 0, causing data corruption.

With these two patches, 4K sector sized btrfs on 64K page sized systems
can pass generic/563 now.

Although considering I have hit data corruption due to the above read
path not skipping uptodate sectors, I'm wondering should I put the full
page read skip code under EXPERIMENTAL flags.

At least this is only affecting subpage cases, the more common x86_64
cases will not be affected.

Qu Wenruo (2):
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: allow buffered write to skip full page if it's sector aligned

 fs/btrfs/extent_io.c | 43 ++++++++++++++++++-------------------------
 fs/btrfs/file.c      |  5 +++--
 2 files changed, 21 insertions(+), 27 deletions(-)

-- 
2.46.2


