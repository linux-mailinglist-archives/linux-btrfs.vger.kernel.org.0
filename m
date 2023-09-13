Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B204279F528
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 00:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjIMWqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 18:46:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D71BCB
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jtKLXGrccLkNU+gD6b9UoIK+avDFO4fVNfiuOVKYzGA=; b=VILW1lhPyn/4fRsSNeCh3Wh/zz
        7p9K7yFkh8PCaTijoHuPF7vnJxHh4A6dRAU9oXAvccW2+D6EECdNMq2JyWPNuanKuZ3NRb7RMcd2I
        Pcg5m1z2h7YZEeJM5BmOfQgKbniXT5NyIDCL4XXl7cT1+VYWZ1fqCRB2HiyC/bCu4LNq6WnjpUFtB
        AXfau/0TUcfLbQFC2XQ8UcuIim2cqYivq+3tcyxf72VNqMc8hZ+OX7pQ74V2mbp0/WJ9r6Jy/UaaJ
        Bzhmp/HiTdDTzSW5L8WwrZOvIV6k0nxEoVaJ81FY7O0Fa/ntN2yoOBMvam1XSH6l9KPL5+6oRgOMT
        EixQAnEg==;
Received: from [187.116.122.196] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qgYcM-003ZCY-DA; Thu, 14 Sep 2023 00:45:55 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, dsterba@suse.cz, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v3] btrfs: Add test for the temp-fsid feature
Date:   Wed, 13 Sep 2023 19:44:59 -0300
Message-ID: <20230913224545.3940971-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The TEMP_FSID btrfs feature allows to mount the same filesystem
multiple times, at the same time. This is the fstests counter-part,
which checks both mkfs/btrfstune (by mounting the FS twice), and
also unsupported scenarios, like device replace / remove.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V3:

- Renamed the feature to temp-fsid.

- Group all requirements;
- Remove the "Finished" echo;
- Make use of helpers like _scratch_mount and _mount.
(Thanks Josef!)

- Use lower case for local vars (thanks Anand!).

V2: https://lore.kernel.org/linux-btrfs/20230905200826.3605083-1-gpiccoli@igalia.com/


 tests/btrfs/301     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/301.out |  4 +++
 2 files changed, 87 insertions(+)
 create mode 100755 tests/btrfs/301
 create mode 100644 tests/btrfs/301.out

diff --git a/tests/btrfs/301 b/tests/btrfs/301
new file mode 100755
index 000000000000..2e3d55a3cd81
--- /dev/null
+++ b/tests/btrfs/301
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Guilherme G. Piccoli (Igalia S.L.).  All Rights Reserved.
+#
+# FS QA Test 301
+#
+# Test for the btrfs temp-fsid feature - both mkfs and btrfstune are
+# validated, as well as explicitly unsupported commands, like device
+# removal / replacement.
+#
+. ./common/preamble
+. ./common/filter
+_begin_fstest auto mkfs quick
+_supported_fs btrfs
+
+_require_btrfs_mkfs_feature temp-fsid
+_require_btrfs_fs_feature temp_fsid
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 1
+_spare_dev_get
+
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_command "$WIPEFS_PROG" wipefs
+
+spare_mnt="${TEST_DIR}/${seq}/spare_mnt"
+mkdir -p $spare_mnt
+
+
+# Part 1
+# First test involves a mkfs with temp-fsid feature enabled.
+# If it succeeds and mounting that FS *twice* also succeeds,
+# we're good and continue.
+$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
+$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
+
+_scratch_mkfs "-b 300M -O temp-fsid" >> $seqres.full 2>&1
+dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
+
+_scratch_mount || _fail "failed to mount scratch dev (1)"
+_mount $SPARE_DEV $spare_mnt || _fail "failed to mount spare dev (1)"
+
+$UMOUNT_PROG $spare_mnt
+_scratch_unmount
+
+
+# Part 2
+# Second test is similar to the first with the difference we
+# run mkfs with no temp-fsid mention, and make use of btrfstune
+# to set such feature.
+$WIPEFS_PROG -a $SCRATCH_DEV >> $seqres.full 2>&1
+$WIPEFS_PROG -a $SPARE_DEV >> $seqres.full 2>&1
+
+_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
+$BTRFS_TUNE_PROG --convert-to-temp-fsid $SCRATCH_DEV
+dd if=$SCRATCH_DEV of=$SPARE_DEV bs=300M count=1 conv=fsync >> $seqres.full 2>&1
+
+_scratch_mount || _fail "failed to mount scratch dev (2)"
+_mount $SPARE_DEV $spare_mnt || _fail "failed to mount spare dev (2)"
+
+$UMOUNT_PROG $spare_mnt
+_scratch_unmount
+
+
+# Part 3
+# Final part attempts to run some temp-fsid unsupported commands,
+# like device replace/remove - it they fail, test succeeds!
+_scratch_mount || _fail "failed to mount scratch dev (3)"
+
+$BTRFS_UTIL_PROG device replace start $SCRATCH_DEV $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG device remove $SCRATCH_DEV $SCRATCH_MNT 2>&1 \
+	| _filter_scratch
+
+_scratch_unmount
+
+_spare_dev_put
+_scratch_dev_pool_put 1
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/301.out b/tests/btrfs/301.out
new file mode 100644
index 000000000000..f7f43d8c09c0
--- /dev/null
+++ b/tests/btrfs/301.out
@@ -0,0 +1,4 @@
+QA output created by 301
+ERROR: ioctl(DEV_REPLACE_STATUS) failed on "SCRATCH_MNT": Invalid argument
+
+ERROR: error removing device 'SCRATCH_DEV': Invalid argument
-- 
2.42.0

