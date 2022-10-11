Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1865FB25D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJKMXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJKMXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 08:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEA8E989;
        Tue, 11 Oct 2022 05:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4523C61185;
        Tue, 11 Oct 2022 12:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BFC433B5;
        Tue, 11 Oct 2022 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665491016;
        bh=sBHJ6g0DrAuFV6GU9I0trG4dICA0Idrzl/SrDamatmo=;
        h=From:To:Cc:Subject:Date:From;
        b=WoJMiWieiCQ6xkdlK2yAm0aF5bvJUKsApOZGIBjLezF6x+DE2pQKv+4vvmcuF5KrJ
         PTIxt2VbG4/AO5GRDe9nmqX7ArKLEqFRL2wjzBO6PTwiZVU2shGm46SsTE+RP2mo6N
         7QzwJmmDcbAvwgUr4H0bEcFr8hrtniglgpIYCWehWg6Lag871FXl8ASj3KWf72n89e
         jaHqlkrKp8oqNs+G5lWxO0BloFFdpyjSf5baFpgKTRLwRff1kueK8ToPxYrdcMmPLW
         o5JkPmnhwtb6v2wJPeP9cnW9Qpb54XHnKUyKDD91krBYIIMcEIwQYw6bpHyBeDBxZm
         Ae2sEJI5smPLQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fiemap reports extent as shared after cloning it
Date:   Tue, 11 Oct 2022 13:22:03 +0100
Message-Id: <c5ede97bf4c2537ef9ee3adf35a9b35cb2150b8a.1665490911.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we have two consecutive extents and only one of them is
cloned, then fiemap correctly reports which one is shared and reports
the other as not shared.

This currently fails on btrfs for all kernel releases, but is fixed by
a kernel patch that landed in Linus' tree last week:

  ac3c0d36a2a2f7 ("btrfs: make fiemap more efficient and accurate reporting extent sharedness")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/702     | 92 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/702.out | 23 +++++++++++
 2 files changed, 115 insertions(+)
 create mode 100755 tests/generic/702
 create mode 100644 tests/generic/702.out

diff --git a/tests/generic/702 b/tests/generic/702
new file mode 100755
index 00000000..f93bc946
--- /dev/null
+++ b/tests/generic/702
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 702
+#
+# Test that if we have two consecutive extents and only one of them is cloned,
+# then fiemap correctly reports which one is shared and reports the other as not
+# shared.
+#
+. ./common/preamble
+_begin_fstest auto quick clone fiemap
+
+. ./common/filter
+. ./common/reflink
+
+_fixed_by_kernel_commit ac3c0d36a2a2f7 \
+	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
+
+_supported_fs generic
+_require_scratch_reflink
+_require_xfs_io_command "fiemap"
+
+fiemap_test_file()
+{
+	local filepath=$1
+
+	# Skip the first two lines of xfs_io's fiemap output (file path and
+	# header describing the output columns).
+	#
+	# Print the first column (extent number), second column (file range),
+	# fourth column (extent size) and fifth column (flags) of the fiemap
+	# output.
+	#
+	# We filter the flags column to only tell us if an extent is shared or
+	# not (flag 0x2000, which matches FIEMAP_EXTENT_SHARED) because on some
+	# filesystem configs we may have other flags printed - for example
+	# running btrfs with "-o compress" we get the flag 0x8 as well (which
+	# is FIEMAP_EXTENT_ENCODED).
+	#
+	# The third column is the physical location of the extents, so it's
+	# omitted because the location varies between different filesystems.
+	#
+	$XFS_IO_PROG -c "fiemap -v" $filepath | tail -n +3 | \
+		$AWK_PROG '{ print $1, $2, $4, \
+			  and(strtonum($5), 0x2000) ? "shared" : "not_shared" }'
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+# We create 128K extents in the test files below.
+_require_congruent_file_oplen $SCRATCH_MNT $((128 * 1024))
+
+# Create file foo with 2 consecutive extents, each one with a size of 128K.
+echo "Creating file foo"
+$XFS_IO_PROG -f -c "pwrite -b 128K 0 128K" -c "fsync" \
+	     -c "pwrite -b 128K 128K 128K" -c "fsync" \
+	     $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Clone only the first extent into another file.
+echo "Cloning first extent of file foo to file bar"
+$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/foo 0 0 128K" $SCRATCH_MNT/bar | \
+	_filter_xfs_io
+
+# Now fiemap file foo, it should report the first 128K extent as shared and the
+# second 128K extent as not shared.
+echo "fiemap of file foo:"
+fiemap_test_file $SCRATCH_MNT/foo
+
+# Now do a similar test as above, except that this time only the second 128K
+# extent is cloned, the first extent is not cloned.
+
+# Create file foo2 with 2 consecutive extents, each one with a size of 128K.
+echo "Creating file foo2"
+$XFS_IO_PROG -f -c "pwrite -b 128K 0 128K" -c "fsync" \
+	     -c "pwrite -b 128K 128K 128K" -c "fsync" \
+	     $SCRATCH_MNT/foo2 | _filter_xfs_io
+
+# Clone only the second extent of foo2 into another file.
+echo "Cloning second extent of file foo2 to file bar2"
+$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/foo2 128K 0 128K" $SCRATCH_MNT/bar2 | \
+	_filter_xfs_io
+
+# Now fiemap file foo2, it should report the first 128K extent as not shared and
+# the second 128K extent as shared
+echo "fiemap of file foo2:"
+fiemap_test_file $SCRATCH_MNT/foo2
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/702.out b/tests/generic/702.out
new file mode 100644
index 00000000..576bb5e8
--- /dev/null
+++ b/tests/generic/702.out
@@ -0,0 +1,23 @@
+QA output created by 702
+Creating file foo
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning first extent of file foo to file bar
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+fiemap of file foo:
+0: [0..255]: 256 shared
+1: [256..511]: 256 not_shared
+Creating file foo2
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning second extent of file foo2 to file bar2
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+fiemap of file foo2:
+0: [0..255]: 256 not_shared
+1: [256..511]: 256 shared
-- 
2.35.1

