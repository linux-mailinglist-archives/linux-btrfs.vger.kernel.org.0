Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6C49DA59
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 06:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiA0Fx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 00:53:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiA0Fx0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 00:53:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15E251F45F;
        Thu, 27 Jan 2022 05:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643262805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rgODDGKh4vi6cYP8u2RG4U3WKnsoI5Chdh0mg9+5Dkg=;
        b=KNhrH3uJwEpP7h0KreszVXr9iPww4YYlqyNKH65Xx2fNYnSjvifGC8iXIBRt9heTxwFlo4
        bTWqzw4U4b+H0lOSTZWHuR7Njl+l3Qj2eJSdI3EI1+hR2sWP15Lny7F8caYyf3AURFCJpR
        t+XLyXcMea8i7G3luOk/jSL1fDYpt9U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 333BA13F5F;
        Thu, 27 Jan 2022 05:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RKkLO1Mz8mFRZwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 27 Jan 2022 05:53:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case to verify that btrfs won't waste IO/CPU to defrag compressed extents already at their max size
Date:   Thu, 27 Jan 2022 13:53:06 +0800
Message-Id: <20220127055306.30252-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing bug in btrfs defrag code that it will always
try to defrag compressed extents, even they are already at max capacity.

This will not reduce the number of extents, but only waste IO/CPU.

The kernel fix is titled:

  btrfs: defrag: don't defrag extents which is already at its max capacity

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/257     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/257.out |  2 ++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/btrfs/257
 create mode 100644 tests/btrfs/257.out

diff --git a/tests/btrfs/257 b/tests/btrfs/257
new file mode 100755
index 00000000..326687dc
--- /dev/null
+++ b/tests/btrfs/257
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 257
+#
+# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
+# at their max capacity.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag
+
+# Import common functions.
+. ./common/filter
+. ./common/btrfs
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+# Needs 4K sectorsize, as larger sectorsize can change the file layout.
+_require_btrfs_support_sectorsize 4096
+
+get_extent_disk_sector()
+{
+	local file=$1
+	local offset=$2
+
+	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
+		head -n1 | $AWK_PROG '{print $3}'
+}
+
+_scratch_mkfs >> $seqres.full
+
+# Need datacow to show which range is defragged, and we're testing
+# autodefrag with compression
+_scratch_mount -o datacow,autodefrag,compress
+
+# Btrfs uses 128K as compressed extent max size, so this would result
+# exactly two extents, which are all at their max size
+$XFS_IO_PROG -f -c "pwrite -S 0xee 0 128k" -c sync \
+		-c "pwrite -S 0xff 128k 128k" -c sync \
+		$SCRATCH_MNT/foobar >> $seqres.full
+
+old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+old_extent1=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+old_extent2=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 128k)
+
+echo "=== File extent layout before defrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
+
+new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+new_extent1=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+new_extent2=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 128k)
+
+echo "=== File extent layout before defrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+if [ $new_csum != $old_csum ]; then
+	echo "file content changed"
+fi
+
+if [ $new_extent1 != $old_extent1 ]; then
+	echo "the first extent get defragged"
+fi
+
+if [ $new_extent2 != $old_extent2 ]; then
+	echo "the second extent get defragged"
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
new file mode 100644
index 00000000..cc3693f3
--- /dev/null
+++ b/tests/btrfs/257.out
@@ -0,0 +1,2 @@
+QA output created by 257
+Silence is golden
-- 
2.34.1

