Return-Path: <linux-btrfs+bounces-16361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA4B35A33
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 12:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5714B2A84EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B879E29D283;
	Tue, 26 Aug 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W1uj/1E1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W1uj/1E1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF92FAC1C
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204817; cv=none; b=n5XWXx6Rtf9KksKae8o+Weh5pzwSLv5cE3/b6J7PcUCXLWzhepB4+mmvmx/4gROX3K9Xkj+N0pvY6ttYfOi3k97pqz+dkTeU9BFaPjjf1aqaFFvL1JGC7tYrcrQExh6GPax9ascmnEjouWrV/BGi1ceOmvkPnrCWf/NNIPMLpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204817; c=relaxed/simple;
	bh=hs9eBPDABg4SIlafemijA244+wXru9HWJCNTORtQxmc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nr5uH7DORiaAP/6jniqnXC8ppB8HC9dZuYaSIzDF314FIf5vUCj4nK2NwOHQK0jJIWdugZ4shUOvfWik0ol0R2A4BkJlpN37kyaVfuAzQXpQdZ0rmskMaZYocsglYP9F00cfNu7Ti+jv25Z86gplyeZM+YgcirqIns1xJ1w7jgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W1uj/1E1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W1uj/1E1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD15A21262;
	Tue, 26 Aug 2025 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756204812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odwKUP99tCqLykUJEuVpKu9HxEdPL9jnr4wHrWNezxw=;
	b=W1uj/1E1Fb23u7GYTd4D8N5HvNJK3xtniOeOdmEinqdlKX0SvJ1JrCcknOGPvTn3TI21+4
	DevDfwjnDYSFNC5FyOdDCx2I/FKGzqyns1g8S0Rp5paWEASeJSpkWIK01K/u+2hHjxTE47
	aE0KUy43Ru5Bg9t7MmBJFmis34B70k0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756204812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odwKUP99tCqLykUJEuVpKu9HxEdPL9jnr4wHrWNezxw=;
	b=W1uj/1E1Fb23u7GYTd4D8N5HvNJK3xtniOeOdmEinqdlKX0SvJ1JrCcknOGPvTn3TI21+4
	DevDfwjnDYSFNC5FyOdDCx2I/FKGzqyns1g8S0Rp5paWEASeJSpkWIK01K/u+2hHjxTE47
	aE0KUy43Ru5Bg9t7MmBJFmis34B70k0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D408913A31;
	Tue, 26 Aug 2025 10:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bRIlJAuPrWimeAAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 26 Aug 2025 10:40:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a new test case to verify compressed read
Date: Tue, 26 Aug 2025 20:09:54 +0930
Message-ID: <20250826103954.26168-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
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
 tests/btrfs/337     | 56 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out | 23 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/btrfs/337
 create mode 100644 tests/btrfs/337.out

diff --git a/tests/btrfs/337 b/tests/btrfs/337
new file mode 100755
index 00000000..9cd2ea42
--- /dev/null
+++ b/tests/btrfs/337
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 337
+#
+# Test compressed read with shared extents, especially for bs < ps cases.
+#
+. ./common/preamble
+_begin_fstest auto quick compress reflink
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: do more strict compressed read merge check"
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
+		-c sync $SCRATCH_MNT/base >> $seqres.full
+echo "Reflink source:"
+echo "Reflink source:" >> $seqres.full
+od -t x1 $SCRATCH_MNT/base | _filter_od
+
+# Create the reflink dest, which reverse the order of the two 32K range.
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
+od -t x1 $SCRATCH_MNT/new | _filter_od
+
+_scratch_cycle_mount
+
+# This will go through readahead path, which has the proper handling, thus give
+# the correct content.
+echo "After mount cycle:"
+od -t x1 $SCRATCH_MNT/new | _filter_od
+
+status=0
+_exit 0
diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
new file mode 100644
index 00000000..d3e35863
--- /dev/null
+++ b/tests/btrfs/337.out
@@ -0,0 +1,23 @@
+QA output created by 337
+Reflink source:
+0 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
+*
+10 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
+*
+20
+Before mount cycle:
+0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
+*
+10 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
+*
+17 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+20
+After mount cycle:
+0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
+*
+10 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
+*
+17 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+20
-- 
2.49.0


