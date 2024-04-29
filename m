Return-Path: <linux-btrfs+bounces-4635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886318B65A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A172D1C2179B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E55194C6D;
	Mon, 29 Apr 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eInGwzcE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPN+dV5+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39382D90
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429413; cv=none; b=pd53mMH62hMPRV7pSxK5tkvW13oIyElBMG0AqNKpULyGuITipuRKugg5/7/HN3g59dktf1XavYxiI6nrWkvACPYgGmcODxh2uSe4bUxGKoZEiSXAENHJrJEcISfr/KEeQCutZkVHlbJtUTojaI1bdYbgFOUSPc7h34rWrNjTprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429413; c=relaxed/simple;
	bh=c1saI8fubstK6VZ9c/O6JRwKZ2TgnbgtQ81fq+UQ1fc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bVMVtY7A6MEMexoXf1eYhPMUQh/uf0gqMG3bkxdoRN/JHXTpXIiF+0eY+xcM6ZGUWWPtsu2oWrfRrFqs19qJTQHmoYxNtBoUtU70m3IAyNSZc7EV2L6hBZNLQUXrxD4f+j9PAS2RivGMEJXs9zYJ03poMMW3yS1cA23bMjIeSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eInGwzcE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HPN+dV5+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA5061F769
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2bQsIKxyt3y18dpJ+SQSEAt3lx8rkpyLkJFRAGIr09Y=;
	b=eInGwzcEfO0vbOBYRQUoxlZkfB9VWPlq1DCELNTfxbWJjO2J+6ngnCAIWcceOc4NbQJLLN
	oL0pi93vmtsNP6ESUIqZKx0m02pt663AawNmAmGk4oC6Rtpis7dxYMV2dHdPTGgeC69OGq
	+uv4DLFJF5M8fyJpPixt9TQqNLcZrrI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HPN+dV5+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2bQsIKxyt3y18dpJ+SQSEAt3lx8rkpyLkJFRAGIr09Y=;
	b=HPN+dV5+cWITET7aWaNtFI6bbqZxh4eFwtSW7fgGcTRCj5MOMdPGVBtlCceMr1OFRBaR+r
	v3eTMFkI/VF7n57CMCSbTjkTvRB64v8iAW3O03q5rCLeJObAaAjmExR9vLELEzYZcSmdks
	kdEXKhXiTaPZEOY7a3fTUPa/wnCZrXI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99817139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGRrDd4dMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: extent-map: use disk_bytenr/offset to replace block_start/block_len/orig_start
Date: Tue, 30 Apr 2024 07:52:58 +0930
Message-ID: <cover.1714428940.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA5061F769
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]

[CHANGELOG]
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

The patchset would do one cleanup first, then rename orig_block_len to
disk_num_bytes.
Then introduce the new member, the extra sanity checks.
Finally introduce the new btrfs_file_extent structure and use that to
remove the older 3 members from extent_map.

Qu Wenruo (9):
  btrfs: remove the recursive include of btrfs_inode.h from itself
  btrfs: rename extent_map::orig_block_len to disk_num_bytes
  btrfs: export the expected file extent through can_nocow_extent()
  btrfs: introduce new members for extent_map
  btrfs: introduce extra sanity checks for extent maps
  btrfs: remove extent_map::orig_start member
  btrfs: remove extent_map::block_len member
  btrfs: remove extent_map::block_start member
  btrfs: remove parameters duplicated from btrfs_file_extent

 fs/btrfs/btrfs_inode.h            |   6 +-
 fs/btrfs/compression.c            |   7 +-
 fs/btrfs/defrag.c                 |  14 +-
 fs/btrfs/extent_io.c              |  10 +-
 fs/btrfs/extent_map.c             | 187 +++++++++++------
 fs/btrfs/extent_map.h             |  51 +++--
 fs/btrfs/file-item.c              |  23 +--
 fs/btrfs/file.c                   |  18 +-
 fs/btrfs/inode.c                  | 333 +++++++++++++++---------------
 fs/btrfs/ordered-data.c           |  20 +-
 fs/btrfs/ordered-data.h           |  22 +-
 fs/btrfs/relocation.c             |   5 +-
 fs/btrfs/tests/extent-map-tests.c | 114 +++++-----
 fs/btrfs/tests/inode-tests.c      | 177 ++++++++--------
 fs/btrfs/tree-log.c               |  25 ++-
 fs/btrfs/zoned.c                  |   4 +-
 include/trace/events/btrfs.h      |  26 +--
 17 files changed, 560 insertions(+), 482 deletions(-)

-- 
2.44.0


