Return-Path: <linux-btrfs+bounces-18092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F0BF4EC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959B018C02B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF927AC48;
	Tue, 21 Oct 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P43l86X9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="joAIT0n5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A71369B4
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031310; cv=none; b=j/8yZff73uxKnBNcA96qsH8Ado2/UjX3dCRLlMXlZruQqLQxStzj/D4Hq0hoKHI6FdWLrDB6e2BSkpiT4oREjmswRQ8UwD13oNzn+hnpIi4B29ZO8B9HX4Ex7Q1O+kKbvsNmX/3nXWbXGGcfmN2HeCDeqYQwB9wXHoFcQqtiJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031310; c=relaxed/simple;
	bh=mNaj3cyMAkiM2WMKYhhuJ0aWJrvygiRwjzyNXfB9e2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fYrJM3Ex+7aL6EruhtiR0I3itXu21istVynm6S7ZOS4rjx+X31NBv6Bj7w0SHgy74uoavOkfZ0LmJe1gHOE17XGrzD6wfUM+f49oYGcsa1YuI8rB3xfL7Z8xyFO/6T/2RVqFTy4bti9+iXAkxmVTl0uHR7VNV+iO0qh6wo2irlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P43l86X9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=joAIT0n5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4258D1F449
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rYINT8CXJVlJPSi5lkiuH0uzbUXkrEDfdAWPIJnTrn0=;
	b=P43l86X9jbdnJPzvfuQ1386HNn+5LFfhY7x1w2LHyplsai/15NezKMgZ+qfoTz0nbxaFw0
	pTrdK4ax4BMaj4PRTK8Xz+VKdrdrAL/rukac5tNUAv6iTvBfkaDJocDjAlm1cuAHkNK7yD
	pgn+GOtDIviRQV0R/OLoWrYD2ZHRMDM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=joAIT0n5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761031298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rYINT8CXJVlJPSi5lkiuH0uzbUXkrEDfdAWPIJnTrn0=;
	b=joAIT0n5LDRXOq3SlsVFAXQ8qqZCOt2+06UwjEnGfQUnwtO4pJf2x9y0mS1Qj8jS8wRt87
	q9jKMvPxYuvTwGLuQBqAHHeP59WdBL9XtuS4RACbA7izTKVnzBrCHdUwzTlJtztNeaqEJc
	gRs4533T2oA2yO7t9fsP3aus3HUaHOE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82A6B139D2
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z/GwEYE092hpSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 07:21:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: do not trust direct IO page at all
Date: Tue, 21 Oct 2025 17:51:13 +1030
Message-ID: <cover.1761030762.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4258D1F449
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

[CHANGELOG]
RFC->v1
- Fix a BUG() triggered btrfs/261
  Where the dio bio can be backed by large folios, thus the whole bio
  can be larger than PAGE_SIZE * BIO_MAX_VECS (4K * 256 for x86_64).
  In that case we are not ensured to allocate a bio to cover the whole
  range.
  Add infrastructure to trace multiple btrfs bios for the same dio bio.

- Add the patch to force STABLE_WRITE flags for all inodes

There is a kernel bugzilla report mentioning that direct IO (and certain
buffered IO can modify the page cache during writeback since the device
has no STABLE_WRITE flag) can easily lead to RAID1 mirror content
mismatch.

Although that report doesn't mention btrfs, as our commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum") make inodes with data checksum (the default) to fallback to
buffered IO thus avoid modification during writeback.

The report still exposed that, for our nodatasum inodes, they are still
affected by the same direct IO buffer modification bug, and even worse
since the inode has nodatasum, it doesn't even set the STABLE_WRITE flag
thus we're allowed to modify the page cache even if it's still under
writeback.

This series address the problem by:

- Force STABLE_WRITE flags for all btrfs inodes
  So even for nodatasum inodes, they will wait for writeback before
  modifying the page cache. So that at least the content of different
  mirrors should match.

- Use bounce pages for direct IO
  Instead of using the pages from dio bio, always allocate our own pages
  (so no one else can modify) to do the real IO.
  This will ensure even direct IO on nodatasum inodes will result stable
  contents on different mirrors.

Qu Wenruo (2):
  btrfs: force stable writes for all inodes
  btrfs: allocate bounce pages for direct IO

 fs/btrfs/btrfs_inode.h |   5 +-
 fs/btrfs/direct-io.c   | 293 ++++++++++++++++++++++++++++++++---------
 2 files changed, 231 insertions(+), 67 deletions(-)

-- 
2.51.0


