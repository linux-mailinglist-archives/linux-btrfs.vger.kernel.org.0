Return-Path: <linux-btrfs+bounces-13433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A3A9D5A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 00:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44874C5C53
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12992951D0;
	Fri, 25 Apr 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MX6UfvR6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MX6UfvR6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA01A3145
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620649; cv=none; b=CbJTvP53cTxrYJ3uueJStN/eak5xfF0SWRBy8IuXBCv8jG9CIGiC8CwuLubRIEGtK5ZXFTkMAg47RQBdhqOiVXvgFEPHYrSmv8MDYA56Z3k6F6kFe/UveQTRRX3PnEaXyv2fIjlfaB1ItFafk1WEXMR5HS6zJwLFXAWk7chpyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620649; c=relaxed/simple;
	bh=ujKiF/ffwrHJSM+LFoEP72XgRWKFRn/O38O6MyM3qTI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OuZcemUC29nOkVuKxIKxxBoMt/RDUz7tVrVa1PDRRQYc5t6ew/V9DmACV8sTZjl2+hA2N1s9XwmFUGxmxOiIOOhdId0heulNefXxkF9JbioF15zobFIF10QerfRYeKAOLBEGOUzMzC5/S7TdaM69NoHrnpvwA8l9ZP8W25/42j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MX6UfvR6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MX6UfvR6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D4CB1F399
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745620644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+4ktLtGnBo4z4EyRgUUhp9xdKNmjccT5hp6wrcSD7zs=;
	b=MX6UfvR6I5jUIpbIVxecLXN/l8m7KHh8sh9WkdYkEBGnUu2mr7ZIc7i+gKp57cncDIgbj0
	h5uaj0Rqb1Jqostke6a0ym28THMntttF1nGsj5wviiXePxlCFtB1M8qEyPO8fctZLv5EaF
	eFErETO8cPDJywLIOOX9xpz48HsIsII=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MX6UfvR6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745620644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+4ktLtGnBo4z4EyRgUUhp9xdKNmjccT5hp6wrcSD7zs=;
	b=MX6UfvR6I5jUIpbIVxecLXN/l8m7KHh8sh9WkdYkEBGnUu2mr7ZIc7i+gKp57cncDIgbj0
	h5uaj0Rqb1Jqostke6a0ym28THMntttF1nGsj5wviiXePxlCFtB1M8qEyPO8fctZLv5EaF
	eFErETO8cPDJywLIOOX9xpz48HsIsII=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99EE31398F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kt+hFaMODGgYWQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/2] btrfs: fix beyond EOF truncation for subpage generic/363 failures
Date: Sat, 26 Apr 2025 08:06:48 +0930
Message-ID: <cover.1745619801.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D4CB1F399
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v5:
- Shrink the parameter list for btrfs_truncate_block()
  Remove the @front and @len, instead passing a new pair of @start/@end,
  so that we can determine if @from is in the head or tail block,
  thus no need for @front.

  This will give callers more freedom (a little too much),
  e.g. for the following zero range/hole punch case:

    Page size is 64K, fs block size is 4K.
    Truncation range is [6K, 58K).

    0        8K                32K                  56K      64K
    |      |/|//////////////////////////////////////|/|      |
           6K                                         58K

    To truncate the first block to zero out range [6K, 8K),
    caller can pass @from = 6K, @start = 6K, @end = 58K - 1.
    In fact, any @from inside range [6K, 8K) will work.

    To truncate the last block to zero out range [56K, 58K),
    caller can pass @from=58K - 1, @start = 6K, @end = 58K -1.
    Any @from inside range [56K, 58K) will also work.

    Furthermore, if aligned @from is passed in, e.g. 8K,
    btrfs_truncate_block() will detect that there is nothing to do,
    and exit properly.

- Only do the extra zeroing if we're truncating beyond EOF
  Especially for the recent large folios support, we can do a lot of
  unnecessary zeroing for a very large folio.

- Remove the lock-wait-retry loop if we're doing aligned truncation
  beyond EOF
  Since it's already EOF, there is no need to wait for the OE anyway.

v4:
- Rebased to the latest for-next branch
  btrfs_free_extent_map() renames cause a minor conflict in the first
  patch.

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
  btrfs: handle unaligned EOF truncation correctly for subpage cases
  btrfs: handle aligned EOF truncation correctly for subpage cases

 fs/btrfs/btrfs_inode.h |   3 +-
 fs/btrfs/file.c        |  34 ++++-----
 fs/btrfs/inode.c       | 152 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 147 insertions(+), 42 deletions(-)

-- 
2.49.0


