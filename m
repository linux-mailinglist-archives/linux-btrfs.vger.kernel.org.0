Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C458B621
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiHFOfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiHFOfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 10:35:09 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401CA12758
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 07:35:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id EA87E2A23FDA9;
        Sat,  6 Aug 2022 22:35:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1659796506; bh=h7vrbD78lFi6B+Lx/u+OsG1iAHRsZIuRbhr5OUKRMJg=;
        h=From:To:Cc:Subject:Date;
        b=qHogRfjOZYglGEeZG+bb9XClCViNY/T4HjXUqB9gRWcz3fsf98X2VlFkP7MKI48/L
         KRTEg1Jl66LFeBlEO2fZtQgP3uZ/1aFzQ1GKbdgDlKcV13yHuQ+zjr1x9MarvWDytD
         z2zkeWZLbL9QzH5o/W1vnTuio0a1aVJfuiyVIXpw=
From:   bingjingc <bingjingc@synology.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     fdmanana@kernel.org, bxxxjxxg@gmail.com,
        BingJing Chang <bingjingc@synology.com>
Subject: [PATCH] fstests: btrfs: test incremental send for changed reference paths
Date:   Sat,  6 Aug 2022 22:34:36 +0800
Message-Id: <20220806143436.3501-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Normally btrfs stores reference paths in an array of ref items. However,
items for the same parent directory can not exceed the size of a leaf. So
btrfs also store the rest of them in extended ref items alternatively.

In this test, it creates a large number of links under a directory
causing the reference paths stored in these two ways as the parent
snapshot. And it deletes and recreates just an amount of them that can be
stored within an array of ref items as the send snapshot. Test that an
incremental send operation correctly issues link/unlink operations only
against new/deleted reference paths, or the receive operation will fail
due to a link on an existed path.

This currently fails on btrfs but is fixed by a kernel patch with the
following subject:

  "btrfs: send: fix sending link commands for existing file paths"

Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/btrfs/272     | 65 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/272.out |  2 ++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/btrfs/272
 create mode 100644 tests/btrfs/272.out

diff --git a/tests/btrfs/272 b/tests/btrfs/272
new file mode 100755
index 00000000..a362d943
--- /dev/null
+++ b/tests/btrfs/272
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 BingJing Chang.
+#
+# FS QA Test No. btrfs/272
+#
+# Regression test for btrfs incremental send issue where a link instruction
+# is sent against an existed file, causing btrfs receive to fail.
+#
+# This issue is fixed by the following linux kernel btrfs patch:
+#
+#   btrfs: send: fix sending link commands for existing file paths
+#
+. ./common/preamble
+_begin_fstest auto quick send
+
+tmp=`mktemp -d`
+
+# Override the default cleanup function.
+_cleanup()
+{
+	rm -rf $tmp
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+
+# create a file and 2000 hard links to the same inode
+touch $SCRATCH_MNT/vol/foo
+for i in {1..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# take a snapshot for a parent snapshot
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+
+# remove 2000 hard links and re-create the last 1000 links
+for i in {1..2000}; do
+	rm $SCRATCH_MNT/vol/$i
+done
+for i in {1001..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# take another one for a send snapshot
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
+
+mkdir $SCRATCH_MNT/receive_dir
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $tmp/diff.snap \
+	$SCRATCH_MNT/snap2
+_run_btrfs_util_prog receive -f $tmp/diff.snap $SCRATCH_MNT/receive_dir
+_scratch_unmount
+
+echo "Silence is golden"
+status=0 ; exit
diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
new file mode 100644
index 00000000..c18563ad
--- /dev/null
+++ b/tests/btrfs/272.out
@@ -0,0 +1,2 @@
+QA output created by 272
+Silence is golden
-- 
2.37.1

