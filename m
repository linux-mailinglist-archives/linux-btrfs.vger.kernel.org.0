Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDA613434
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJaLLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJaLLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD13B847;
        Mon, 31 Oct 2022 04:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54903B815E2;
        Mon, 31 Oct 2022 11:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE14C433D7;
        Mon, 31 Oct 2022 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667214693;
        bh=KgBdBtmhw7LMT5jL6xTCRVd52JXwApMCk08xC5XsQ7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmQ1c2kw4JXFSnhAlEixf352xihZja5bkRoDQt/B+ELoL9uIqMQeL5NZj9VnRJ6Pr
         3NMF0eyjlNJvS0gLIPf7xhr6hUIQ6+gpkCV/pETTqsF+IGzk81XGRfJmqM7139nYJD
         CutYeiHO8uAaHFY6TLN/sfKLnRb5VYPh6uIHVJHeW8vEB8lHB4v7aQR1KQqcgnQVhb
         mLvEE6gWaCzd8Rpo0eevJtuon8aFkYUqreyi9usXyBBLKqEpf2dRFzpSXrvWRrUd/Y
         23XlPtZqhQ1o+hE00fDdjy2AQMSmiMtLdv8jZXlWBmMhevATymoEWEf5QhkuaVy8zj
         KXi6glO12YKUA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] btrfs: test that fiemap reports extent as not shared after deleting file
Date:   Mon, 31 Oct 2022 11:11:20 +0000
Message-Id: <27a0c4ab551b7a7410f4062f5235f20c88e77cfc.1667214081.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667214081.git.fdmanana@suse.com>
References: <cover.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we have two files with shared extents, after removing one of
the files, if we do a fiemap against the other file, it does not report
extents as shared anymore.

This exercises the processing of delayed references for data extents in
the backref walking code, used by fiemap to determine if an extent is
shared.

This used to fail until very recently and was fixed by the following
kernel commit that landed in 6.1-rc2:

  4fc7b5722824 (""btrfs: fix processing of delayed data refs during backref walking")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/279     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/279.out | 39 +++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100755 tests/btrfs/279
 create mode 100644 tests/btrfs/279.out

diff --git a/tests/btrfs/279 b/tests/btrfs/279
new file mode 100755
index 00000000..5b5824fd
--- /dev/null
+++ b/tests/btrfs/279
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 279
+#
+# Test that if we have two files with shared extents, after removing one of the
+# files, if we do a fiemap against the other file, it does not report extents as
+# shared anymore.
+#
+# This exercises the processing of delayed references for data extents in the
+# backref walking code, used by fiemap to determine if an extent is shared.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol fiemap clone
+
+. ./common/filter
+. ./common/reflink
+. ./common/punch # for _filter_fiemap_flags
+
+_supported_fs btrfs
+_require_scratch_reflink
+_require_cp_reflink
+_require_xfs_io_command "fiemap"
+
+_fixed_by_kernel_commit 4fc7b5722824 \
+	"btrfs: fix processing of delayed data refs during backref walking"
+
+run_test()
+{
+	local file_path_1=$1
+	local file_path_2=$2
+	local do_sync=$3
+
+	$XFS_IO_PROG -f -c "pwrite 0 64K" $file_path_1 | _filter_xfs_io
+	_cp_reflink $file_path_1 $file_path_2
+
+	if [ $do_sync -eq 1 ]; then
+		sync
+	fi
+
+	echo "Fiemap of $file_path_1 before deleting $file_path_2:" | \
+		_filter_scratch
+	$XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
+
+	rm -f $file_path_2
+
+	echo "Fiemap of $file_path_1 after deleting $file_path_2:" | \
+		_filter_scratch
+	$XFS_IO_PROG -c "fiemap -v" $file_path_1 | _filter_fiemap_flags
+}
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Create two test subvolumes, we'll reflink files between them.
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv2 | _filter_scratch
+
+echo
+echo "Testing with same subvolume and without transaction commit"
+echo
+run_test "$SCRATCH_MNT/subv1/f1" "$SCRATCH_MNT/subv1/f2" 0
+
+echo
+echo "Testing with same subvolume and with transaction commit"
+echo
+run_test "$SCRATCH_MNT/subv1/f3" "$SCRATCH_MNT/subv1/f4" 1
+
+echo
+echo "Testing with different subvolumes and without transaction commit"
+echo
+run_test "$SCRATCH_MNT/subv1/f5" "$SCRATCH_MNT/subv2/f6" 0
+
+echo
+echo "Testing with different subvolumes and with transaction commit"
+echo
+run_test "$SCRATCH_MNT/subv1/f7" "$SCRATCH_MNT/subv2/f8" 1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
new file mode 100644
index 00000000..a959a86d
--- /dev/null
+++ b/tests/btrfs/279.out
@@ -0,0 +1,39 @@
+QA output created by 279
+Create subvolume 'SCRATCH_MNT/subv1'
+Create subvolume 'SCRATCH_MNT/subv2'
+
+Testing with same subvolume and without transaction commit
+
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Fiemap of SCRATCH_MNT/subv1/f1 before deleting SCRATCH_MNT/subv1/f2:
+0: [0..127]: shared|last
+Fiemap of SCRATCH_MNT/subv1/f1 after deleting SCRATCH_MNT/subv1/f2:
+0: [0..127]: last
+
+Testing with same subvolume and with transaction commit
+
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Fiemap of SCRATCH_MNT/subv1/f3 before deleting SCRATCH_MNT/subv1/f4:
+0: [0..127]: shared|last
+Fiemap of SCRATCH_MNT/subv1/f3 after deleting SCRATCH_MNT/subv1/f4:
+0: [0..127]: last
+
+Testing with different subvolumes and without transaction commit
+
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Fiemap of SCRATCH_MNT/subv1/f5 before deleting SCRATCH_MNT/subv2/f6:
+0: [0..127]: shared|last
+Fiemap of SCRATCH_MNT/subv1/f5 after deleting SCRATCH_MNT/subv2/f6:
+0: [0..127]: last
+
+Testing with different subvolumes and with transaction commit
+
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Fiemap of SCRATCH_MNT/subv1/f7 before deleting SCRATCH_MNT/subv2/f8:
+0: [0..127]: shared|last
+Fiemap of SCRATCH_MNT/subv1/f7 after deleting SCRATCH_MNT/subv2/f8:
+0: [0..127]: last
-- 
2.35.1

