Return-Path: <linux-btrfs+bounces-16072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D4B25AD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C3268317D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93122154F;
	Thu, 14 Aug 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rYyntiOZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rYyntiOZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B083214209
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149629; cv=none; b=unZSra/PdRLySNzOE5Q+TxOH6cEMuDmA5rEH7XIg4YwiejxMC00CgjTbXdRPomCo3s9tNRT1N8MJeETh0Fr2l9PEAVnQ20Z+cCnquXmb0E1s1Gucv8K0s34NukxktjyQhGcHBZ2Emjfu0NEvJ7Uoa9XjLa3p18AeWZIliCcVK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149629; c=relaxed/simple;
	bh=zmBd0alV103c4F1YIVrvHrIyCNtH2SW5x7rykDo6vGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MBC9avuQN6UCIPTCt55WyLtzNC//iidGB62Y6/n5t3wjRkxzIYIn9+rzINPD6GvlVODeaQqWSTu4XSWPeQLAR2sewy37+o30ierXDBA1wVCGwjWzYSowVlPoc5Rmg7SmDpK1d22GXgSpVYNb+Ab10Msfm/O3LPYWCcR+TnJ/vKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rYyntiOZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rYyntiOZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4416421ADD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QqlEAB4Nz3Bxf8rDqe7S0HuSJbyBW2+j/O4rnQYWCaU=;
	b=rYyntiOZne0tMcPs7q+KqxGNkOr7y4glu9QDGjOBprfofFyqzC/lkMAbhqa/9MAAh9SZmw
	blZ4u0ubceK7ZddFB+NJorjZYePJQh9884XiJCHyY37+B8AoRWuhALNCopu11r6c2tdPhU
	pGgbH5cxNBkbmKM5IGyWs4gUA2ySjQg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QqlEAB4Nz3Bxf8rDqe7S0HuSJbyBW2+j/O4rnQYWCaU=;
	b=rYyntiOZne0tMcPs7q+KqxGNkOr7y4glu9QDGjOBprfofFyqzC/lkMAbhqa/9MAAh9SZmw
	blZ4u0ubceK7ZddFB+NJorjZYePJQh9884XiJCHyY37+B8AoRWuhALNCopu11r6c2tdPhU
	pGgbH5cxNBkbmKM5IGyWs4gUA2ySjQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61B3813479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAWUBjh1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: per-fs compression workspace manager
Date: Thu, 14 Aug 2025 15:03:19 +0930
Message-ID: <cover.1755148754.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Currently btrfs utilizes the following components at a per-module basis:

- Folios pool
  A per-module pool for compressed data.
  All folios in the pool are page sized.

- Workspace
  A workspace is a compression algorithm specific structure, providing
  things like extra memory buffer and compression level handling.

- Workspace manager
  The workspace manager is managing the above workspaces for each
  algorithm.

All the folio pool/workspaces are using the fixed PAGE_SIZE buffer size,
this is fine for now as even for block size (bs) < page size (ps) cases,
a larger buffer size won't cause huge problems except wasting memories.

However if we're going to support bs > ps, this fixed PAGE_SIZE buffer
and per-module shared folios pool/workspaces will not work at all.

To address this problem, this series will move the workspace and
workspace manager into a per-fs basis, so that different fses (with
different block size) can have their own workspaces.

This brings a small memory usage reduce for bs < ps cases.
Now zlib/lzo/zstd will only allocate buffer using block size.

This is especially useful for lzo compression algorithm, as lzo is an
one-short compression algorithm, it doesn't support multi-shot (aka,
swapping input/output buffer halfway) compress/decompress.

Thus btrfs goes per-block compression for LZO, and compressed result
will never go larger than a block (or btrfs will just give up).
In that case, a 64K page sized buffer will waste 7/8th of the buffer.

This is part 1 of the preparation for btrfs bs > ps support.

Qu Wenruo (7):
  btrfs: add an fs_info parameter for compression workspace manager
  btrfs: add workspace manager initialization for zstd
  btrfs: add generic workspace manager initialization
  btrfs: migrate to use per-fs workspace manager
  btrfs: cleanup the per-module workspace managers
  btrfs: rename btrfs_compress_op to btrfs_compress_levels
  btrfs: reduce workspace buffer space to block size

 fs/btrfs/compression.c | 186 ++++++++++++++++++++++++-----------------
 fs/btrfs/compression.h |  49 +++++------
 fs/btrfs/disk-io.c     |   4 +
 fs/btrfs/fs.h          |  13 +++
 fs/btrfs/lzo.c         |  25 +++---
 fs/btrfs/zlib.c        |  16 ++--
 fs/btrfs/zstd.c        | 143 ++++++++++++++++---------------
 7 files changed, 248 insertions(+), 188 deletions(-)

-- 
2.50.1


