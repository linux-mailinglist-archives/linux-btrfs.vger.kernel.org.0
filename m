Return-Path: <linux-btrfs+bounces-9188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966F9B2485
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 06:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB4BB22E14
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95418CC1F;
	Mon, 28 Oct 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z2DGIc5H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z2DGIc5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6D18C92E;
	Mon, 28 Oct 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094120; cv=none; b=BdJ163KdRTLXAmLN7TGPWUjK/Su355kkV/aSXhhAdWODaJHANGUZXPbaa/OdULsr8BQ8qLmMtRVDKujn6V3ZDIFW3Oo8SiqphP1+uV77hcvfR84YzUsSseyRQbhS3Qi55PWBVb4nYHFrTcdUVQolDVVgzacA4OQ35A20neuOwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094120; c=relaxed/simple;
	bh=xk+aGIEiIZz88+kCWEUF3noJb4a3fMo9jeuTVzGq+Nk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lFVrzCRn8alNH0jIGpcKefn4HiPAnlXtt5bPOtzpNbU3JLSLmIU672Dz2ezOj7/nFtGG/5UKsG8Vwd1YjZdObtLWPWf3ZF+rlDGgMpRNdGdrBHm6nfjKU4Tzj0Nzr3/ykVGJjIWDkbXjuuWVGo3ejId0OycyIpIUt06JFlrLDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z2DGIc5H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z2DGIc5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F4E61FD5A;
	Mon, 28 Oct 2024 05:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730094115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wLunHEG/KTBKRYvZmbrK7KnQj/G1ulmdSAvZSod8x9Y=;
	b=Z2DGIc5HGvRdMU3z6Tpjjd8EhNg2TXnXKyk7jWLoYjX9bISaGC75lx9brEp2jlfksY28dq
	70IR1yFsqiWyx8R2WpZGkjoGmtC5vpBQnqStm7UAQjNowdfFX2druX/yl/PYg3OLvmnPk5
	p3HmIpe4HElm+Lox27Vw7r6ySh1uqxk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730094115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wLunHEG/KTBKRYvZmbrK7KnQj/G1ulmdSAvZSod8x9Y=;
	b=Z2DGIc5HGvRdMU3z6Tpjjd8EhNg2TXnXKyk7jWLoYjX9bISaGC75lx9brEp2jlfksY28dq
	70IR1yFsqiWyx8R2WpZGkjoGmtC5vpBQnqStm7UAQjNowdfFX2druX/yl/PYg3OLvmnPk5
	p3HmIpe4HElm+Lox27Vw7r6ySh1uqxk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40D981361C;
	Mon, 28 Oct 2024 05:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4E8DASIkH2fyZgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 28 Oct 2024 05:41:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/366: add a new test case to verify if certain fio load will hang the filesystem
Date: Mon, 28 Oct 2024 16:11:21 +1030
Message-ID: <20241028054121.50985-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
During the development to make btrfs pass generic/563 (which needs to
make btrfs to support partial updaote folios), generic/095 causes hangs
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
 tests/generic/366     | 80 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |  2 ++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out

diff --git a/tests/generic/366 b/tests/generic/366
new file mode 100755
index 00000000..2ebc5728
--- /dev/null
+++ b/tests/generic/366
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 366
+#
+# Test if certain fio load will hang the filesystem.
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
+_fixed_by_kernel_commit fa630df665aa \
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


