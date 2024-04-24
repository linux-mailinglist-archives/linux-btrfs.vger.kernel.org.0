Return-Path: <linux-btrfs+bounces-4513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC48B06FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97589283814
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2346159564;
	Wed, 24 Apr 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SUCGpXpr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MSA55m4W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B005158D99;
	Wed, 24 Apr 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953390; cv=none; b=Uv02+kgANj37Df6iVdTVzLGJy/9Pz07JPhCI7GPXim/Pwf08LhG48BIiq0UAcVOBUhsdtKFQ66nv8y7j0M1C31jxbRS4D7im1dsx3hfN0nmbuwSH8g/aMX/gyq9rZsIgFzl4839StUQFTB7hFfv9j3MRSahGma2MEpENccfDgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953390; c=relaxed/simple;
	bh=W6xud4LaOVjv4EcBRw1ooiHmNDmW6u4oEH9qzeBFsEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cy5SNnWHInQ6fkKKHwx3ee1dSaibJUAMqTVfPO1k9tWetESaHlOyoAbrZ8+nifC6DKrWKfLSzC6MWR7FSH4gtM41FzIoaFfQ4dJ1nAMR/nalIeT4xNoao4ThQVWgzwWjz3QgKuz1bgVX8UbJ9N9mqOcOnfw1lH8tCwCXb4sUHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SUCGpXpr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MSA55m4W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB1B36136F;
	Wed, 24 Apr 2024 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713953384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eDWLEwWp9FzNgsYJ9/J+V2MeJ5MCV4vYPXzikttfM24=;
	b=SUCGpXprADGhHmkGjBIoi4O76qljYrHgVMCQnQr/BioiQmF1JZ1hhQu1ARWQx6VeC0qbbo
	3SyyVqgKn92sSRk/C6xkqM/iLLvHjLJH/CSITn2scALlALMeWcsJxmrfTsexwJaxIkGueI
	Nx7IcFlLvCZqvUsHb7VacpmLR5gdtxs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MSA55m4W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713953382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eDWLEwWp9FzNgsYJ9/J+V2MeJ5MCV4vYPXzikttfM24=;
	b=MSA55m4Wg3OpK6wFdwo+hvhC9Gc7apVj6p0bpJ9zgF3IyHjVqCukj+DW6QORI9s91u5ldy
	RwvudBqx3Mg0WAh4+2/T4bJD01p08Obi7fFU5q8M2KqL/53wHlV9UBP717VY8wrxDrc8Hi
	MkUn+MfxMXCsnWkiOmq41E1MudnJcGs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D891393C;
	Wed, 24 Apr 2024 10:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kAjcN2baKGaDRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Apr 2024 10:09:42 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc6
Date: Wed, 24 Apr 2024 12:01:52 +0200
Message-ID: <cover.1713884233.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EB1B36136F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

Hi,

please pull a few more fixes, thanks.

- fix information leak by the buffer returned from LOGICAL_INO ioctl

- fix flipped condition in scrub when tracking sectors in zoned mode

- fix calculation when dropping extent range

- reinstate fallback to write uncompressed data in case of fragmented
  space that could not store the entire compressed chunk

- minor fix to message formatting style to make it conforming to the
  commonly used style

----------------------------------------------------------------
The following changes since commit 1db7959aacd905e6487d0478ac01d89f86eb1e51:

  btrfs: do not wait for short bulk allocation (2024-04-09 23:20:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc5-tag

for you to fetch changes up to fe1c6c7acce10baf9521d6dccc17268d91ee2305:

  btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range() (2024-04-18 18:18:50 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: remove colon from messages with state

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Naohiro Aota (1):
      btrfs: scrub: run relocation repair when/only needed

Qu Wenruo (1):
      btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()

Sweet Tea Dorminy (1):
      btrfs: fallback if compressed IO fails for ENOSPC

 fs/btrfs/backref.c                | 12 +++---------
 fs/btrfs/extent_map.c             |  2 +-
 fs/btrfs/inode.c                  | 13 ++++++-------
 fs/btrfs/messages.c               |  2 +-
 fs/btrfs/scrub.c                  | 18 +++++++++---------
 fs/btrfs/tests/extent-map-tests.c |  5 +++++
 6 files changed, 25 insertions(+), 27 deletions(-)

