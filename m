Return-Path: <linux-btrfs+bounces-9684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0719CDB64
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 10:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92C01F21F41
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BD18FDA9;
	Fri, 15 Nov 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iMtKBObL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iMtKBObL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B06189F39;
	Fri, 15 Nov 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662393; cv=none; b=tSNqTgXjdS7nhAnOQlgtYt7NEhbkhCItf6Z6of+BP8sQkmoDoyBivweoB0mFVv833/L+mmHlUAKIOpUBXJIryKxyfVg6PQonqwuJM769ZA4Ou57SCt8WGM6qz4C1+WlbWJ226Ii92xrA00QTmiNb5oFHO1D91RvpCsZT1wGc48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662393; c=relaxed/simple;
	bh=xDKowZfzuQlfGDqCe1JXTFqYxcBrR5OHTVFEXaRC72A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hZRkeZReFiFobRPzJgqBpQTfWoJZOzd7ZwVZwao+mTbnds3GhqeJ4NbShlWwM4vthoWoHTkMHUgtrzRYluYONBm7TnnIAq9B6EM+Fs9xzdb2cl0rT4QNggaS9lb1N5a1heeHzIUPk2QOJUCZ854tkPf/XbuLkWxVkuDgz6BP+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iMtKBObL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iMtKBObL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586B81F750;
	Fri, 15 Nov 2024 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731662389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nWMcFZFec5tgShlvJNyBry+yTFhC7vNfcrU3Vnuwc9Y=;
	b=iMtKBObLXCEQz3QJuNrhV4G2fpniIT14EitSYXilnsAS2YJXQyDhAYHb6AqgjG9QfewiaW
	brjVWBwSSq7HTW4wS0XZmk62UhgEMUqjYnLOCxDXzRs0ar3/Pk8XpbawOY8/+PfFloq385
	htjEUoCqiMWrqlEU//r3aA1dQqO4DAA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731662389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nWMcFZFec5tgShlvJNyBry+yTFhC7vNfcrU3Vnuwc9Y=;
	b=iMtKBObLXCEQz3QJuNrhV4G2fpniIT14EitSYXilnsAS2YJXQyDhAYHb6AqgjG9QfewiaW
	brjVWBwSSq7HTW4wS0XZmk62UhgEMUqjYnLOCxDXzRs0ar3/Pk8XpbawOY8/+PfFloq385
	htjEUoCqiMWrqlEU//r3aA1dQqO4DAA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30A1913485;
	Fri, 15 Nov 2024 09:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ayNxNjMSN2fPQAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 15 Nov 2024 09:19:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/327: add a test case to verify inline extent data read
Date: Fri, 15 Nov 2024 19:49:26 +1030
Message-ID: <20241115091926.101742-1-wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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
When developing sector size < page size handling for btrfs, I'm hitting
a data corruption, which is only possible with the following out-of-tree
patches:

  btrfs: allow inline data extents creation if sector size < page size
  btrfs: allow buffered write to skip full page if it's sector aligned

[CAUSE]
Thankfully no upstream kernels are affected, even if some one is
mounting a btrfs created by x86_64 with inlined data extents, they won't
hit the corruption.

The root cause is that when reading inline extents, we zero out the
whole remaining range until folio end.

This means such zeroing out can cover ranges that is dirtied but not yet
written back, thus lead to data corruption.

This needs all the following conditions to be met:

- Sector size < page size
  So no x86_64 is affected. The most common users should be Asahi Linux.
  But they are safe due to the next two conditions.

- Inline data extents are present
  For sector size < page size cases, we do not allow creating new inline
  data extents but only reading it.

  But even all above cases are met by using a x86_64 created btrfs with
  inlined data extents, the next point will still save us.

- Partial uptodate folios are allowed
  This requires the out-of-tree patch "btrfs: allow buffered write to skip
  full page if it's sector aligned", or buffered write will read out the
  whole folio before dirting any range.

So end users are completely safe.

[TEST CASE]
The test case itself is pretty straightforward:

- Buffered write [0, 4k)
- Drop all page cache
- Buffered write [8k, 12k)
- Verify the file content

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
For anyone who wants to verify the failure, please fetch the following
branch, and reset to commit 4df35fbb829dfbcf64a914e5c8f652d9a3ad5227
("btrfs: allow inline data extents creation if sector size < page
size").

 https://github.com/adam900710/linux.git subpage

The top commit e7338d321bdf48e3b503c40e8eca7d7592709c83
("btrfs: fix inline data extent reads which zero out the remaining part") is the fix.
---
 tests/btrfs/327     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/327.out |  2 ++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/btrfs/327
 create mode 100644 tests/btrfs/327.out

diff --git a/tests/btrfs/327 b/tests/btrfs/327
new file mode 100755
index 00000000..72269fc7
--- /dev/null
+++ b/tests/btrfs/327
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 327
+#
+# Make sure reading inlined extents doesn't cause any corruption.
+#
+# This is a preventive test case inspired by btrfs/149, which can cause
+# data corruption when the following out-of-tree patches are applied and
+# the sector size is smaller than page size:
+#
+#  btrfs: allow inline data extents creation if sector size < page size
+#  btrfs: allow buffered write to skip full page if it's sector aligned
+#
+# Thankfully no upstream kernel is affected.
+
+. ./common/preamble
+_begin_fstest auto quick compress
+
+_require_scratch
+
+# We need 4K sector size support, especially this case can only be triggered
+# with sector size < page size for now.
+#
+# We do not check the page size and not_run so far, as in the long term btrfs
+# will support larger folios, then in that future 4K page size should be enough
+# to trigger the bug.
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o compress,max_inline=4095"
+
+# Create one inlined data extent, only when using compression we can
+# create an inlined data extent up to sectorsize.
+# And for sector size < page size cases, we need the out-of-tree patch
+# "btrfs: allow inline data extents creation if sector size < page size" to
+# create such extent.
+xfs_io -f -c "pwrite 0 4k" "$SCRATCH_MNT/foobar" > /dev/null
+
+# Drop the cache, we need to read out the above inlined data extent.
+echo 3 > /proc/sys/vm/drop_caches
+
+# Write into range [8k, 12k), with the out-of-tree patch "btrfs: allow
+# buffered write to skip full page if it's sector aligned", such write will not
+# trigger the read on the folio.
+xfs_io -f -c "pwrite 8k 4k" "$SCRATCH_MNT/foobar" > /dev/null
+
+# Verify the checksum, for the affected devel branch, the read of inline extent
+# will zero out all the remaining range of the folio, screwing up the content
+# at [8K, 12k).
+_md5_checksum "$SCRATCH_MNT/foobar"
+
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/327.out b/tests/btrfs/327.out
new file mode 100644
index 00000000..aebf8c72
--- /dev/null
+++ b/tests/btrfs/327.out
@@ -0,0 +1,2 @@
+QA output created by 327
+277f3840b275c74d01e979ea9d75ac19
-- 
2.46.0


