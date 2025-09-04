Return-Path: <linux-btrfs+bounces-16619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6895B43230
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC291895B18
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 06:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C479125B1D2;
	Thu,  4 Sep 2025 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABU4udfS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ABU4udfS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2710259CA5
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966808; cv=none; b=Yf6Vtbv1p/HDQKLXchpaEN48eXHMc2+Z+d+kiogLyQyfpbAMHXVv37UNCfWxLpYro77Oid2LrGFdPDsc9P2cmvyaPNlGZhqTZ2Y0xEmYJpYfWQx5wqDVxoQLL54HQ4TJAYqlgo2tctLimzhLiaOV1ghcEM0MDq5r3uKsRBqN4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966808; c=relaxed/simple;
	bh=JoR2izDHZUeg6jHGQrRgnFVjB003AdBiQIRbHEMy+o0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TMLol8NAGUBFlNE8OPpJqg73FjLqjr3xzTOI1D9RksABbb0grBXIWWsOqIAyLQtAbP5CPB7Lw9JUfGZEqXKbktul7gl7fb7v+qoUAP1wKV0uNKPkHfGJdGom2QQpnjWkp53uRcNPAcISmY36OMfJz9B3989K9l7CnuZcUXJNCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABU4udfS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ABU4udfS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C2C420BFB;
	Thu,  4 Sep 2025 06:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756966803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bXGF0L2rjmX05uyGdYfQyqnLSnUnsgpmA2eY4g5JH6I=;
	b=ABU4udfSSbH92wdNXiWZ2I/mM0/sdALbP8/Ltv443iePXEREdDnM5BIgRhMfm9b1ZSefuQ
	p2RIFnJ6yRik2FG1zm6ua64xFilXDiZdjm/pvCzW8E53rx8vrAH+/RkRs1i1GIRnXK7xu8
	HNSGbGV1y1UcSVpXb/ZbYxiAK2jNxbA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ABU4udfS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756966803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bXGF0L2rjmX05uyGdYfQyqnLSnUnsgpmA2eY4g5JH6I=;
	b=ABU4udfSSbH92wdNXiWZ2I/mM0/sdALbP8/Ltv443iePXEREdDnM5BIgRhMfm9b1ZSefuQ
	p2RIFnJ6yRik2FG1zm6ua64xFilXDiZdjm/pvCzW8E53rx8vrAH+/RkRs1i1GIRnXK7xu8
	HNSGbGV1y1UcSVpXb/ZbYxiAK2jNxbA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA7213675;
	Thu,  4 Sep 2025 06:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id at1ANJEvuWgAVwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Sep 2025 06:20:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: generic/228: do not rely on the bash core dump output
Date: Thu,  4 Sep 2025 15:49:44 +0930
Message-ID: <20250904061944.105518-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1C2C420BFB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

[BUG]
With bash 5.3.x, the test case generic/228 will always fail with the
following golden output mismatch:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PREEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
MKFS_OPTIONS  -- /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/228 1s ... - output mismatch (see /home/adam/xfstests/results//generic/228.out.bad)
    --- tests/generic/228.out	2025-09-04 15:15:08.965000000 +0930
    +++ /home/adam/xfstests/results//generic/228.out.bad	2025-09-04 15:16:05.627457599 +0930
    @@ -1,6 +1,6 @@
     QA output created by 228
     File size limit is now set to 100 MB.
     Let us try to preallocate 101 MB. This should fail.
    -File size limit exceeded
    +File size limit exceeded   $XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch
     Let us now try to preallocate 50 MB. This should succeed.
     Test over.
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/228.out /home/adam/xfstests/results//generic/228.out.bad'  to see the entire diff)
Ran: generic/228
Failures: generic/228
Failed 1 of 1 tests

[CAUSE]
The "File size limit exceeded" line is never from xfs_io, but the
coredump from bash itself.

And with latest 5.3.x bash, it added extra dump during such core dump
handling (even if we have explicitly skipped the coredump).

[FIX]
Instead of relying on bash to do the coredump, which is unreliable
between different bash versions as I have shown above, ignore the
SIGXFSZ signal so that xfs_io will do the error output, which is more
reliable than bash.

And since we do not need to bother the coredump behavior, remove all the
cleanup and preparation for coredump.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove all coredump related code.
  As we ignored the signal, no coredump will be triggered.
---
 tests/generic/228     | 28 +++++++---------------------
 tests/generic/228.out |  2 +-
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/tests/generic/228 b/tests/generic/228
index f1881f84..d7bd9b7a 100755
--- a/tests/generic/228
+++ b/tests/generic/228
@@ -9,22 +9,6 @@
 . ./common/preamble
 _begin_fstest rw auto prealloc quick
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	sysctl -w kernel.core_pattern="$core_pattern" &>/dev/null
-	ulimit -c $ulimit_c
-}
-
-tmp=$TEST_DIR/$$
-core_pattern=`sysctl -n kernel.core_pattern`
-ulimit_c=`ulimit -c`
-_register_cleanup "_cleanup" 25
-
-# Import common functions.
-
 # generic, but xfs_io's fallocate must work
 # only Linux supports fallocate
 _require_test
@@ -38,10 +22,6 @@ _require_xfs_io_command "falloc"
 avail=`df -P $TEST_DIR | awk 'END {print $4}'`
 [ "$avail" -ge 104000 ] || _notrun "Test device is too small ($avail KiB)"
 
-# Suppress core dumped messages
-sysctl -w kernel.core_pattern=core &>/dev/null
-ulimit -c 0
-
 # Set the FSIZE ulimit to 100MB and check
 ulimit -f 102400
 flim=`ulimit -f`
@@ -50,7 +30,13 @@ flim=`ulimit -f`
 
 echo "File size limit is now set to 100 MB."
 echo "Let us try to preallocate 101 MB. This should fail."
-$XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch
+# xfs_io will receive SIGXFSZ signal, if not handled it will trigger a coredump.
+#
+# And in bash 5.3.x, bash will always output the command/script triggering the
+# coredump.
+# Work around the new behavior by ignoring the signal.
+# Falloc will still fail but with a more reliable error message.
+bash -c "trap '' SIGXFSZ; $XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch"
 rm -f $TEST_DIR/ouch
 
 echo "Let us now try to preallocate 50 MB. This should succeed."
diff --git a/tests/generic/228.out b/tests/generic/228.out
index 842d4bb7..00d041f6 100644
--- a/tests/generic/228.out
+++ b/tests/generic/228.out
@@ -1,6 +1,6 @@
 QA output created by 228
 File size limit is now set to 100 MB.
 Let us try to preallocate 101 MB. This should fail.
-File size limit exceeded
+fallocate: File too large
 Let us now try to preallocate 50 MB. This should succeed.
 Test over.
-- 
2.51.0


