Return-Path: <linux-btrfs+bounces-18387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44574C184F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A56506A6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C559F2FC892;
	Wed, 29 Oct 2025 05:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X6UrX7RJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X6UrX7RJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C32FBDF3
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716085; cv=none; b=X6Ns/QlQ+DDWA+XjXBXgDxbjRnWW6fKCcJ7Rt1Vop0lY0n67PT0COC3qathAyO078shFxqS4U974VWMobwHn+gbViu53uJXonEtVJKNfG59bkh/+r60eGJHl7dGrAwGw9T0ia0tjolvDiyYQpo9PiPuXZjrIN9HFipbcStz1bGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716085; c=relaxed/simple;
	bh=2WUO5hEQGpnGE+JhE/uu1Me/iTtW7RlrZoP5KEMvP8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i4soqwZrsy69yFqvBiwnH0maGXKffwe3HU+yWCTd3ZBTvIp6Hi5eUTPmiKxLQX9QjZNrGDWMLZ181c7XjHGYkPN1e0QBLljjRd2nsaoNZpwqbN4nID7D79s1ItCZ3oJFXV1NohpRMnZp9oEuCLUiDzaJDTPyiNtOzylITrEfDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X6UrX7RJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X6UrX7RJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 654E021C42
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4NpMYc9CE9XJjvhDlRxuEY0qaWZ9oGiTIc5YO8IuWj0=;
	b=X6UrX7RJGssDOxuQixdsNM7Vse9C1DMutXQUEkXPsfTIDgsHPsxzArnbk1sMP6RjNx8CcN
	/QDrShJjJ9FQKBrZwi87wond0GLKAb7sjpkg5XEPj4GMLZNg4jCr1KZJ2KMqnoF4U8Eqmo
	Y5F2jbYmq5+YRy4DF9xfsHgCHrUNyq4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=X6UrX7RJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4NpMYc9CE9XJjvhDlRxuEY0qaWZ9oGiTIc5YO8IuWj0=;
	b=X6UrX7RJGssDOxuQixdsNM7Vse9C1DMutXQUEkXPsfTIDgsHPsxzArnbk1sMP6RjNx8CcN
	/QDrShJjJ9FQKBrZwi87wond0GLKAb7sjpkg5XEPj4GMLZNg4jCr1KZJ2KMqnoF4U8Eqmo
	Y5F2jbYmq5+YRy4DF9xfsHgCHrUNyq4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9850E13886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uxHNFWunAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs: introduce btrfs_bio::async_csum
Date: Wed, 29 Oct 2025 16:04:10 +1030
Message-ID: <cover.1761715649.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 654E021C42
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Fix a race where csum generation can be completely skipped
  If the lower storage layer advanced the bi_iter before we finished
  calculating the checksum, bio_one_bio() may skip generating csum
  completely.

  Unfortunately to solve this, a new bvec_iter must be introduced and
  cause the size of btrfs_bio to increase.

- Remove btrfs_bio::fs_info by always requireing btrfs_bio::inode
  For scrub, use btree inode instead, and for the only function that
  requires to be called by scrub, btrfs_submit_repair_write(), use
  a new member, btrfs_bio::is_scrub, to check the callers.

- Add a new patch to cleanup the recursive including problems
  The idea is to keep the btrfs headers inside .h files to minimal,
  thus lower risk of recursive including.

- Remove BTRFS_MAX_BIO_SECTORS macro
  It's the same as BIO_MAX_VECS, and only utilized once.

The new async_csum feature will allow btrfs to calculate checksum for
data write bios and submit them in parallel.

This will reduce latency and improve write throughput when data checksum
is utilized.

This will slightly reclaim the performance drop after commit
968f19c5b1b7 ("btrfs: always fallback to buffered write if the inode
requires checksum").

Patch 1 is a minor cleanup to remove a single-used macro.
Patch 2 is a preparation to remove btrfs_bio::fs_info, the core
is to avoid recursive including.
Patch 3 is to remove btrfs_bio::fs_info, as soon we will
increase the size of btrfs_bio by 16 bytes.

Patch 4~6 are preparations to make sure btrfs_bio::end_io() is called in
task context.

Patch 7 enables the async checksum generation for data writes, under
experimental flags.

The series will increase btrfs_bio size by 8 bytes (+16 for the new
structurs, -8 for the removal of btrfs_bio::fs_info).

Since the new async_csum should be better than the csum offload anyway,
we may want to deprecate the csum offload feature completely in the
future.
Thankfully csum offload feature is still behind the experimental flag,
thus it should not affect end users.

Qu Wenruo (7):
  btrfs: replace BTRFS_MAX_BIO_SECTORS with BIO_MAX_VECS
  btrfs: headers cleanup to remove unnecessary local includes
  btrfs: remove btrfs_bio::fs_info by extracting it from
    btrfs_bio::inode
  btrfs: make sure all btrfs_bio::end_io is called in task context
  btrfs: remove btrfs_fs_info::compressed_write_workers
  btrfs: relax btrfs_inode::ordered_tree_lock
  btrfs: introduce btrfs_bio::async_csum

 fs/btrfs/accessors.h    |   1 +
 fs/btrfs/bio.c          | 136 ++++++++++++++++++++++++++--------------
 fs/btrfs/bio.h          |  32 ++++++----
 fs/btrfs/btrfs_inode.h  |   8 +--
 fs/btrfs/compression.c  |  33 +++-------
 fs/btrfs/compression.h  |  13 ++--
 fs/btrfs/ctree.h        |   2 -
 fs/btrfs/defrag.c       |   1 +
 fs/btrfs/dir-item.c     |   1 +
 fs/btrfs/direct-io.c    |   8 +--
 fs/btrfs/disk-io.c      |  10 +--
 fs/btrfs/disk-io.h      |   3 +-
 fs/btrfs/extent-tree.c  |   1 +
 fs/btrfs/extent_io.c    |  27 ++++----
 fs/btrfs/extent_io.h    |   1 -
 fs/btrfs/extent_map.h   |   3 +-
 fs/btrfs/file-item.c    |  64 +++++++++++++------
 fs/btrfs/file-item.h    |   4 +-
 fs/btrfs/fs.h           |   1 -
 fs/btrfs/inode.c        |  12 ++--
 fs/btrfs/ordered-data.c |  57 ++++++++---------
 fs/btrfs/scrub.c        |  49 ++++++++-------
 fs/btrfs/space-info.c   |   1 +
 fs/btrfs/subpage.h      |   1 -
 fs/btrfs/transaction.c  |   2 +
 fs/btrfs/transaction.h  |   4 --
 fs/btrfs/tree-log.c     |   5 +-
 fs/btrfs/tree-log.h     |   3 +-
 fs/btrfs/zoned.c        |   4 +-
 fs/btrfs/zoned.h        |   1 -
 30 files changed, 264 insertions(+), 224 deletions(-)

-- 
2.51.0


