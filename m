Return-Path: <linux-btrfs+bounces-9196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E99B3E8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 00:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD5A1F23260
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 23:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA411FB89D;
	Mon, 28 Oct 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xj2JWTlY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xj2JWTlY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA01F8918;
	Mon, 28 Oct 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158564; cv=none; b=ZKJEd78RAxJgzsPJXcyBgL38vABGjPFr5/vojP3UJ07V7cF1dfYAdJFp5BQnn9mf6Aa17YHOfJrO1snlfvxc9kT8Ny4wissC5GMx+P4hpI+DfCpar808/siHl8nB3omrNYibcZwyVQ5Z4R6FIlGMJD0yr6d69zCi8nUA3Rf3bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158564; c=relaxed/simple;
	bh=3d/1UYJYM1tL/W1Xt6aZ1X/otEMXGm96IUmbUmAw+XU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o/TNB9GA4baDQQojFNkvk3EiV5LcLW+SdObSem54S1nAxKd4cee/0FJ64Olhgu0rUtyXzjLyGU7E089VDapsb++0t/SYLUBAkSuEW9/diCzOm2yqwRDdqF8lpYUy6So6avP8ppa0SQAkY6reQcE6NicMBvNQjqlGeSo+mfFAwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xj2JWTlY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xj2JWTlY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 567D41FDD8;
	Mon, 28 Oct 2024 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730158559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yFBFaUDXyPXX72ZNKTBbJw3otjnMchWwhqHr5W99jDg=;
	b=Xj2JWTlYg/mrcRMd7g7EakzwiIq77lD/1hGbLBAU7ijK0V9ATbxaecEBqDxjbihXIfGYaf
	QHaf2pOsVHH/KVI5+7rFfP6oM2F0oJndAleFYf7p1jjOZ5bjax/JbWWw620M9VIt8gadng
	qZdttpdAZoPdVV50xO2caA/zZirhTtE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Xj2JWTlY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730158559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yFBFaUDXyPXX72ZNKTBbJw3otjnMchWwhqHr5W99jDg=;
	b=Xj2JWTlYg/mrcRMd7g7EakzwiIq77lD/1hGbLBAU7ijK0V9ATbxaecEBqDxjbihXIfGYaf
	QHaf2pOsVHH/KVI5+7rFfP6oM2F0oJndAleFYf7p1jjOZ5bjax/JbWWw620M9VIt8gadng
	qZdttpdAZoPdVV50xO2caA/zZirhTtE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5908D136DC;
	Mon, 28 Oct 2024 23:35:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p9lGB94fIGelDQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 28 Oct 2024 23:35:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: generic/366: add a new test case to verify if certain fio load will hang the filesystem
Date: Tue, 29 Oct 2024 10:05:25 +1030
Message-ID: <20241028233525.30973-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 567D41FDD8
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
During the development to make btrfs pass generic/563 (which needs to
make btrfs to support partial folios), generic/095 causes hangs
during tests.

The call trace for the hanging process looks like this:

  __switch_to+0xf8/0x168
  __schedule+0x328/0x8a8
  schedule+0x54/0x140
  io_schedule+0x44/0x68
  folio_wait_bit_common+0x198/0x3f8
  __folio_lock+0x24/0x40
  extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
  btrfs_writepages+0x94/0x158 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  __filemap_fdatawrite_range+0x6c/0xa8
  filemap_fdatawrite_range+0x1c/0x30
  btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
  btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
  __get_extent_map+0xa0/0x220 [btrfs]
  btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
  btrfs_read_folio+0x50/0xa0 [btrfs]
  filemap_read_folio+0x54/0x110
  filemap_update_page+0x2e0/0x3b8
  filemap_get_pages+0x228/0x4d8
  filemap_read+0x11c/0x3b8
  btrfs_file_read_iter+0x74/0x90 [btrfs]
  new_sync_read+0xd0/0x1d0
  vfs_read+0x1a0/0x1f0

[CAUSE]
The root cause is a btrfs specific behavior that during a folio read, we
can trigger writeback of the same folio, which will try to lock the same
folio already locked by the read process.

The fix is already sent to the mailing list:
https://lore.kernel.org/linux-btrfs/62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com/

This problem can only happen if all the following conditions are met:

- The sector size of btrfs is smaller than page size
  To have partial uptodate folios.

- Btrfs won't read the full folio if buffered write is block aligned
  This is done by the not yet merged patch:
  https://lore.kernel.org/linux-btrfs/ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com/

[TEST CASE]
During the debugging of that generic/095 hang, I extracted a minimal
reproducer which is much smaller and faster, although it still requires
several runs to trigger a hang.

The test case will run the fio workload 32 times by default, which is
more than enough to trigger the hang.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the duplicated _fixed_by_kernel_commit line
- Fix a typo in the commit message
- Update the comments to show the workload and how it hangs btrfs
---
 tests/generic/366     | 106 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |   2 +
 2 files changed, 108 insertions(+)
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out

diff --git a/tests/generic/366 b/tests/generic/366
new file mode 100755
index 00000000..9d31c1c8
--- /dev/null
+++ b/tests/generic/366
@@ -0,0 +1,106 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 366
+#
+# Test if mixed direct read, direct write and buffered write on the same file will
+# hang the filesystem.
+#
+# This is exposed by an incoming btrfs feature, which allows a folio to be
+# partial uptodate if the buffered write range is block aligned but not yet
+# full folio aligned.
+#
+# Such behavior makes btrfs to hang reliably under generic/095.
+# This is the extracted minimal reproducer for 4k block size and 64K page size.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+_require_scratch
+_require_odirect
+_require_aio
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: avoid deadlock when reading a partial uptodate folio"
+
+iterations=$((32 * LOAD_FACTOR))
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+cat >$fio_config <<EOF
+[global]
+bs=8k
+iodepth=1
+randrepeat=1
+size=256k
+directory=$SCRATCH_MNT
+numjobs=1
+[job1]
+ioengine=sync
+bs=512
+direct=1
+rw=randread
+filename=file1
+[job2]
+ioengine=libaio
+rw=randwrite
+direct=1
+filename=file1
+[job3]
+ioengine=posixaio
+rw=randwrite
+filename=file1
+EOF
+_require_fio $fio_config
+
+for (( i = 0; i < $iterations; i++)); do
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount
+	# There's a known EIO failure to report collisions between directio and buffered
+	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
+	# at here.
+	#
+	# And for btrfs if sector size < page size, if we have a partial
+	# uptodate folio caused by a buffered write, e.g:
+	#
+	#    0          16K         32K          48K         64K
+	#    |                                   |///////////|
+	#					     \- sector Uptodate|Dirty
+	#
+	# Then writeback happens and finished, but btrfs' ordered extent not
+	# yet finished.
+	# In that case, the folio can be released from the page cache (since
+	# the folio is not under IO/lock).
+	#
+	# Then new buffered writes into the folio happened, re-dirty the folio:
+	#   0          16K         32K          48K         64K
+	#   |//////////|                        |///////////|
+	#      \- sector Uptodate|Dirty              \- No sector flags
+	#                                               extent map PINNED
+	#                                               OE still here
+	#
+	# Now read is triggered on that folio.
+	# Btrfs will need to wait for any existing ordered extents in the folio range,
+	# that wait will also trigger writeback if the folio is dirty.
+	# That writeback will happen for range [48K, 64K), but since the whole folio
+	# is locked for read, writeback will also try to lock the same folio, causing
+	# a deadlock.
+	$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out
+	# umount before checking dmesg in case umount triggers any WARNING or Oops
+	_scratch_unmount
+
+	_check_dmesg _filter_aiodio_dmesg
+
+	echo "=== fio $i/$iterations ===" >> $seqres.full
+	cat $fio_out >> $seqres.full
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/366.out b/tests/generic/366.out
new file mode 100644
index 00000000..1fe90e06
--- /dev/null
+++ b/tests/generic/366.out
@@ -0,0 +1,2 @@
+QA output created by 366
+Silence is golden
-- 
2.46.0


