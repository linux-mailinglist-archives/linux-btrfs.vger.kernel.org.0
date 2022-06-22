Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134C5541F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356367AbiFVE7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357005AbiFVE7D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:59:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1B35858;
        Tue, 21 Jun 2022 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5Pq1L/fAWak8/gN0+y+r3SK/kler+Labzc9dCwUab+c=; b=OmKXIlY7Tpw32+qAoXstAIFMds
        PPtorIKg1XN2nrQ0IdmmTy9/9n7yZciQx8zRfi0FLthF1trj+vne4R0Nm/s/yVVZ8HJlTsjaA3Nqt
        AV+GMBY1zp8k6l6dmyOgzQ/ytqbP4MUVIPhKAawukT4vvS2xqan2fSJJ6hpfiG296WIepRyQOUiDA
        lyysdg7DEzMQ973t+762CUFbf+gzSp/b4pI2ASogHe1//1cJl0S+NpZypPTtfwcPHUb7PdHxlBrBg
        SdA9frGdvxRv4nnvxZ1DyPFDeo0MPzlGsrLHvEYRU/5evqHN1cF6SRBMwVQGZsh68RPjpxu7H/AET
        t0g87BQw==;
Received: from 213-225-1-25.nat.highway.a1.net ([213.225.1.25] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3sS5-008WkP-LZ; Wed, 22 Jun 2022 04:58:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs; add a test for impossible repair cases
Date:   Wed, 22 Jun 2022 06:58:42 +0200
Message-Id: <20220622045844.3219390-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622045844.3219390-1-hch@lst.de>
References: <20220622045844.3219390-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Verify that a repair attempt that can't succeed because all copies are
bad returns a proper I/O error and doesn't cause any deadlocks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/268     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/268.out |  7 +++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/btrfs/268
 create mode 100644 tests/btrfs/268.out

diff --git a/tests/btrfs/268 b/tests/btrfs/268
new file mode 100755
index 00000000..5043bb02
--- /dev/null
+++ b/tests/btrfs/268
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christoph Hellwig.
+#
+# FS QA Test 268
+#
+# Test that btrfs read repair on a raid1 profile won't loop forever if data
+# is corrupted on both mirrors and can't be recovered.
+#
+
+. ./common/preamble
+_begin_fstest auto quick read_repair
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_odirect
+_require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+echo "step 1......mkfs.btrfs"
+
+_scratch_pool_mkfs "-d raid1 -b 1G" >>$seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
+	"$SCRATCH_MNT/foobar" | \
+	_filter_xfs_io_offset
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
+physical3=$(_btrfs_get_physical ${logical} 3)
+devpath3=$(_btrfs_get_device_path ${logical} 3)
+
+_scratch_unmount
+
+echo "step 2......corrupt file extent"
+$XFS_IO_PROG -d -c "pwrite -S 0xba -b 4K $physical1 4K" \
+	$devpath1 > /dev/null
+$XFS_IO_PROG -d -c "pwrite -S 0xba -b 4K $physical2 4K" \
+	$devpath2 > /dev/null
+
+_scratch_mount
+
+echo "step 3......try to repair"
+$XFS_IO_PROG -d -c "pread -b 4K 0 4K" $SCRATCH_MNT/foobar
+
+_scratch_unmount
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/268.out b/tests/btrfs/268.out
new file mode 100644
index 00000000..d28b37b3
--- /dev/null
+++ b/tests/btrfs/268.out
@@ -0,0 +1,7 @@
+QA output created by 268
+step 1......mkfs.btrfs
+wrote 262144/262144 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+step 2......corrupt file extent
+step 3......try to repair
+pread: Input/output error
-- 
2.30.2

