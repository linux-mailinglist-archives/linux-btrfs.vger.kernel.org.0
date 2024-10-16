Return-Path: <linux-btrfs+bounces-8963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075EA9A0C94
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B1D1C21E20
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89C20ADDA;
	Wed, 16 Oct 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="McnRKBWz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="McnRKBWz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C18207A11;
	Wed, 16 Oct 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088812; cv=none; b=BggG/T0WO8Z5Ptl8pRJY8baAgQjoehOea429/gB4zOQYwba3m0JAOI4+kUqTuJaC4eL3mgt63uCgMMhp0P2SPGT6qwEU2+X1di7CKDkRLK5IQH7U0lU5ttHegFDS++ETAuDkd0KjhcdI0KcAE5oVxoCz7My31IHrM/FpN/hPw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088812; c=relaxed/simple;
	bh=2v5nDtN7ZV9pXk0lRwQM5SIj1UGkUw8LqCT+ejQ8qUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oF9N+QEAM7nQDhpYyr349oR5YvY3o4mXj0IfQ2jXAOYD4dMQw6nxN/d8nS3JlX8oYyfr1Exp0Yd9s+GbZosiCWO3pXAR0W5jY8KZ97DszDctlQ1+dxCdBHh4pc0/KicsuGfyJS29X5fhWEAnpCs0x770hBITXTDSbZkKzWbLkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=McnRKBWz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=McnRKBWz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F2F21F7E9;
	Wed, 16 Oct 2024 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729088808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vY/9lktZ1wS/CC2qhTTVN7rCUBlro92o+pIt9PbmR8s=;
	b=McnRKBWzXMIAWmcU84Gp7pr/Et8E2gAtIlukV/puRq4evurnUfjLwsqQtoOY19JG9IKFIq
	KbZyCQjmmO3oqNLxleqxrw0bjm8TZIqxsra8GHwYV3ZLVaPVQpWwr+Y0cQmU9bQV/XA1At
	k9az5TBVBua5dMrwme4/ReWUjMJybB0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=McnRKBWz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729088808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vY/9lktZ1wS/CC2qhTTVN7rCUBlro92o+pIt9PbmR8s=;
	b=McnRKBWzXMIAWmcU84Gp7pr/Et8E2gAtIlukV/puRq4evurnUfjLwsqQtoOY19JG9IKFIq
	KbZyCQjmmO3oqNLxleqxrw0bjm8TZIqxsra8GHwYV3ZLVaPVQpWwr+Y0cQmU9bQV/XA1At
	k9az5TBVBua5dMrwme4/ReWUjMJybB0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5784B13433;
	Wed, 16 Oct 2024 14:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7QFZFSjND2dpHQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Oct 2024 14:26:48 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc4
Date: Wed, 16 Oct 2024 16:26:39 +0200
Message-ID: <cover.1729087733.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F2F21F7E9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hi,

please pull the following branch with a few fixes, thanks.

- regression fix, dirty extents tracked in xarray for qgroups must be
  adjusted for 32bit platforms

- fix potentially freeing uninitialized name in fscrypt structure

- fix warning about unneeded variable in a send callback

----------------------------------------------------------------
The following changes since commit e761be2a0744086fc4793a4870d4b5746b7fe8cd:

  btrfs: fix clear_dirty and writeback ordering in submit_one_sector() (2024-10-09 13:23:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc3-tag

for you to fetch changes up to 2ab5e243c2266c841e0f6904fad1514b18eaf510:

  btrfs: fix uninitialized pointer free on read_alloc_one_name() error (2024-10-11 19:55:04 +0200)

----------------------------------------------------------------
Christian Heusel (1):
      btrfs: send: cleanup unneeded return variable in changed_verity()

Filipe Manana (1):
      btrfs: use sector numbers as keys for the dirty extents xarray

Roi Martin (2):
      btrfs: fix uninitialized pointer free in add_inode_ref()
      btrfs: fix uninitialized pointer free on read_alloc_one_name() error

 fs/btrfs/delayed-ref.c | 15 ++++++++-------
 fs/btrfs/delayed-ref.h | 10 +++++++++-
 fs/btrfs/qgroup.c      | 21 ++++++++++++++++-----
 fs/btrfs/send.c        |  4 +---
 fs/btrfs/tree-log.c    |  6 +++---
 5 files changed, 37 insertions(+), 19 deletions(-)

