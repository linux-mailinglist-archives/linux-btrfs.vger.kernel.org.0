Return-Path: <linux-btrfs+bounces-13979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D5AB5FC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 01:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035B546305A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634161F0E50;
	Tue, 13 May 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ak6UjYlt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ak6UjYlt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE911DFD8B
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747177409; cv=none; b=n/k86HL9hBBaU7c59EyBVNw8O9f6lTdq3TKWSSiPZGXnfEA7GXiIQ6ulpMUOkxvutLpIONgqBdqklcp0PWF+rLXtQf0GAKGN4+YhCcgeDftdDhvYD+oGE6nEhxdFkiVeofoOlUChjoNXlPCWlBPs8FJgwA7oyafopCnDIGaBVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747177409; c=relaxed/simple;
	bh=QfpYBqEgZXQUfAPkRyz7ayZgD/ReGr8O3T/wEukouGA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vFVb3UoAl95xeopBXwtI9OaDhkbg5RCzWL1Lf8hU5oJUMCGNqkDMEJnSi7wC2/vdMEmw0S8JfmNaypYMK8xXULl58l7UMZwOgQP2LNaWAuIr5RPHrY0A/X99r3fI9f2Ocu/+8Z6xnBxPjbnMyLvF0+FwEjm2AdHtsOSxPyje3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ak6UjYlt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ak6UjYlt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66193211E0;
	Tue, 13 May 2025 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747177404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEvNSYzTHXxy3yyJGsnfgBPn+Qb2sFShi2xTrl2y7k4=;
	b=Ak6UjYltn1v9Ig4T0zb3en3kyT+ArfTPwjf5Uc8ThpW0T7xOeJGQO9tB6xlwPVc3gJBvJX
	PdUJbVGhnu7nqMqiJ0KBjXsqd+xEIX9siJKbwC5awueHlmjnXFqGnSpjn7/1PyZJBNHGq/
	+QAvw20ZsoHrk0AWCvk8nXkiJYnXrro=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ak6UjYlt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747177404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZEvNSYzTHXxy3yyJGsnfgBPn+Qb2sFShi2xTrl2y7k4=;
	b=Ak6UjYltn1v9Ig4T0zb3en3kyT+ArfTPwjf5Uc8ThpW0T7xOeJGQO9tB6xlwPVc3gJBvJX
	PdUJbVGhnu7nqMqiJ0KBjXsqd+xEIX9siJKbwC5awueHlmjnXFqGnSpjn7/1PyZJBNHGq/
	+QAvw20ZsoHrk0AWCvk8nXkiJYnXrro=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67BAB137E8;
	Tue, 13 May 2025 23:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5fq3CrvPI2jMAQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 13 May 2025 23:03:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/020: use device pool to avoid busy TEST_DEV
Date: Wed, 14 May 2025 08:33:01 +0930
Message-ID: <20250513230301.69503-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 66193211E0
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

[BUG]
There is an internal report about btrfs/020 failure, the 020.full looks
like this:

  ERROR: ioctl(DEV_REPLACE_START) failed on "/opt/test/020.5968.mnt": Read-only file system

  Performing full device TRIM /dev/loop8 (256.00MiB) ...
  _check_btrfs_filesystem: filesystem on /dev/loop0 is inconsistent
  *** fsck.btrfs output ***
  ERROR: /dev/loop0 is currently mounted, use --force if you really intend to check the filesystem
  Opening filesystem to check...
  *** end fsck.btrfs output
  *** mount output ***
  [...]
  /dev/loop0 on /opt/test type btrfs (rw,relatime,seclabel,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)
  *** end mount output

[CAUSE]
Unfortunately I can not reproduce the situation here, but it looks like
by somehow we didn't unmount the TEST_DEV before checking it.

This may or may not be caused by the fact we're using loop back devices
on TEST_MNT.

[FIX]
For this particluar test case, we really do not need to use TEST_MNT and
create complex loopback devices.

We can just ask for 3 devices from the device pool, use 2 for the raid1
fs, and then use the spare one for dev replace.

This should greately simplify the test case setup and cleanup, thus
avoid the above busy TEST_DEV and false test failure.

Furthermore use the golden output to match the error message, and since
we're here also handle a bug in btrfs-progs where the error message is
incorrectly split into two lines.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use golden output to match the error
- Add a filter to filter out the unexpected new line
  Btrfs-progs will also get a fix for the incorrect line break.
---
 tests/btrfs/020     | 47 +++++++++++++++------------------------------
 tests/btrfs/020.out |  2 +-
 2 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/tests/btrfs/020 b/tests/btrfs/020
index 7e5c6fd7..3b5f9f2f 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -12,44 +12,29 @@
 . ./common/preamble
 _begin_fstest auto quick replace volume
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	$UMOUNT_PROG $loop_mnt
-	_destroy_loop_device $loop_dev1
-	losetup -d $loop_dev2 >/dev/null 2>&1
-	_destroy_loop_device $loop_dev3
-	rm -rf $loop_mnt
-	rm -f $fs_img1 $fs_img2 $fs_img3
-}
-
 . ./common/filter
 
-_require_test
-_require_loop
+_require_scratch_dev_pool 3
 
-echo "Silence is golden"
+_fixed_by_kernel_commit bbb651e469d9 \
+	"Btrfs: don't allow the replace procedure on read only filesystems"
 
-loop_mnt=$TEST_DIR/$seq.$$.mnt
-fs_img1=$TEST_DIR/$seq.$$.img1
-fs_img2=$TEST_DIR/$seq.$$.img2
-fs_img3=$TEST_DIR/$seq.$$.img3
-mkdir $loop_mnt
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img2 >>$seqres.full 2>&1
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img3 >>$seqres.full 2>&1
+_scratch_dev_pool_get 2
+_spare_dev_get
 
-loop_dev1=`_create_loop_device $fs_img1`
-loop_dev2=`_create_loop_device $fs_img2`
-loop_dev3=`_create_loop_device $fs_img3`
+_scratch_pool_mkfs -m raid1 -d raid1 >> $seqres.full 2>&1
+_scratch_mount -o ro
 
-_mkfs_dev -m raid1 -d raid1 $loop_dev1 $loop_dev2 >>$seqres.full 2>&1
-_mount -o ro $loop_dev1 $loop_mnt
+# The replace is expected to fail.
+#
+# There is an unexpected newline at the middle of the error message, filter it out
+# to handle older progs (unexpected new line) and newer ones (new line removed).
+$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT 2>&1 >> $seqres.full | \
+	sed -e "/^$/d" | _filter_scratch
 
-$BTRFS_UTIL_PROG replace start -B 2 $loop_dev3 $loop_mnt >>$seqres.full 2>&1 && \
-_fail "FAIL: Device replaced on RO btrfs"
+_scratch_unmount
+_spare_dev_put
+_scratch_dev_pool_put
 
 status=0
 exit
diff --git a/tests/btrfs/020.out b/tests/btrfs/020.out
index 20d7944e..a3ede235 100644
--- a/tests/btrfs/020.out
+++ b/tests/btrfs/020.out
@@ -1,2 +1,2 @@
 QA output created by 020
-Silence is golden
+ERROR: ioctl(DEV_REPLACE_START) failed on "SCRATCH_MNT": Read-only file system
-- 
2.49.0


