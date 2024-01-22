Return-Path: <linux-btrfs+bounces-1609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE13837183
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305871C2A4FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632B524B8;
	Mon, 22 Jan 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8nkgU0F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8nkgU0F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C151C54;
	Mon, 22 Jan 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948457; cv=none; b=UY2tDBGqNlE0bYVSVgRVzZqDljMTU86k4W6dxkUj98eJkMUMlNtXE1Yas3QmxAFDnwp2VhMy26zAbXgqjL+1pusP8vbcZA00eJ2CDU8233HzydiBkH7x1u3XWhJy0BRKJe9ZLPcEdo85stNkKZJq8CnhT1XDkS2rXLRufDJE4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948457; c=relaxed/simple;
	bh=oQacqnuO9mGmDHTgnL5CUIN0m7GKe62VcG6C7MQT824=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCLSUMsLT7WsvUSq70r71BkGzwWJi9YFGBssP17lnTl95cc7udRm/T7Iv3z3iLRRbeJJiznXirUxvvwwWAo///t3QffhBLqMXOsaIBPQKJPHrv1grU/9FwayFzDcgycDzEIvwwkpe6WR0BMAnEvdJNe5eWcVemJgJ2KQ5YMBvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8nkgU0F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8nkgU0F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03DBF21FC0;
	Mon, 22 Jan 2024 18:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705948454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FjNsB5EjumG15DrXXoM5w5G4N1GM3TAKsj6a0kiIkio=;
	b=k8nkgU0FiBOd8U+340kNfl8mFHAY46grDguxZYxxfz4bhnm+cVRLWMYYI70Nfd+HFqrZm7
	hUeVnQdmYOaW5z+VnM5Xy4tpp/C2xj+1ydFnN0+9aOW/sKMFmbsn6pxN3hHSuGchLQUVa8
	aBzhs+znyEOrOsprZOmgfEzmAWGzEsM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705948454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FjNsB5EjumG15DrXXoM5w5G4N1GM3TAKsj6a0kiIkio=;
	b=k8nkgU0FiBOd8U+340kNfl8mFHAY46grDguxZYxxfz4bhnm+cVRLWMYYI70Nfd+HFqrZm7
	hUeVnQdmYOaW5z+VnM5Xy4tpp/C2xj+1ydFnN0+9aOW/sKMFmbsn6pxN3hHSuGchLQUVa8
	aBzhs+znyEOrOsprZOmgfEzmAWGzEsM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E94A11390F;
	Mon, 22 Jan 2024 18:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fcupOCW1rmVKbQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 22 Jan 2024 18:34:13 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc2
Date: Mon, 22 Jan 2024 19:33:44 +0100
Message-ID: <cover.1705946889.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.46
X-Spamd-Result: default: False [3.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.56)[0.853];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi,

please pull the following fixes. Thanks.

- zoned mode fixes:
  - fix slowdown when writing large file sequentially by looking up
    block groups with enough space faster
  - locking fixes when activating a zone

- new mount API fixes:
  - preserve mount options for a ro/rw mount of the same subvolume

- scrub fixes:
  - fix use-after-free in case the chunk length is not aligned to 64K,
    this does not happen normally but has been reported on images
    converted from ext4
  - similar alignment check was missing with raid-stripe-tree

- subvolume deletion fixes:
  - prevent calling ioctl on already deleted subvolume
  - properly track flag tracking a deleted subvolume

- in subpage mode, fix decompression of an inline extent (zlib, lzo, zstd)

- fix crash when starting writeback on a folio, after integration with
  recent MM changes this needs to be started conditionally

- reject unknown flags in defrag ioctl

- error handling, API fixes, minor warning fixes

----------------------------------------------------------------
The following changes since commit e94dfb7a2935cb91faca88bf7136177d1ce0dda8:

  btrfs: pass btrfs_io_geometry into btrfs_max_io_len (2023-12-15 23:03:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag

for you to fetch changes up to 7f2d219e78e95a137a9c76fddac7ff8228260439:

  btrfs: scrub: limit RST scrub to chunk boundary (2024-01-18 23:43:08 +0100)

----------------------------------------------------------------
Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

David Sterba (1):
      btrfs: don't warn if discard range is not aligned to sector

Dmitry Antipov (1):
      btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send()

Fedor Pchelkin (1):
      btrfs: ref-verify: free ref cache before clearing mount opt

Josef Bacik (2):
      btrfs: use the original mount's mount options for the legacy reconfigure
      btrfs: don't unconditionally call folio_start_writeback in subpage

Naohiro Aota (4):
      btrfs: zoned: factor out prepare_allocation_zoned()
      btrfs: zoned: optimize hint byte for zoned allocator
      btrfs: fix unbalanced unlock of mapping_tree_lock
      btrfs: zoned: fix lock ordering in btrfs_zone_activate()

Omar Sandoval (2):
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted

Qu Wenruo (6):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
      btrfs: zlib: fix and simplify the inline extent decompression
      btrfs: lzo: fix and simplify the inline extent decompression
      btrfs: zstd: fix and simplify the inline extent decompression
      btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned
      btrfs: scrub: limit RST scrub to chunk boundary

 fs/btrfs/compression.c     | 23 ++++++++++-----
 fs/btrfs/compression.h     |  6 ++--
 fs/btrfs/extent-tree.c     | 53 ++++++++++++++++++++++++---------
 fs/btrfs/inode.c           | 22 ++++++++------
 fs/btrfs/ioctl.c           |  7 +++++
 fs/btrfs/lzo.c             | 34 ++++++---------------
 fs/btrfs/ref-verify.c      |  6 ++--
 fs/btrfs/scrub.c           | 36 ++++++++++++++++++-----
 fs/btrfs/send.c            |  4 +--
 fs/btrfs/subpage.c         |  3 +-
 fs/btrfs/super.c           |  8 +++++
 fs/btrfs/tree-checker.c    |  2 +-
 fs/btrfs/volumes.c         |  2 --
 fs/btrfs/zlib.c            | 73 ++++++++++++----------------------------------
 fs/btrfs/zoned.c           |  8 ++---
 fs/btrfs/zstd.c            | 73 +++++++++++++---------------------------------
 include/uapi/linux/btrfs.h |  3 ++
 17 files changed, 178 insertions(+), 185 deletions(-)

