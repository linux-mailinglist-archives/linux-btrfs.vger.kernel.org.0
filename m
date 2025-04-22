Return-Path: <linux-btrfs+bounces-13250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF4A9731B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0871899A51
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7734296140;
	Tue, 22 Apr 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nY/6wlCq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nY/6wlCq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4C296D1B
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340758; cv=none; b=fEuA9oT8RSaHEnPi22Rp7rDvFNJngtncW/xdcnsvcyPC6g6tc5OY8O0acRnhXVDsjN6LYg7e4fh+A4TdiKc6wgJZu2SYIuG+cbqYTasfl4W3jL7UYrZada7b7QeG2/xdOos9JBJhaz7WmwtouduVdy43GZScrBoVkRWSGdoHrD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340758; c=relaxed/simple;
	bh=T36wXcZ7zCSmvsshp1K/S1XsS6E9Wrxp5490tr4Tru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNRanfHEz8SZD5Qekxjo9DQvz611zmJojHXzKH+/5svTzvXC0PpOvn3R+6C68X2FoPK8NbigFjyYW1egLTkq4NOMmw5cbuP5xUp/LWQ/MFEY6dOvy/0tMnLrMRz3OKCmvTxTAUAG+U6herhPlSSH28xiev9Pva+dNJxT8tsOX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nY/6wlCq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nY/6wlCq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D633211A1;
	Tue, 22 Apr 2025 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745340754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UcgHSw5qsTgMRgKyDw44V36OYO//MyDXvRLVjZf6X2s=;
	b=nY/6wlCq9i4ZTv7/Lc9mKsL/KkFv28HkTo0vJCV6FdJPvnEr4GApqTrqoAjei81ZP/AVM6
	nhGSl0C+vTWNH0EXPYtvcDyTWd5DmZn3k+pyLP783M/nQ0aqtvHQWiCZUtkJk7rcVfNPwh
	55XX0WmSm8mRsdhctQ2Kz43hCI69ddc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745340754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UcgHSw5qsTgMRgKyDw44V36OYO//MyDXvRLVjZf6X2s=;
	b=nY/6wlCq9i4ZTv7/Lc9mKsL/KkFv28HkTo0vJCV6FdJPvnEr4GApqTrqoAjei81ZP/AVM6
	nhGSl0C+vTWNH0EXPYtvcDyTWd5DmZn3k+pyLP783M/nQ0aqtvHQWiCZUtkJk7rcVfNPwh
	55XX0WmSm8mRsdhctQ2Kz43hCI69ddc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D752137CF;
	Tue, 22 Apr 2025 16:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zUr7CVLJB2iteAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 22 Apr 2025 16:52:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.15-rc4
Date: Tue, 22 Apr 2025 18:52:27 +0200
Message-ID: <cover.1745339483.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi,

please pull the following short fixes. Most of them are one-liners,
there's one preparatory patch in block layer moving some code around
and adding a helper that's used in a fix. Thanks.

- subpage mode fixes
  - access correct object (folio) when looking up bit offset
  - fix assertion condition for number of blocks per folio
  - fix upper boundary of locking range in hole punch

- zoned fixes
  - fix potential deadlock caught by lockdep when zone reporting and
    device freeze run in parallel
  - fix zone write pointer mismatch and NULL pointer dereference when
    metadata are converted from DUP to RAID1

- fix error handling when reloc inode creation fails

- in tree-checker, unify error code for header level check

- block layer: add helpers to read zone capacity

----------------------------------------------------------------
The following changes since commit 65f2a3b2323edde7c5de3a44e67fec00873b4217:

  btrfs: remove folio order ASSERT()s in super block writeback path (2025-04-01 01:02:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.15-rc3-tag

for you to fetch changes up to 866bafae59ecffcf1840d846cd79740be29f21d6:

  btrfs: zoned: skip reporting zone for new block group (2025-04-17 11:57:25 +0200)

----------------------------------------------------------------
David Sterba (1):
      btrfs: tree-checker: adjust error code for header level check

Filipe Manana (1):
      btrfs: fix invalid inode pointer after failure to create reloc inode

Johannes Thumshirn (1):
      btrfs: zoned: return EIO on RAID1 block group write pointer mismatch

Naohiro Aota (2):
      block: introduce zone capacity helper
      btrfs: zoned: skip reporting zone for new block group

Qu Wenruo (3):
      btrfs: subpage: access correct object when reading bitmap start in subpage_calc_start_bit()
      btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
      btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()

 fs/btrfs/file.c         |  9 +++++--
 fs/btrfs/relocation.c   |  2 +-
 fs/btrfs/subpage.c      |  4 +--
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/zoned.c        | 19 +++++++++++---
 include/linux/blkdev.h  | 67 +++++++++++++++++++++++++++++++++----------------
 6 files changed, 72 insertions(+), 31 deletions(-)

