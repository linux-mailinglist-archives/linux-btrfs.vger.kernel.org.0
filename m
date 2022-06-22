Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DE55483B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiFVJVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 05:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351485AbiFVJVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 05:21:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864DD34B86;
        Wed, 22 Jun 2022 02:21:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B877768AA6; Wed, 22 Jun 2022 11:21:40 +0200 (CEST)
Date:   Wed, 22 Jun 2022 11:21:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: test read repair on a corrupted compressed
 extent
Message-ID: <20220622092140.GA26204@lst.de>
References: <20220622045844.3219390-1-hch@lst.de> <20220622045844.3219390-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622045844.3219390-5-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So while this test properly documents the current behavior, it failed
to grasp how broken that behavior ist: the current read repair code
writes back the uncompressed data to disk even for a compressed extent,
and this test verified the behavior.

Below is a correct test that fails on current mainline.  I'll send fixes
but right now they depend on a lot of prep work.

---
From 6b6c505f75c6c7cc15359f14053b1db43e3d3091 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 22 Jun 2022 06:55:36 +0200
Subject: btrfs: test read repair on a corrupted compressed extent

Exercise read repair on a corrupted compressed sector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/270     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/270.out |  7 ++++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/btrfs/270
 create mode 100644 tests/btrfs/270.out

diff --git a/tests/btrfs/270 b/tests/btrfs/270
new file mode 100755
index 00000000..5b73fb15
--- /dev/null
+++ b/tests/btrfs/270
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
+#
+# FS QA Test 270
+#
+# Regression test for btrfs buffered read repair of compressed data.
+#
+. ./common/preamble
+_begin_fstest auto quick read_repair compress
+
+. ./common/filter
+
+_supported_fs btrfs
+_require_btrfs_command inspect-internal dump-tree
+_require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+get_physical()
+{
+	local logical=$1
+	local stripe=$2
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+
+get_devid()
+{
+	local logical=$1
+	local stripe=$2
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+}
+
+
+echo "step 1......mkfs.btrfs"
+_check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
+_scratch_pool_mkfs "-d raid1 -b 1G" >>$seqres.full 2>&1
+_scratch_mount -ocompress
+
+# Create a file with all data being compressed
+$XFS_IO_PROG -f -c "pwrite -S 0xaa -W -b 128K 0 128K" \
+	"$SCRATCH_MNT/foobar" | _filter_xfs_io_offset
+
+logical_in_btrfs=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
+physical=$(get_physical ${logical_in_btrfs} 1)
+devid=$(get_devid ${logical_in_btrfs} 1)
+devpath=$(get_device_path ${devid})
+
+_scratch_unmount
+echo "step 2......corrupt file extent"
+echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
+	>> $seqres.full
+dd if=$devpath of=$TEST_DIR/$seq.dump.good skip=$physical bs=1 count=4096 \
+	2>/dev/null
+$XFS_IO_PROG -c "pwrite -S 0xbb -b 4K $physical 4K" $devpath > /dev/null
+
+_scratch_mount
+
+echo "step 3......repair the bad copy"
+_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
+
+_scratch_unmount
+
+echo "step 4......check if the repair worked"
+dd if=$devpath of=$TEST_DIR/$seq.dump skip=$physical bs=1 count=4096 \
+	2>/dev/null
+cmp -bl $TEST_DIR/$seq.dump.good $TEST_DIR/$seq.dump
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
new file mode 100644
index 00000000..6d744c02
--- /dev/null
+++ b/tests/btrfs/270.out
@@ -0,0 +1,7 @@
+QA output created by 270
+step 1......mkfs.btrfs
+wrote 131072/131072 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+step 2......corrupt file extent
+step 3......repair the bad copy
+step 4......check if the repair worked
-- 
2.30.2

