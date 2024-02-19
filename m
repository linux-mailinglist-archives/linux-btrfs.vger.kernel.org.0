Return-Path: <linux-btrfs+bounces-2481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49849859BDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 07:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10901F219A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63838200C8;
	Mon, 19 Feb 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A2UauhDM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A2UauhDM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E221CD0F
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322927; cv=none; b=sZrso0/vdc1Vv/8A7LW0v/Dyw/lsKmCqUGVwJ9UbbxWUuNTYkGGpouI8Quz8SSRIjW/L1VeMiBZAPfkXslcl3/RryApw7Hi2zrEW1w0R4EpOgZRlGSzHbi8JTblEFFwZ22MOHRo63g0Rx/U51Jc6QBbUQvyRT6sKcUZnku1hXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322927; c=relaxed/simple;
	bh=HdI+pnsuzNc3PlPgc7r5VQWblJTt0UmGT08lnlY0Rig=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tfuLUTsiFgyvWRnKnjO+wlWwHUYNRcvvGBsYvyo8G6OG2vFHSiRR4pmGfeycx0aKRv8MHdQgFP0zOlrfp+6T3UMtT/rIDKSSRWTxs231LSCrVX3SKydGgLYt8kbme7co6XuvYrD9H4f2QU86XSfIcoAvnqlv8Fei0vFX8IXFwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A2UauhDM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A2UauhDM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 239081FD04
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FvseK5ItHIRHKhTtp9Ul+Obp7gCVshHUt36onQkSxDs=;
	b=A2UauhDM+Cq2VBjSu7iQlcZ7d6qqswVY8kmsFpGty3jHd89IOhxsJejdtS+KNh6EFEYA/y
	lIyE/5u7oRpnmD8R3ZGccSMarJc5xTc0b9ULyoXc7mAEvp8KBrWB2gwcjB0xGuVaGZNBCC
	QGPDvGcNSjJjfV+Xgssp3gtePGdey/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FvseK5ItHIRHKhTtp9Ul+Obp7gCVshHUt36onQkSxDs=;
	b=A2UauhDM+Cq2VBjSu7iQlcZ7d6qqswVY8kmsFpGty3jHd89IOhxsJejdtS+KNh6EFEYA/y
	lIyE/5u7oRpnmD8R3ZGccSMarJc5xTc0b9ULyoXc7mAEvp8KBrWB2gwcjB0xGuVaGZNBCC
	QGPDvGcNSjJjfV+Xgssp3gtePGdey/I=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 260A513585
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id N1V3NWjw0mXcJQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: initial subpage support for zoned devices
Date: Mon, 19 Feb 2024 16:38:33 +1030
Message-ID: <cover.1708322044.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A2UauhDM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 239081FD04
X-Spam-Flag: NO

[REPO]
https://github.com/adam900710/linux/tree/subpage_delalloc

Please fetch the whole series for testing, as it relies on 3 submitted
patches.

[BUG]
When running subpage btrfs (sectorsize < PAGE_SIZE) with zoned device,
btrfs can easily crash (with CONFIG_BTRFS_ASSERT enabled) with an
ASSERT():

 assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1384
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/extent_io.c:1384!
 CPU: 2 PID: 1711 Comm: fsstress Tainted: G           OE      6.8.0-rc4-custom+ #9
 Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20231122-12.fc39 11/22/2023
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __extent_writepage_io+0x404/0x460 [btrfs]
 lr : __extent_writepage_io+0x404/0x460 [btrfs]
 Call trace:
  __extent_writepage_io+0x404/0x460 [btrfs]
  extent_write_locked_range+0x16c/0x460 [btrfs]
  run_delalloc_cow+0x88/0x118 [btrfs]
  btrfs_run_delalloc_range+0x128/0x228 [btrfs]
  writepage_delalloc+0xb8/0x178 [btrfs]
  __extent_writepage+0xc8/0x3a0 [btrfs]
  extent_write_cache_pages+0x1cc/0x460 [btrfs]
  extent_writepages+0x8c/0x120 [btrfs]
  btrfs_writepages+0x18/0x30 [btrfs]
  do_writepages+0x94/0x1f8
  filemap_fdatawrite_wbc+0x88/0xc8
  __filemap_fdatawrite_range+0x6c/0xa8
  filemap_flush+0x24/0x38
  btrfs_remap_file_range_prep+0x100/0x1a8 [btrfs]
  btrfs_remap_file_range+0x2ec/0x448 [btrfs]
  vfs_copy_file_range+0x4cc/0x520
  __do_sys_copy_file_range+0xc4/0x2e8
  __arm64_sys_copy_file_range+0x30/0xd0
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x48/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x3c/0x138
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x194/0x198
 Code: 9108c021 90000be0 913d8000 9402bfad (d4210000)
 ---[ end trace 0000000000000000 ]---

[CAUSE]
There are several problems involved in this case:

- __extent_writepage_io() would always try writeback the whole page
- extent_write_locked_range() would only lock the first delalloc range

This two limits combined, result the following page cache layout to
cause the problem:

     0     4K     8K    12K    16K
     |/////|      |/////|

- btrfs_run_delalloc_range() called on the above page
- run_dealloc_cow() ran for range [0, 4K)
- __extent_writepage_io() called for the whole page
- __extent_writepage_io() submitted bio for [0, 4K)
- __extent_writepage_io() try to submit IO for [8K, 12K)
  But this range has no OE covered, and the existing extent map is a
  hole, and triggered the ASSERT().

  Even if we ignore the ASSERT(), we would still hit other problems.

- run_delalloc_cow() would unlock the full page.
- btrfs_run_delalloc_range() called again on the page
  The page is no longer locked, triggering another ASSERT() on
  PageLocked.

[FIX]
This series would try to fix the problem by:

- making __extent_writepage_io() to only write the specified range
- making writepage_delalloc() to lock all delalloc range first
  Then btrfs_run_delalloc_range() for each locked range.

  This patch is a temporaray solution, until needed subpage interfaces
  are introduced, and allowing me to do extra testing to make sure the
  lock-in-one-go behavior is safe.

  This is a preparation for allowing subpage delalloc async submission.

- adding subpage interfaces to go through all subpage locked ranges

- using new subpage interfaces to make sure the full page is only
  unlocked when the last writer lock owner is releasing the lock

But please note, this fix is only for the above mentioned problems.
There can still be other problems related to zoned+subpage, but at least
we won't trigger ASSERT()s and crash.

Qu Wenruo (4):
  btrfs: make __extent_writepage_io() to write specified range only
  btrfs: lock subpage ranges in one go for writepage_delalloc()
  btrfs: subpage: introduce helpers to handle subpage delalloc locking
  btrfs: migrate writepage_delalloc() to use subpage helpers

 fs/btrfs/extent_io.c |  95 +++++++++++++++++++++++-----
 fs/btrfs/subpage.c   | 144 +++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/subpage.h   |  10 ++-
 3 files changed, 228 insertions(+), 21 deletions(-)

-- 
2.43.2


