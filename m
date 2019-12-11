Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08D11A910
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfLKKko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 05:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728856AbfLKKko (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 05:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF5F1B1D7;
        Wed, 11 Dec 2019 10:40:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/3] fstests: btrfs/15[78]: Use proper helper to get both devid and physical offset for corruption
Date:   Wed, 11 Dec 2019 18:40:29 +0800
Message-Id: <20191211104029.25541-4-wqu@suse.com>
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
When using btrfs-progs v5.4, btrfs/157 and btrfs/158 will fail:

btrfs/157 1s ... - output mismatch (see xfstests/results//btrfs/157.out.bad)
    --- tests/btrfs/157.out 2018-09-16 21:30:48.505104287 +0100
    +++ xfstests/results//btrfs/157.out.bad
2019-12-10 15:35:43.112390076 +0000
    @@ -1,9 +1,9 @@
     QA output created by 157
     wrote 131072/131072 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    +wrote 65536/65536 bytes at offset 22020096
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    ...
    (Run 'diff -u xfstests/tests/btrfs/157.out xfstests/results//btrfs/157.out.bad'  to see the entire diff)
btrfs/158 2s ... - output mismatch (see xfstests/results//btrfs/158.out.bad)
    --- tests/btrfs/158.out 2018-09-16 21:30:48.505104287 +0100
    +++ xfstests/results//btrfs/158.out.bad
2019-12-10 15:35:44.844388521 +0000
    @@ -1,9 +1,9 @@
     QA output created by 158
     wrote 131072/131072 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    +wrote 65536/65536 bytes at offset 22020096
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 65536/65536 bytes at offset 9437184
    ...
    (Run 'diff -u xfstests/tests/btrfs/158.out xfstests/results//btrfs/158.out.bad'  to see the entire diff)

[CAUSE]
This two tests use physical offset as golden output, while mkfs.btrfs
can do whatever it likes to arrange its chunk layout, thus physical
offset is never reliable.

And btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
order to the stripe index") just changed the layout.

So the output mismatch and failed.

[FIX]
In fact, that btrfs-progs commit not only changed offset, but also the
device sequence.

So we can't just simply remove the physical offset, but also need to use
proper helper to get both devid (as its device path) and physical offset
for corruption.

As long as mkfs.btrfs still uses sequential devid, these tests should
handle future chunk layout change without problem.

Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/157     | 53 +++++++++++++++++++++++++++++----------------
 tests/btrfs/157.out |  4 ----
 tests/btrfs/158     | 48 +++++++++++++++++++++++++---------------
 tests/btrfs/158.out |  4 ----
 4 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 7f75c407..80b01b8d 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -51,22 +51,30 @@ _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
 
-get_physical_stripe0()
+get_physical()
 {
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep " DATA\|RAID6" -A 10 | \
-	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6 }'
+	local stripe=$1
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep " DATA\|RAID6" -A 10 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
 }
 
-get_physical_stripe1()
+get_devid()
 {
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep " DATA\|RAID6" -A 10 | \
-	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6 }'
+	local stripe=$1
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep " DATA\|RAID6" -A 10 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 4
-# step 1: create a raid6 btrfs and create a 4K file
+# step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
 mkfs_opts="-d raid6 -b 1G"
@@ -80,18 +88,25 @@ _scratch_mount -o nospace_cache
 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
 	"$SCRATCH_MNT/foobar" | _filter_xfs_io
 
+logical=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
 _scratch_unmount
 
-stripe_0=`get_physical_stripe0`
-stripe_1=`get_physical_stripe1`
-dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
-dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
-
-# step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
-echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
-
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+phy0=$(get_physical 0)
+devid0=$(get_devid 0)
+devpath0=$(get_device_path $devid0)
+phy1=$(get_physical 1)
+devid1=$(get_devid 1)
+devpath1=$(get_device_path $devid1)
+
+# step 2: corrupt stripe #0 and #1
+echo "step 2......simulate bitrot at:" >>$seqres.full
+echo "      ......stripe #0: devid $devid0 devpath $devpath0 phy $phy0" \
+	>>$seqres.full
+echo "      ......stripe #1: devid $devid1 devpath $devpath1 phy $phy1" \
+	>>$seqres.full
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy0 64K" $devpath0 > /dev/null
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
 
 # step 3: read foobar to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
diff --git a/tests/btrfs/157.out b/tests/btrfs/157.out
index 08d592c4..d69c0f1d 100644
--- a/tests/btrfs/157.out
+++ b/tests/btrfs/157.out
@@ -1,10 +1,6 @@
 QA output created by 157
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 0200000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
 *
 0400000
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 603e8bea..c8d5af82 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -43,22 +43,30 @@ _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
 
-get_physical_stripe0()
+get_physical()
 {
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep " DATA\|RAID6" -A 10 | \
-	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /0/) { print $6 }'
+	local stripe=$1
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep " DATA\|RAID6" -A 10 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
 }
 
-get_physical_stripe1()
+get_devid()
 {
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep " DATA\|RAID6" -A 10 | \
-	$AWK_PROG '($1 ~ /stripe/ && $3 ~ /devid/ && $2 ~ /1/) { print $6 }'
+	local stripe=$1
+        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep " DATA\|RAID6" -A 10 | \
+		awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 4
-# step 1: create a raid6 btrfs and create a 4K file
+# step 1: create a raid6 btrfs and create a 128K file
 echo "step 1......mkfs.btrfs" >>$seqres.full
 
 mkfs_opts="-d raid6 -b 1G"
@@ -74,16 +82,22 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
 
 _scratch_unmount
 
-stripe_0=`get_physical_stripe0`
-stripe_1=`get_physical_stripe1`
-dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
-dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
+phy0=$(get_physical 0)
+devid0=$(get_devid 0)
+devpath0=$(get_device_path $devid0)
+phy1=$(get_physical 1)
+devid1=$(get_devid 1)
+devpath1=$(get_device_path $devid1)
 
 # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
-echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
-
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+echo "step 2......simulate bitrot at:" >>$seqres.full
+echo "      ......stripe #0: devid $devid0 devpath $devpath0 phy $phy0" \
+	>>$seqres.full
+echo "      ......stripe #1: devid $devid1 devpath $devpath1 phy $phy1" \
+	>>$seqres.full
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy0 64K" $devpath0 > /dev/null
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $phy1 64K" $devpath1 > /dev/null
 
 # step 3: scrub filesystem to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
index 1f5ad3f7..95562f49 100644
--- a/tests/btrfs/158.out
+++ b/tests/btrfs/158.out
@@ -1,10 +1,6 @@
 QA output created by 158
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
 *
 0400000
-- 
2.23.0

