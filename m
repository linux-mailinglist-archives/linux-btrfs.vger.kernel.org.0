Return-Path: <linux-btrfs+bounces-2182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD184C0E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191562875DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C21CD2C;
	Tue,  6 Feb 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X9lVzmEL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X9lVzmEL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB21CD1B;
	Tue,  6 Feb 2024 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262233; cv=none; b=IX0exyy/HDz/ffrDqNE9eE0Zz7SfvkgyztPA8uutzK+/KpEt9ghgPuohahppw+ztfucyKTw1OU0e55GxypH5tVdsI9rOzTQp3X8gyfeK/W2SV99n/ywR2NPVWSrdjG8xPGCjVXVZQwAnwBSXLJ7N/IYBInpx67Yqx5VNg6rQurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262233; c=relaxed/simple;
	bh=vkm8D1E0V707Nwt5sJ0ehU22c1x7RUk7mL62jVbeEXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u1BI48sU3oahVfasYNmFhK7PvJXzdY0QZv+MJSCioa/88vmpkD8p2PuZlEgnBvLIQmXQQcVGClwhMTN8BZgr26ESunmTjT+POP3eo9KQZlojY/Zcg12zAe7BvUp7gPMlOsTXRcQBMKiIRXoNcR/Ncjz4lgKo00whbjKhm3kbuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X9lVzmEL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X9lVzmEL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1038A21F68;
	Tue,  6 Feb 2024 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707262228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l729SMBbcR+esyF+HcdG2tmSvyxNIX6h56j3YvjxIYM=;
	b=X9lVzmELV68WNn9RxqMWLkHVVrcQPkq3g6l+jjaE2Cy81HdYN2VSFpqHNkCscCiI8Poq91
	gy98Mk4DgIZdUtSn5i0dzX0Vrq6f4mCFlt2wNxSuc8iJ19Sg3vDz9wjLdU1LD/nedsbM6U
	ZiwE4AgeEnntM8I9O6hyk/4oYKl8IbE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707262228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l729SMBbcR+esyF+HcdG2tmSvyxNIX6h56j3YvjxIYM=;
	b=X9lVzmELV68WNn9RxqMWLkHVVrcQPkq3g6l+jjaE2Cy81HdYN2VSFpqHNkCscCiI8Poq91
	gy98Mk4DgIZdUtSn5i0dzX0Vrq6f4mCFlt2wNxSuc8iJ19Sg3vDz9wjLdU1LD/nedsbM6U
	ZiwE4AgeEnntM8I9O6hyk/4oYKl8IbE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F772132DD;
	Tue,  6 Feb 2024 23:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /bviMBLBwmXLVQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 06 Feb 2024 23:30:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: make sure defrag doesn't increase space usage
Date: Wed,  7 Feb 2024 10:00:24 +1030
Message-ID: <20240206233024.35399-1-wqu@suse.com>
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
There is a bug report that, the following simple file layout would make
btrfs defrag to wrongly defrag part of the file, and results in
increased space usage:

 # mkfs.btrfs -f $dev
 # mount $dev $mnt
 # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
 # sync
 # xfs_io -f -c "pwrite 40m 64k" $mnt/foobar.
 # sync
 # btrfs filesystem defrag $mnt/foobar
 # sync

[CAUSE]
It's a bug in the defrag decision part, where we use the length to the
end of the extent to determine if it meets our extent size threshold.

That cause us to do different defrag decision inside the same file
extent, and such defrag would cause extra space caused by btrfs data
CoW.

[TEST CASE]
The test case would just use the above workload as the core, and use
qgroups to properly record the data usage of the fs tree, to make sure
the defrag at least won't cause extra space usage in this particular
case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/310     | 63 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out |  2 ++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/310
 create mode 100644 tests/btrfs/310.out

diff --git a/tests/btrfs/310 b/tests/btrfs/310
new file mode 100755
index 00000000..ca535f99
--- /dev/null
+++ b/tests/btrfs/310
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 310
+#
+# what am I here for?
+#
+. ./common/preamble
+_begin_fstest auto quick defrag qgroup 
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_no_nodatacow
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size"
+
+_scratch_mkfs >> $seqres.full
+
+# We require no compression and enable datacow.
+# As we rely on qgroup to give us an accurate number of used space,
+# which is based on on-disk extent size, thus we have to disable compression.
+#
+# And we rely COW to cause wasted space on unpatched kernels, thus data cow
+# is required.
+_scratch_mount -o compress=no,datacow
+
+# Enable quota to account the wasted bookend space.
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT 2>> $seqres.full &
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
+
+# Create the following layout
+# [0, 40M)		A regular uncompressed extent
+# [40M, 40M+64K)	A small regular extent allowing merging
+$XFS_IO_PROG -f -c "pwrite 0 40M" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 40M 64K" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Then record the current qgroup number, which should be 40M + 64K + nodesize
+qgroup_before=$($BTRFS_UTIL_PROG qgroup show --sync --raw "$SCRATCH_MNT" | tail -n1 | $AWK_PROG '{print $2}')
+echo "qgroup number before defrag: $qgroup_before" >> $seqres.full
+
+# Now defrag the file with the default 32M extent size threshold.
+$BTRFS_UTIL_PROG filesystem defrag -t 32M "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Write back the re-dirtied content of defrag and update qgroup.
+sync
+
+# Now check the newer qgroup numbers
+qgroup_after=$($BTRFS_UTIL_PROG qgroup show --sync --raw "$SCRATCH_MNT" | tail -n1 | $AWK_PROG '{print $2}')
+echo "qgroup number after defrag: $qgroup_after" >> $seqres.full
+
+# The new number should not exceed the old one, or the defrag itself is
+# doing more damage.
+if [ "$qgroup_after" -gt "$qgroup_before" ]; then
+	echo "defrag caused more space usage: before=$qgroup_before after=$qgroup_after"
+fi
+
+echo "Silence is golden"
+
+# success, all done
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


