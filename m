Return-Path: <linux-btrfs+bounces-12951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DCA852F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 07:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE868468127
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403CF27CCCB;
	Fri, 11 Apr 2025 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LMcUdrmj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B6sNraqo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C427C87D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348464; cv=none; b=fXpZEq/SFwJEYY3FGdF8VojH3ct+0chsRepX2wzDhKd5o/LeYOxiD0Ge9SIxxvykrxTkAkZKCGfP9CxxlG16GyqGDVc9Wcf+DQosf3lnf6Tr/zFBW/3mnGrHzDIrNfTEtrfJMQzIIn3P/YvSyrcV35dY0nsSJhTaGZCpF88334Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348464; c=relaxed/simple;
	bh=yyOpe3GL5+4y+DDzb7Po2bizI2aVmncJNlRHwbIktmQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t5e3zBHkvylwMMgFCW40QU5ZsmktdHCtAdBpw6quHgCtYKOE50plWJcHDcz2gcQLTQYVTsCUwmjGU8purxynRuPegnk/WwYjTihsz//CPG97E7mNnLyKKg3vZOrJGv9wnmahaRAEMw0CKJtxFYxAUs7Zh9PDqgGFd/YtXx4AtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LMcUdrmj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B6sNraqo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8A3321163
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 05:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744348460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TPzWm51uzCtay4TA0bkGDXkwQKb8akW6QdnNXRNW7FE=;
	b=LMcUdrmjLvZRdWzBIjO3/xnK4EO6twIHkszVmB1SdZpo4qO95Q2VjkE+By35rEUbnWlnWy
	vm+l9LcUl4G+SrpwYW6BQf3vOhhpskmkysM1d5cDuYEaKP1daEiepS36BdgfBsJ/Qp08Tr
	1VYxrfIMV9PNgmpwiWqIJVqh7ISeru0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=B6sNraqo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744348459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TPzWm51uzCtay4TA0bkGDXkwQKb8akW6QdnNXRNW7FE=;
	b=B6sNraqoCceEFra1p73RDyN2B3100aby4GodI+5twnTWeQS4wA66gFfhrPneaM1wAbP8wT
	9/N7dSrHi5IFHXEhQdZiESKBswFJTscLBuwWHRtvjKFh8VCQzeS6pHQoKQgWacNQThXUR0
	QhrAHZtHSrAvTnbBRwuGBFGdKqwCvEI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D90C13886
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 05:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3OOINyql+Gf9XgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 05:14:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix corner cases for subpage generic/363 failures
Date: Fri, 11 Apr 2025 14:43:59 +0930
Message-ID: <cover.1744344865.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8A3321163
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
 fs/btrfs/file.c        |  33 ++++++---
 fs/btrfs/inode.c       | 148 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 155 insertions(+), 36 deletions(-)

-- 
2.49.0


