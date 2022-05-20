Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60552F10E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbiETQsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351904AbiETQrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 12:47:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB6185C99;
        Fri, 20 May 2022 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Vxq3PG6dePl9+lE5uUMfQc1NUEfmmkbncsICDPs8GVw=; b=IkGn0/qAHgE/Y6RZiqZ7hL1oug
        clLfkLD/DokyabazYTl3WY7f/AmyJDdjbFZJH5S0JmO6tFWJMqGfwa7BASEOG5qVa0NFiRmh1jEKV
        cx32WSvt6e28GAJkH5B6Jpzy2QkKMzyxdrR7OfzvoN9SclhDjBvbHTa1O9J9StaUo7eyWIbtvXOZ2
        jzFtrWmIFtCj6j/Y/NR8RRiq/Ytl1UgxB9oPp6LJtgVwDs3r2dkVGVS09U7Tu9IRd/dI2Xs2Q4fpk
        oLdtLeBDsMEz3B5gs/ZjcKtIo4/PNbs8TMlvpkcIBBoz86vuoDadyIRZzVAR1W6GDCiXkA0nbf6MW
        oCyw/nTg==;
Received: from 213-147-165-123.nat.highway.webapn.at ([213.147.165.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns5n4-00DoB8-UF; Fri, 20 May 2022 16:47:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: test repair with sectors corrupted in multiple mirrors
Date:   Fri, 20 May 2022 18:47:42 +0200
Message-Id: <20220520164743.4023665-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520164743.4023665-1-hch@lst.de>
References: <20220520164743.4023665-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test that repair handles the case where it needs to read from more than
a single mirror on the raid1c3 profile.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/265     | 127 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/265.out |  75 ++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100755 tests/btrfs/265
 create mode 100644 tests/btrfs/265.out

diff --git a/tests/btrfs/265 b/tests/btrfs/265
new file mode 100755
index 00000000..96f37989
--- /dev/null
+++ b/tests/btrfs/265
@@ -0,0 +1,127 @@
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
+BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
+
+_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
+_require_command "$FILEFRAG_PROG" filefrag
+_require_odirect
+# Overwriting data is forbidden on a zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+get_physical()
+{
+	local logical=$1
+	local stripe=$2
+
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
+		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+			
+get_device_path()
+{
+	local logical=$1
+	local stripe=$2
+
+	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
+		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
+}
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
+# ensure btrfs-map-logical sees the tree updates
+sync
+
+# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
+# one in $SCRATCH_DEV_POOL
+echo "step 2......corrupt file extent"
+
+${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
+logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
+
+physical1=$(get_physical ${logical_in_btrfs} 1)
+devpath1=$(get_device_path ${logical_in_btrfs} 1)
+
+physical2=$(get_physical ${logical_in_btrfs} 2)
+devpath2=$(get_device_path ${logical_in_btrfs} 2)
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
+# since raid1c3 consists of three copies, and the bad copy was put on stripe #1
+# while the good copy lies the other stripes, the bad copy only gets accessed
+# when the reader's pid % 3 is 1
+while true; do
+	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
+	pid=$!
+	wait
+	if [ $((pid % 3)) == 1 ]; then
+	    break
+	fi
+done
+while true; do
+	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null &
+	pid=$!
+	wait
+	if [ $((pid % 3)) == 2 ]; then
+	    break
+	fi
+done
+
+_scratch_unmount
+
+echo "step 4......check if the repair works"
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
index 00000000..4d3e7f80
--- /dev/null
+++ b/tests/btrfs/265.out
@@ -0,0 +1,75 @@
+QA output created by 265
+step 1......mkfs.btrfs
+wrote 131072/131072 bytes
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+step 2......corrupt file extent
+step 3......repair the bad copy
+step 4......check if the repair works
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

