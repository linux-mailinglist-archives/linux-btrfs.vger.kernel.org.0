Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319504A6CF2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 09:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiBBIcR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 03:32:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiBBIcR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 03:32:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C8D9210FD;
        Wed,  2 Feb 2022 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643790736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=au7IWxOAYfgxW0RFE+juojWRdRwolzu2CqVEmix0gLM=;
        b=KPU9bX7BZjWU26SoraWwNGZFb785nmpDLuQLDaWg9XyHJpzSxH6jb55Dg9zg+hd472Uj83
        09KTL9NhCcIRGXy+DQ7HN5Pwug5FXg/yJMRtDbPspaCIb0giXVywH9bBLfEoXZ9GdMyk39
        ES4gc0fJMbdPTepVKSgtOCkSv0jcMRc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8735013DE1;
        Wed,  2 Feb 2022 08:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BoaFI9B+mG9JwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 02 Feb 2022 08:32:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case to verify "btrfs filesystem defrag -c" behavior
Date:   Wed,  2 Feb 2022 16:31:58 +0800
Message-Id: <20220202083158.68262-1-wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Despite the regular file defragging, "btrfs filesystem defrag" provides
an option, -c, to convert all data extents (except holes and
preallocated ranges) to a new compression algorithm.

The special behavior here is, unlike defrag which is not going to touch
extents which are adajacent to preallocated/hole ranges, with -c, all
non-hole/non-preallocated extents should be defragged and converted to
the new compression algorithm.

This test case will ensure the old behavior is properly kept.

Currently both old kernels (v5.15 and older) and newer kernel with
refactored defrag (v5.16 and newer) can pass the tests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/258     | 153 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/258.out |   2 +
 2 files changed, 155 insertions(+)
 create mode 100755 tests/btrfs/258
 create mode 100644 tests/btrfs/258.out

diff --git a/tests/btrfs/258 b/tests/btrfs/258
new file mode 100755
index 00000000..a82e5af9
--- /dev/null
+++ b/tests/btrfs/258
@@ -0,0 +1,153 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 258
+#
+# Make sure "btrfs filesystem defrag" can still convert the compression
+# algorithm of all regular extents.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag compress
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+get_inode_number()
+{
+	local file="$1"
+
+	stat -c "%i" "$file"
+}
+
+get_file_extent()
+{
+	local file="$1"
+	local offset="$2"
+	local ino=$(get_inode_number "$file")
+	local file_extent_key="($ino EXTENT_DATA $offset)"
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
+		grep -A4 "$file_extent_key"
+}
+
+check_file_extent()
+{
+	local file="$1"
+	local offset="$2"
+	local expected="$3"
+
+	echo "=== file extent at file '$file' offset $offset ===" >> $seqres.full
+	get_file_extent "$file" "$offset" > $tmp.output
+	cat $tmp.output >> $seqres.full
+	grep -q "$expected" $tmp.output ||\
+		echo "file \"$file\" offset $offset doesn't have expected string \"$expected\""
+}
+
+# Unlike file extents whose btrfs specific attributes need to be grabbed from
+# dump-tree, we can check holes by fiemap. In fact recent no-holes feature
+# even makes it unable to grab holes from dump-tree.
+check_hole()
+{
+	local file="$1"
+	local offset="$2"
+	local len="$3"
+
+	output=$($XFS_IO_PROG -c "fiemap $offset $len" "$file" |\
+		 _filter_xfs_io_fiemap | head -n1)
+	if [ -z $output ]; then
+		echo "=== file extent at file '$file' offset $offset is a hole ===" \
+			>> $seqres.full
+	else
+		echo "=== file extent at file '$file' offset $offset is not a hole ==="
+	fi
+}
+
+# Needs 4K sectorsize as the test is crafted using that sectorsize
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs -s 4k >> $seqres.full 2>&1
+
+# Initial data is compressed using lzo
+_scratch_mount -o compress=lzo,compress-force=lzo
+
+# file 'large' has all of its compressed extents at their maximum size
+$XFS_IO_PROG -f -c "pwrite 0 1m" "$SCRATCH_MNT/large" >> $seqres.full
+
+# file 'fragment' has all of its compressed extents adjacent to
+# preallocated/hole ranges, which should not be defragged with regular
+# defrag ioctl, but should still be defragged by "btrfs fi defrag -c"
+$XFS_IO_PROG -f -c "pwrite 0 16k" \
+		-c "pwrite 32k 16k" -c "pwrite 64k 16k" \
+		"$SCRATCH_MNT/fragment" >> $seqres.full
+sync
+# We only do the falloc after the compressed data reached disk.
+# Or the inode could have PREALLOC flag, and prevent the
+# data from being compressed.
+$XFS_IO_PROG -f -c "falloc 16k 16k" "$SCRATCH_MNT/fragment"
+sync
+
+echo "====== Before the defrag ======" >> $seqres.full
+
+# Should be lzo compressed 
+check_file_extent "$SCRATCH_MNT/large" 0 "compression 2"
+
+# Should be lzo compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 2"
+
+# Should be preallocated
+check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
+
+# Should be lzo compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 2"
+
+# Should be hole
+check_hole "$SCRATCH_MNT/fragment" 49152 16384
+
+# Should be lzo compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 2"
+
+$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/large" -czstd \
+	"$SCRATCH_MNT/fragment" >> $seqres.full
+# Need to commit the transaction or dump-tree won't grab the new
+# metadata on-disk.
+sync
+
+echo "====== After the defrag ======" >> $seqres.full
+
+# Should be zstd compressed 
+check_file_extent "$SCRATCH_MNT/large" 0 "compression 3"
+
+# Should be zstd compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 3"
+
+# Should be preallocated
+check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
+
+# Should be zstd compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 3"
+
+# Should be hole
+check_hole "$SCRATCH_MNT/fragment" 49152 16384
+
+# Should be zstd compressed 
+check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 3"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/258.out b/tests/btrfs/258.out
new file mode 100644
index 00000000..9d47016c
--- /dev/null
+++ b/tests/btrfs/258.out
@@ -0,0 +1,2 @@
+QA output created by 258
+Silence is golden
-- 
2.34.1

