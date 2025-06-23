Return-Path: <linux-btrfs+bounces-14868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1ACAE40DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EEF164176
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86724BBE4;
	Mon, 23 Jun 2025 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bwJc4M6g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rfNsAojL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316A24A049
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682597; cv=none; b=uHH5NyFt6Qqj8MLAuwVb+deK4U2k4LKzGs510YYfWJMYy8kgjT0iB3PQYJjHcQ/GhFgdghaOmvy3fLgAK0sbLUw969A7ujieDItlwRulKW6/sJMpTFpjCI7H6cLi/LoMSDlsot9cmqpvZOQhxyQbhg0+bbEB2NbdCLQH+19vlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682597; c=relaxed/simple;
	bh=+GteQ0qr9x/fH1uMF3hS26ryy7lACYLVIJY3mFLhJzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKGTfcd68e+BTCRMyEMbO2Syn9pTVYn+AWiVU0z4nOlP0ZejPkN3CjacWSjWYVI5Zpc/GnqWkVdzFjlJMII8/nJ8/rOqXPckRQVHR1wxoC+ITfoWRLBzKFQmguI1wfLzeyXATJdDf5p6c9fAoH0xIYaNCz2GD+P5Gpniu0hbc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bwJc4M6g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rfNsAojL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF2EE210ED;
	Mon, 23 Jun 2025 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750682593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ROIVaHrIif6tZQUptIPgfJDr1WQJtteF6eb5riTi0A=;
	b=bwJc4M6g1Vp+KN/sS9s95Fz74ZM1cBAR2I/fcikCCQhtHru9VyXrIKAbxUMoaNndg9qT2+
	cb3jUH+Zx8EIbayVtv5AHpEhxTNzOYtpc42s5f+u7+eIuU3QbUmrOYxwmn9nItjd0pnJLJ
	os7n3gOPH+vawb2NtLA+eTZwYhKscTY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750682592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8ROIVaHrIif6tZQUptIPgfJDr1WQJtteF6eb5riTi0A=;
	b=rfNsAojLyMBWr59+zTH/ILxfPko2+18UXKF+LKddQwtKUhsicgEDYPuwDeqA9wl1gNV+Pu
	yFvC1PLiAb/PwQcvnhrEA0iXU4DCgU+bQPVnyzkeo0vmBsWcVTN0qXkqdselAD5j7KEQdL
	WyZyQCuKFgiFc9zTi0uByh04USFpzcU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4AE513485;
	Mon, 23 Jun 2025 12:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hC+ZM+BLWWjkRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 23 Jun 2025 12:43:12 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.16-rc4
Date: Mon, 23 Jun 2025 14:43:03 +0200
Message-ID: <cover.1750680667.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

please pull the following updates for btrfs. There are mostly short
fixes that have accumulated since rc1. Thanks.

Fixes:

  - fix invalid inode pointer dereferences during log replay

  - fix a race between renames and directory logging

  - fix shutting down delayed iput worker

  - fix device byte accounting when dropping chunk

  - in zoned mode, fix offset calculations for DUP profile when
    conventional and sequential zones are used together

Regression fixes:

  - fix possible double unlock of extent buffer tree (xarray conversion)

  - in zoned mode, fix extent buffer refcount when writing out extents
    (xarray conversion)

Error handling fixes and updates:

  - handle unexpected extent type when replaying log

  - check and warn if there are remaining delayed inodes when putting a
    root

  - fix assertion when building free space tree

  - handle csum tree error with mount option 'rescue=ibadroot'

Other:

  - error message updates: add prefix to all scrub related messages,
    include other information in messages

----------------------------------------------------------------
The following changes since commit eeb133a6341280a1315c12b5b24a42e1fbf35487:

  btrfs: move misplaced comment of btrfs_path::keep_locks (2025-05-17 21:15:08 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.16-rc3-tag

for you to fetch changes up to c0d90a79e8e65b89037508276b2b31f41a1b3783:

  btrfs: zoned: fix alloc_offset calculation for partly conventional block groups (2025-06-19 15:21:15 +0200)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: scrub: add prefix for the error messages

Filipe Manana (7):
      btrfs: include root in error message when unlinking inode
      btrfs: fix a race between renames and directory logging
      btrfs: fix double unlock of buffer_tree xarray when releasing subpage eb
      btrfs: fix invalid inode pointer dereferences during log replay
      btrfs: don't silently ignore unexpected extent type when replaying log
      btrfs: fix assertion when building free space tree
      btrfs: fix race between async reclaim worker and close_ctree()

Johannes Thumshirn (1):
      btrfs: zoned: fix alloc_offset calculation for partly conventional block groups

Josef Bacik (1):
      btrfs: don't drop a reference if btrfs_check_write_meta_pointer() fails

Leo Martins (2):
      btrfs: fix delayed ref refcount leak in debug assertion
      btrfs: warn if leaking delayed_nodes in btrfs_put_root()

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Qu Wenruo (1):
      btrfs: handle csum tree error with rescue=ibadroots correctly

 fs/btrfs/delayed-inode.c   |  5 ++-
 fs/btrfs/disk-io.c         | 27 ++++++++++----
 fs/btrfs/extent_io.c       |  3 +-
 fs/btrfs/free-space-tree.c | 16 ++++++---
 fs/btrfs/inode.c           | 89 +++++++++++++++++++++++++++++++++++-----------
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/scrub.c           | 53 ++++++++++++++-------------
 fs/btrfs/tree-log.c        | 17 ++++-----
 fs/btrfs/volumes.c         |  6 ++++
 fs/btrfs/zoned.c           | 86 ++++++++++++++++++++++++++++++++++++--------
 10 files changed, 220 insertions(+), 84 deletions(-)

