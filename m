Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29B5541EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357024AbiFVE7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357010AbiFVE7D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:59:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FAD2981B;
        Tue, 21 Jun 2022 21:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GyCCPoZj3PX6jdclZjF9+An2q71g86u7wcDPTJBoSnY=; b=Oht0ZuvNKZ+sS6OqK+hxBvoeCw
        iuLsoUrXw8UKOIV8q/f1Zr/xR5aPoHHJpeP6jfGa9TFZ5znu3C9FcsdL4NQIc1ZMX2aAoBr7hi0eX
        9JJpXPI9QD7IZpbHf0Jw+izyWwlM3CtpUQ9xAVU9MWOqmhlS2n8qpK4qTFLT2CxvKcRpV7gQd3sOM
        f9w2qmS+yRDLB3kyiW2kOhLGbcoIfsJmpFcGHZ0SQviEXOy7TLfw2PYWiBvMpqAy9vs0fh849uL0n
        XRhbOTxjN9eK3rop2vZ5y2HD8/CpmpsWAMQzGEPAkT+rprud6kYjcpxzRBVw6sXpjNUQykwFu0P9H
        H2kF4AFQ==;
Received: from 213-225-1-25.nat.highway.a1.net ([213.225.1.25] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3sSB-008WmL-Nz; Wed, 22 Jun 2022 04:59:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: test read repair on a corrupted compressed extent
Date:   Wed, 22 Jun 2022 06:58:44 +0200
Message-Id: <20220622045844.3219390-5-hch@lst.de>
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

Exercise read repair on a corrupted compressed sector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/270     | 79 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/270.out | 41 +++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100755 tests/btrfs/270
 create mode 100644 tests/btrfs/270.out

diff --git a/tests/btrfs/270 b/tests/btrfs/270
new file mode 100755
index 00000000..4229a02c
--- /dev/null
+++ b/tests/btrfs/270
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
+#
+# FS QA Test 270
+#
+# Regression test for btrfs buffered read repair of compressed data.
+#
+. ./common/preamble
+_begin_fstest auto quick read_repair
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
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
+
+_scratch_mount
+
+echo "step 3......repair the bad copy"
+_btrfs_buffered_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
+
+_scratch_unmount
+
+echo "step 4......check if the repair worked"
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
+	_filter_xfs_io_offset
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/270.out b/tests/btrfs/270.out
new file mode 100644
index 00000000..53a80692
--- /dev/null
+++ b/tests/btrfs/270.out
@@ -0,0 +1,41 @@
+QA output created by 270
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
-- 
2.30.2

