Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A654A6FBB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbiBBLPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 06:15:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbiBBLP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 06:15:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3EAFD21114;
        Wed,  2 Feb 2022 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643800527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=OI0z+u5I0IlSp+noGxFtGuTkBWe5ok2x+UFv18BFg80=;
        b=rXbBZ/JKbQ+RJhNWiHUvvYMhpkvZIkxRrHc8misNbg9oS/+1sFvhiLpcgS/kinjetfFW7u
        Xk6e9LvRrxSu5EChLR0LzvQQvtZwUx++tRPB3+goIjUXZ+kO9qBDLxTQNJ1NP/MqOZI79V
        p719M6vsQlFmwafEJdCN9BiPY+ROZLs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 596DA13E05;
        Wed,  2 Feb 2022 11:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K47SCM5n+mGSfgAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 02 Feb 2022 11:15:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add test case to verify "btrfs filesystem defragment -c" behavior
Date:   Wed,  2 Feb 2022 19:15:08 +0800
Message-Id: <20220202111508.81263-1-wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Despite the regular file defragging, "btrfs filesystem defragment" provides
an option, -c, to convert all data extents (except holes and
preallocated ranges) to a new compression algorithm.

The special behavior here is, unlike regular defrag which is not going to
touch extents which are adjacent to preallocated/hole ranges, with -c, all
non-hole/non-preallocated extents should be defragged and converted to
the new compression algorithm.

This test case will ensure the old behavior is properly kept.

Currently both old kernels (v5.15 and older) and newer kernel with
refactored defrag (v5.16 and newer) can pass the tests.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add the test into prealloc group
- Add explicit requirement for ranged fiemap and prealloc of xfs_io
- Fix a typo in commit message
- Use full "btrfs filesystem defragment" in the test case
- Remove unnecessary compress-force mount option
- Remove unnecessary -f option for xfs_io falloc command
  Which is working on an existing file.
---
 tests/btrfs/258     | 158 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/258.out |   2 +
 2 files changed, 160 insertions(+)
 create mode 100755 tests/btrfs/258
 create mode 100644 tests/btrfs/258.out

diff --git a/tests/btrfs/258 b/tests/btrfs/258
new file mode 100755
index 00000000..360bb5f5
--- /dev/null
+++ b/tests/btrfs/258
@@ -0,0 +1,158 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 258
+#
+# Make sure "btrfs filesystem defragment" can still convert the compression
+# algorithm of all regular extents.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag compress prealloc
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
+_require_xfs_io_command "fiemap" "ranged"
+_require_xfs_io_command "falloc"
+_require_btrfs_command inspect-internal dump-tree
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
+# dump-tree, we can check holes by fiemap. And mkfs enables no-holes feature by
+# default in recent versions of btrfs-progs, preventing us from grabbing holes
+# from dump-tree.
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
+_scratch_mount -o compress=lzo
+
+# file 'large' has all of its compressed extents at their maximum size
+$XFS_IO_PROG -f -c "pwrite 0 1m" "$SCRATCH_MNT/large" >> $seqres.full
+
+# file 'fragment' has all of its compressed extents adjacent to
+# preallocated/hole ranges, which should not be defragged with regular
+# defrag ioctl, but should still be defragged by
+# "btrfs filesystem defragment -c"
+$XFS_IO_PROG -f -c "pwrite 0 16k" \
+		-c "pwrite 32k 16k" -c "pwrite 64k 16k" \
+		"$SCRATCH_MNT/fragment" >> $seqres.full
+sync
+# We only do the falloc after the compressed data reached disk.
+# Or the inode could have PREALLOC flag, and prevent the
+# data from being compressed.
+$XFS_IO_PROG -c "falloc 16k 16k" "$SCRATCH_MNT/fragment"
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
+$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/large" -czstd \
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

