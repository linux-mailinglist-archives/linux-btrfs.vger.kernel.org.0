Return-Path: <linux-btrfs+bounces-22194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH1jGwoZp2m+dgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22194-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:23:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A351F493B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 18:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147FB311671A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134773537D6;
	Tue,  3 Mar 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKlRGR8T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0713537CD;
	Tue,  3 Mar 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558419; cv=none; b=d9DR2rUpJf82Y7rOWUZZwrI4McC6sr6ZMQIVKkTiTEXUFLYd6A73sSMqqFFFxa/BM7QsFHG69FJ7BT99A8blpET/6dSI1xq3hsiRlJrjJVOslXH8sA3e++ECoBEr5hNYhUT1aRb968vMxMXHjgyF40vexvg7WIj+YgfIHxPeYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558419; c=relaxed/simple;
	bh=TVH3/gfJTLCRKCKNDmtOWdhwgUO28COAH57ZVdOsufw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxb1JNgtxEo2PP0I+dppYCNIyP1xkyqD4/oIipIMQhLX5ekSnfwv3qbNlC3JWMqOUNwdTFGd+Ui/7H79CZoTbAhWfUdl1M6S5qUOGp3uZ+YQxdaZhcgvRkEaB5C3nz6a4sM9gomZsytk26Hwof5HMbVvnQ1V5hdS+BGOngJ/spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKlRGR8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B0C19425;
	Tue,  3 Mar 2026 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772558419;
	bh=TVH3/gfJTLCRKCKNDmtOWdhwgUO28COAH57ZVdOsufw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKlRGR8T0WZ3icxzkTnAriVfJGfaBar5n51pD5UJjWWlIZazyJ55EMLbUHEM+Supq
	 /EBG5ONnb2z5Uk3EMYCHCajARVtfoEhWJ/rxceJ8jABM9Q24Fj2tA9BKcib7AHRfP8
	 XBCYGUAR/cz44aYFxKdR5t7UKAQASUtdY9SrSchh9ZUKdyBbe4Fpn1G73aM86XldM8
	 JufPurxIs3lqVHq58/uqMw+oBapXNhnw9MTkTG/hCY+mJa0dXwbSGDojzjN3UnWBzB
	 j4CxlUYW6K1i4BAaYY1xKqEbbG3XuOTSLmx+R2K7bM2FPOvVPfZllfZNbUEuftoUgf
	 vakhLLAPalOww==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test a directory fsync scenaro after replacing a subdir with a file
Date: Tue,  3 Mar 2026 17:20:10 +0000
Message-ID: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4A351F493B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22194-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Test a scenario where we remove a directory previously persisted, create
a file with the same name and parent directory, create two directories in
the same parent directory, create a hard link for the new file in one of
the new directories, fsync the directory with the hard link and fsync the
parent directory. After a power failure we expect both directories to be
persisted as well as the new file and its hard link.

This exercises a bug on btrfs fixed by the following kernel patch:

  "btrfs: log new dentries when logging parent dir of a conflicting inode"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/790     | 69 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/790.out | 12 ++++++++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/generic/790
 create mode 100644 tests/generic/790.out

diff --git a/tests/generic/790 b/tests/generic/790
new file mode 100755
index 00000000..a25203a1
--- /dev/null
+++ b/tests/generic/790
@@ -0,0 +1,69 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 790
+#
+# Test a scenario where we remove a directory previously persisted, create a
+# file with the same name and parent directory, create two directories in the
+# same parent directory, create a hard link for the new file in one of the
+# new directories, fsync the directory with the hard link and fsync the parent
+# directory. After a power failure we expect both directories to be persisted
+# as well as the new file and its hard link.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/dmflakey
+
+_require_scratch
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: log new dentries when logging parent dir of a conflicting inode"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_scratch_mount
+
+mkdir $SCRATCH_MNT/foo
+
+_scratch_sync
+
+rmdir $SCRATCH_MNT/foo
+
+# Create two new directories in the same parent directory as the new file.
+mkdir $SCRATCH_MNT/dir1
+mkdir $SCRATCH_MNT/dir2
+
+# Create a file with the name of the directly we deleted and was persisted
+# before.
+touch $SCRATCH_MNT/foo
+
+# Create a hard link for the new file inside one of the new directories.
+ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir2/link
+
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# We expect to see dir1, dir2, file foo and its hard link, since dir2 was
+# explicitly fsynced as well as the parent directory.
+echo -e "Filesystem content after power failure:\n"
+# Exclude 'lost+found' dir from ext4 and last line if it's blank (due to removal
+# of 'lost+found').
+ls -R $SCRATCH_MNT/ | grep -v 'lost+found' | sed -e '${/^$/d;}'
+
+# success, all done
+_exit 0
diff --git a/tests/generic/790.out b/tests/generic/790.out
new file mode 100644
index 00000000..d2232a19
--- /dev/null
+++ b/tests/generic/790.out
@@ -0,0 +1,12 @@
+QA output created by 790
+Filesystem content after power failure:
+
+/home/fdmanana/btrfs-tests/scratch_1/:
+dir1
+dir2
+foo
+
+/home/fdmanana/btrfs-tests/scratch_1/dir1:
+
+/home/fdmanana/btrfs-tests/scratch_1/dir2:
+link
-- 
2.47.2


