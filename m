Return-Path: <linux-btrfs+bounces-16427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E1B37491
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF1E7C5676
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F02299923;
	Tue, 26 Aug 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uFEEYZ+U";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uFEEYZ+U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5D72605
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245366; cv=none; b=BztgumGVe4it+f69pu8g2OMPSVzyYD6PG5zcidzFOmAB4aLgjvNQI0SAvgobkk95tXzaQkJ6+0Hy2VXp29Qh7ClMyqNkROV4dxXpSac4m+QVTjbjo1uaBTRJL2D8WpECVFJC07ofur1ak7qmM52DKRhZFcYXOSby0kBTn++C/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245366; c=relaxed/simple;
	bh=DlyxoM7j8ebm9DUGXRV8smtsOEdv4l6ilOSU8tLp1zM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K8g90LwjTN80FoxwcSHduIc87PbXoz9EGw2YU6EvzA63+nbVPPYYAo06fd2BUohTU/Y76QbCBYCcPdWx277NfgXhWeJYw+BFpfoE7HRUrXyV8GMS6SL73qfbjXsYenllS0Ez48/PIJsWzLC3s7VWoHXw5vQBeROSjr1/UycDUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uFEEYZ+U; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uFEEYZ+U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDBB15C45C;
	Tue, 26 Aug 2025 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756245362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KcMHfwOvq3Y9+rqqgOFsQsLkLWAsqqTk8wO0bBwdk2c=;
	b=uFEEYZ+UiLWTR0LWBjg1iuc1Sdjo9snr1G1/UPMeK2IzyJrvXMiH9pvGdlUYIAWN8kcTcj
	/+xCD6f38PIW+DCHwFN1lDLGAtVLsfRuoUXjCR32IRicOntZy2JVFhdLEr7Uvklg+GQyh4
	U5a6Tb9U6MnDNg9m6Uw9CPFqh9sP398=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756245362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KcMHfwOvq3Y9+rqqgOFsQsLkLWAsqqTk8wO0bBwdk2c=;
	b=uFEEYZ+UiLWTR0LWBjg1iuc1Sdjo9snr1G1/UPMeK2IzyJrvXMiH9pvGdlUYIAWN8kcTcj
	/+xCD6f38PIW+DCHwFN1lDLGAtVLsfRuoUXjCR32IRicOntZy2JVFhdLEr7Uvklg+GQyh4
	U5a6Tb9U6MnDNg9m6Uw9CPFqh9sP398=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6DDC13479;
	Tue, 26 Aug 2025 21:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p5mwHXEtrmjDTgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 26 Aug 2025 21:56:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: add a new test case to verify compressed read
Date: Wed, 27 Aug 2025 07:25:44 +0930
Message-ID: <20250826215544.7560-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index 00000000..17b804ea
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
+008000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
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


