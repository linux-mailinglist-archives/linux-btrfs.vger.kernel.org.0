Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6215F4F91
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJEFq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJEFqx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 01:46:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66472B6A;
        Tue,  4 Oct 2022 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664948812; x=1696484812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zz8EGP68GFfz00z+TD7RpSCgY56irAOtcxjJkFkvxcY=;
  b=kqCz/WtEk/6jQ2SRaWVGjeN27gwiCBV3DMIU4t0l36oMhBhmV8Etpma7
   zfdtR3vLPNqBkTmj6Dmo1RACMWj4SXsr/0vXgwc0PGH+KeBiHe89COB4K
   lOn5UY1e50uphR8Gi4sczqRxoaiDxAj09V1m0u/yLy0+odcqnIdDqSn1K
   gfIDQuyHPA2px3QDJ/R5HL26bL3Lx0W4lNO6y7nY/Cl2X+VPcJl28+9rc
   /CbDHV0WLbM/YY9R+GsEpxd9KG4CTTDMwfWeubIND16ooT4rD+GYWVGW5
   h3jQkjZfZrgGtNxElcc57HEEH/cmw4EsM1jhaVP0Qtu8j9bUfWjdJAwFZ
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="317309478"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:46:51 +0800
IronPort-SDR: anfD7eSWrV9U/CQ5ww8XxZc040TBpNjGEVEdgGl2Kr/DXXMPlQ6KcODXUb9r5oV/mudlRJOQau
 Pg0A8HCS4iQp6i5tde0yQgTmvudg2rAOvV3oB0YXigtxfgP9tg111Xxpt5xBM1rAWI9TOsvD8v
 vX33p5GriZpAUKD56QXvig/nmgFtG3oSyj+EOzn5M2R5JRZpk8nyAdbPvnLTGItDDrRyCQrnbR
 S1mmwEB1T66TXSODY0XzVbhziuvypldYnnBZW/wVOAVVsLFxgDLjD3UYpy6sgfgLa48vJex6Kf
 9zm7ofEyF80UN2czC9rZZBKH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:01:04 -0700
IronPort-SDR: 00iWFwHkLBtzBX2I2AuTu8aPb3230OQzo7nGdlB+zKVHh9G9wmbPEimTVw5kOVssZilZXB0m/G
 Ab8vjpLHFjdfCu08VHOLkgkRfJEctIsiphdHcAz0oHoFO1G99cHqLzQbJmentBeKNPi9JbzC7b
 o1rKAG7+VTxExtdQpKBeW1iBBjo4EN9p8qMjmaY3aVWPDQXVlMCX9dV3ZkcSH3eeWZxRFkMrIS
 yM8/PSGngffMPD0qc55pfyOzqqxAG/cQMFHkn3SREU5AD+Xy3aIfLye2jFKS/R5OCptdoOGSqD
 Njc=
WDCIronportException: Internal
Received: from 5cg2075dx4.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.62])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Oct 2022 22:46:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: test active zone tracking
Date:   Wed,  5 Oct 2022 14:46:44 +0900
Message-Id: <244083eb330f899de5f4aef3716a716208796d73.1664948475.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1664948475.git.naohiro.aota@wdc.com>
References: <cover.1664948475.git.naohiro.aota@wdc.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/zoned        |  11 ++++
 tests/btrfs/292     | 143 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/292.out |   2 +
 3 files changed, 156 insertions(+)
 create mode 100755 tests/btrfs/292
 create mode 100644 tests/btrfs/292.out

diff --git a/common/zoned b/common/zoned
index d1bc60f784a1..eed0082a15cf 100644
--- a/common/zoned
+++ b/common/zoned
@@ -15,6 +15,17 @@ _filter_blkzone_report()
 	sed -e 's/len/cap/2'
 }
 
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
index 000000000000..00b8e165b102
--- /dev/null
+++ b/tests/btrfs/292
@@ -0,0 +1,143 @@
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
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+
+	# kill commands in stress_data_bgs_2
+	[ -n "$pid1" ] && kill $pid1
+	[ -n "$pid2" ] && kill $pid2
+	wait
+}
+
+# Import common functions.
+. ./common/zoned
+
+# real QA test starts here
+
+_supported_fs btrfs
+_fixed_by_kernel_commit 2ce543f47843 \
+	"btrfs: zoned: wait until zone is finished when allocation didn't progress"
+# which is further fixed by
+_fixed_by_kernel_commit d5b81ced74af \
+	"btrfs: zoned: fix API misuse of zone finish waiting"
+_require_zoned_device "$SCRATCH_DEV"
+_require_limited_active_zones "$SCRATCH_DEV"
+
+_require_command "$BLKZONE_PROG" blkzone
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
+	# Asuumes we have the same capacity between zones.
+	local capacity=$(_zone_capacity 0)
+	local fill_size=$((capacity - 1024 * 1024))
+
+	for x in $(seq ${max_active}); do
+		dd if=/dev/zero of=${SCRATCH_MNT}/fill$(printf "%02d" $x) \
+			bs=${fill_size} count=1 oflag=direct 2>/dev/null
+		$BTRFS_UTIL_PROG filesystem sync ${SCRATCH_MNT}
+
+		local nactive=$($BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | wc -l)
+		if [[ ${nactive} == ${max_active} ]]; then
+			break
+		fi
+	done
+
+	echo "max active zones: ${max_active}" >> $seqres.full
+	$BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | cat -n >> $seqres.full
+}
+
+workout() {
+	local func="$1"
+
+	_scratch_mkfs >/dev/null 2>&1
+	_scratch_mount
+
+	fill_active_zones
+	eval "$func" || _fail "${func} failed"
+
+	_scratch_unmount
+	_check_btrfs_filesystem ${SCRATCH_DEV}
+}
+
+stress_data_bgs() {
+	# This dd fails with ENOSPC, which should not :(
+	dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=1 oflag=sync \
+		>>$seqres.full 2>&1
+}
+
+stress_data_bgs_2() {
+	# This dd fails with ENOSPC, which should not :(
+	dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=10 conv=fsync \
+		>>$seqres.full 2>&1 &
+	pid1=$!
+
+	dd if=/dev/zero of=${SCRATCH_MNT}/large2 bs=64M count=10 conv=fsync \
+		>>$seqres.full 2>&1 &
+	pid2=$!
+
+	wait $pid1; local ret1=$?; unset pid1
+	wait $pid2; local ret2=$?; unset pid2
+
+	if [ $ret1 -ne 0 -o $ret2 -ne 0 ]; then
+		return 1
+	fi
+	return 0
+}
+
+get_meta_bgs() {
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t EXTENT ${SCRATCH_DEV} |
+		grep BLOCK_GROUP -A 1 |grep -B1 'METADATA|' |
+		grep -oP '\(\d+ BLOCK_GROUP_ITEM \d+\)'
+}
+
+# This test case does not return the result because
+# _run_btrfs_util_prog will call _fail() in the error case anyway.
+stress_metadata_bgs() {
+	local metabgs=$(get_meta_bgs)
+	local count=0
+
+	while : ; do
+		_run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
+		_run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
+		cur_metabgs=$(get_meta_bgs)
+		if [[ "${cur_metabgs}" != "${metabgs}" ]]; then
+			break
+		fi
+		i=$((i + 1))
+	done
+}
+
+WORKS=(
+	stress_data_bgs
+	stress_data_bgs_2
+	stress_metadata_bgs
+)
+
+for work in "${WORKS[@]}"; do
+	workout "${work}"
+done
+
+echo "Silence is golden"
+
+# success, all done
+status=0
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
2.38.0

