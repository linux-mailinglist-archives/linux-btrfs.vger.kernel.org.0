Return-Path: <linux-btrfs+bounces-18418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308BC21795
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 18:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78AEC4EE180
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B83683B4;
	Thu, 30 Oct 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQoE9TQP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B083191B7;
	Thu, 30 Oct 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844970; cv=none; b=MrDZIFkecj6bFtQiG3Y0ORswvow+cCOyaLqRaPNfejU1DgIEZ3p+g1b3O5voIelOVUrrycx161Si9EhGEfu3P37zUIJJIG1hHhWl2ac8gIE3NgQ5nG8MHuw4N/TAokbM6uBO8qoebPRnPcbLxwS8t23eoJzwlnwX+Bg9/to+O5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844970; c=relaxed/simple;
	bh=W07yYwa5au1fJ3WzG5uZqyYf4v1LD3aCRdwM94U6qcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7Y2wzgdF4C+625iEx/MqncL0PJdn7xny19sn83kxyH7DpCRirfgnUttVuV2Ww0zAFsgr37iu7yUpVbkK6/dBSyJXA9IydaQ726RGkE2Te0EKfyuFu7793H7Zz1Ey+wPOH3YafglHtpvXXoWPnA3pyU+8S4AIryK5gnYO3kTuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQoE9TQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCFFC4CEF1;
	Thu, 30 Oct 2025 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844969;
	bh=W07yYwa5au1fJ3WzG5uZqyYf4v1LD3aCRdwM94U6qcY=;
	h=From:To:Cc:Subject:Date:From;
	b=cQoE9TQPdmMjj2H+lOcdEF9b4ghB5+5l6wDzK10jU7TRUzo5yg6OeHrUfzUunjJXg
	 xiCg+J2s3JufBFqTtBUSeyZRvrE73rs0KX/uCcWmYmwk6+V7MhgMi9DmlauX7fyXLj
	 HWAy9YRZaIc5fMiA32nkknCmggwoBTtCxn2BJF/Jp5ZhFy5TuhZLcg6SUTpjaEjTka
	 cpCNV+32FQTRHE1Ca2DJSqIE1UkkufpLwYjA4PF3xev3t+7b5qMXMCBonnMuRSpMg/
	 Df8las7RKHan4qvJh7ZIs+DO+VisqDAgFDTCzT0yyqP/lnLpFXn/kcyaIaKDKylvhN
	 jtr4MoksrW2pg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send after deleting directories with many hardlinks
Date: Thu, 30 Oct 2025 17:22:44 +0000
Message-ID: <8d1b819511b4c93b5ba0b3137090f5c28a952364.1761844883.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send works after we removed directories that have
large number of hardlinks for the same file (so that we have extrefs).

This is a regression test for the kernel commit 1fabe43b4e1a ("btrfs:
send: fix duplicated rmdir operations when using extrefs").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/338     | 93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/338.out |  3 ++
 2 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/338
 create mode 100644 tests/btrfs/338.out

diff --git a/tests/btrfs/338 b/tests/btrfs/338
new file mode 100755
index 00000000..0cc29c7c
--- /dev/null
+++ b/tests/btrfs/338
@@ -0,0 +1,93 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 338
+#
+# Test that an incremental send works after we removed directories that have
+# large number of hardlinks for the same file (so that we have extrefs).
+#
+. ./common/preamble
+_begin_fstest auto quick send
+
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	rm -fr $send_files_dir
+}
+
+_require_test
+_require_scratch
+_require_fssum
+
+_fixed_by_kernel_commit 1fabe43b4e1a \
+	"btrfs: send: fix duplicated rmdir operations when using extrefs"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+first_stream="$send_files_dir/1.send"
+second_stream="$send_files_dir/2.send"
+first_fssum="$send_files_dir/snap1.fssum"
+second_fssum="$send_files_dir/snap2.fssum"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
+_scratch_mount
+
+# Create two directories which will have many hardlinks for the same file, a
+# large number that triggers the use of extrefs. This way we will get many
+# extref items in the subvolume tree, with a very high likelyhood that not
+# all hardlinks for directory "a" are consecutive in the tree, that they are
+# interspersed with extref items for hardlinks to directory "b".
+#
+# Example:
+#
+#        item 0 key (259 INODE_EXTREF 2309449) itemoff 16257 itemsize 26
+#                index 6925 parent 257 namelen 8 name: foo.6923
+#        item 1 key (259 INODE_EXTREF 2311350) itemoff 16231 itemsize 26
+#                index 6588 parent 258 namelen 8 name: foo.6587
+#        item 2 key (259 INODE_EXTREF 2457395) itemoff 16205 itemsize 26
+#                index 6611 parent 257 namelen 8 name: foo.6609
+#        (...)
+#
+# Refer to the kernel commit's changelog for more details.
+mkdir $SCRATCH_MNT/a
+mkdir $SCRATCH_MNT/b
+
+touch $SCRATCH_MNT/a/foo
+for ((i = 1; i <= 1000; i++)); do
+	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/a/foo.$i
+	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo.$i
+done
+
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+
+# Now delete the directories and all the links inside them.
+rm -fr $SCRATCH_MNT/a
+rm -fr $SCRATCH_MNT/b
+
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
+
+_btrfs send -f $first_stream $SCRATCH_MNT/snap1
+_btrfs send -f $second_stream -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
+
+$FSSUM_PROG -A -f -w $first_fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -A -f -w $second_fssum -x $SCRATCH_MNT/snap2/snap1 \
+	$SCRATCH_MNT/snap2
+
+# Create a new fs and apply both send streams.
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
+_scratch_mount
+
+_btrfs receive -f $first_stream $SCRATCH_MNT
+_btrfs receive -f $second_stream $SCRATCH_MNT
+
+$FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2
+
+# success, all done
+_exit 0
diff --git a/tests/btrfs/338.out b/tests/btrfs/338.out
new file mode 100644
index 00000000..7ea61817
--- /dev/null
+++ b/tests/btrfs/338.out
@@ -0,0 +1,3 @@
+QA output created by 338
+OK
+OK
-- 
2.47.2


