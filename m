Return-Path: <linux-btrfs+bounces-9278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8B9B8A50
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E2628247D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B81494B5;
	Fri,  1 Nov 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CMb5UJH3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CMb5UJH3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF74F20C;
	Fri,  1 Nov 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437692; cv=none; b=eTG7lM5Ebn8uWh9i/lLfk82XqON3cNzNlhFwLMy3TCW4j7K1pCu/gqbkMtY762eLMYTqfTSM8t8hoosNm6bjiIRbpVrsy8NOX4U36SSIANWQP+YuKDDd+ANL4pULm6A2vvkEr8bIRZFPDaEbcooZ3Vi0MOhXg6Wm+4/YgdhtZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437692; c=relaxed/simple;
	bh=Ba2Naoq+NVHghePSsq77JA+BZTg/BuGx1+QWCOnzZn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VVmFyqh2+V23V+N9u9TCXmwTTEkhiG23fHXwjrve56qZez0TcBDNyLY/6Be4bY8l64BSJOsirfmviY86GoJZYH8Mb3XBDQQq3f99nArNeeCZd3uuAS+284aumnQhZvjP5A+7QcJrFcCTO27JKWjDef2b0n8VxMj5f3ieMXBd7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CMb5UJH3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CMb5UJH3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 307F61F82A;
	Fri,  1 Nov 2024 05:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730437682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hCzxjH7xrv5wsN4fyDaKgen09HktwVXkm4obAaSZp+w=;
	b=CMb5UJH3u161izk4ngLsWHPSgsy++cg6tQWtawKDqJhseirEogbvIw+SyRNpduh1OKZ5d8
	llFgNFsbVf9vuzyx1IRjOIM9dRVtb6EflqZUzOzN/WUcBb20JY0owgmwBBun/rSIEuUHe/
	QIq7GkPn0f+g4Tb8u3hrzutpbi94A6o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CMb5UJH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730437682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hCzxjH7xrv5wsN4fyDaKgen09HktwVXkm4obAaSZp+w=;
	b=CMb5UJH3u161izk4ngLsWHPSgsy++cg6tQWtawKDqJhseirEogbvIw+SyRNpduh1OKZ5d8
	llFgNFsbVf9vuzyx1IRjOIM9dRVtb6EflqZUzOzN/WUcBb20JY0owgmwBBun/rSIEuUHe/
	QIq7GkPn0f+g4Tb8u3hrzutpbi94A6o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18C4913B13;
	Fri,  1 Nov 2024 05:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4onMTBiJGezeQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 01 Nov 2024 05:08:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: a new test case to verify mount behavior with background remounting
Date: Fri,  1 Nov 2024 15:37:43 +1030
Message-ID: <20241101050743.113687-1-wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 307F61F82A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
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
 tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out |  2 ++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/btrfs/325
 create mode 100644 tests/btrfs/325.out

diff --git a/tests/btrfs/325 b/tests/btrfs/325
new file mode 100755
index 00000000..d0713b39
--- /dev/null
+++ b/tests/btrfs/325
@@ -0,0 +1,80 @@
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
+	umount "$subv1_mount" &> /dev/null
+	umount "$subv2_mount" &> /dev/null
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
+
+# Subv1 remount workload, mount the subv1 and switching it between
+# RO and RW.
+_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=subvol1
+while _mount -o remount,ro "$subv1_mount"; do
+	mount -o remount,rw "$subv1_mount"
+done &
+subv1_pid=$!
+
+# Subv2 rw mount workload
+# For unpatched kernel, this will fail with -EBUSY.
+#
+# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
+# mounted RO, unpatched btrfs will retry with its RO flag reverted,
+# then reconfigure the fs to RW.
+#
+# But such retry has no super blocl lock hold, thus if another remount
+# process has already remounted the fs RW, the attempt will fail and
+# return -EBUSY.
+#
+# Patched kernel will allow the superblock and mount point RO flags
+# to differ, and then hold the s_umount to reconfigure the superblock
+# to RW, preventing any possible race.
+while _mount "$SCRATCH_DEV" "$subv2_mount "-o subvol=subvol2; do
+	umount "$subv2_mount";
+done &
+subv2_pid=$!
+
+sleep $(( 10 * $TIME_FACTOR ))
+
+kill $subv1_pid
+kill $subv2_pid
+umount "$subv1_mount" &> /dev/null
+umount "$subv2_mount" &> /dev/null
+rm -rf -- "$subv1_mount" &> /dev/null
+rm -rf -- "$subv2_mount" &> /dev/null
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


