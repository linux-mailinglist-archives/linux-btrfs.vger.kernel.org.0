Return-Path: <linux-btrfs+bounces-3897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496A897C6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C928316F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 23:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3D15921F;
	Wed,  3 Apr 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W3XocgXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388FE158DC8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187738; cv=none; b=mkn7qb89R+eztA8IYoDVOL0ebqqmxCKZEUncPQu73OAYi4zu2Y5mndLtXxCJNlCm+xrn131kzYEbh4NuosSHgiUuaIBL1T2hj9/Zt0AsbCj3uEuLW5UwAZL3cFypL5p1M3FTcNip73aj9X4Hd1Q3FHiJetfDKCcKXoMAAvaAohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187738; c=relaxed/simple;
	bh=ZW9Im7EMyv5k+6y70B0oYKklpeI6fxnQoTOHj4jBCwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=W9h06DghAO3Zq3FrATtBOp7Nd+ckwlLecY5fTTQuJ9u6dLd0nEbx/C1kovaXW+kJCBA7A02Skvd9oU6gFNVqTQ+nWhqAWvLRYsuE0WPHBcAAaTan9pOyB+UNM6oDT13JqbaKSvjtMa0X/D66SsfPeKZOnbFjhZppP83irXmrtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W3XocgXd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50C555D2E8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712187733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=B3IY2uK0mUNrjqEkXJYNz2af+fATC0x7sneCSyvXXxM=;
	b=W3XocgXdnf9AoykCKx4ojYJPVeGYggT7SuBOzcAl0tE59CkOeB2kJjbeRyuwNbLY8Qfcsj
	EqIU+zPNdX/pOCoeMlR13r6/THYYmk1w+/lVUwRRZKJgo/v5DSIKTZHwp5F+rhg/yxTA+w
	zAdXR4T68Az1Sy6d9DMmTKACWK/w2LE=
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F8C1331E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3dG4EFTpDWalfQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 23:42:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: more explaination on extent_map members
Date: Thu,  4 Apr 2024 10:11:57 +1030
Message-ID: <cover.1712187452.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

[REPO]
https://github.com/adam900710/linux.git/ em_cleanup

[CHANGELOG]
v2:
- Add Filipe's cleanup on mod_start/mod_len
  These two members are no longer utilized, saving me quite some time on
  digging into their usage.

- Update the comments of the extent_map structure
  To make them more readable and less confusing.

- Further cleanup for inline extent_map reading

- A new patch to do extra sanity checks for create_io_em()
  Firstly pure NOCOW writes should not call create_io_em(), secondly
  with the new knowledge of extent_map, it's easier to do extra sanity
  checks for the already pretty long parameter list.

Btrfs uses extent_map to represent a in-memory file extent.

There are severam members that are 1:1 mappe in on-disk file extent
items and extent maps:

- extent_map::start	==	key.offset
- extent_map::len	==	file_extent_num_bytes
- extent_map::ram_bytes	==	file_extent_ram_bytes

But that's all, the remaining are pretty different:

- Use block_start to indicate holes/inline extents
  Meanwhile btrfs on-disk file extent items go with a dedicated type for
  inline extents, and disk_bytenr 0 for holes.

- Extra members for fsync optimization
  I'm still not 100% sure how mod_start and mod_len really works though.

- Weird block_start/orig_block_len/orig_start
  In theory we can directly go with the same file_extent_disk_bytenr,
  file_extent_disk_num_bytes and file_extent_offset to calculate the
  remaining members (block_start/orig_start/orig_block_len/block_len).

  But for whatever reason, we didn't go that path and have a hell of
  weird and inconsistent calculation for them.

I do not have the confidence to handle the mess yet, but as the first
step, I would add comments for those members mostly according to
btrfs_extent_item_to_extent_map(), and hopefully we can improve the
situation in not-far-away future.

Filipe Manana (1):
  btrfs: remove not needed mod_start and mod_len from struct extent_map

Qu Wenruo (3):
  btrfs: add extra comments on extent_map members
  btrfs: simplify the inline extent map creation
  btrfs: add extra sanity checks for create_io_em()

 fs/btrfs/extent_map.c        | 18 -----------
 fs/btrfs/extent_map.h        | 58 ++++++++++++++++++++++++++++++++----
 fs/btrfs/file-item.c         | 15 +++++-----
 fs/btrfs/inode.c             | 44 ++++++++++++++++++++++++---
 fs/btrfs/tree-log.c          |  4 +--
 include/trace/events/btrfs.h |  3 +-
 6 files changed, 104 insertions(+), 38 deletions(-)

-- 
2.44.0


