Return-Path: <linux-btrfs+bounces-12955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1733AA85722
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321479A5609
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6D29616D;
	Fri, 11 Apr 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R4mIVMDL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZRvI6o3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94415D5B6
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361962; cv=none; b=a+kio7tz9XYkOKf9i6i/i161H7UOgvOxC89Qo7nVF82fFYu5DXDUsno4PpSrlRjeoQr8XrpN8Wa1/llipwYIxPmh1K/A44AtrMLPazEv3vqdFXGJwltTkoxf0y6D/bVXwbXv6qPGlYqeju3VTm/I7VDmqw8jEQ0sSsaEyuxuJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361962; c=relaxed/simple;
	bh=j6tH6v/azgcznUoqBsxHkbbnS5gYMwhYNV1QnSy5G3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t8KkRlVJheodsfd6RqiznglE/tp+xw71zHaD4kkujJuY6YEshYsrncFN/cR0k+g8ATdIM8yBh1uGjMC62bRz+ontzNNIKhdiSkdHvSxnAvbuJzTXs1kdBjO7++aFx3aAYOJPWWkl7wA1jfg27tUaG2d3EOfCEJSFOtzRELQJ47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R4mIVMDL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZRvI6o3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EFFF21186
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744361958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjYZ1axYZlwqheO5IvQcC7nJYpcllY48flFPaoMNGlg=;
	b=R4mIVMDLVwoO9ARec/uMoKlciQcLBkUUYghGYWt0tMduyy1KVJSMqtlBQGikM3MOhHdUw8
	0Qi2jf0o5yzK3vliT+BVRxon+2MEeaqSSZ8cDwz3Qx/xFZCG4aJRo8P7/1N0t0i17GPTw6
	R/mupZpt5YFNPPsMrdfbqQyWPp2poIA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744361957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjYZ1axYZlwqheO5IvQcC7nJYpcllY48flFPaoMNGlg=;
	b=WZRvI6o3VoOAV2m8t23KarLUkXv6UD7U8x/Do4DSw9M8HF1aZsuZLpl19dSlzMRq4EpyqW
	1b5KteZxSwifh+yJ6A8js3msRSGgnI1GZL74qotDierI8WKTZKQHj+xJuvZkXWGKAtaJZi
	2+twH2W2bUFsZDgL86X5olN64DcmIF0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E9D13886
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Kx7DuTZ+GfJHQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 08:59:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix corner cases for subpage generic/363 failures
Date: Fri, 11 Apr 2025 18:28:52 +0930
Message-ID: <cover.1744361863.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

[CHANGELOG]
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
 fs/btrfs/file.c        |  37 +++++++----
 fs/btrfs/inode.c       | 148 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 157 insertions(+), 38 deletions(-)

-- 
2.49.0


