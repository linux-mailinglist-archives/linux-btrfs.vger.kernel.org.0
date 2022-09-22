Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4475E5B07
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 07:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIVFzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 01:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIVFzp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 01:55:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D1B4422;
        Wed, 21 Sep 2022 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663826141; x=1695362141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIYnDrM5zolSy4IWbZU17+zV+GczOAiQsjZcy2FcsWg=;
  b=HnARpTIjSuIFtp7qvB6g0O+shKphQUi7XdFsQ7ULDrwDbbSF0dnwm+M+
   MSl25rcvOiqgh2BH4fd3ui+C9igZS4qz4wWLULcTGcQyGlBYUEtrFFWcD
   YzW5RCYtz1CY7kMEGd/Nph5y+mmgv65mXCrJ9WxRMwIuTTaoYubWGL/9X
   PNpjWVhT+iwNnBEMM7DDxC/FsuPx8ljPEva3E1Ytz2cAhxZCyM/xoncCJ
   1AkMmfFEmF/opk2UgpQuVW0AJWBcl3VCr38mezgaEZl3udqF6TGVgVu7A
   uYbD77QtGnQCfAo3nvpaadEJihkA0+YDCs/sZWjV16dvLRZHFRRyarAaE
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654531200"; 
   d="scan'208";a="324089197"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2022 13:55:41 +0800
IronPort-SDR: F4+jEYCSoL0+u1GPp4+glXd2sdtYmuYV5fhUVPVfP/76ERUBqy2ht8w1BHPZ03oLslCDa4yyyw
 lnihUCxV8/xRqaFZMxAZkf3bFtuDFS+SyJWd+cpXOj1r7eaHEhsH5lT8MbJWZmXCLnAOq1yAmw
 NSDaZ7xqb8XMv2MpiUzSsltN6t4ERS6DNSqKMV2Buv9uhE2OkmdjQ4CwhD0SNQDy+EwCQHSAna
 wYPQRopjEcjZSLoiL7BXfZFRSgiKRmrch2QB4uj/LO81icSaxPwFzaMpFx9nit74dx7sERWyQA
 IXDIvcikHUM6y6HNltU14yJr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2022 22:10:15 -0700
IronPort-SDR: XxwYQiJv/j9u6BtrArOeh9D63r6S9Uru5JmM6WxdgIAWHSlV+qBCEBQN5VFfCB8Y96vqQE/1YA
 9hoCwJQVpAkq7b6/0zNozWTQAjHVxyNXiJmdrxGkQk7BXBm3GQlVmmzp/bn8p9qnCtY34SydJf
 L2v7DWaDRJ8LPZRm5vtz5YkYinZ8jL50cTXxVZYqpEgNUPFzqyomyu16OUTYzJMPcpy+MGXzFu
 7j1+58roLeD6Se4oBAooQ3KUMh5/7Q+4k6qMHJ3tHzT8Xshe6yVaXRl7qzK4Y3jZXC5eyHD9NR
 Xw8=
WDCIronportException: Internal
Received: from ghkxqv2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.86])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Sep 2022 22:55:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: test active zone tracking
Date:   Thu, 22 Sep 2022 14:54:59 +0900
Message-Id: <7e30a693ce98783d68bc70d07c185bffc693a4d1.1663825728.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663825728.git.naohiro.aota@wdc.com>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A ZNS device limits the number of active zones, which is the number of
zones can be written at the same time. To deal with the limit, btrfs's
zoned mode tracks which zone (corresponds to a block group on the SINGLE
profile) is active, and finish a zone if necessary.

This test checks if the active zone tracking and the finishing of zones
works properly. First, it fills <number of max active zones> zones
mostly. And, run some data/metadata stress workload to force btrfs to use a
new zone.

This test fails on an older kernel (e.g, 5.18.2) like below.

btrfs/292
[failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
    --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
    +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
    @@ -1,2 +1,5 @@
     QA output created by 292
    -Silence is golden
    +stress_data_bgs failed
    +stress_data_bgs_2 failed
    +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
    +(see /host/btrfs/292.full for details)
    ...
    (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)

The failure is fixed with a series "btrfs: zoned: fix active zone tracking
issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
allocation didn't progress")).

[1] https://lore.kernel.org/linux-btrfs/cover.1657321126.git.naohiro.aota@wdc.com/

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/zbd          |  12 ++++
 tests/btrfs/292     | 137 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |   2 +
 3 files changed, 151 insertions(+)
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

diff --git a/common/zbd b/common/zbd
index 329bb7be6b7b..19a59fd27e69 100644
--- a/common/zbd
+++ b/common/zbd
@@ -2,8 +2,20 @@
 # Common zoned block device specific functions
 #
 
+. common/rc
 . common/filter
 
+_require_limited_active_zones() {
+    local dev=$1
+    local sysfs=$(_sysfs_dev ${dev})
+    local attr="${sysfs}/queue/max_active_zones"
+
+    [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. Maybe non-zoned device?"
+    if [ $(cat "${attr}") == 0 ]; then
+	_notrun "this test requires limited active zones"
+    fi
+}
+
 _zone_capacity() {
     local phy=$1
     local dev=$2
diff --git a/tests/btrfs/292 b/tests/btrfs/292
new file mode 100755
index 000000000000..30c027c4ba5f
--- /dev/null
+++ b/tests/btrfs/292
@@ -0,0 +1,137 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Western Digital Corporation.  All Rights Reserved.
+#
+# FS QA Test 292
+#
+# Test that an active zone is properly reclaimed to allow the further
+# allocations, even if the active zones are mostly filled.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot zone
+
+# Import common functions.
+. ./common/btrfs
+. ./common/zbd
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_zoned_device "$SCRATCH_DEV"
+_require_limited_active_zones "$SCRATCH_DEV"
+
+_require_command "$BLKZONE_PROG" blkzone
+_require_fio
+_require_btrfs_command inspect-internal dump-tree
+
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
+max_active=$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones)
+
+# Fill the zones leaving the last 1MB
+fill_active_zones() {
+    # Asuumes we have the same capacity between zones.
+    local capacity=$(_zone_capacity 0)
+    local fill_size=$((capacity - 1024 * 1024))
+
+    for x in $(seq ${max_active}); do
+	dd if=/dev/zero of=${SCRATCH_MNT}/fill$(printf "%02d" $x) bs=${fill_size} \
+	   count=1 oflag=direct 2>/dev/null
+	$BTRFS_UTIL_PROG filesystem sync ${SCRATCH_MNT}
+
+	local nactive=$($BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | wc -l)
+	if [[ ${nactive} == ${max_active} ]]; then
+	    break
+	fi
+    done
+
+    echo "max active zones: ${max_active}" >> $seqres.full
+    $BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | cat -n >> $seqres.full
+}
+
+workout() {
+    local func="$1"
+
+    _scratch_mkfs >/dev/null 2>&1
+    _scratch_mount
+
+    fill_active_zones
+    eval "$func"
+    local ret=$?
+
+    _scratch_unmount
+    _check_btrfs_filesystem ${SCRATCH_DEV}
+
+    return $ret
+}
+
+stress_data_bgs() {
+    # This dd fails with ENOSPC, which should not :(
+    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=1 oflag=sync \
+       >>$seqres.full 2>&1
+}
+
+stress_data_bgs_2() {
+    # This dd fails with ENOSPC, which should not :(
+    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=10 conv=fsync \
+       >>$seqres.full 2>&1 &
+    local pid1=$!
+
+    dd if=/dev/zero of=${SCRATCH_MNT}/large2 bs=64M count=10 conv=fsync \
+       >>$seqres.full 2>&1 &
+    local pid2=$!
+
+    wait $pid1; local ret1=$?
+    wait $pid2; local ret2=$?
+
+    if [ $ret1 -ne 0 -o $ret2 -ne 0 ]; then
+	return 1
+    fi
+    return 0
+}
+
+get_meta_bgs() {
+    $BTRFS_UTIL_PROG inspect-internal dump-tree -t EXTENT ${SCRATCH_DEV} |
+        grep BLOCK_GROUP -A 1 |grep -B1 'METADATA|' |
+        grep -oP '\(\d+ BLOCK_GROUP_ITEM \d+\)'
+}
+
+# This test case does not return the result because
+# _run_btrfs_util_prog will call _fail() in the error case anyway.
+stress_metadata_bgs() {
+    local metabgs=$(get_meta_bgs)
+    local count=0
+
+    while : ; do
+        _run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
+        _run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
+        cur_metabgs=$(get_meta_bgs)
+        if [[ "${cur_metabgs}" != "${metabgs}" ]]; then
+            break
+        fi
+        i=$((i + 1))
+    done
+}
+
+WORKS=(
+    stress_data_bgs
+    stress_data_bgs_2
+    stress_metadata_bgs
+)
+
+status=0
+for work in "${WORKS[@]}"; do
+    if ! workout "${work}"; then
+	echo "${work} failed"
+	status=1
+    fi
+done
+
+# success, all done
+if [ $status -eq 0 ]; then
+    echo "Silence is golden"
+fi
+exit
diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
new file mode 100644
index 000000000000..627309d3fbd2
--- /dev/null
+++ b/tests/btrfs/292.out
@@ -0,0 +1,2 @@
+QA output created by 292
+Silence is golden
-- 
2.37.3

