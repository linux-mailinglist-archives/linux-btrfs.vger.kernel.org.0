Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B31792F8E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbjIEUIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242698AbjIEUIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:08:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADF199;
        Tue,  5 Sep 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dpctAN8yIpJSMB/GLp3M6ArNQv+a+uUGcuwQybJnBX4=; b=O5L1FHHC9Gq0OPKv1F70Iw3QWs
        rfoBl8E/wPC+Cdok5bCvetUypQMPws/1l6yvHzuG4pO4A1P5coGb2NZpoPmWOPVV6Z2KfbAc1m4IE
        o4K3x4qG6MMSHtzTc3Lyj4AC0KTroyWPo22R+5n8scIB4nrHs40au8XV0l3wihBEn8BPHtvQsto7x
        nA0fUqvfictxXVOPpA8xdLtpbgt6DzOtY1mrV0j4JsbUrUms/bRnCIRweNB9svQYswMmZq0UOEnf/
        rY0mLVq+AHQ/6UlQoqFYFxK7RlLf68wTuS2tBHjNmolAILOve9+iD2Gku1YMxrujcfTCrmbRd7r84
        r6gBez2Q==;
Received: from [179.232.147.2] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qdcLk-002klH-4q; Tue, 05 Sep 2023 22:08:36 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, kernel@gpiccoli.net, kernel-dev@igalia.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] btrfs: Add test for the single-dev feature
Date:   Tue,  5 Sep 2023 17:06:56 -0300
Message-ID: <20230905200826.3605083-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The SINGLE_DEV btrfs feature allows to mount the same filesystem
multiple times, at the same time. This is the fstests counter-part,
which checks both mkfs/btrfstune (by mounting the FS twice), and
also unsupported scenarios, like device replace / remove.

Suggested-by: Anand Jain <anand.jain@oracle.com>
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V2:
- Rebased against v2023.09.03 / changed test number to 301;

- Implemented the great suggestions from Anand, which definitely
made the test more clear and concise;

-Cc'ing linux-btrfs as well.

Thanks in advance for reviews / comments!
Cheers,

Guilherme


 tests/btrfs/301     | 94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |  5 +++
 2 files changed, 99 insertions(+)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

diff --git a/tests/btrfs/301 b/tests/btrfs/301
new file mode 100755
index 000000000000..5f8abdbe157a
--- /dev/null
+++ b/tests/btrfs/301
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
+#
+# FS QA Test 301
+#
+# Test for the btrfs single-dev feature - both mkfs and btrfstune are
+# validated, as well as explicitly unsupported commands, like device
+# removal / replacement.
+#
+. ./common/preamble
+_begin_fstest auto mkfs quick
+. ./common/filter
+_supported_fs btrfs
+
+_require_btrfs_mkfs_feature single-dev
+_require_btrfs_fs_feature single_dev
+
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 1
+_spare_dev_get
+
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_command "$WIPEFS_PROG" wipefs
+
+# Helper to mount a btrfs fs
+# Arg 1: device
+# Arg 2: mount point
+mount_btrfs()
+{
+	$MOUNT_PROG -t btrfs $1 $2
+	[ $? -ne 0 ] && _fail "mounting $1 on $2 failed"
+}
+
+SPARE_MNT="${TEST_DIR}/${seq}/spare_mnt"
+mkdir -p $SPARE_MNT
+
+
+# Part 1
+# First test involves a mkfs with single-dev feature enabled.
+# If it succeeds and mounting that FS *twice* also succeeds,
+# we're good and continue.
+$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
+$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
+
+_scratch_mkfs "-b 300M -O single-dev" >> $seqres.full 2>&1
+dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
+
+mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
+mount_btrfs $SPARE_DEV $SPARE_MNT
+
+$UMOUNT_PROG $SPARE_MNT
+$UMOUNT_PROG $SCRATCH_MNT
+
+
+# Part 2
+# Second test is similar to the first with the difference we
+# run mkfs with no single-dev mention, and make use of btrfstune
+# to set such feature.
+$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
+$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
+
+_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
+$BTRFS_TUNE_PROG --convert-to-single-device $SCRATCH_DEV
+dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
+
+mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
+mount_btrfs $SPARE_DEV $SPARE_MNT
+
+$UMOUNT_PROG $SPARE_MNT
+$UMOUNT_PROG $SCRATCH_MNT
+
+
+# Part 3
+# Final part attempts to run some single-dev unsupported commands,
+# like device replace/remove - it they fail, test succeeds!
+mount_btrfs $SCRATCH_DEV $SCRATCH_MNT
+
+$BTRFS_UTIL_PROG device replace start $SCRATCH_DEV $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG device remove $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
+	| _filter_scratch
+
+$UMOUNT_PROG $SCRATCH_MNT
+
+_spare_dev_put
+_scratch_dev_pool_put 1
+
+# success, all done
+status=0
+echo "Finished"
+
+exit
diff --git a/tests/btrfs/301.out b/tests/btrfs/301.out
new file mode 100644
index 000000000000..c65604fecc5f
--- /dev/null
+++ b/tests/btrfs/301.out
@@ -0,0 +1,5 @@
+QA output created by 301
+ERROR: ioctl(DEV_REPLACE_STATUS) failed on "SCRATCH_MNT": Invalid argument
+
+ERROR: error removing device 'SCRATCH_DEV': Invalid argument
+Finished
-- 
2.42.0

