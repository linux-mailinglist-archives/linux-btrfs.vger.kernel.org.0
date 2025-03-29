Return-Path: <linux-btrfs+bounces-12670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0405A75569
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5B1705B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBB1A9B5D;
	Sat, 29 Mar 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pWGi09NH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TnugHkPi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04A17B402
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240007; cv=none; b=ScyBXmEJZav/e9UTebNj6OuHvq21udnBVqoSPnoiBCinRwV95m2Jt2RuNAoTvp0evwjxzRhNeK+7Abq4wFvZlkGEhKVVMUSWSaKKXAyqzqjG6akEMeoZbcSms7HipJNgT/qTKQw89s4LaDSWJG6udcgYqDIomF3pPqw/XWUMjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240007; c=relaxed/simple;
	bh=3/TrSgc34BX0cBF2iMG6lH1UK+icqp4nYmpxulBoyno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E5qsS1TOmG0h4+RpMDl8wkwKjMoJ8EgwIs4k0aH/sBTnBDZH50cP12S3kNdGXjxt7/CFSmkEFdwvGpepEj/dEJ/9VzrPXz9udM62BqmXJyivShSGWYJRQdusFH+fg4d63nQLiMVl0nEcUxARfxjU9ge5cA+/EjPr1VNASnhUAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pWGi09NH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TnugHkPi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7DBA211EF
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=76HbAmXFVzGSQ4BuPtIOkav8r8LepjLDI5IRAZ6ucJA=;
	b=pWGi09NHtk+B8Y8TEfZxS6O8r+VwwUbYq2p6sIQNZ8DoJiCsfVzNAhzyUMCHYXXZ8bbk5i
	RDt+iGjkLzjHgmUK4qkzYNbWLNF73WyjWDDCnmBtUopcO6uf6h5UoPqxj9b33zPKEx21l0
	LWL3sWTG2R67G1xQ5jebxCRQPxwhXok=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=76HbAmXFVzGSQ4BuPtIOkav8r8LepjLDI5IRAZ6ucJA=;
	b=TnugHkPimNsxVhP0GlNiZsb8vaAwMic+duJdnFGFCslMxPx4IVZLL4cJ3y+arTZUOdakGF
	kMnx2QqukeFRF9CAAdSeH3s7Krym7Mck5wXPbo+x+KAJWTH9jl+gUB3bUBKCC8Rr9C6Q8h
	2y+ImMR1FmfnEaSBZP+5DCa6zGsUFxU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2874113A41
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vZVGNkG752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: add the missing preparations exposed by initial large data folio support
Date: Sat, 29 Mar 2025 19:49:35 +1030
Message-ID: <cover.1743239672.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
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
- Rebased to the latest misc-next
  As there are some conflicts regarding to:
  * parameter list indent
  * iov_iter parameter name

- Fix a busy loop caused by underflowing check_range_has_page() parameters
  This is only happening for fs block size < page size cases, e.g.
  the fs block size is 4K, page size is 64K.
  And the lockend is (4K - 1).

  The lockend in btrfs_punch_hole_lock_range() will be (u64)-1, as
  round_down(lockend + 1, PAGE_SIZE) leads to 0, resulting
  btrfs_punch_hole_lock_range() to do a busy loop waiting for all folios
  to be purged.


With all the existing preparations, finally I can enable and start
initial testing (aka, short fsstress loops).

To no one's surprise, it immeidately exposed several problems:

- A critical subpage helper is still using offset_in_page()
  Which causes incorrect start bit calculation and triggered the
  ASSERT() inside subpage locking.

  Fixed in the first patch.

- Fix a dead busy loop in btrfs_punch_hole_lock_range()
  This is only happening when fs block size < page size.

  @page_lockend can underflow, causing it to be -1, and
  btrfs_punch_hole_lock_range() will busy loop waiting for all the
  pages of an inode to be dropped, meanwhile
  truncate_pagecache_range() is only called for the range inside the
  first page (aka, doing nothing).

  Fixed in the second patch.

- Buffered write can not shrink reserved space properly
  Since we're reserving data and metadata space before grabbing the
  folio, we have to reserved as much space as possible, other than just
  reserving space for the range inside the page.

  If the folio we got is smaller than what we expect, we have to shrink
  the reserved space, but things like btrfs_delalloc_release_extents()
  can not handle it.

  Fixed in the third patch, with a new helper
  btrfs_delalloc_shrink_extents().

  This will also be a topic in in the iomap migration, iomap goes
  valid_folio() callbacks to make sure no extent map is changed during
  our buffered write, thus they can reserve a large range of space,
  other than our current over-reserve-then-shrink.

  Our behavior is super safe, but less optimized compared to iomap.

- Buffered write is not utilizing large folios
  Since buffered write is the main entrance to allocate large folios,
  without its support there will be no large folios at all.

  Addressed in the forth patch.

- A dead busy loop inside btrfs_punch_hole_lock_range()
  It turns out that the usage of filemap_range_has_page() is never a
  good idea for large folios, as we can easily hit the following case:

          start                            end
          |                                |
    |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
     \         /                         \   /
      Folio A                            Folio B

  Fixed in the last patch, with a helper check_range_has_page() to do
  the check with large folios in mind.

  This will also be a topic in the iomap migration, as our zero range
  behavior is quite different from the iomap one, and the
  filemap_range_has_page() behavior looks a little overkilled to me.

I'm pretty sure there will be more hidden bugs after I throw the whole
fstests to my local branch, but that's all the bugs I have so far.

Qu Wenruo (5):
  btrfs: subpage: fix a bug that blocks large folios
  btrfs: avoid page_lockend underflow in btrfs_punch_hole_lock_range()
  btrfs: refactor how we handle reserved space inside copy_one_range()
  btrfs: prepare btrfs_buffered_write() for large data folios
  btrfs: prepare btrfs_punch_hole_lock_range() for large data folios

 fs/btrfs/delalloc-space.c |  24 +++++
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/file.c           | 203 ++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.c        |   2 +-
 4 files changed, 177 insertions(+), 55 deletions(-)

-- 
2.49.0


