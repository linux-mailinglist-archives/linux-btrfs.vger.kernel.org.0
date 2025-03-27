Return-Path: <linux-btrfs+bounces-12632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FCA740F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 23:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FD17CDF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DAA1EDA33;
	Thu, 27 Mar 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ePTwIMeM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ePTwIMeM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9B1DDA0E
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114692; cv=none; b=AxtrOb9Hyj9GyQS/PTYz1Jbvmw/wLvd4soRg4Ejewfs523wP+7ySxlZNRE9y8+rj0RVz3LpDVl6Kqe1D0P+lPH6nDfwRruUkvgUi56WKO4fGgZnXV9Pzd/R4US8kQ7ZffPc2+8td8ucvD2Ll5loQgU5i2WCeFc9AbRBnEYNgTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114692; c=relaxed/simple;
	bh=mGKYxzM+LJ77WqWdFCWP6GwTYEGrPCGQDoJDPSeu97c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xq4LSRspI/SgwVcAjxXdRp6L8IqUkh6XM7PwgH5wwvObrt4My6mcQlS2vB8jWUsm9pOyF05eNZlg/SLB8cYhy3VPOq3kL3Fx6HDhY9uAnZx/qQFMd6DivqjBrUkvu4Jvm8ysbgjNcOBfFJ/A9u380Eqlk4UtWzdDm8xxZlTJYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ePTwIMeM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ePTwIMeM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46BE01F388
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DcpbsOG+cWxSOJf51A119dphsKy/s1vR+nYhWNlTihY=;
	b=ePTwIMeMKtTzMqPi0RB9rIKMWtcyUns+xU5kpxSxGcLYE8H50TeZ6mUqzD93JPMVPQ0Hfy
	wGdSVBsKka9Wor7UgOW7wRBemILSPHBjWsKxeomv1xq6glLADHQFV96SiC0AQsd6pVBEdC
	FXlgBHEbDZ9KzaDTfvTmWFlTACRf5Fg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DcpbsOG+cWxSOJf51A119dphsKy/s1vR+nYhWNlTihY=;
	b=ePTwIMeMKtTzMqPi0RB9rIKMWtcyUns+xU5kpxSxGcLYE8H50TeZ6mUqzD93JPMVPQ0Hfy
	wGdSVBsKka9Wor7UgOW7wRBemILSPHBjWsKxeomv1xq6glLADHQFV96SiC0AQsd6pVBEdC
	FXlgBHEbDZ9KzaDTfvTmWFlTACRf5Fg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F741139D4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QR16EL/R5WfMagAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: add the missing preparations exposed by initial large data folio support
Date: Fri, 28 Mar 2025 09:01:01 +1030
Message-ID: <cover.1743113694.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

With all the existing preparations, finally I can enable and start
initial testing (aka, short fsstress loops).

To no one's surprise, it immeidately exposed several problems:

- A critical subpage helper is still using offset_in_page()
  Which causes incorrect start bit calculation and triggered the
  ASSERT() inside subpage locking.

  Fixed in the first patch.

- Buffered write can not shrink reserved space properly
  Since we're reserving data and metadata space before grabbing the
  folio, we have to reserved as much space as possible, other than just
  reserving space for the range inside the page.

  If the folio we got is smaller than what we expect, we have to shrink
  the reserved space, but things like btrfs_delalloc_release_extents()
  can not handle it.

  Fixed in the second patch, with a new helper
  btrfs_delalloc_shrink_extents().

  This will also be a topic in in the iomap migration, iomap goes
  valid_folio() callbacks to make sure no extent map is changed during
  our buffered write, thus they can reserve a large range of space,
  other than our current over-reserve-then-shrink.

  Our behavior is super safe, but less optimized compared to iomap.

- Buffered write is not utilizing large folios
  Since buffered write is the main entrance to allocate large folios,
  without its support there will be no large folios at all.

  Addressed in the third patch.

- Long CPU busy loops inside btrfs_punch_hole_lock_range()
  It turns out that the usage of filemap_range_has_page() is never a
  good idea for large folios, as we can easily hit the following case:

          start                            end
          |                                |
    |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
     \         /                         \   /
      Folio A                            Folio B

  Fixed in the fourth patch, with a helper check_range_has_page() to do
  the check with large folios in mind.

  This will also be a topic in the iomap migration, as our zero range
  behavior is quite different from the iomap one, and the
  filemap_range_has_page() behavior looks a little overkilled to me.

I'm pretty sure there will be more hidden bugs after I throw the whole
fstests to my local branch, but that's all the bugs I have so far.

Qu Wenruo (4):
  btrfs: subpage: fix a bug that blocks large folios
  btrfs: refactor how we handle reserved space inside copy_one_range()
  btrfs: prepare btrfs_buffered_write() for large data folios
  btrfs: prepare btrfs_punch_hole_lock_range() for large data folios

 fs/btrfs/delalloc-space.c |  25 ++++++
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/file.c           | 184 ++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.c        |   2 +-
 4 files changed, 165 insertions(+), 49 deletions(-)

-- 
2.49.0


