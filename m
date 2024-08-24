Return-Path: <linux-btrfs+bounces-7473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF295DD62
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 12:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B251F22515
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Aug 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E8155CAC;
	Sat, 24 Aug 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N/heGgVO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N/heGgVO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2871EEB5;
	Sat, 24 Aug 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724495460; cv=none; b=FSeXcg4a4el6hZ4hhaDSvPg4+L4AVukCkotA/Eqra0nXT7SOUm4OfAAQNQK06epvzlMNTpeGw7gJ6jGHBKpuPGWrcFeaxTFWYa8oXpCYYhnPc0tTN8wl7wccxF5v9GqB8fKxo4ixPX9RwDKSgs54rMCTurVoNLJl1MX9APDaf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724495460; c=relaxed/simple;
	bh=i1KDoprvcrdWkgHYZt/QV7oULE4Y7kgX9hRPfLuTaCw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fgHEL5EwR4SVCzLO3WOAi27JJ+Y/amzC//Ld1eHxvOOZKvQ/EDN1RQXyRmDi/iF7fY/7CUk/WkHwrQa1LR443DBs0wjHaQ8Mu9iI1Hy9omJnpwNlSezr+9h+I8LCfwH7W4WdgusZWgZQs0YBYaCTSpVunoVt4oKFRFuvrATK1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N/heGgVO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N/heGgVO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CF7921A28;
	Sat, 24 Aug 2024 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724495455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j2bd8iPMHYa9YUXjjYIiYm/B5x012eqsUuLjfxUwMl8=;
	b=N/heGgVOPzqUgnxGviAKwV56IFWc4GTFy3igxsdc26mMcr5+10XopNLgsKcnRQa2jPDvgy
	RrjVduyy+RbWwgGtRrkfIB0Hc7b1BR2F9stte7B0RnxT340cQpvrTae4gX4mbHXwT/ZTpk
	g5CenVtNqAF8W4N9IqzyN+tf1NHP7hY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724495455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j2bd8iPMHYa9YUXjjYIiYm/B5x012eqsUuLjfxUwMl8=;
	b=N/heGgVOPzqUgnxGviAKwV56IFWc4GTFy3igxsdc26mMcr5+10XopNLgsKcnRQa2jPDvgy
	RrjVduyy+RbWwgGtRrkfIB0Hc7b1BR2F9stte7B0RnxT340cQpvrTae4gX4mbHXwT/ZTpk
	g5CenVtNqAF8W4N9IqzyN+tf1NHP7hY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E07113A1F;
	Sat, 24 Aug 2024 10:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a3CNL122yWYHLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 24 Aug 2024 10:30:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: a new test case to verify a use-after-free bug
Date: Sat, 24 Aug 2024 20:00:21 +0930
Message-ID: <20240824103021.264856-1-wqu@suse.com>
X-Mailer: git-send-email 2.46.0
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
There is a use-after-free bug triggered very randomly by btrfs/125.

If KASAN is enabled it can be triggered on certain setup.
Or it can lead to crash.

[CAUSE]
The test case btrfs/125 is using RAID5 for metadata, which has a known
RMW problem if the there is some corruption on-disk.

RMW will use the corrupted contents to generate a new parity, losing the
final chance to rebuild the contents.

This is specific to metadata, as for data we have extra data checksum,
but the metadata has extra problems like possible deadlock due to the
extra metadata read/recovery needed to search the extent tree.

And we know this problem for a while but without a better solution other
than avoid using RAID56 for metadata:

>   Metadata
>       Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
>       respectively.

Combined with the above csum tree corruption, since RAID5 is stripe
based, btrfs needs to split its read bios according to stripe boundary.
And after a split, do a csum tree lookup for the expected csum.

But if that csum lookup failed, in the error path btrfs doesn't handle
the split bios properly and lead to double freeing of the original bio
(the one containing the bio vectors).

[NEW TEST CASE]
Unlike the original btrfs/125, which is very random and picky to
reproduce, introduce a new test case to verify the specific behavior by:

- Create a btrfs with enough csum leaves
  To bump the csum tree level, use the minimal nodesize possible (4K).
  Writing 32M data which needs at least 8 leaves for data checksum

- Find the last csum tree leave and corrupt it

- Read the data many times until we trigger the bug or exit gracefully
  With an x86_64 VM (which is never able to trigger btrfs/125 failure)
  with KASAN enabled, it can trigger the KASAN report in just 4
  iterations (the default iteration number is 32).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the wrong commit hash
  The proper fix is not yet merged, the old hash is a place holder
  copied from another test case but forgot to remove.

- Minor wording update

- Add to "dangerous" group
---
 tests/btrfs/319     | 84 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/319.out |  2 ++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/319
 create mode 100644 tests/btrfs/319.out

diff --git a/tests/btrfs/319 b/tests/btrfs/319
new file mode 100755
index 00000000..4be2b50b
--- /dev/null
+++ b/tests/btrfs/319
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 319
+#
+# Make sure data csum lookup failure will not lead to double bio freeing
+#
+. ./common/preamble
+_begin_fstest auto quick dangerous
+
+_require_scratch
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
+
+# The final fs will have a corrupted csum tree, which will never pass fsck
+_require_scratch_nocheck
+_require_scratch_dev_pool 2
+
+# Use RAID0 for data to get bio splitted according to stripe boundary.
+# This is required to trigger the bug.
+_check_btrfs_raid_type raid0
+
+# This test goes 4K sectorsize and 4K nodesize, so that we easily create
+# higher level of csum tree.
+_require_btrfs_support_sectorsize 4096
+
+# The bug itself has a race window, run this many times to ensure triggering.
+# On an x86_64 VM with KASAN enabled, normally it is triggered before the 10th run.
+runtime=32
+
+_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
+# This test requires data checksum to trigger the bug.
+_scratch_mount -o datasum,datacow
+
+# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M data
+# will need 32K data checksum at minimal, which is at least 8 leaves.
+_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
+sync
+_scratch_unmount
+
+# Search for the last leaf of the csum tree, that will be the target to destroy.
+$BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV >> $seqres.full
+target_bytenr=$($BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
+
+if [ -z "$target_bytenr" ]; then
+	_fail "unable to locate the last csum tree leave"
+fi
+
+echo "bytenr of csum tree leave to corrupt: $target_bytenr" >> $seqres.full
+
+# Corrupt that csum tree block.
+physical=$(_btrfs_get_physical "$target_bytenr" 1)
+dev=$(_btrfs_get_device_path "$target_bytenr" 1)
+
+echo "physical bytenr: $physical" >> $seqres.full
+echo "physical device: $dev" >> $seqres.full
+
+_pwrite_byte 0x00 "$physical" 4 "$dev" > /dev/null
+
+for (( i = 0; i < $runtime; i++ )); do
+	echo "=== run $i/$runtime ===" >> $seqres.full
+	_scratch_mount -o ro
+	# Since the data is on RAID0, read bios will be split at the stripe
+	# (64K sized) boundary. If csum lookup failed due to corrupted csum
+	# tree, there is a race window that can lead to double bio freeing
+	# (triggering KASAN at least).
+	cat "$SCRATCH_MNT/foobar" &> /dev/null
+	_scratch_unmount
+
+	# Manually check the dmesg for "BUG", and do not call _check_dmesg()
+	# as it will clear 'check_dmesg' file and skips the final check after
+	# the test.
+	# For now just focus on the "BUG:" line from KASAN.
+	if _check_dmesg_for "BUG" ; then
+		_fail "Critical error(s) found in dmesg"
+	fi
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
new file mode 100644
index 00000000..d40c929a
--- /dev/null
+++ b/tests/btrfs/319.out
@@ -0,0 +1,2 @@
+QA output created by 319
+Silence is golden
-- 
2.46.0


