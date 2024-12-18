Return-Path: <linux-btrfs+bounces-10530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6279F61F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEF01895EB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98826198E75;
	Wed, 18 Dec 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s8bXiHyI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s8bXiHyI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD44195385
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514922; cv=none; b=TnKrfzq8z6tUsNhttTrSw+W8DHMDGKRJG7+9UYW0rH7LG7QX7veGMzZD5Vm/ftwohZ4viTqYSw/ZaGMwmf1Q4Col4ixkziBNwbcr/AXBAezcwUKahakr2x9Y6PE26/gLhUznHqikS1IWsFvsTRFZHGZ89N46a4v5FbjfciX17mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514922; c=relaxed/simple;
	bh=XFJhAbr8ttxXW3V0dpfZY/Iho2ruf4CkNvjyLrFfdYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y42E+mrTvb1UdAGwgs0bp8um2mNoCf/vB1DsN1mYVz9owm0CUk0waytCLuB+UzCftEYqp0i7RLx0wGvWkam4MDwuV2dq+BAZJD6eLdfzKGkUnxch57KDWpU1HulLha3vX85WSqUWeIVhXkM7wnLSPcZVKT4EqatDWoVYhG3r+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s8bXiHyI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s8bXiHyI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34A4A2115D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9GDcZsxdC+1ULeI5rh3cOIpChErYAfRKAeBvhW0NpKg=;
	b=s8bXiHyIdJWZK4Rpv17/vlguX6qIIT+Yhy/7wQshmQ6oubnE67JaERIX0gJBa8pLjLCvnU
	WKwx+6shOVILPdSwMIE4/hNOuYPantf83pn40gsDIZazDbMAzZaQTr8puHHdfSkn5yKYhe
	Liv1nmrx/bk0yf7o4EFU+Tv/Or/6DbE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9GDcZsxdC+1ULeI5rh3cOIpChErYAfRKAeBvhW0NpKg=;
	b=s8bXiHyIdJWZK4Rpv17/vlguX6qIIT+Yhy/7wQshmQ6oubnE67JaERIX0gJBa8pLjLCvnU
	WKwx+6shOVILPdSwMIE4/hNOuYPantf83pn40gsDIZazDbMAzZaQTr8puHHdfSkn5yKYhe
	Liv1nmrx/bk0yf7o4EFU+Tv/Or/6DbE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61491132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zW3uB+CYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/18] btrfs: migrate to "block size" to describe the
Date: Wed, 18 Dec 2024 20:11:16 +1030
Message-ID: <cover.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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

[BACKGROUND]
Since day 1, btrfs uses a different terminology, sector size, to
describe the minimum data block size.

Meanwhile all other filesystems (ext4, xfs, jfs, bcachefs, reiserfs) are
using "block size" to describe the same unit.

Furthermore, kernel itself has its own sector size, fixed to 512 bytes,
as the minimal block IO unit.

This will cause extra confusiong when we're talking with other MM/FS
developers.

[IMPEMENTATION]
To reduce the confusion, this patchset will do such a huge migration in
different steps:

- Introduce btrfs_fs_info::blocksize as an alias for
  btrfs_fs_info::sectorsize
  This is done by introducing an anonymous union, allowing @sectorsize
  and @blocksize to share the same value, and do the migration on a
  per-file basis.

  This covers @blocsize, @blocksize_bits, @blocks_per_page.

- Rename involved users, comments and local variables

- Rename related function names, parameters and even some macros
  This affects scrub and raid56 most, as I follow the strict "sector"
  terminology when reworking on those functionality.

  Thus they will receive very heavy renames.

- Finish the btrfs_fs_info::sectorsize rename

- Add btrfs_super_block::blocksize as an alias for sectorsize
- Add btrfs_ioctl_fs_info_args::blocksize as an alias for sectorsize
  Unlike the btrfs_fs_info::blocksize change which is purely inside
  btrfs, those structures are exported as on-disk format and ioctl
  parameters.

  To keep the compatibility for older programs which may never update
  their code, make @blocksize and @sectorsize co-exist as unions, to
  avoid breakage for older programs.

Qu Wenruo (18):
  btrfs: rename btrfs_fs_info::sectorsize to blocksize for disk-io.c
  btrfs: migrate subpage.[ch] to use block size terminology
  btrfs: migrate tree-checker.c to use block size terminology
  btrfs: migrate scrub.c to use block size terminology
  btrfs: migrate extent_io.[ch] to use block size terminology
  btrfs: migrate compression related code to use block size terminology
  btrfs: migrate free space cache code to use block size terminology
  btrfs: migrate file-item.c to use block size terminology
  btrfs: migrate file.c to use block size terminology
  btrfs: migrate inode.c and btrfs_inode.h to use block size terminology
  btrfs: migrate raid56.[ch] to use block size terminology
  btrfs: migrate defrag.c to use block size terminology
  btrfs: migrate bio.[ch] to use block size terminology
  btrfs: migrate the remaining sector size users to use block size
    terminology
  btrfs: migrate selftests to use block size terminology
  btrfs: finish the rename of btrfs_fs_info::sectorsize
  btrfs: migrate btrfs_super_block::sectorsize to blocksize
  btrfs: migrate the ioctl interfaces to use block size terminology

 fs/btrfs/accessors.h                    |   6 +-
 fs/btrfs/bio.c                          |  24 +-
 fs/btrfs/bio.h                          |   4 +-
 fs/btrfs/block-group.c                  |   4 +-
 fs/btrfs/btrfs_inode.h                  |   2 +-
 fs/btrfs/compression.c                  |  30 +-
 fs/btrfs/defrag.c                       |  52 +-
 fs/btrfs/delalloc-space.c               |  26 +-
 fs/btrfs/delayed-inode.c                |   2 +-
 fs/btrfs/delayed-ref.c                  |  12 +-
 fs/btrfs/delayed-ref.h                  |   4 +-
 fs/btrfs/dev-replace.c                  |  12 +-
 fs/btrfs/direct-io.c                    |   6 +-
 fs/btrfs/disk-io.c                      |  82 +--
 fs/btrfs/extent-tree.c                  |  14 +-
 fs/btrfs/extent_io.c                    | 124 ++--
 fs/btrfs/extent_io.h                    |  16 +-
 fs/btrfs/extent_map.h                   |   2 +-
 fs/btrfs/fiemap.c                       |   6 +-
 fs/btrfs/file-item.c                    |  94 +--
 fs/btrfs/file.c                         | 138 ++--
 fs/btrfs/free-space-cache.c             |   8 +-
 fs/btrfs/free-space-tree.c              |  28 +-
 fs/btrfs/fs.h                           |  19 +-
 fs/btrfs/inode-item.c                   |   8 +-
 fs/btrfs/inode.c                        | 140 ++--
 fs/btrfs/ioctl.c                        |  14 +-
 fs/btrfs/lzo.c                          |  80 +--
 fs/btrfs/print-tree.c                   |  14 +-
 fs/btrfs/qgroup.c                       |  10 +-
 fs/btrfs/qgroup.h                       |   2 +-
 fs/btrfs/raid56.c                       | 810 ++++++++++++------------
 fs/btrfs/raid56.h                       |  36 +-
 fs/btrfs/reflink.c                      |  22 +-
 fs/btrfs/relocation.c                   |  16 +-
 fs/btrfs/scrub.c                        | 442 ++++++-------
 fs/btrfs/send.c                         |  36 +-
 fs/btrfs/subpage.c                      |  92 +--
 fs/btrfs/subpage.h                      |   8 +-
 fs/btrfs/super.c                        |  10 +-
 fs/btrfs/sysfs.c                        |   4 +-
 fs/btrfs/tests/btrfs-tests.c            |  38 +-
 fs/btrfs/tests/btrfs-tests.h            |  18 +-
 fs/btrfs/tests/delayed-refs-tests.c     |   4 +-
 fs/btrfs/tests/extent-buffer-tests.c    |   8 +-
 fs/btrfs/tests/extent-io-tests.c        |  34 +-
 fs/btrfs/tests/free-space-tests.c       | 104 +--
 fs/btrfs/tests/free-space-tree-tests.c  |  28 +-
 fs/btrfs/tests/inode-tests.c            | 266 ++++----
 fs/btrfs/tests/qgroup-tests.c           |  12 +-
 fs/btrfs/tests/raid-stripe-tree-tests.c |   8 +-
 fs/btrfs/tree-checker.c                 | 100 +--
 fs/btrfs/tree-log.c                     |   6 +-
 fs/btrfs/volumes.c                      |  26 +-
 fs/btrfs/zlib.c                         |   2 +-
 fs/btrfs/zoned.c                        |   6 +-
 fs/btrfs/zstd.c                         |   6 +-
 include/uapi/linux/btrfs.h              |  21 +-
 include/uapi/linux/btrfs_tree.h         |  13 +-
 59 files changed, 1590 insertions(+), 1569 deletions(-)

-- 
2.47.1


