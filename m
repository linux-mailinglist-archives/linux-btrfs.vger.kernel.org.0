Return-Path: <linux-btrfs+bounces-8798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112C998B22
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9FEB381D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86141CF281;
	Thu, 10 Oct 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YvKiIlsB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YvKiIlsB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174631CEAB3;
	Thu, 10 Oct 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572525; cv=none; b=ICJ/bXMyFEbJvVY2OELczaS1GhzrIYdNZV0TSBva13T7ZlBawb8FJxxdQXcq6izaVWSwcTQ3tfIqYgMIEk7EA3AN+Wq8ufAYXs5YEPPC7IzxXM+s5rhO/HolHnyEDtTCY2NiaX0NyWyFVg5sQInZ5E7MGGklaiPcSD5zFiNAEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572525; c=relaxed/simple;
	bh=R3lTl2iaXolcH9id3gL2csQ4+YyBwcG0jNSPApUumv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jkn+fHP1EbzZjCTttXU1r3WmGRiIop/9jxg80ot+EyZQPSZrryfKp9AUKIFEUVKHi53RvIfMnhkJvjvqrE6YJA/CpEsSBj6fbXmMSM6ElLfHhDoLZ09/KSOLFG6nmbzXxpJ/+fjhW9PBISKZoNM3n4nMsrnyT1/jm0FUg56PPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YvKiIlsB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YvKiIlsB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 132791F7FA;
	Thu, 10 Oct 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728572522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZM7HeuFpavIdZER+cohvEsb87S5cGATsj8ndPgJnlmM=;
	b=YvKiIlsBIcVA7Sjm9i7EthnJf+QGIcZBKQ/0cT5eJX5NepvR3d4/sC9e0TvaLhF8S6vyuA
	s/9N40k6tp+L8dq6BIAG3by44xct3Cc5YYQbv6J693QU4EkKGhOxGmmqUG7WpC25xhQQeU
	pzSiBNFzLeK2Qfd+hwqV97CgzZj2CGg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YvKiIlsB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728572522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZM7HeuFpavIdZER+cohvEsb87S5cGATsj8ndPgJnlmM=;
	b=YvKiIlsBIcVA7Sjm9i7EthnJf+QGIcZBKQ/0cT5eJX5NepvR3d4/sC9e0TvaLhF8S6vyuA
	s/9N40k6tp+L8dq6BIAG3by44xct3Cc5YYQbv6J693QU4EkKGhOxGmmqUG7WpC25xhQQeU
	pzSiBNFzLeK2Qfd+hwqV97CgzZj2CGg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 087E713A6E;
	Thu, 10 Oct 2024 15:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +rPRAWrsB2c+cwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 10 Oct 2024 15:02:02 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc3
Date: Thu, 10 Oct 2024 17:01:57 +0200
Message-ID: <cover.1728571063.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 132791F7FA
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few more fixes, thanks.

- update fstrim loop and add more cancellation points, fix reported
  delayed or blocked suspend if there's a huge chunk queued

- fix error handling in recent qgroup xarray conversion

- in zoned mode, fix warning printing device path without RCU protection

- again fix invalid extent xarray state (6252690f7e1b), lost due to
  refactoring

----------------------------------------------------------------
The following changes since commit d6e7ac65d4c106149d08a0ffba39fc516ae3d21b:

  btrfs: disable rate limiting when debug enabled (2024-10-01 19:29:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc2-tag

for you to fetch changes up to e761be2a0744086fc4793a4870d4b5746b7fe8cd:

  btrfs: fix clear_dirty and writeback ordering in submit_one_sector() (2024-10-09 13:23:51 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix missing error handling when adding delayed ref with qgroups enabled
      btrfs: zoned: fix missing RCU locking in error message when loading zone info

Luca Stefani (2):
      btrfs: split remaining space to discard in chunks
      btrfs: add cancellation points to trim loops

Naohiro Aota (1):
      btrfs: fix clear_dirty and writeback ordering in submit_one_sector()

 fs/btrfs/delayed-ref.c      | 42 +++++++++++++++++++++++++++++++++---------
 fs/btrfs/extent-tree.c      | 26 +++++++++++++++++++++-----
 fs/btrfs/extent_io.c        | 14 +++++++-------
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/free-space-cache.h |  6 ++++++
 fs/btrfs/volumes.h          |  6 ++++++
 fs/btrfs/zoned.c            |  2 +-
 7 files changed, 76 insertions(+), 24 deletions(-)

