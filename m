Return-Path: <linux-btrfs+bounces-9357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FE9BDE04
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 05:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5364C284AD7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54618FDBE;
	Wed,  6 Nov 2024 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H8wjPsbJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H8wjPsbJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61576035;
	Wed,  6 Nov 2024 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868078; cv=none; b=MzZ7C6Z+Yya5fsT+aZDKHs0sNhc1+wp/Odiz0Ua3B1xPurjCo7zxvbHmaSKoOISn7d8cvv5c8fJVwpvOG3sGnBdJUoDnp1xBnvFgFzI2WwrjwhC6fe7/mXGbHe9KiEEmJd0zGiTZ7X/Cyp++XQKrYVIBdwRNAH+/BGL+nCaqoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868078; c=relaxed/simple;
	bh=Ft8LQwhW39ZRoBRTpShwfuqBL4EqUW+yYN93rrUuLHs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T9siwG3ZAgzfAMqVgUz3e3Kbqp6PHYBZeoHNbbvYteNG+GQ/h42kuJSIDKeUVmy/6iYP8sBbyuEdHS/sEFR7tllWsBobZDbe9U58x7toqiBs3xrKhQGwSkQhhQeD6o1DpgxYl+9JuQlNgZHpG0loJFlEOjm3jZUsT5qp8MuJmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H8wjPsbJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H8wjPsbJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6580A21C29;
	Wed,  6 Nov 2024 04:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730868074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pXzv5ltxofrgMSC6Ee8vWlZ/zuePv50hzHdjda0jL4Q=;
	b=H8wjPsbJCXehboN8VejVw0P+P3S1M5Mc9hJHuxODC8XpThmw2Vm3QuO5mZ10luaNwGZ+gM
	UdZ0MtDXJKT8XqKI5iVaJwfGzra2oh3/08EdyBmqh6f+obF18Z/DqtAwEUNwmqz2aqhD/Z
	d3GaWiI4xE54LGnRC9EzigiRcU9F8M0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=H8wjPsbJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730868074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pXzv5ltxofrgMSC6Ee8vWlZ/zuePv50hzHdjda0jL4Q=;
	b=H8wjPsbJCXehboN8VejVw0P+P3S1M5Mc9hJHuxODC8XpThmw2Vm3QuO5mZ10luaNwGZ+gM
	UdZ0MtDXJKT8XqKI5iVaJwfGzra2oh3/08EdyBmqh6f+obF18Z/DqtAwEUNwmqz2aqhD/Z
	d3GaWiI4xE54LGnRC9EzigiRcU9F8M0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6745613736;
	Wed,  6 Nov 2024 04:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ExXFCmnzKmdqBAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 06 Nov 2024 04:41:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v3] btrfs: a new test case to verify mount behavior with background remounting
Date: Wed,  6 Nov 2024 15:10:51 +1030
Message-ID: <20241106044051.12712-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6580A21C29
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

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
---
Changelog:
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


