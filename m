Return-Path: <linux-btrfs+bounces-22197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IRNCDYkp2mrewAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22197-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:11:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9BD1F50C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D72713068A17
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6561381AF9;
	Tue,  3 Mar 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqovZgPE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C9381AEA;
	Tue,  3 Mar 2026 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561260; cv=none; b=SIIFk2uE8tgkPRsssANqJygTdGGKm7mnTpw6O61MdKw4C48UwfkD+rhOuYduLySFpFafIDjq6dqfORxLOvkmAX9DD1ca3Umfwc4SNKUsgNYQfvpHkZyUVHUYG3xwK9zlK1jMt3P5okxqOXxWwRCwXEx8cduRiZwKIU/Xyq2Bufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561260; c=relaxed/simple;
	bh=e883LE6sbByzEGI0VDmquzsg/UrM4VCHEtVja+B7Hhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqSJDJLnS2+8Pt+Pof2F4uxfJZ0JL73WELi9/NFi0fqiCX8n98F4hjTYx2aoxZG/ZM50RanTyBAo78aD8UAuuPbOmO10ouBXw74GTKXFue5xm8u6tmh4fKt4akdDpMAaEfvE6eU+VkcoE7MYsNkxofHXlHT1+ECTHrZ6lYDQ7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqovZgPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA9C116C6;
	Tue,  3 Mar 2026 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561259;
	bh=e883LE6sbByzEGI0VDmquzsg/UrM4VCHEtVja+B7Hhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqovZgPEFQnDqZjVkNpd8aasuOHtfWW/3UmSW4QKLm0CJkeN8Imtaf0mx5yVHVJ1I
	 42OPPCdv560jBi/EIYakc719kS0QRx1Wmssm/xlWOb7LPCkP5KQiGS0GCHhn7UzFhd
	 WarSWXX/04OQBbt2/VUMpCkyZxqA6FI9zdkECaEYgxu4nU72K8zfmu4LI7ACJrI7Ok
	 yzQi9jGyvRZKp8npfHGrFnqy9TvEtmvWk5FK0A6EVeFgQdg04a53PICawvQBpXTqxp
	 zqMNXe9TPXqJRYUhbgHeXsoC2k2TdEJ2cPNlXUy2z+mhn4n9Nk2TFnW88rdhgYS3F/
	 USDMVqGXobDiA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test a directory fsync scenaro after replacing a subdir with a file
Date: Tue,  3 Mar 2026 18:07:33 +0000
Message-ID: <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F9BD1F50C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22197-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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

V2: Add missing scratch filter for the ls output.

 tests/generic/790     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/790.out | 12 ++++++++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/generic/790
 create mode 100644 tests/generic/790.out

diff --git a/tests/generic/790 b/tests/generic/790
new file mode 100755
index 00000000..c9bac6d0
--- /dev/null
+++ b/tests/generic/790
@@ -0,0 +1,70 @@
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
+. ./common/filter
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
+ls -R $SCRATCH_MNT/ | grep -v 'lost+found' | sed -e '${/^$/d;}' | _filter_scratch
+
+# success, all done
+_exit 0
diff --git a/tests/generic/790.out b/tests/generic/790.out
new file mode 100644
index 00000000..d9c0592d
--- /dev/null
+++ b/tests/generic/790.out
@@ -0,0 +1,12 @@
+QA output created by 790
+Filesystem content after power failure:
+
+SCRATCH_MNT/:
+dir1
+dir2
+foo
+
+SCRATCH_MNT/dir1:
+
+SCRATCH_MNT/dir2:
+link
-- 
2.47.2


