Return-Path: <linux-btrfs+bounces-21719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB75G5K0lGlbGgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21719-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:33:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DBF14F2DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B973300A253
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A82673A5;
	Tue, 17 Feb 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqKOebpX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A9280A29;
	Tue, 17 Feb 2026 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353215; cv=none; b=nLwpcTvxEsexHout8C6YWowM3WaDYtnxOheAoTkNwRa+WbsETpcdR6nDCZIVfwMnJ8MyZ2uFT5aAxpfYNE/WZ7U4NKtcxrSKrZPASp/6h7n4Tw6f5IcEKTI+bqhcTWyFGbj11NNdfO0GMR2Iqusi8eXCKtmLQdgYYjGUDeIW664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353215; c=relaxed/simple;
	bh=gGEVfelMtEM7n53HUBkv3jEHr3mCc4AtxtINeXGWwcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rh8QyYNWSHbpqvQuNIBkj6sFJ+bZOyeu4lFDlydkV7R0/0Da7XH0hH0lbag81NoQ7tfHo2gQIgxTu++bjygUYhWkxxnAWMmdh2/4+7hPM+nS0zetQn9lziSro7cRFT+9nhP0ghXaISxQVWmQLWjYipr27r36sAZDKvXEM0wKxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqKOebpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987E9C4CEF7;
	Tue, 17 Feb 2026 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771353215;
	bh=gGEVfelMtEM7n53HUBkv3jEHr3mCc4AtxtINeXGWwcs=;
	h=From:To:Cc:Subject:Date:From;
	b=kqKOebpXBQ5XNYXPHIZZW8POiU2ENLd/fPqhoVWMLpt63Xsvt5hZPUC8l8e6uOUO5
	 anY1Fi8u+B+CvbYTHTFuaIrR5F5lA06OQs8WhPq/h3tqZpQz5sE22m49sRWxc9VmCL
	 usFnyEGThFWm/gzSNcrjYzZZlLs+oeDTe8HSlts3JWTaGAObL/ZeCKNqhfavNMh7UA
	 FHd8LtUAJ3FF2TG6LXP9GNdLtAQ2gMmSZ4r0sjiWozYonnYV6kffu+BthfBGxR3Chm
	 CWW04c+idF9JwSPaT5wKjbEhNK4BJaDkzP3SC26BrcMPmKtsz6oTyPokY3l7DbateC
	 VUJjOqf2hUWRQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fsync of a file truncated to a length of zero
Date: Tue, 17 Feb 2026 18:33:30 +0000
Message-ID: <f4a25aa2a17255493a9887e0ba6610a307a4961a.1771352543.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21719-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: A1DBF14F2DD
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Test that if we truncate a file to 0, fsync it, add a hard link to the
file and then fsync the parent directory, after a power failure the file
has a size of 0 (and the hardlink exists too).

This exercises a bug fixed by the following kernel patch for btrfs:

  "btrfs: fix zero size inode with non-zero size after log replay"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/788     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/788.out |  5 ++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/generic/788
 create mode 100644 tests/generic/788.out

diff --git a/tests/generic/788 b/tests/generic/788
new file mode 100755
index 00000000..0234cc7f
--- /dev/null
+++ b/tests/generic/788
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 788
+#
+# Test that if we truncate a file to 0, fsync it, add a hard link to the file
+# and then fsync the parent directory, after a power failure the file has a
+# size of 0 (and the hardlink exists too).
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
+. ./common/filter
+. ./common/dmflakey
+
+_require_scratch
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix zero size inode with non-zero size after log replay"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_scratch_mount
+
+mkdir $SCRATCH_MNT/dir
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/dir/foo | _filter_xfs_io
+
+# Persist the file and directory.
+_scratch_sync
+
+# Truncate the file to 0 and fsync it.
+$XFS_IO_PROG -c "truncate 0" -c "fsync" $SCRATCH_MNT/dir/foo
+
+# Create a link to foo in the same dir.
+ln $SCRATCH_MNT/dir/foo $SCRATCH_MNT/dir/bar
+
+# Fsync the directory.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+echo "file size after power failure: $(stat -c %s $SCRATCH_MNT/dir/foo)"
+echo "file link count after power failure: $(stat -c %h $SCRATCH_MNT/dir/foo)"
+[ -f $SCRATCH_MNT/dir/bar ] || echo "link dir/bar is missing"
+
+# success, all done
+_exit 0
diff --git a/tests/generic/788.out b/tests/generic/788.out
new file mode 100644
index 00000000..37f3f36a
--- /dev/null
+++ b/tests/generic/788.out
@@ -0,0 +1,5 @@
+QA output created by 788
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+file size after power failure: 0
+file link count after power failure: 2
-- 
2.47.2


