Return-Path: <linux-btrfs+bounces-13170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F87A9420D
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77E18A3529
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9355198E81;
	Sat, 19 Apr 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mo/uY/M8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mo/uY/M8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD92AE66
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047063; cv=none; b=R8gPR0dJ9xyTTm2wXM/OF7QHi7DAyqNMWSvQDs653Se8d56I44oIRvntLmTDiPmwfFIxBHucY4Fd1JlO/zj1uEdZEsCuXlRemja0VTc2tHpGQW2vrdhyCwC/XS1gAKU4ixCg6bQlGLO+hf5V1bYWwmkOnDXrywuQ/5D4BW0GfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047063; c=relaxed/simple;
	bh=GJ5pliwkOmg1SCliifv4NJ1an5j9+mIx8W+uOawrpMo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kXCFfTMhOJjVynt/vIeKkhz7qzgvsnRz/rv8kVuuAP9bIPRbwnvaZ6EvHIprvcfH8FguWAyDlhUrMOO3jvKWrXZxZjYQoNC3uB8FLOVNpC+AwK3pzVBjVbeaGaJdTZP28pT277ghjmPD7XaA6GTg0uaK+478F4FQKazsE0rExf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mo/uY/M8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mo/uY/M8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A08F2120A;
	Sat, 19 Apr 2025 07:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2dWi2PXZ2zzCaKXdqaHQTeizWZiqgOQPpyIDxul5gLs=;
	b=Mo/uY/M8YkEo8veyq5yjMZyPWZlf3uh0MoTfqv/XsN+XGoCQA/LyBX/XLG/9ROuUxGFzAw
	Eq4quExzRZD9cY4DP4TLJZvCfh9wXWoeGsELUvDF18/gjJfNSpgGvItHIlX2mGxMYrFhOO
	tfz6c30Fwzo2ji/bM/qWvyyBo4ssUS0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2dWi2PXZ2zzCaKXdqaHQTeizWZiqgOQPpyIDxul5gLs=;
	b=Mo/uY/M8YkEo8veyq5yjMZyPWZlf3uh0MoTfqv/XsN+XGoCQA/LyBX/XLG/9ROuUxGFzAw
	Eq4quExzRZD9cY4DP4TLJZvCfh9wXWoeGsELUvDF18/gjJfNSpgGvItHIlX2mGxMYrFhOO
	tfz6c30Fwzo2ji/bM/qWvyyBo4ssUS0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D0FB13942;
	Sat, 19 Apr 2025 07:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8lwbNBBOA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 0/8] btrfs: do not poking into the implementation details of bio_vec
Date: Sat, 19 Apr 2025 16:47:07 +0930
Message-ID: <cover.1745024799.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

- Fix a crash caused by incorrectly index sector_ptrs
  The 5th patch, caused by missing increasement of the @offset variable.

- Use physical addresses instead of virtual addresses to handle HIGHMEM
  The 6th patch, as we can still get sector_ptr from bio_sectors[] which
  is using pages from the bio, and that can be highmem.

  However I can not do a proper test on this, as the latest kernel has
  already rejected HIGHMEM64G option, thus even if my VM has extra 3GB
  for HIGHMEM (total 6GB), I'm not sure if the kernel can really utilize
  those high memories.

  Furthermore there seems to be other bugs in mm layer related to
  HIGHMEM + PAGE, resulting zswap crash when try compressing a page to
  be swapped out.
  But at least several scrub/balance related test cases passed on x86
  32bit with HIGHMEM and PAGE.

  I have tested with x86_64 (64 bit, no HIGHMEM), aarch64 (64bit, 64K
  page size, no HIGHMEM) with no regression.

- Fix a incorrect __bio_add_page() usage in scrub_bio_add_sector()
  The 6th patch, as bio_add_page() do extra bvec merging before
  allocating a new bvec, but __bio_add_page() does not.

  This triggers WARN_ON_ONCE() in __bio_add_page() checking if the bio
  is full.

  Fixing it by do the old bio_add_page() and ASSERT(), with extra
  comment on we can not use __bio_add_page().

- Various minor commit message update
  And full proper test runs.

Christoph Hellwig (8):
  btrfs: remove the alignment checks in end_bbio_data_read
  btrfs: track the next file offset in struct btrfs_bio_ctrl
  btrfs: pass a physical address to btrfs_repair_io_failure
  btrfs: move kmapping out of btrfs_check_sector_csum
  btrfs: simplify bvec iteration in index_one_bio
  btrfs: raid56: store a physical address in structure sector_ptr
  btrfs: scrub: use virtual addresses directly
  btrfs: use bvec_kmap_local in btrfs_decompress_buf2page

 fs/btrfs/bio.c         |   9 +-
 fs/btrfs/bio.h         |   3 +-
 fs/btrfs/btrfs_inode.h |   4 +-
 fs/btrfs/compression.c |   9 +-
 fs/btrfs/disk-io.c     |   7 +-
 fs/btrfs/extent_io.c   |  60 ++++---------
 fs/btrfs/inode.c       |  20 ++---
 fs/btrfs/raid56.c      | 189 ++++++++++++++++++++++-------------------
 fs/btrfs/scrub.c       |  93 +++++++++-----------
 9 files changed, 184 insertions(+), 210 deletions(-)

-- 
2.49.0


