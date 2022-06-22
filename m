Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64E5541ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357006AbiFVE7K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357008AbiFVE7D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:59:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98535861;
        Tue, 21 Jun 2022 21:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xf881ymmHgZZ9GBnXHqAh+UxVhriB0OZ+2fjdoLSoUM=; b=jZB/o0wDEgM8f1bop9zywIAngr
        JPqPOLcO4bXVzX/BbsDnGP397bOFB7kmeN7dblkkgA5KGtjPQcDE96/hn9N6f8rXzT3lnrsj71lmi
        S710JHWYmE1J+RirKZGSTjWD/lfM5fi6JXO/lIceLij5VC359+HAJryzrJ58xIles/E4MO8nXSnkb
        D5hyUCY6dT+lGvpDzJL4VDZ8Mh+KcB17hAb+wOqpq4iV83KPKvq5CXK096N+qyIkiaKcLL16YI0y8
        K9QfF2QvrXHmKUL/PZBzHb0HhdslM9j212Qg8Cq/bOxkLdZdzMhQ9dhRm2q3kqeE3vNqGWBuoavbl
        npPDkaJA==;
Received: from 213-225-1-25.nat.highway.a1.net ([213.225.1.25] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3sS8-008Wl0-Rh; Wed, 22 Jun 2022 04:58:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: test checker pattern corruption on raid10
Date:   Wed, 22 Jun 2022 06:58:43 +0200
Message-Id: <20220622045844.3219390-4-hch@lst.de>
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

Check read repair for the case where the corruption is spread over
the different legs of a raid10 set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/269     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/269.out | 41 +++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 tests/btrfs/269
 create mode 100644 tests/btrfs/269.out

diff --git a/tests/btrfs/269 b/tests/btrfs/269
new file mode 100755
index 00000000..3c11da3f
--- /dev/null
+++ b/tests/btrfs/269
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christoph Hellwig.
+#
+# FS QA Test 269
+#
+# Test btrfs read repair over tricky stripe boundaries on the raid10 profile:
+#
+#             | stripe 0 | stripe 2
+#   --------------------------------
+#    mirror 1 | I/O FAIL | GOOD    
+#    mirror 2 | GOOD     | CSUM FAIL
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
+_require_scratch_dev_pool 4
+_scratch_dev_pool_get 4
+
+echo "step 1......mkfs.btrfs"
+
+_scratch_pool_mkfs "-d raid10 -b 1G" >>$seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
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
+physical4=$(_btrfs_get_physical ${logical} 3)
+devpath4=$(_btrfs_get_device_path ${logical} 3)
+
+_scratch_unmount
+
+echo "step 2......corrupt file extent"
+
+$XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical1 64K" \
+	$devpath1 > /dev/null
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical4 + 65536)) 64K" \
+	$devpath4 > /dev/null
+
+_scratch_mount
+
+echo "step 3......repair the bad copy"
+
+_btrfs_direct_read_on_mirror 0 2 "$SCRATCH_MNT/foobar" 0 128K
+_btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
+
+_scratch_unmount
+
+echo "step 4......check if the repair worked"
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
+	_filter_xfs_io_offset
+$XFS_IO_PROG -d -c "pread -v -b 512 $((physical4 + 65536)) 512" $devpath4 |\
+	_filter_xfs_io_offset
+
+_scratch_dev_pool_put
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/269.out b/tests/btrfs/269.out
new file mode 100644
index 00000000..d3ad7f07
--- /dev/null
+++ b/tests/btrfs/269.out
@@ -0,0 +1,41 @@
+QA output created by 269
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

