Return-Path: <linux-btrfs+bounces-1856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970883F003
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C40283ECD
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398E17BA3;
	Sat, 27 Jan 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S7SaeCJ3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S7SaeCJ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CF14AAE;
	Sat, 27 Jan 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706388286; cv=none; b=WzH3rpwq8QVwhReJl2pVLpiEe7MIJ71wNb9fFcgY0fK685yuft0xy37KvhPG6mYbZM5QfZ9oRQoby9TxKuTATS9Dz/kKfTcru/Lig9wgEptks7hZfw/GuB4UizmBTaxWAByikj8wx+8P6kAU/+FdF4Ei9Rr6DG4Rhoyffjv7fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706388286; c=relaxed/simple;
	bh=et05MBeBLjOGvTD4CdjRQuT9lahPDzzoReNVExkfhLg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cw1y/9s+TZ7q0R5yV2RRxOkc0vesANyV54OtdjSufEFTB5bOr2aSyf6wzD6t0eK7UqTCCPEA2Y4LAuhIFkOGObf50gK2TqkoSyhxMtrSm4l0aUZ7DzYTlr7a8TRTZ/FGwPVbO3XWZf9Qp4/v+LVbwrOYTAAebGplCF9ys669+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S7SaeCJ3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S7SaeCJ3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 06AD221E77;
	Sat, 27 Jan 2024 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706388276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3+Wnnwt+b1edc5CO4paTxNcGAJPoMyZ5f+/EzivmTZQ=;
	b=S7SaeCJ3VWG66IRdkm+gurQz0KOZTJSAogt7IbcW8Ahmkf8ARZcODU3zkDtRn6RIL11B7y
	M7JIOKl/+rNk/YYaVG98DMlNUpEnqn5oQWmB2f87s/DsikqGkD0kSZucOv7flR49qa1ogA
	MLUcRTzGXOhTt09YSCZXnJYRYuKovac=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706388276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3+Wnnwt+b1edc5CO4paTxNcGAJPoMyZ5f+/EzivmTZQ=;
	b=S7SaeCJ3VWG66IRdkm+gurQz0KOZTJSAogt7IbcW8Ahmkf8ARZcODU3zkDtRn6RIL11B7y
	M7JIOKl/+rNk/YYaVG98DMlNUpEnqn5oQWmB2f87s/DsikqGkD0kSZucOv7flR49qa1ogA
	MLUcRTzGXOhTt09YSCZXnJYRYuKovac=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F27E81329F;
	Sat, 27 Jan 2024 20:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UXwhLDJrtWVzTwAAn2gu4w
	(envelope-from <wqu@suse.com>); Sat, 27 Jan 2024 20:44:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: verify the read behavior of compressed inline extent
Date: Sun, 28 Jan 2024 07:14:17 +1030
Message-ID: <20240127204417.11880-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
There is a report about reading a zstd compressed inline file extent
would lead to either a VM_BUG_ON() crash, or lead to incorrect file
content.

[CAUSE]
The root cause is a incorrect memcpy_to_page() call, which uses
incorrect page offset, and can lead to either the VM_BUG_ON() as we may
write beyond the page boundary, or writes into the incorrect offset of
the page.

[TEST CASE]
The test case would:

- Mount with the specified compress algorithm
- Create a 4K file
- Verify the 4K file is all inlined and compressed
- Verify the content of the initial write
- Cycle mount to drop all the page cache
- Verify the content of the file again
- Unmount and fsck the fs

This workload would be applied to all supported compression algorithms.
And it can catch the problem correctly by triggering VM_BUG_ON(), as our
workload would result decompressed extent size to be 4K, and would
trigger the VM_BUG_ON() 100%.
And with the revert or the new fix, the test case can pass safely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/310     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  2 ++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out
---
Changelog:
v2:
- Add a comment on why a "sync" is needed
- Update the failure case comment
  The specific design of the inline extent size is ensured to trigger
  VM_BUG_ON(), thus remove the data corruption case.

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 00000000..507485a4
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 310
+#
+# Make sure reading on an compressed inline extent is behaving correctly
+#
+. ./common/preamble
+_begin_fstest auto quick compress
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+# This test require inlined compressed extents creation, and all the writes
+# are designed for 4K sector size.
+_require_btrfs_inline_extents_creation
+_require_btrfs_support_sectorsize 4096
+
+_fixed_by_kernel_commit e01a83e12604 \
+	"Revert \"btrfs: zstd: fix and simplify the inline extent decompression\""
+
+# The correct md5 for the correct 4K file filled with "0xcd"
+md5sum_correct="5fed275e7617a806f94c173746a2a723"
+
+workload()
+{
+	local algo="$1"
+
+	echo "=== Testing compression algorithm ${algo} ===" >> $seqres.full
+	_scratch_mkfs >> $seqres.full
+	_scratch_mount -o compress=${algo}
+
+	_pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
+	result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
+	echo "after initial write, md5sum=${result}" >> $seqres.full
+	if [ "$result" != "$md5sum_correct" ]; then
+		_fail "initial write results incorrect content for \"$algo\""
+	fi
+	# Writeback data to get correct fiemap result, or we got FIEMAP_DEALLOC
+	# without compression/inline flags.
+	sync
+
+	$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n 1 > $tmp.fiemap
+	cat $tmp.fiemap >> $seqres.full
+	# Make sure we got an inlined compressed file extent.
+	# 0x200 means inlined, 0x100 means not block aligned, 0x8 means encoded
+	# (compressed in this case), and 0x1 means the last extent.
+	if ! grep -q "0x309" $tmp.fiemap; then
+		rm -f -- $tmp.fiemap
+		_notrun "No compressed inline extent created, maybe subpage?"
+	fi
+	rm -f -- $tmp.fiemap
+
+	# Unmount to clear the page cache.
+	_scratch_cycle_mount
+
+	# For v6.8-rc1 without the revert or the newer fix, this would
+	# lead to VM_BUG_ON() thus crash
+	result=$(_md5_checksum "$SCRATCH_MNT/inline_file")
+	echo "after cycle mount, md5sum=${result}" >> $seqres.full
+	if [ "$result" != "$md5sum_correct" ]; then
+		_fail "read for compressed inline extent failed for \"$algo\""
+	fi
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+algo_list=($(_btrfs_compression_algos))
+for algo in ${algo_list[@]}; do
+	workload $algo
+done
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
new file mode 100644
index 00000000..7b9eaf78
--- /dev/null
+++ b/tests/btrfs/310.out
@@ -0,0 +1,2 @@
+QA output created by 310
+Silence is golden
-- 
2.42.0


