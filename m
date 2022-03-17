Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8A4DC985
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 16:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiCQPFM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiCQPFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 11:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78286F1E88;
        Thu, 17 Mar 2022 08:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A102B81EA0;
        Thu, 17 Mar 2022 15:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095E1C340F2;
        Thu, 17 Mar 2022 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647529429;
        bh=orGX/kh4NsHZWmLxoR4eUmzkWSNg0vLppIh8Pnn9QEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fML2/kYLQ7aHrmrP9ReciHYN3VdTueLSC+Gf4Q6tzvTP8N1Ku3CKGbeoYnEPmOjKI
         hpZG+zbdvZwSQen0ND3vwhqHg2L83PPcn7Ayhe0AJC3+1SCKBhAVs5SqRma217GbXC
         vvX59VyF3WgCt2e4b/F6PV4Gi2c4IZQLBErMgkfncGJ5ZBKVjWhWLSChkUoBYmECsg
         TwLuyxPdPZdFtIBPNSY5iuqQx8A6gHH39CcNwUzFjouufMfbo9y/jNspdfrWKaez0x
         KXTEyYgePdfwC0z5E0WgJeZyiIbhqFcRLwfDdac3hsM1H161HMNZYJAR+SQPtT2N7u
         yxvmzveVvS+XQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fallocate against a file range with a mix of holes and extents
Date:   Thu, 17 Mar 2022 15:03:40 +0000
Message-Id: <4db70a749eaf214025dd944df5b231f4c317e13e.1647529329.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we call fallocate against a file range that has a mix of holes
and written extents, the fallocate succeeds if the filesystem has enough free
space to allocate extents for the holes.

This currently fails on btrfs and is fixed by a patch that has the subject:

  "btrfs: only reserve the needed data space amount during fallocate"

There's nothing that is really specific to btrfs in the test case, and the
same test passes on ext4 and f2fs for example. But it fails on xfs, and
after some discussion with Darrick, it seems it's due to technical reasons
that would require a significant effort to xfs's implementation, and at
the moment there isn't enough motivation to do such change. The relevent
thread is at:

   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/

So for the time being, make the test btrfs specific.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/261     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out | 20 ++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/btrfs/261
 create mode 100644 tests/btrfs/261.out

diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..e7e9f15e
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 261
+#
+# Test that if we call fallocate against a large file range that is nearly full
+# with written extents, the fallocate succeeds and allocates unwritten extents
+# for the holes in the range.
+#
+. ./common/preamble
+_begin_fstest auto quick prealloc
+
+. ./common/rc
+. ./common/filter
+. ./common/punch
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fiemap"
+
+rm -f $seqres.full
+
+# Create a 1G filesystem.
+_scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mount
+
+# Create a file with a size of 600M and two holes, each with a size of 1M and
+# at file ranges [200, 201M[ and [401M, 402M[.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 200M" \
+                -c "pwrite -S 0xcd 201M 200M" \
+                -c "pwrite -S 0xef 402M 198M" \
+		$SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now call fallocate against the whole file range.
+# It should succeed, because only 2M of data space needs to be allocated,
+# and not 600M (which isn't available since our fs has a size of 1G).
+$XFS_IO_PROG -c "falloc 0 600M" $SCRATCH_MNT/foobar
+
+# Unmount and mount again the filesystem. We want to veriy that the fallocate
+# results were persisted and that all the file metadata and data on disk are
+# also correct.
+_scratch_cycle_mount
+
+echo -n "Number of unwritten extents in the file: "
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap | \
+    grep 'unwritten' | wc -l
+
+# Verify we don't have any corruption caused by the fallocate.
+echo "File content after fallocate:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100644
index 00000000..db7f0d6d
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,20 @@
+QA output created by 261
+wrote 209715200/209715200 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 209715200/209715200 bytes at offset 210763776
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 207618048/207618048 bytes at offset 421527552
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Number of unwritten extents in the file: 2
+File content after fallocate:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+209715200 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+210763776 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+420478976 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+421527552 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+629145600
-- 
2.33.0

