Return-Path: <linux-btrfs+bounces-9296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB19B8F35
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868CB1F22EEF
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB86170A15;
	Fri,  1 Nov 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M1XNWTrz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M1XNWTrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73639839F4;
	Fri,  1 Nov 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457035; cv=none; b=ekuNrQgAwNUfjp9YSCOLRiz8f53ly9xxd4URtAaEVnl5RjXRPd0NL1rputtGIuiijMogWU5G3IQCUS7xmeuaYMkjtdS1sPJDwyX4uhyJ3kS5d1iIu4dwjDyfU9t1MtpuU5JyqMtypYNzSWeB0hpLDNEMmIcaWVz68EEnlfuwkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457035; c=relaxed/simple;
	bh=qKuMMf7ugQiAKjEMzc2RKEvT6akuSPUGtNBIfjJRSiY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sOzTj5X31Z/sT79w+kz3xCIF1UiWO5HsjzAGpIfRKt3Xwhim8kEl4oedYGxqYi5T8AieI3jT3Ihguqu40G7HEjsNKuN9FlLNuli04oxikWiRDCYNTzPSmx1FUcuineXDjxW+bPRqlNMUrfu3OJmA7rbQcT1yt0ywS8TRuURwohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M1XNWTrz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M1XNWTrz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 10CD321C86;
	Fri,  1 Nov 2024 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730457030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dtK6nQED3rWQ19J8r2a7PDbTQ1vz0rcBRsWWgxNpxPE=;
	b=M1XNWTrzgGgfql5uirneQ3rp/Yy0wQnIaGMNJhzWt/A3f/EKAeS1nMUyt5NXvJgm9Hu7ak
	7rg7oIwOf4dj0H0unK+j1OnAS46N2JrNsuYdyM2s1vOsCn9IhXpW56vqZtTMeQl6pUsPEt
	p8J3OB87HODa5ScQOeelBCF6z3xUeyY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=M1XNWTrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730457030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dtK6nQED3rWQ19J8r2a7PDbTQ1vz0rcBRsWWgxNpxPE=;
	b=M1XNWTrzgGgfql5uirneQ3rp/Yy0wQnIaGMNJhzWt/A3f/EKAeS1nMUyt5NXvJgm9Hu7ak
	7rg7oIwOf4dj0H0unK+j1OnAS46N2JrNsuYdyM2s1vOsCn9IhXpW56vqZtTMeQl6pUsPEt
	p8J3OB87HODa5ScQOeelBCF6z3xUeyY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0208F13722;
	Fri,  1 Nov 2024 10:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ol1nLMStJGdNTAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 01 Nov 2024 10:30:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: a new test case to verify mount behavior with background remounting
Date: Fri,  1 Nov 2024 20:59:56 +1030
Message-ID: <20241101102956.174733-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10CD321C86
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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
---
Changelog:
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
 tests/btrfs/325     | 99 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out |  2 +
 2 files changed, 101 insertions(+)
 create mode 100755 tests/btrfs/325
 create mode 100644 tests/btrfs/325.out

diff --git a/tests/btrfs/325 b/tests/btrfs/325
new file mode 100755
index 00000000..ffa10c61
--- /dev/null
+++ b/tests/btrfs/325
@@ -0,0 +1,99 @@
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
+	kill "$remount_pid" "$mount_pid" &> /dev/null
+	wait &> /dev/null
+	$UMOUNT_PROG "$subv1_mount" &> /dev/null
+	$UMOUNT_PROG "$subv2_mount" &> /dev/null
+	rm -rf -- "$subv1_mount" &> /dev/null
+	rm -rf -- "$subv2_mount" &> /dev/null
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
+
+# subv1 is always mounted, thus the umount should not fail.
+$UMOUNT_PROG "$subv1_mount"
+$UMOUNT_PROG "$subv2_mount" &> /dev/null
+
+rm -rf -- "$subv1_mount" "$subv2_mount"
+
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


