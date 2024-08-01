Return-Path: <linux-btrfs+bounces-6941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED13944406
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 08:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B377283A62
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8731917E6;
	Thu,  1 Aug 2024 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OsL5UlmO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OsL5UlmO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77818FC75
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492788; cv=none; b=edzDPs/Nwz5rPQmf2jtfYpUeqWo+0P4Tv9GFbkTIaN6B5GrPDQD4GOuquwtEYLW7ivAC66e+50lFoYbPvL7JVQpF9uF1GFbgWCyMUrIJgPJ++S7KezL1txL/CHQOt6A8hKfxaGRfF6rKWVwi3GtM82SyBpwiDzw62zHyaDnxd6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492788; c=relaxed/simple;
	bh=aW65hLCuUwAmSHovg+YrWgeQ2LtpGG+icSFfxXVX+m8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OHtl5WEqoXjEfDrx7SI4OwxSmA2XGJZcBhfICSECu4mOxx2VcddwTlOTN66ocPq1GpKB+KA+hS8oqqdKs7+9PG8cZK2eM8DinzbpIKVomYHRBxkXwEsKL3R1Hi38jxxoWexRc7DgxwYr6rp6Doob5GhL8dDxoRhwVzv5nMxJM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OsL5UlmO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OsL5UlmO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3CB621A9F
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JEXYSKd/6jLhlb6XCxs5+sS5ETw8IbUfn3R/+0AveOc=;
	b=OsL5UlmOY6JjcuVgAyW3o5T9A97CBZHMwMPcVAMgakv0d0IakYb1nf/ixd9auwtHqyYE6f
	UFpKZ6Smx55K3Wy1jemj8tb4kIEKtHogb/PvUHWh1jIxJBq+RvMFb3sjRg1f40wo6Tn0WY
	awbNSnafwjqem7Y2j1ne7TrS00CG3N8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JEXYSKd/6jLhlb6XCxs5+sS5ETw8IbUfn3R/+0AveOc=;
	b=OsL5UlmOY6JjcuVgAyW3o5T9A97CBZHMwMPcVAMgakv0d0IakYb1nf/ixd9auwtHqyYE6f
	UFpKZ6Smx55K3Wy1jemj8tb4kIEKtHogb/PvUHWh1jIxJBq+RvMFb3sjRg1f40wo6Tn0WY
	awbNSnafwjqem7Y2j1ne7TrS00CG3N8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6FB313946
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w7PQH24nq2ZkaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2024 06:13:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs-progs: rework how we traverse rootdir
Date: Thu,  1 Aug 2024 15:42:35 +0930
Message-ID: <cover.1722492491.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

[CHANGELOG]
v2:
- Change the current_path.level, so that 0 means uninitialized
  This makes the current_path level to match the ftwbuf level.

- Add a comment explaining how the current_path stack works
  With an example layout and stack changes.

- Add two new test cases
  Both test cases are for the old rootdir bugs:
  * Extra hard link are out of the rootdir
    Old --rootdir will create a corrupted fs with incorrect nlink.
    This is because we use st_nlink without any extra verification

  * Conflicting inode numbers caused by different mount points
    Old --rootdir will fail gracefully, but still not ideal as the error
    message doesn't explain it at all.
    This is because we use st_inode without any extra verification

- Newline and typo fixes

Thanks to Mark's recent work, I finally get some time to rework rootdir
traversal.

All the problems are described inside the second patch.
While the last patch is a small enhancement to --rootdir to reject hard
links.

With this change, it's much easier to support subvolume creations at
mkfs time:

- Create a hashmap (or other similar structure) to record all the
  directories that should be subvolume

- Call btrfs_make_subvoume() other than btrfs_insert_inode() if a path
  should be a subvolume

- Call btrfs_link_subvolume() other than btrfs_add_link() for a
  subvolume

Everything like parent directory inode size is properly handled by
btrfs_link_subvolume() and btrfs_add_link() already.


Qu Wenruo (5):
  btrfs-progs: constify the name parameter of btrfs_add_link()
  btrfs-progs: mkfs: rework how we traverse rootdir
  btrfs-progs: rootdir: warn about hard links
  btrfs-progs: mkfs-tests: a new test case to verify handling of hard
    links
  btrfs-progs: mkfs-tests: verify cross mount point behavior for rootdir

 kernel-shared/ctree.h                         |   2 +-
 kernel-shared/inode.c                         |   2 +-
 mkfs/rootdir.c                                | 711 ++++++++----------
 mkfs/rootdir.h                                |   8 -
 .../034-rootdir-extra-hard-links/test.sh      |  24 +
 .../035-rootdir-cross-mount/test.sh           |  46 ++
 6 files changed, 377 insertions(+), 416 deletions(-)
 create mode 100755 tests/mkfs-tests/034-rootdir-extra-hard-links/test.sh
 create mode 100755 tests/mkfs-tests/035-rootdir-cross-mount/test.sh

--
2.45.2


