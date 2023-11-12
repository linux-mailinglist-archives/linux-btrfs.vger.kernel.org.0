Return-Path: <linux-btrfs+bounces-88-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F197E935B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 00:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BEAB208AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Nov 2023 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77601C29E;
	Sun, 12 Nov 2023 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLEHzdl7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE321BDC4;
	Sun, 12 Nov 2023 23:33:47 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F81BF7;
	Sun, 12 Nov 2023 15:33:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 909C61F45B;
	Sun, 12 Nov 2023 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699832024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2ICh6pwnGbyOeDtbMijzBbhE79LgWANYXpveNTIE9xU=;
	b=OLEHzdl7V+xuiIU4reczBrpKCJSdMZV5NbKkfELGXdK/8JRkdWMZw8ayWk+3fnPwIuPPwQ
	FGZKIK+rIqcbVkD5tZwGFbib6rfiuReUL2awxDXpQufVYWqYBgU2Asl7oK1RGdMP/yLmvc
	w5WL+xDBtwG7VBjjdcYvD5R6Qdk46xA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A371391A;
	Sun, 12 Nov 2023 23:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pO9qENdgUWUZJwAAMHmgww
	(envelope-from <wqu@suse.com>); Sun, 12 Nov 2023 23:33:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: test snapshot creation with existing qgroup
Date: Mon, 13 Nov 2023 10:03:25 +1030
Message-ID: <20231112233325.103250-1-wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[BUG]
There is a sysbot regression report about transaction abort during
snapshot creation, which is caused by the new timing of qgroup creation
and too strict error check.

[FIX]
The proper fix is already submitted, with the title "btrfs: do not abort
transaction if there is already an existing qgroup".

[TEST]
The new test case would reproduce the regression by:

- Create a subvolume and a snapshot of it

- Record the subvolumeid of the snapshot

- Re-create the fs
  Since btrfs won't reuse the subvolume id, we have to re-create the fs.

- Enable quota and create a qgroup with the same subvolumeid

- Create a subvolume and a snapshot of it
  For unpatched and affected kernel (thankfully no release is affected),
  the snapshot creation would fail due to aborted transaction.

- Make sure the subvolume id doesn't change for the snapshot
  There is one very hacky attempt to fix it by avoiding using the
  subvolume id, which is completely wrong and would be caught by this
  extra check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/303     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out |  2 ++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/btrfs/303
 create mode 100644 tests/btrfs/303.out

diff --git a/tests/btrfs/303 b/tests/btrfs/303
new file mode 100755
index 00000000..fe924496
--- /dev/null
+++ b/tests/btrfs/303
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 303
+#
+# A regression test to make sure snapshot creation won't cause transaction
+# abort if there is already an existing qgroup.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: do not abort transaction if there is already an existing qgroup"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# Create the first subvolume and get its id.
+# This subvolume id should not change no matter if there is an existing
+# qgroup for it.
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
+$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
+	"$SCRATCH_MNT/snapshot">> $seqres.full
+
+init_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
+
+if [ -z "$init_subvolid" ]; then
+	_fail "Unable to get the subvolid of the first snapshot"
+fi
+
+echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
+
+_scratch_unmount
+
+# Re-create the fs, as btrfs won't reuse the subvolume id.
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
+
+# Create a qgroup for the first subvolume, this would make the later
+# subvolume creation to find an existing qgroup, and abort transaction.
+$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seqres.full
+sync
+
+# Now create the first snapshot, which should have the same subvolid no matter
+# if the quota is enabled.
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
+$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
+	"$SCRATCH_MNT/snapshot">> $seqres.full
+
+# Either the snapshot create failed and transaction is aborted thus no
+# snapshot here, or we should be able to create the snapshot.
+new_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
+
+echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
+
+if [ -z "$new_subvolid" ]; then
+	_fail "Unable to get the subvolid of the first snapshot"
+fi
+
+# Make sure the subvolumeid for the first snapshot didn't change.
+if [ "$new_subvolid" -ne "$init_subvolid" ]; then
+	_fail "Subvolumeid for the first snapshot changed, has ${new_subvolid} expect ${init_subvolid}"
+fi
+
+_scratch_unmount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
new file mode 100644
index 00000000..d48808e6
--- /dev/null
+++ b/tests/btrfs/303.out
@@ -0,0 +1,2 @@
+QA output created by 303
+Silence is golden
-- 
2.42.0


