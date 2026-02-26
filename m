Return-Path: <linux-btrfs+bounces-21973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELNrDUhboGm3igQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21973-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:40:08 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2C1A7BC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B42830BB539
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E33AE70B;
	Thu, 26 Feb 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZctx3y0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985B3B9607;
	Thu, 26 Feb 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116469; cv=none; b=hGP7c2vNKO3V5S//cqGv+vCUmYS+oEJSMFv8o6m8SBjtHNRJAicflTdRAXedsTdglBNTIYbwUId1wE/633bg3fKx8ImqHMfwUJ+N08Ljig6om2xd7pjE9NeCz4Lx/PB2hbf5hmbrkYy/D9GFyEc23g7ufIsXfAEt/lt5jeorJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116469; c=relaxed/simple;
	bh=UeG4sGapgo0ldocVkBw3qSr2HMbiqPYC0XLPWEJVj/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXCNM3akQd2Rl1i6+T17GL2Q/32B850RljLUluXqosAB9RXR1HKjRXHKuzM2nxCV6gL6FNmJoOYSsXs2VPrqeHspkDgH87qnkKtFkgy0WYIscWFwBI5gK3rmYnuBH+JByMy/bcolyQCQrbsZZjlTGLaq0G2lgA6b59i69bXKVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZctx3y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C281C116C6;
	Thu, 26 Feb 2026 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116469;
	bh=UeG4sGapgo0ldocVkBw3qSr2HMbiqPYC0XLPWEJVj/0=;
	h=From:To:Cc:Subject:Date:From;
	b=CZctx3y0Wa1ttY0kc4qKQ+i5IP7HrD1A11iaKooGSwkRFZswS+P1ZUAaDcE6CUNK+
	 t0p7NEdy1X0now9R/OIIz+BHObU5vm1y5TgxIPQOmzpOEb7t4obEj17De/a8ZDE6l2
	 6LhjsgF8o7TPAPYGiPPFgCA6b8C5wvmyHQ9ZXn8Crq3x/rsI5QTFTlOANmCPS5qa4l
	 JVxopYebLLCzPF18JNEPt7EMSQ1YjWglUXy/+J06ildrUq09Cx+qq8i9Xep3ESx1O2
	 Q37f+OXs8duZg+wY85Sz2GPDAqiSas/C77LXo6a2RmLlBV7knkPnc5H0V2ZEMjQ+K2
	 fmRi27pY59PBw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test creating a large number of snapshots of a received subvolume
Date: Thu, 26 Feb 2026 14:34:24 +0000
Message-ID: <18154871aaddf2f1887c14e63513955c79b2a712.1772106013.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21973-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DC2C1A7BC1
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Test that we can create a large number of snapshots of a received
subvolume without triggering a transaction abort due to leaf item
overflow. Also check that we are able to delete the snapshots and use
the last one for an incremental send/receive despite an item overflow
when updating the uuid tree to insert a BTRFS_UUID_KEY_RECEIVED_SUBVOL
item.

This exercises a bug fixed by the following kernel patch:

  "btrfs: fix transaction abort when snapshotting received subvolumes"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/345     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/345.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/btrfs/345
 create mode 100644 tests/btrfs/345.out

diff --git a/tests/btrfs/345 b/tests/btrfs/345
new file mode 100755
index 00000000..75cc3067
--- /dev/null
+++ b/tests/btrfs/345
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 345
+#
+# Test that we can create a large number of snapshots of a received subvolume
+# without triggering a transaction abort due to leaf item overflow. Also check
+# that we are able to delete the snapshots and use the last one for an
+# incremental send/receive despite an item overflow when updating the uuid tree
+# to insert a BTRFS_UUID_KEY_RECEIVED_SUBVOL item.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol send snapshot
+
+_require_scratch
+_require_btrfs_support_sectorsize 4096
+_require_btrfs_command "property"
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix transaction abort when snapshotting received subvolumes"
+
+# Use a 4K node/leaf size to make the test faster.
+_scratch_mkfs -n 4K >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# Create a subvolume.
+_btrfs subvolume create $SCRATCH_MNT/sv
+touch $SCRATCH_MNT/sv/foo
+
+# Turn the subvolume to RO mode so that we can send it.
+_btrfs property set $SCRATCH_MNT/sv ro true
+
+# Send the subvolume and receive it. Our received version of the subvolume
+# (in $SCRATCH_MNT/snaps/sv) will have a non-NULL received UUID field in its
+# root item.
+mkdir $SCRATCH_MNT/snaps
+_btrfs send -f $SCRATCH_MNT/send.stream $SCRATCH_MNT/sv
+_btrfs receive -f $SCRATCH_MNT/send.stream $SCRATCH_MNT/snaps
+
+# Now snapshot the received the subvolume a lot of times and check we are able
+# to snapshot and that we don't trigger a transaction abort (will trigger a
+# warning and dump a stack trace in dmesg/syslog).
+total=$(( 1000 * LOAD_FACTOR ))
+for ((i = 1; i <= $total; i++)); do
+    _btrfs subvolume snapshot -r $SCRATCH_MNT/snaps/sv $SCRATCH_MNT/snaps/sv_$i
+done
+
+# Create a snapshot based on the last snapshot, add a file to it, and turn it
+# to RO so that we can used it for a send operation.
+last_snap="${SCRATCH_MNT}/snaps/sv_${total}"
+_btrfs subvolume snapshot $last_snap $SCRATCH_MNT/snaps/sv_last_as_parent
+echo -n "hello world" > $SCRATCH_MNT/snaps/sv_last_as_parent/bar
+_btrfs property set $SCRATCH_MNT/snaps/sv_last_as_parent ro true
+
+# Now we attempt to send and receive that snapshot, verify that it works even
+# if the creation of the snapshot $last_snap was not able to add a
+# BTRFS_UUID_KEY_RECEIVED_SUBVOL item to the uuid tree due to leaf overflow.
+_btrfs send -f $SCRATCH_MNT/inc_send.stream -p $last_snap \
+       $SCRATCH_MNT/snaps/sv_last_as_parent
+_btrfs receive -f $SCRATCH_MNT/inc_send.stream $SCRATCH_MNT/
+
+# Verify the received snapshot has the new file with the right content.
+diff $SCRATCH_MNT/snaps/sv_last_as_parent/bar $SCRATCH_MNT/sv_last_as_parent/bar
+
+# Now check that we are able to delete all the snapshots too.
+for ((i = 1; i <= $total; i++)); do
+    _btrfs subvolume delete $SCRATCH_MNT/snaps/sv_$i
+done
+
+# success, all done
+echo "Silence is golden"
+_exit 0
diff --git a/tests/btrfs/345.out b/tests/btrfs/345.out
new file mode 100644
index 00000000..11ef4e7e
--- /dev/null
+++ b/tests/btrfs/345.out
@@ -0,0 +1,2 @@
+QA output created by 345
+Silence is golden
-- 
2.47.2


