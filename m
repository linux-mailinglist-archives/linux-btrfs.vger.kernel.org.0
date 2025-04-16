Return-Path: <linux-btrfs+bounces-13058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDFA8B46D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EAF17D6DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B681231A42;
	Wed, 16 Apr 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZsAZ8QmD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZsAZ8QmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70A5227
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793672; cv=none; b=Qfg0/leX3dUytTTEKDGZ2+TiPMfmYzshjlKjMFJ78KYOdPSXIc+3Z0pNl7WY0LIWkZBeMa4RfLXl5GlmzpJ32ww+qy72wKIPjeR2yN7KluWCay6S9yk9eIWyD4UqzIuSBM5lQebnVvO8wcic75xQXG183LI25m6b8JjJ4Vkugic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793672; c=relaxed/simple;
	bh=D7XnOs4saGbq1kPtmcGSIQbJgEeOEINZbqlISOiic6s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MigcNL7Ddey9hT738xdMjwSoGE59svuKzp6+F16H8mybddcCkNpoVLJme74vHAqMrTPJ9gil+YK7NA41exGtkhtzZv78sKQzubTMjbwfnTLYGdBXV/Ep2YmkgzTuHEeH3D2BuE2FKRMnp8hu9TlcuibQj9EgSt5gqGoAn3UpTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZsAZ8QmD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZsAZ8QmD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6AB71F7B3
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744793668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8z73XpTO3UwrMmi8SNCow6oeTQEmknvEaET8eOZ3GUU=;
	b=ZsAZ8QmDw+HRYzw9NjWghKS+PY/WL0pXwneLrggBHpj9JXWAW0pVeVcAZTJqKIV42NcvvB
	QeEzw/e0DMWDCQbqOKB+rw51pBbWOtX61Jo1OsAm5rrP1qovqqqURj2kJJu9RZI8I/cKpe
	e3iSni6xClhoWMlUX8UetdImM8sEqtk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744793668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8z73XpTO3UwrMmi8SNCow6oeTQEmknvEaET8eOZ3GUU=;
	b=ZsAZ8QmDw+HRYzw9NjWghKS+PY/WL0pXwneLrggBHpj9JXWAW0pVeVcAZTJqKIV42NcvvB
	QeEzw/e0DMWDCQbqOKB+rw51pBbWOtX61Jo1OsAm5rrP1qovqqqURj2kJJu9RZI8I/cKpe
	e3iSni6xClhoWMlUX8UetdImM8sEqtk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD31813976
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +TecIkNw/2fOZwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 08:54:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fix corner cases for subpage generic/363 failures
Date: Wed, 16 Apr 2025 18:24:07 +0930
Message-ID: <cover.1744793549.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v3:
- Fix a typo where @block_size should @blocksize.
  There is a global function, block_size(), thus this typo will cause
  type conflicts inside round_down()/round_up().

v2:
- Fix a conversion bug in the first patch that leads to generic/008
  failure on x86_64
  The range is passed incorrectly and caused btrfs_truncate_block() to
  incorrectly skip an unaligned range.

Test case generic/363 always fail on subpage (fs block fs < page size)
btrfses, there are mostly two kinds of problems here:

All examples are based on 64K page size and 4K fs block size.

1) EOF is polluted and btrfs_truncate_block() only zeros the block that
   needs to be written back

   
   0                           32K                           64K
   |                           |              |GGGGGGGGGGGGGG|
                                              50K EOF
   The original file is 50K sized (not 4K aligned), and fsx polluted the
   range beyond EOF through memory mapped write.
   And since memory mapped write is page based, and our page size is
   larger than block size, the page range [0, 64K) covere blocks beyond
   EOF.

   Those polluted range will not be written back, but will still affect
   our page cache.

   Then some operation happens to expand the inode to size 64K.

   In that case btrfs_truncate_block() is called to trim the block
   [48K, 52K), and that block will be marked dirty for written back.

   But the range [52K, 64K) is untouched at all, left the garbage
   hanging there, triggering `fsx -e 1` failure.

   Fix this case by force btrfs_truncate_block() to zeroing any involved
   blocks. (Meanwhile still only one block [48K, 52K) will be written
   back)

2) EOF is polluted and the original size is block aligned so
   btrfs_truncate_block() does nothing

   0                           32K                           64K
   |                           |                |GGGGGGGGGGGG|
                                                52K EOF

   Mostly the same as case 1, but this time since the inode size is
   block aligned, btrfs_truncate_block() will do nothing.

   Leaving the garbage range [52K, 64K) untouched and fail `fsx -e 1`
   runs.

   Fix this case by force btrfs_truncate_block() to zeroing any involved
   blocks when the btrfs is subpage and the range is aligned.
   This will not cause any new dirty blocks, but purely zeroing out EOF
   to pass `fsx -e 1` runs.



Qu Wenruo (2):
  btrfs: make btrfs_truncate_block() to zero involved blocks in a folio
  btrfs: make btrfs_truncate_block() zero folio range for certain
    subpage corner cases

 fs/btrfs/btrfs_inode.h |  10 ++-
 fs/btrfs/file.c        |  37 ++++++----
 fs/btrfs/inode.c       | 153 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 162 insertions(+), 38 deletions(-)

-- 
2.49.0


