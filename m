Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98C011C83F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 09:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfLLIbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 03:31:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:57326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfLLIbg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 03:31:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DCABB03D;
        Thu, 12 Dec 2019 08:31:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/14[01]: Use proper helper to get both devid and physical for corruption
Date:   Thu, 12 Dec 2019 16:31:23 +0800
Message-Id: <20191212083123.25888-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With btrfs-progs v5.4, btrfs/140 and btrfs/141 will fail.

[CAUSE]
Both tests are testing re-silvering of RAID1, thus they need to corrupt
on-disk data.

This requires to do manual logical -> physical bytes mapping in the test
case.
However the test case itself uses too many hard coded helper to grab
physical offset, which will change with mkfs.btrfs.

[FIX]
Use more flex helper, to get both devid and physical for such
corruption.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/140     | 36 ++++++++++++++++++++++++++++--------
 tests/btrfs/140.out |  2 --
 tests/btrfs/141     | 33 ++++++++++++++++++++++++++-------
 tests/btrfs/141.out |  2 --
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 1c5aa679..5c6de733 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -46,10 +46,26 @@ _require_odirect
 
 get_physical()
 {
-	# $1 is logical address
-	# print chunk tree and find devid 2 which is $SCRATCH_DEV
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
+	local logical=$1
+	local stripe=$2
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+
+get_devid()
+{
+	local logical=$1
+	local stripe=$2
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 2
@@ -72,11 +88,15 @@ echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical_on_scratch=`get_physical ${logical_in_btrfs}`
+physical=$(get_physical ${logical_in_btrfs} 1)
+devid=$(get_devid ${logical_in_btrfs} 1)
+devpath=$(get_device_path ${devid})
 
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
-	_filter_xfs_io_offset
+
+echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
 
 _scratch_mount
 
@@ -96,7 +116,7 @@ done
 _scratch_unmount
 
 # check if the repair works
-$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
+$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
index f3fdf174..fb5aa108 100644
--- a/tests/btrfs/140.out
+++ b/tests/btrfs/140.out
@@ -1,8 +1,6 @@
 QA output created by 140
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 186d18c8..2f5ad1a2 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -46,10 +46,26 @@ _require_command "$FILEFRAG_PROG" filefrag
 
 get_physical()
 {
-        # $1 is logical address
-        # print chunk tree and find devid 2 which is $SCRATCH_DEV
+	local logical=$1
+	local stripe=$2
         $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
+		grep $logical -A 6 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+
+get_devid()
+{
+	local logical=$1
+	local stripe=$2
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 2
@@ -72,11 +88,14 @@ echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical_on_scratch=`get_physical ${logical_in_btrfs}`
+physical=$(get_physical ${logical_in_btrfs} 1)
+devid=$(get_devid ${logical_in_btrfs} 1)
+devpath=$(get_device_path ${devid})
 
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
-	_filter_xfs_io_offset
+echo " corrupt stripe #1, devid $devid devpath $devpath physical $physical" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /dev/null
 
 _scratch_mount
 
@@ -97,7 +116,7 @@ done
 _scratch_unmount
 
 # check if the repair works
-$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
index 116f98a2..4b8be189 100644
--- a/tests/btrfs/141.out
+++ b/tests/btrfs/141.out
@@ -1,8 +1,6 @@
 QA output created by 141
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-- 
2.23.0

