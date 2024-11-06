Return-Path: <linux-btrfs+bounces-9358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CC39BDE57
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 06:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18641C22CCC
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 05:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A01917DB;
	Wed,  6 Nov 2024 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E6TPbgnQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W4um5BFn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05124084D;
	Wed,  6 Nov 2024 05:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871839; cv=none; b=TiZU5Y9eL0H/b9fZ4hZYPFwYlUhP5Amvm99iAaHNCA1pQ1zOsSHaft743+Hz75b4k69BPTSi/1PsQtyo14SjmZq8vJfFeY2bIN3s+5rVEoZ0capiFhBjmQ3k95U/fSJwaL0VjGHlnb4Tiun0ayxeEnJF6goM51/YXUcJrjsoUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871839; c=relaxed/simple;
	bh=iO3a7mk7D4gfWcss9JZMrBEl8CVvGfOWlQ+ATxq2fMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEN3QDR5xJWGIIOYamV7OLtZzX8iy6uJJwu7HygjN//Bqz+e5SxOOEPux4koOVtWcLefPnj5oQf6kOa3pLbhDn5hwL0B2iEvOahlSxdi8RxgZ6zGNvmuIhzQQdReBo7Bl+bviz1v1sB2ggC+ojMaAwsRq01QdT5ZIkNVGpmBLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E6TPbgnQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W4um5BFn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4DAD1F82A;
	Wed,  6 Nov 2024 05:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730871828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ciQDiH4eSkPn68rX4DniD6HfOnW0TFnmeAEATlvrQy4=;
	b=E6TPbgnQ9+eUoVQBE3cX475F6zeafOVVvAGi9cGY4aatvCI6r3y8uEmLgwdLmj36EWAu0u
	8wxZeQNXTGkU0In7dAHs9VZLcoNcrh4wekmvuK/6wQWRz6sSNZ0wcBbGbo01aJhftnESCM
	5WRBGwlkiH4lv7d70pHnjMHonSnS+Lo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730871827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ciQDiH4eSkPn68rX4DniD6HfOnW0TFnmeAEATlvrQy4=;
	b=W4um5BFnKtTwK74Esun1t4Qj4wiBXi21m8qQYJkC9v4ZhRr/wFoVOHtvdj1tdPvh2FTcE5
	p24HCSW1AjKHNNYQygkZxOCMawn/xtkb+fRvtK8uEEZBQsMMIiNsgovVOtSdxn/2836ocb
	T6gs3vt96uqxdJk88tn0VnQ+B4wH0RU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A99A134A0;
	Wed,  6 Nov 2024 05:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CqbEARICK2cgEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 06 Nov 2024 05:43:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4] btrfs: a new test case to verify mount behavior with background remounting
Date: Wed,  6 Nov 2024 16:13:28 +1030
Message-ID: <20241106054328.19842-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.960];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.79
X-Spam-Flag: NO

[BUG]
When there is a process in the background remounting a btrfs, switching
between RO/RW, then another process try to mount another subvolume of
the same btrfs read-only, we can hit a race causing the RW mount to fail
with -EBUSY:

[CAUSE]
During the btrfs mount, to support mounting different subvolumes with
different RO/RW flags, we have a small hack during the mount:

  Retry with matching RO flags if the initial mount fail with -EBUSY.

The problem is, during that retry we do not hold any super block lock
(s_umount), this meanings there can be a remount process changing the RO
flags of the original fs super block.

If so, we can have an EBUSY error during retry.
And this time we treat any failure as an error, without any retry and
cause the above EBUSY mount failure.

[FIX]
The fix is already sent to the mailing list.
The fix is to allow btrfs to have different RO flag between super block
and mount point during mount, and if the RO flag mismatch, reconfigure
the fs to RW with s_umount hold, so that there will be no race.

[TEST CASE]
The test case will create two processes:

- Remounting an existing subvolume mount point
  Switching between RO and RW

- Mounting another subvolume RW
  After a successful mount, unmount and retry.

This is enough to trigger the -EBUSY error in less than 5 seconds.
To be extra safe, the test case will run for 10 seconds at least, and
follow TIME_FACTOR for extra loads.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changelog:
v4:
- Add the missing reviewed-by tag from Filipe

v3:
- Also remove the default temporaray files in cleanup

- Unset mount/remount pid and avoid killing them if unset during cleanup

- Remove the mount points to avoid name conflicts

- Extra comments on the the final unmounts for both mount point and
  cleanup

v2:
- Better signal handling for both remount and mount workload
  Need to do the extra handling for both workload

- Wait for any child process to exit before cleanup

- Keep the stderr of the final rm command

- Keep the stderr of the unmount of $subv1_mount
  Which should always be mounted.

- Use "$UMOUNT_PROG" instead of direct "umount"

- Use "_mount" instead of direct "mount"

- Fix a typo of "block"
---
 tests/btrfs/325     | 107 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out |   2 +
 2 files changed, 109 insertions(+)
 create mode 100755 tests/btrfs/325
 create mode 100644 tests/btrfs/325.out

diff --git a/tests/btrfs/325 b/tests/btrfs/325
new file mode 100755
index 00000000..0f4984f1
--- /dev/null
+++ b/tests/btrfs/325
@@ -0,0 +1,107 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 325
+#
+# Test that mounting a subvolume read-write will success, with another
+# subvolume being remounted RO/RW at background
+#
+. ./common/preamble
+_begin_fstest auto quick mount remount
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix mount failure due to remount races"
+
+_cleanup()
+{
+	cd /
+	rm -rf -- $tmp.*
+	[ -n "$mount_pid" ] && kill $mount_pid &> /dev/null
+	[ -n "$remount_pid" ] && kill $remount_pid &> /dev/null
+	wait
+	$UMOUNT_PROG "$subv1_mount" &> /dev/null
+	$UMOUNT_PROG "$subv2_mount" &> /dev/null
+	rm -rf -- "$subv1_mount" "$subv2_mount"
+}
+
+# For the extra mount points
+_require_test
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
+_scratch_unmount
+
+subv1_mount="$TEST_DIR/subvol1_mount"
+subv2_mount="$TEST_DIR/subvol2_mount"
+rm -rf "$subv1_mount" "$subv2_mount"
+mkdir -p "$subv1_mount"
+mkdir -p "$subv2_mount"
+_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=subvol1
+
+# Subv1 remount workload, mount the subv1 and switching it between
+# RO and RW.
+remount_workload()
+{
+	trap "wait; exit" SIGTERM
+	while true; do
+		_mount -o remount,ro "$subv1_mount"
+		_mount -o remount,rw "$subv1_mount"
+	done
+}
+
+remount_workload &
+remount_pid=$!
+
+# Subv2 rw mount workload
+# For unpatched kernel, this will fail with -EBUSY.
+#
+# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
+# mounted RO, unpatched btrfs will retry with its RO flag reverted,
+# then reconfigure the fs to RW.
+#
+# But such retry has no super block lock hold, thus if another remount
+# process has already remounted the fs RW, the attempt will fail and
+# return -EBUSY.
+#
+# Patched kernel will allow the superblock and mount point RO flags
+# to differ, and then hold the s_umount to reconfigure the super block
+# to RW, preventing any possible race.
+mount_workload()
+{
+	trap "wait; exit" SIGTERM
+	while true; do
+		_mount "$SCRATCH_DEV" "$subv2_mount"
+		$UMOUNT_PROG "$subv2_mount"
+	done
+}
+
+mount_workload &
+mount_pid=$!
+
+sleep $(( 10 * $TIME_FACTOR ))
+
+kill "$remount_pid" "$mount_pid"
+wait
+unset remount_pid mount_pid
+
+# Subv1 is always mounted, thus the umount should never fail.
+$UMOUNT_PROG "$subv1_mount"
+
+# Subv2 may have already been unmounted, so here we ignore all output.
+# This may hide some errors like -EBUSY, but the next rm line would
+# detect any still mounted subvolume so we're still safe.
+$UMOUNT_PROG "$subv2_mount" &> /dev/null
+
+# If above unmount, especially subv2 is not properly unmounted,
+# the rm should fail with some error message
+rm -r -- "$subv1_mount" "$subv2_mount"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
new file mode 100644
index 00000000..cf13795c
--- /dev/null
+++ b/tests/btrfs/325.out
@@ -0,0 +1,2 @@
+QA output created by 325
+Silence is golden
-- 
2.46.0


