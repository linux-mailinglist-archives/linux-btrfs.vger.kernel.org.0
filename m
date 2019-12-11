Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4711A913
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfLKKkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 05:40:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:58652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbfLKKks (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 05:40:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E19FAD55;
        Wed, 11 Dec 2019 10:40:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] fstests: btrfs/14[23]: Use proper help to get both devid and physical offset for corruption.
Date:   Wed, 11 Dec 2019 18:40:28 +0800
Message-Id: <20191211104029.25541-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211104029.25541-1-wqu@suse.com>
References: <20191211104029.25541-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using btrfs-progs v5.4, btrfs/142 and btrfs/143 will fail:
btrfs/142 1s ... - output mismatch (see xfstests/results//btrfs/142.out.bad)
    --- tests/btrfs/142.out 2018-09-16 21:30:48.505104287 +0100
    +++ xfstests/results//btrfs/142.out.bad
2019-12-10 15:35:40.280392626 +0000
    @@ -3,37 +3,37 @@
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     wrote 65536/65536 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa ................
    ...
    (Run 'diff -u xfstests/tests/btrfs/142.out xfstests/results//btrfs/142.out.bad' to see the entire diff)

[CAUSE]
Btrfs/14[23] test whether a read on corrupted stripe will re-silver
itself.
Such test by its nature will need to modify on-disk data, thus need to
get the btrfs logical -> physical mapping, which is done by near
hard-coded lookup function, which rely on certain stripe:devid sequence.

Recent btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
order to the stripe index") changes how we use devices in mkfs.btrfs,
this caused a change in chunk layout, and break the hard-coded
stripe:devid sequence.

[FIX]
This patch will do full devid and physical offset lookup, instead of old
physical offset only lookup.

The only assumption made is, mkfs.btrfs assigns devid sequentially for
its devices.
Which means, for "mkfs.btrfs $dev1 $dev2 $dev3", we get devid 1 for $dev1,
devid 2 for $dev2, and so on.

This change will allow btrfs/14[23] to handle even future chunk layout
change. (Although I hope this will never happen again).

This also addes extra debug output (although less than 10 lines) into
$seqres.full, just in case when layout changes and current lookup can't
handle it, developer can still pindown the problem easily.

Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/142     | 50 +++++++++++++++++++++++++++++++--------------
 tests/btrfs/142.out |  2 --
 tests/btrfs/143     | 48 +++++++++++++++++++++++++++++++------------
 tests/btrfs/143.out |  2 --
 4 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/tests/btrfs/142 b/tests/btrfs/142
index a23fe1bf..9c037ff6 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -47,30 +47,45 @@ _require_command "$FILEFRAG_PROG" filefrag
 
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
 }
 
+get_devid()
+{
+	local logical=$1
+	local stripe=$2
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
 
-SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
+}
 
 start_fail()
 {
+	local sysfs_bdev="$1"
 	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
 	echo 2 > $DEBUGFS_MNT/fail_make_request/times
 	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
 	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $SYSFS_BDEV/make-it-fail
+	echo 1 > $sysfs_bdev/make-it-fail
 }
 
 stop_fail()
 {
+	local sysfs_bdev="$1"
 	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
 	echo 0 > $DEBUGFS_MNT/fail_make_request/times
 	echo 0 > $DEBUGFS_MNT/fail_make_request/task-filter
-	echo 0 > $SYSFS_BDEV/make-it-fail
+	echo 0 > $sysfs_bdev/make-it-fail
 }
 
 _scratch_dev_pool_get 2
@@ -87,17 +102,23 @@ _scratch_mount -o nospace_cache,nodatasum
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
 
-# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
-# one in $SCRATCH_DEV_POOL
+# step 2, corrupt the first 64k of stripe #1
 echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical_on_scratch=`get_physical ${logical_in_btrfs}`
+physical=`get_physical ${logical_in_btrfs} 1`
+devid=$(get_devid ${logical_in_btrfs} 1)
+target_dev=$(get_device_path $devid)
+
+SYSFS_BDEV=`_sysfs_dev $target_dev`
 
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
-	_filter_xfs_io_offset
+$BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV | \
+	grep $logical_in_btrfs -A 6 >> $seqres.full
+echo "Corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
 
 _scratch_mount -o nospace_cache
 
@@ -106,8 +127,7 @@ echo "step 3......repair the bad copy" >>$seqres.full
 
 # since raid1 consists of two copies, and the bad copy was put on stripe #1
 # while the good copy lies on stripe #0, the bad copy only gets access when the
-# reader's pid % 2 == 1 is true
-start_fail
+start_fail $SYSFS_BDEV
 while [[ -z ${result} ]]; do
 	# enable task-filter only fails the following dio read so the repair is
 	# supposed to work.
@@ -117,12 +137,12 @@ while [[ -z ${result} ]]; do
 		exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRATCH_MNT/foobar\"
 	fi");
 done
-stop_fail
+stop_fail $SYSFS_BDEV
 
 _scratch_unmount
 
 # check if the repair works
-$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev | \
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
diff --git a/tests/btrfs/142.out b/tests/btrfs/142.out
index 0f32ffbe..2e22f292 100644
--- a/tests/btrfs/142.out
+++ b/tests/btrfs/142.out
@@ -1,8 +1,6 @@
 QA output created by 142
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 91af52f9..b2ffeb63 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -54,30 +54,48 @@ _require_command "$FILEFRAG_PROG" filefrag
 
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
 
 SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
 
 start_fail()
 {
+	local sysfs_bdev="$1"
 	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
 	# the 1st one fails the first bio which is reading 4k (or more due to
 	# readahead), and the 2nd one fails the retry of validation so that it
 	# triggers read-repair
 	echo 2 > $DEBUGFS_MNT/fail_make_request/times
 	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $SYSFS_BDEV/make-it-fail
+	echo 1 > $sysfs_bdev/make-it-fail
 }
 
 stop_fail()
 {
+	local sysfs_bdev="$1"
 	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
 	echo 0 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $SYSFS_BDEV/make-it-fail
+	echo 0 > $sysfs_bdev/make-it-fail
 }
 
 _scratch_dev_pool_get 2
@@ -94,17 +112,21 @@ _scratch_mount -o nospace_cache,nodatasum
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
 	_filter_xfs_io_offset
 
-# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
-# one in $SCRATCH_DEV_POOL
+# step 2, corrupt the first 64k of stripe #1
 echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical_on_scratch=`get_physical ${logical_in_btrfs}`
+physical=`get_physical ${logical_in_btrfs} 1`
+devid=$(get_devid ${logical_in_btrfs} 1)
+target_dev=$(get_device_path $devid)
 
+SYSFS_BDEV=`_sysfs_dev $target_dev`
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
-	_filter_xfs_io_offset
+
+echo "corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
 
 _scratch_mount -o nospace_cache
 
@@ -118,18 +140,18 @@ while [[ -z ${result} ]]; do
     # invalidate the page cache.
     _scratch_cycle_mount
 
-    start_fail
+    start_fail $SYSFS_BDEV
     result=$(bash -c "
         if [[ \$((\$\$ % 2)) -eq 1 ]]; then
                 exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/foobar\"
         fi");
-    stop_fail
+    stop_fail $SYSFS_BDEV
 done
 
 _scratch_unmount
 
 # check if the repair works
-$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev |\
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
diff --git a/tests/btrfs/143.out b/tests/btrfs/143.out
index 66afea4b..a9e82ceb 100644
--- a/tests/btrfs/143.out
+++ b/tests/btrfs/143.out
@@ -1,8 +1,6 @@
 QA output created by 143
 wrote 131072/131072 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
 XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-- 
2.23.0

