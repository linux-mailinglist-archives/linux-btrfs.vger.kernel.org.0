Return-Path: <linux-btrfs+bounces-7534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9B95FDEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76C1B213F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27C2CA9;
	Tue, 27 Aug 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pXSeHHzB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pXSeHHzB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81E2114;
	Tue, 27 Aug 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717666; cv=none; b=PEf7BmhyxHPpTTObb0iSUIq02sSSS9jfPn7YzXfAaO6g7+KfVU//lyWcUJiCLwpVFHHN4x5jYWImOhoVHGhJ4IVX/ECw59gptIDj1ir3VfwVCe26vReLUh9homDtT86fbXS2C+deguhfRSEzng2yHHAZ7beVAJukINQIzp74LQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717666; c=relaxed/simple;
	bh=4yiKCSGS+njy/pVc0nKFm4v4UKSAJd2XRmLKR9JlVgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hfBL2Ynlhhh4a6m0s1PzNIDXhaQO5W6yVHz691ZLzXyeXeEh4WX6e9e0aD+m3AxauJUFXn8A68y4VUmjuhG4kXcx/kB43qGGBPisvWpx9lfAFFGHff1IIx5Y96+S0g6PVi3divXGfcYXzVwz7ZufzC4yuJSr6EJmJIuEM8I7ILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pXSeHHzB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pXSeHHzB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDA01F8BF;
	Tue, 27 Aug 2024 00:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724717657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gRy7NvCilOydz0hez7g5sdwx+JbaEJQjzz4QeHct8qM=;
	b=pXSeHHzBW0f7Ww3Yr8ZgHD6ACwo04VEXOFrCzLlAojBteMk50xej8TVqeSE8Ruw7Sw3rEI
	urg3roK0bB9haH7PaufPoCTGK4GDMx8Bw7mocqE2JSoHUfY0lcH8Oxxh/qzZ3s72TGlEqZ
	kZ0Vn6jBBdNlf0oHQ+YFTB/yjlyPogQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724717657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gRy7NvCilOydz0hez7g5sdwx+JbaEJQjzz4QeHct8qM=;
	b=pXSeHHzBW0f7Ww3Yr8ZgHD6ACwo04VEXOFrCzLlAojBteMk50xej8TVqeSE8Ruw7Sw3rEI
	urg3roK0bB9haH7PaufPoCTGK4GDMx8Bw7mocqE2JSoHUfY0lcH8Oxxh/qzZ3s72TGlEqZ
	kZ0Vn6jBBdNlf0oHQ+YFTB/yjlyPogQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D80513408;
	Tue, 27 Aug 2024 00:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KmhtAFgazWaDBgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 27 Aug 2024 00:14:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v3] fstests: btrfs: test reading data with a corrupted checksum tree leaf
Date: Tue, 27 Aug 2024 09:43:54 +0930
Message-ID: <1b0c008b1b05a9fd24b751e174da37bd769637ff.1724717443.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
There is a bug report that, KASAN get triggered when:

- A read bio needs to be split
  This can happen for profiles with stripes, including
  RAID0/RAID10/RAID5/RAID6.

- An error happens before submitting the new split bio
  This includes:
  * chunk map lookup failure
  * data csum lookup failure

Then during the error path of btrfs_submit_chunk(), the original bio is
fully freed before submitted range has a chance to call its endio
function, resulting a use-after-free bug.

[NEW TEST CASE]
Introduce a new test case to verify the specific behavior by:

- Create a btrfs with enough csum leaves with data RAID0 profile
  To bump the csum tree level, use the minimal nodesize possible (4K).
  Writing 32M data which needs at least 8 leaves for data checksum

  RAID0 profile ensures the data read bios will get split.

- Find the last csum tree leave and corrupt it

- Read the data many times until we trigger the bug or exit gracefully
  With an x86_64 VM with KASAN enabled, it can trigger the KASAN report in
  just 4 iterations (the default iteration number is 32).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Remove the unrelated btrfs/125 references
  There is nothing specific to RAID56, it's just a coincident that
  btrfs/125 leads us to the bug.
  Since we have a more comprehensive understanding of the bug, there is
  no need to mention it at all.

- More grammar fixes
- Use proper _check_btrfs_raid_type() to verify raid0 support
- Update the title to be more specific about the test case
- Renumber to btrfs/321 to avoid conflicts with an new test case
- Remove unnecessary 'sync' which is followed by unmount
- Use full subcommand name "inspect-internal"
- Explain why we want to fail early if hitting the bug
- Remove unnecessary `_require_scratch` which is duplicated to
  `_require_scratch_nocheck`

v2:
- Fix the wrong commit hash
  The proper fix is not yet merged, the old hash is a place holder
  copied from another test case but forgot to remove.

- Minor wording update

- Add to "dangerous" group
---
 tests/btrfs/321     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/321.out |  2 ++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/321
 create mode 100644 tests/btrfs/321.out

diff --git a/tests/btrfs/321 b/tests/btrfs/321
new file mode 100755
index 000000000000..e30199daa0d0
--- /dev/null
+++ b/tests/btrfs/321
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 321
+#
+# Make sure there are no use-after-free, crashes, deadlocks etc, when reading data
+# which has its data checksums in a corrupted csum tree block.
+#
+. ./common/preamble
+_begin_fstest auto quick raid dangerous
+
+_require_scratch_nocheck
+_require_scratch_dev_pool 2
+
+# Use RAID0 for data to get bio split according to stripe boundary.
+# This is required to trigger the bug.
+_require_btrfs_raid_type raid0
+
+# This test goes 4K sectorsize and 4K nodesize, so that we easily create
+# higher level of csum tree.
+_require_btrfs_support_sectorsize 4096
+_require_btrfs_command inspect-internal dump-tree
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
+
+# The bug itself has a race window, run this many times to ensure triggering.
+# On an x86_64 VM with KASAN enabled, normally it is triggered before the 10th run.
+iterations=32
+
+_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
+# This test requires data checksum to trigger the bug.
+_scratch_mount -o datasum,datacow
+
+# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M data
+# will need 32K data checksum at minimal, which is at least 8 leaves.
+_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
+_scratch_unmount
+
+
+# Search for the last leaf of the csum tree, that will be the target to destroy.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV >> $seqres.full
+target_bytenr=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
+
+if [ -z "$target_bytenr" ]; then
+	_fail "unable to locate the last csum tree leaf"
+fi
+
+echo "bytenr of csum tree leaf to corrupt: $target_bytenr" >> $seqres.full
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
+for (( i = 0; i < $iterations; i++ )); do
+	echo "=== run $i/$iterations ===" >> $seqres.full
+	_scratch_mount -o ro
+	# Since the data is on RAID0, read bios will be split at the stripe
+	# (64K sized) boundary. If csum lookup failed due to corrupted csum
+	# tree, there is a race window that can lead to double bio freeing
+	# (triggering KASAN at least).
+	cat "$SCRATCH_MNT/foobar" &> /dev/null
+	_scratch_unmount
+
+	# Instead of relying on the final _check_dmesg() to find errors,
+	# error out immediately if KASAN is triggered.
+	# As non-triggering runs will generate quite some error messages,
+	# making investigation much harder.
+	if _check_dmesg_for "BUG" ; then
+		_fail "Critical error(s) found in dmesg"
+	fi
+done
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/321.out b/tests/btrfs/321.out
new file mode 100644
index 000000000000..290a5eb31312
--- /dev/null
+++ b/tests/btrfs/321.out
@@ -0,0 +1,2 @@
+QA output created by 321
+Silence is golden
-- 
2.46.0


