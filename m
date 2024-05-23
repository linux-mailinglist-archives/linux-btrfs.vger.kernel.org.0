Return-Path: <linux-btrfs+bounces-5226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC18A8CCB91
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09421C21539
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21347CF39;
	Thu, 23 May 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NGgrrNC+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NGgrrNC+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1D17F6
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440635; cv=none; b=uz2fjPLyiNgMWbB9dF2PlB9U0KRttMjlfsgE1E9UV6eQF9khfatQpyRqlRgunj8qEyOw3nLa3seKnUAeyZdUQNhEX5PrGLkpTDpds+/oRYhzH6vuqN/JeAmr00v5eiS1XdJ1CTZ6RO9SQS0zGcQtvn2ilDwa08saw2TCXCz6hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440635; c=relaxed/simple;
	bh=P7l5/GKCzPzvsX/DWHuBR/uSYblXfXGNdQekpLDznvY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bcGqtco8sLM6sOSmhUyioXRSmKfHYOXHg3GRX0iNcGgIwDPu6HpRT0AMkqFZP2fNI4/IyZnqeW3/6FcUHmwmCYiWykg1h4iAG73cJlUd83eulXRH0Zy8vGc60OZCRuWQugJsqCaMa2oZwNxv/gdoSKuEo1L8xFVkbp1M4OovoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NGgrrNC+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NGgrrNC+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0CED220E3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vvdB2o6eF4r15ygcgH9EwBUPgIyYaUKzZ3967oP0xWQ=;
	b=NGgrrNC+BEbYADxQXQ+n1iGNnYMV9IXVMZTN2D5N+1E1yINOs/QqDb+x5Mo8FLiXSFrJVK
	+3YIYCsyqU9NOXe8KI13OmGuE1ceBbDuKa5WOzKpRAU71q1AWmGZCZEzWzh5iZBTu6n8fa
	iK1yPOMFtnDTOaVSdl5Df/7c1uOj7c0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vvdB2o6eF4r15ygcgH9EwBUPgIyYaUKzZ3967oP0xWQ=;
	b=NGgrrNC+BEbYADxQXQ+n1iGNnYMV9IXVMZTN2D5N+1E1yINOs/QqDb+x5Mo8FLiXSFrJVK
	+3YIYCsyqU9NOXe8KI13OmGuE1ceBbDuKa5WOzKpRAU71q1AWmGZCZEzWzh5iZBTu6n8fa
	iK1yPOMFtnDTOaVSdl5Df/7c1uOj7c0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8C413A6B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZGyRIzTOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/11] btrfs: extent-map: unify the members with btrfs_ordered_extent
Date: Thu, 23 May 2024 14:33:19 +0930
Message-ID: <cover.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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
v3:
- Rebased to the latest for-next
  There is a small conflicts with the extent map tree members changes,
  no big deal.

- Fix an error where original code is checking
  btrfs_file_extent_disk_bytenr()
  The newer code is checking disk_num_bytes, which is wrong.

- Various commit messages/comments update
  Mostly some grammar fixes and removal of rants on the btrfs_file_extent
  member mismatches for btrfs_alloc_ordered_extent().
  However a comment is still left inside btrfs_alloc_ordered_extent()
  for NOCOW/PREALLOC as a reminder for further cleanup.

v2:
- Rebased to the latest for-next
  There is a conflicts with extent locking, and maybe some other
  hidden conflicts for NOCOW/PREALLOC?
  As previously the patchset passes fstests auto group, but after
  the merging with other patches, it always crashes as btrfs/060.

- Fix an error in the final cleanup patch
  It's the NOCOW/PREALLOC shenanigans again, in the buffered NOCOW path,
  that we have to use the old inaccurate numbers for NOCOW/PREALLOC OEs.

- Split the final cleanup into 4 patches
  Most cleanups are very straightforward, but the cleanup for
  btrfs_alloc_ordered_extent() needs extra special handling for
  NOCOW/PREALLOC.

v1:
- Rebased to the latest for-next
  To resolve the conflicts with the recently introduced extent map
  shrinker

- A new cleanup patch to remove the recursive header inclusion

- Use a new structure to pass the file extent item related members
  around

- Add a new comment on why we're intentionally passing incorrect
  numbers for NOCOW/PREALLOC ordered extents inside
  btrfs_create_dio_extent()

[REPO]
https://github.com/adam900710/linux/tree/em_cleanup

This series introduce two new members (disk_bytenr/offset) to
extent_map, and removes three old members
(block_start/block_len/offset), finally rename one member
(orig_block_len -> disk_num_bytes).

This should save us one u64 for extent_map, although with the recent
extent map shrinker, the saving is not that useful.

But to make things safe to migrate, I introduce extra sanity checks for
extent_map, and do cross check for both old and new members.

The extra sanity checks already exposed one bug (thankfully harmless)
causing em::block_start to be incorrect.

But so far, the patchset is fine for default fstests run.

Furthermore, since we're already having too long parameter lists for
extent_map/ordered_extent/can_nocow_extent, here is a new structure,
btrfs_file_extent, a memory-access-friendly structure to represent a
btrfs_file_extent_item.

With the help of that structure, we can use that to represent a file
extent item without a super long parameter list.

The patchset would rename orig_block_len to disk_num_bytes first.
Then introduce the new member, the extra sanity checks, and introduce the
new btrfs_file_extent structure and use that to remove the older 3 members
from extent_map.

After all above works done, use btrfs_file_extent to further cleanup
can_nocow_file_extent_args()/btrfs_alloc_ordered_extent()/create_io_em()/
btrfs_create_dio_extent().

The cleanup is in fact pretty tricky, the current code base never
expects correct numbers for NOCOW/PREALLOC OEs, thus we have to keep the
old but incorrect numbers just for NOCOW/PREALLOC.

I will address the NOCOW/PREALLOC shenanigans the future, but
after the huge cleanup across multiple core structures.

Qu Wenruo (11):
  btrfs: rename extent_map::orig_block_len to disk_num_bytes
  btrfs: export the expected file extent through can_nocow_extent()
  btrfs: introduce new members for extent_map
  btrfs: introduce extra sanity checks for extent maps
  btrfs: remove extent_map::orig_start member
  btrfs: remove extent_map::block_len member
  btrfs: remove extent_map::block_start member
  btrfs: cleanup duplicated parameters related to
    can_nocow_file_extent_args
  btrfs: cleanup duplicated parameters related to
    btrfs_alloc_ordered_extent
  btrfs: cleanup duplicated parameters related to create_io_em()
  btrfs: cleanup duplicated parameters related to
    btrfs_create_dio_extent()

 fs/btrfs/btrfs_inode.h            |   4 +-
 fs/btrfs/compression.c            |   7 +-
 fs/btrfs/defrag.c                 |  14 +-
 fs/btrfs/extent_io.c              |  10 +-
 fs/btrfs/extent_map.c             | 192 +++++++++++++------
 fs/btrfs/extent_map.h             |  51 +++--
 fs/btrfs/file-item.c              |  23 +--
 fs/btrfs/file.c                   |  18 +-
 fs/btrfs/inode.c                  | 308 +++++++++++++-----------------
 fs/btrfs/ordered-data.c           |  34 +++-
 fs/btrfs/ordered-data.h           |  19 +-
 fs/btrfs/relocation.c             |   5 +-
 fs/btrfs/tests/extent-map-tests.c | 114 ++++++-----
 fs/btrfs/tests/inode-tests.c      | 177 ++++++++---------
 fs/btrfs/tree-log.c               |  23 ++-
 fs/btrfs/zoned.c                  |   4 +-
 include/trace/events/btrfs.h      |  18 +-
 17 files changed, 541 insertions(+), 480 deletions(-)

-- 
2.45.1


