Return-Path: <linux-btrfs+bounces-16430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1BB3774F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 03:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAEA7A9C1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 01:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98D1FDA9E;
	Wed, 27 Aug 2025 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTTs4yl5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTTs4yl5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B81CD208
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258994; cv=none; b=YNf1FHMSxIGkDtEvQH5GlfNwayMgFQP0zb7JA7wW5cjYhWzCHVZVh2W0vq/5wxatlRyoxcR5qhcl7nNqxlIsP6gnb4xioizbsOVzK3Lf1stZlofr8GHqPYSI66dNxsMHHvqWXSliGu63EZpM9UHuFXZMYv8baSBl4VKKVTgE4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258994; c=relaxed/simple;
	bh=blR0XwbWwwo6hqakEJhG/NjWjQfNhd0hrTFFLKzPVFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aANxgImHgqNS13xds3PU+bk0BMvR8tDIn5/7M9uh1L6oPSk75rJ8T1m1fVXbuWwVXzCIDRd/eLhXChEWisSYaVcq8YDbvHvubh2mpM2/g/O9Zx1mz/23Sseq25dXu/CqMptjOymrJui/BZBLyiwocHS5b3DSltbjSZ/VcAf7aZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NTTs4yl5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NTTs4yl5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 315B61F393;
	Wed, 27 Aug 2025 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756258989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L3LANSiJH+KYmLc5PcRnzYW8HOCpfOPtBAmDiptnpDM=;
	b=NTTs4yl5fxSFpr3XHVQNJj6zPl6Ey0AhnWtMO7VTQFEeoQ57xQew1jCwphR/HIJPRvAXcI
	VCGFGSGpcJt4WB0JBYuLZUHYzB2zS7hZcGmzHqUB4rvll2CB8chNJMrbf5EQ3exjiiDBFr
	UcUPbjEMhDIzFhJ9J4523AUmoptu4PE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NTTs4yl5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756258989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L3LANSiJH+KYmLc5PcRnzYW8HOCpfOPtBAmDiptnpDM=;
	b=NTTs4yl5fxSFpr3XHVQNJj6zPl6Ey0AhnWtMO7VTQFEeoQ57xQew1jCwphR/HIJPRvAXcI
	VCGFGSGpcJt4WB0JBYuLZUHYzB2zS7hZcGmzHqUB4rvll2CB8chNJMrbf5EQ3exjiiDBFr
	UcUPbjEMhDIzFhJ9J4523AUmoptu4PE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3363E13867;
	Wed, 27 Aug 2025 01:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SneeOatirmhtDAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 27 Aug 2025 01:43:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v3] fstests: btrfs: add a new test case to verify compressed read
Date: Wed, 27 Aug 2025 11:12:50 +0930
Message-ID: <20250827014250.170552-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 315B61F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
X-Spam-Score: -3.01

The new test case is a regression test related to the block size < page
size handling of compressed read.

The test case will only be triggered with 64K page size and 4K btrfs
block size.
I'm using aarch64 with 64K page size to trigger the regression.

The test case will create the following file layout:

  base:
  [0, 64K): Single compressed data extent at bytenr X.

  new:
  [0, 32K): Reflinked from base [32K, 64K)
  [32K, 60K): Reflinked from base [0, 28K)
  [60K, 64K): New 4K write

  The range [0, 32K) and [32K, 64K) are pointing to the same compressed
  data.

  The last 4K write is a special workaround. It is a block aligned
  write, thus it will create the folio but without reading out the
  remaing part.

  This is to avoid readahead path, which has the proper fix.
  We want single folio read without readahead.

Then output the file "new" just after the last 4K write, then cycle
mount and output the content again.

For patched kernel, or with 4K page sized system, the test will pass,
the resulted content will not change during mount cycles.

For unpatched kernel and with 64K page size, the test will fail, the
content after the write will be incorrect (the range [32K, 60K) will be
zero), but after a mount cycle the content is correct again.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Fix the golden output which is generated by an unpatched kernel

v2:
- Remove the unnecessary sync inherited from the kernel fix
- Use _hexdump instead of open-coded od dumps
- Use the correct 'clone' group instead of 'reflink'
- Minor grammar fixes
  All thanks to Filipe.
---
 tests/btrfs/337     | 55 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out | 23 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/btrfs/337
 create mode 100644 tests/btrfs/337.out

diff --git a/tests/btrfs/337 b/tests/btrfs/337
new file mode 100755
index 00000000..9c409e4d
--- /dev/null
+++ b/tests/btrfs/337
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 337
+#
+# Test compressed read with shared extents, especially for bs < ps cases.
+#
+. ./common/preamble
+_begin_fstest auto quick compress clone
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix corruption reading compressed range when block size is smaller than page size"
+
+. ./common/filter
+. ./common/reflink
+
+_require_btrfs_support_sectorsize 4096
+_require_scratch_reflink
+
+# The layout used in the test case is all 4K based, and can only be reproduced
+# with page size larger than 4K.
+_scratch_mkfs -s 4k >> $seqres.full
+_scratch_mount "-o compress"
+
+# Create the reflink source, which must be a compressed extent.
+$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
+		-c "pwrite -S 0xf0 32K 32K" \
+		$SCRATCH_MNT/base >> $seqres.full
+echo "Reflink source:"
+_hexdump $SCRATCH_MNT/base
+
+# Create the reflink dest, which reverses the order of the two 32K ranges.
+#
+# And do a further aligned write into the last block.
+# This write is to make sure the folio exists in filemap, so that we won't go
+# through the readahead path (which has the proper handling) for the folio.
+$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
+		-c "reflink $SCRATCH_MNT/base 0 32K 32K" \
+		-c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
+
+# This will result an incorrect output for unpatched kernel.
+# The range [32K, 60K) will be zero due to incorrectly merged compressed read.
+echo "Before mount cycle:"
+_hexdump $SCRATCH_MNT/new
+
+_scratch_cycle_mount
+
+# This will go through readahead path, which has the proper handling, thus give
+# the correct content.
+echo "After mount cycle:"
+_hexdump $SCRATCH_MNT/new
+
+status=0
+_exit 0
diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
new file mode 100644
index 00000000..cecbbbcf
--- /dev/null
+++ b/tests/btrfs/337.out
@@ -0,0 +1,23 @@
+QA output created by 337
+Reflink source:
+000000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
+*
+008000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
+*
+010000
+Before mount cycle:
+000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
+*
+008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
+*
+00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
+*
+010000
+After mount cycle:
+000000 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0  >................<
+*
+008000 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f  >................<
+*
+00f000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
+*
+010000
-- 
2.49.0


