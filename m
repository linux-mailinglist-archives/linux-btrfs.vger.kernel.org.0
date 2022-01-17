Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7231348FFD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 01:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiAQA5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 19:57:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58141 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiAQA5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 19:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642381026; x=1673917026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9uaJiom+9DVVRRSdntg/b/+yHB13yV0L0N0eumFGKs=;
  b=FBZoHlCHwD0iNdJVRahzZfwAmq648LI+sL3lAfgKo08UYGXRvmVcDS4D
   brAtIn9Y1XKsynCwUU+sRkjMjJdhNaAx2t4LgZ1NYL/ctrtAnndJIzBXY
   dc9Qbwl2F3EVsMzd8WJHhu6odf2rOCZj2Xm5d0qT3Eh6fKiRLfL7ehj79
   i7376H7t/2bLFIkPJsGkIXEkI1SvEBQCAWhZt73CiY9EU0O/X3VrGsRFl
   uti0wXbb+KBZi8yJJV04IujFSvMzPA5a3Uf6W8685fpukhZ9wtcHiOFg3
   oqlA77d/VhKwL3DsdssHHdlK8m1TzxbbCPzcCxyfoOGQmTk1PhrKQVsZ+
   w==;
X-IronPort-AV: E=Sophos;i="5.88,294,1635177600"; 
   d="scan'208";a="302472793"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2022 08:57:06 +0800
IronPort-SDR: Dl0Y5EyBo36N2f8zwlciVKNZPGI9srpntOpLMqyMvQlyb3BP2bhGKoc2K8AGjZ6aV1+TdLKN5D
 +lmmLopItqtoqjZvE4N/+5HmHOKnXJ8wr6aQJmwl9MbQwGL6VdPMMd2jYAhbWj6AyJp/4tzEwJ
 p2pFiHXSlkooIgtejBUxq6aB752Iy03Fq7AVKyzHmmVQnM9vvAiV4ewc7fmts86WDoCnxuMiEg
 ZFme4xcLwxwdFNXM61n+m1vqy6R55yX+pE2z4wz6m52+AuJd2VuYhRBXOnfYJfz4qHX3v1uE7f
 er7Q+fHrUBb4KC6699v1V0kL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 16:29:22 -0800
IronPort-SDR: oxYTvc/6Z4kPhA2wRIzfw0c7yFW/WUrpzuxh1bgLt3oiL+gkqVp1DsAZs2Bb+ko0Qn+QkOCtef
 m0R0mPct5G4MSoyCoBoW3C7Gsw9VEPW4whDLZDplgrMDhKg+9Jt5RmdqWYvCOeNLtPz6oG/oPP
 0cbGUmYfrI8kBx5ffKXUN9Jazq84p35JsuIFo6rvBI7NffVXswXZH7zhM3pZ7+EnB7azshQ8AG
 oUvTej36fCYMzU6pIVSIMfRlDOgEHXXkDkk2AFgx5boKd6dHrIk6q/yMPGzGgf/lehz+FNU3Ky
 qKM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jan 2022 16:57:06 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs/255: add test for quota disable in parallel with balance
Date:   Mon, 17 Jan 2022 09:57:05 +0900
Message-Id: <20220117005705.956931-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test quota disable during btrfs balance and confirm it does not cause
kernel hang. This is a regression test for the problem reported to
linux-btrfs list [1]. The hang was recreated using the test case and
memory backed null_blk device with 5GB size as the scratch device.

[1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinichiro.kawasaki@wdc.com/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/btrfs/255     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out

diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..16b682ca
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,42 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Western Digital Corporation or its affiliates.
+#
+# FS QA Test No. btrfs/255
+#
+# Confirm that disabling quota during balance does not hang
+#
+. ./common/preamble
+_begin_fstest auto qgroup
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Fill 40% of the device or 2GB
+fill_percent=40
+max_fillsize=$((2*1024*1024*1024))
+
+devsize=$(($(_get_device_size $SCRATCH_DEV) * 512))
+fillsize=$((devsize * fill_percent / 100))
+((fillsize > max_fillsize)) && fillsize=$max_fillsize
+
+fs=$((4096*1024))
+for ((i=0; i * fs < fillsize; i++)); do
+	dd if=/dev/zero of=$SCRATCH_MNT/file.$i bs=$fs count=1 \
+	   >> $seqres.full 2>&1
+done
+echo 3 > /proc/sys/vm/drop_caches
+
+# Run btrfs balance and quota enable/disable in parallel
+_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full &
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
+wait
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
new file mode 100644
index 00000000..7eefb828
--- /dev/null
+++ b/tests/btrfs/255.out
@@ -0,0 +1,2 @@
+QA output created by 255
+Silence is golden
-- 
2.33.1

