Return-Path: <linux-btrfs+bounces-17464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13060BBE882
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FF63BCE56
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC272D662D;
	Mon,  6 Oct 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jRDlOBgk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jRDlOBgk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AC2D879A
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765679; cv=none; b=YEyirBk+VioUdJ7qt7cJ+fxUPcwwZRyTYtE9ywpEr4iOOYTKz7aApoeAh9XLp49EJXBDuBkNkwDyFMDYSBe4KvHNGnR2v7+tItYBlP+aIIho2QyQY/koEpF17EVMPJkbtb91U9EUbnCs/go47E6dCV+zUp3+u/PTeKTl147hx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765679; c=relaxed/simple;
	bh=HN+nDCrFhsv8BG7LtrvF2kbTqt8nRNOB8Bt6++wEvd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCEszbpRbeKx8PLrSWZK5hsyd/xAkPAc6iLFv31VT4jeSrmGEogMMbOB5NmaVlwjqAMVKxLKrNFXRxYEJMz9Q45/pAxp6ba+WwqpPmWS5wD9d0Jq+FuVNZ6zwScOVgfgMqrvd7ZFIYHqF3Ac/J6hf/kpFXeFwsdqTxiyRilqGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jRDlOBgk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jRDlOBgk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5C631F451;
	Mon,  6 Oct 2025 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759765675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wKm7I/Sa0st0bjo6Se4lnhfhlbVutU6i0ITMuizxzx8=;
	b=jRDlOBgk2l2QRYBZV/YKtIAqHWxfB37Mhp31E5a1qzOg/hHYr2btP0fSKodvSGSjSa9rUu
	1CH0d5OS/40Uf8PGM4TUpSLcEG4Qm0Xa21D9wtvD0tWilh0Z8icy9H0e21ivO6qnti7bNP
	bw+BDMScZs+ELXA3uf41511NDz7GWnM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759765675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wKm7I/Sa0st0bjo6Se4lnhfhlbVutU6i0ITMuizxzx8=;
	b=jRDlOBgk2l2QRYBZV/YKtIAqHWxfB37Mhp31E5a1qzOg/hHYr2btP0fSKodvSGSjSa9rUu
	1CH0d5OS/40Uf8PGM4TUpSLcEG4Qm0Xa21D9wtvD0tWilh0Z8icy9H0e21ivO6qnti7bNP
	bw+BDMScZs+ELXA3uf41511NDz7GWnM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C7D413700;
	Mon,  6 Oct 2025 15:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Hf0Javk42jnNAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 06 Oct 2025 15:47:55 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.18, part 2
Date: Mon,  6 Oct 2025 17:47:52 +0200
Message-ID: <cover.1759762927.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi,

please pull two short fixes that would be good to have before rc1.
Thanks.

- fix printk format warning on 32bit platforms

- fix potential out-of-bounds access in callback encoding NFS handles

----------------------------------------------------------------
The following changes since commit 45c222468d33202c07c41c113301a4b9c8451b8f:

  btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot() (2025-09-23 09:02:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag

for you to fetch changes up to 4335c4496b1bcf8e85761af23550a180e937bac6:

  btrfs: fix PAGE_SIZE format specifier in open_ctree() (2025-10-01 16:27:28 +0200)

----------------------------------------------------------------
Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Nathan Chancellor (1):
      btrfs: fix PAGE_SIZE format specifier in open_ctree()

 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/export.c  | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

