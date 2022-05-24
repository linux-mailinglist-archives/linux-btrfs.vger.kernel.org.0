Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D345323ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiEXHTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiEXHTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 03:19:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE6941AE;
        Tue, 24 May 2022 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=l93CbR3xkwhO8zkRlFy4YMpI8owEyRLezZ81xujTwaU=; b=fqoszG4KTVGhOL2TVffBFY5H3/
        tSQXOtKZdlR0KwnoSDGvG20IutmxvLuMkTVEeCgEaIbpzZuCcxhhKxRmWHzNNwuTg6sAQNkg1RBLk
        apdJp/o10zB+RHGwBavp6gM11FsalGfVAtd0n65FrLO//UKnSq8IG4fULq6Snt96oXArfj/9mjVq5
        /CyZMS165sGBVQh3TOGPL/bs7CxOILyNXNXPf+b4bwpdqkNMsmguOds68VEPsnrhA+qSGFL2FC6O5
        WbPcbNhr6/08Zu5y7Y8afvDuMCR5wL1q2we3D8Jsg7a5oGviByTpW94pt2IBesLGnjEwOsI1b5i9J
        SjBIYnhg==;
Received: from [2001:4bb8:18c:7298:31fd:9579:b449:3c3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntOou-0073Kb-Sf; Tue, 24 May 2022 07:19:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs: test repair with sectors corrupted in multiple mirrors
Date:   Tue, 24 May 2022 09:18:37 +0200
Message-Id: <20220524071838.715013-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524071838.715013-1-hch@lst.de>
References: <20220524071838.715013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test that repair handles the case where it needs to read from more than
a single mirror on the raid1c3 profile.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/265     | 86 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/265.out | 75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100755 tests/btrfs/265
 create mode 100644 tests/btrfs/265.out

diff --git a/tests/btrfs/265 b/tests/btrfs/265
new file mode 100755
index 00000000..b243ba0b
--- /dev/null
+++ b/tests/btrfs/265
@@ -0,0 +1,86 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
+# Copyright (c) 2022 Christoph Hellwig.
+#
+# FS QA Test 265
+#
+# Test that btrfs raid repair on a raid1c3 profile can repair corruption on two
+# mirrors for the same logical offset.
+#
+. ./common/preamble
+_begin_fstest auto quick read_repair
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+
+_require_odirect
+# Overwriting data is forbidden on a zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+_scratch_dev_pool_get 3
+# step 1, create a raid1 btrfs which contains one 128k file.
+echo "step 1......mkfs.btrfs"
+
+mkfs_opts="-d raid1c3 -b 1G"
+_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
+
+# make sure data is written to the start position of the data chunk
+_scratch_mount $(_btrfs_no_v1_cache_opt)
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
+	"$SCRATCH_MNT/foobar" | \
+	_filter_xfs_io_offset
+
+# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
+# one in $SCRATCH_DEV_POOL
+echo "step 2......corrupt file extent"
+
+# ensure btrfs-map-logical sees the tree updates
+sync
+
+logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
+
+physical1=$(_btrfs_get_physical ${logical} 1)
+devpath1=$(_btrfs_get_device_path ${logical} 1)
+
+physical2=$(_btrfs_get_physical ${logical} 2)
+devpath2=$(_btrfs_get_device_path ${logical} 2)
+
+_scratch_unmount
+
+echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical1 64K" $devpath1 \
+	> /dev/null
+
+echo " corrupt stripe #2, devpath $devpath2 physical $physical2" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical2 64K" $devpath2 \
+	> /dev/null
+
+_scratch_mount
+
+# step 3, 128k dio read (this read can repair bad copy)
+echo "step 3......repair the bad copy"
+
+_btrfs_direct_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 128K
+_btrfs_direct_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 128K
+
+_scratch_unmount
+
+echo "step 4......check if the repair worked"
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
+	_filter_xfs_io_offset
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
+	_filter_xfs_io_offset
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
new file mode 100644
index 00000000..c62c7a39
--- /dev/null
+++ b/tests/btrfs/265.out
@@ -0,0 +1,75 @@
+QA output created by 265
+step 1......mkfs.btrfs
+wrote 131072/131072 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+step 2......corrupt file extent
+step 3......repair the bad copy
+step 4......check if the repair worked
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+read 512/512 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+read 512/512 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.30.2

