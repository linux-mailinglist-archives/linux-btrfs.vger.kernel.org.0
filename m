Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051591AB2F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442205AbgDOUym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442190AbgDOUyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 16:54:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D4C061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 13:54:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so535870pgo.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhfm3G2KaVuGQbPaYn1tfgdaI+7EfW6erFaHGWEwg5M=;
        b=z6dXbgCYRWe7TD4iiyAsgWXM2rb2RbHNHqvDiqzw9EMqS2zunakOiG9Xke4zs/9IZe
         TD01zheJc8N5skhIhrIoDAEz9QH8TdbRkWy1Ga58mA+IHlUoIIiA+E+d8REq5nD5QnMB
         nGLLxNBJ0ohFLGEBZV+zrwPWT/nYKn4/j4Av0/VI8FFdZCiAAA5TLYAY7ms7IBR12TFJ
         sFcnauBxam7hOZQRwtPNXx0/2ICESaci6l0EHdZPm7W+Ebdv0hS1jcKkLHiUaHsMyhD0
         rzqxbSveXOTMnJUwJVO1/Tok0wwlOG3XL2OLw/W8JMaNWBXdnZeosnbiKMET61ZH8Wie
         dKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhfm3G2KaVuGQbPaYn1tfgdaI+7EfW6erFaHGWEwg5M=;
        b=bkdnxYg2ojvZVF7ZrOg7kL6dQhFgTxvL5PyIwvxWQpy2uYk9Nq5VoIXuuhYRk3FvV3
         vvb3tmKAs0gn4aPPJOXy2wvdom8tEBVI3st1U9iV0EA2UjK1vqWMms+m8JUjNCS2IKgV
         X3tvAaHWOiYI+UgW8KfRR55Szvg5BQFqO05adBlYsg+oOzzAKv0Lw5XRaJp0mg0H/0cU
         bCnxkTskmvYhN7l+XLvfZLJB2CULgpILHwpMdOkWIT1dTu+5xoJG+FUTuicvmy3DZ8bx
         evPtTTq/utMzpOWC0BxeA/N8IKvBsRfaz5veXtov0IUpUuBUT9IT/TxfLNm63RX3Kb0a
         4xQg==
X-Gm-Message-State: AGi0PuZk7lQqynHK6AjEhCJdCbVuXzQu2qNnfniHDZwGgNa/3tzghtEx
        9//N27PeXqbI2OnzY3GwAkTCkw==
X-Google-Smtp-Source: APiQypIJ+qmg9l+aWYiYhmqF8V7OLUbkSmFpEBLuDXqsueCnMys6wSxW24TjbdIVN59EbID7Wni5AQ==
X-Received: by 2002:a63:d143:: with SMTP id c3mr27726805pgj.171.1586984078406;
        Wed, 15 Apr 2020 13:54:38 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:b0c6])
        by smtp.gmail.com with ESMTPSA id w134sm14753393pfd.41.2020.04.15.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:54:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     fstests@vger.kernel.org
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH fstests] btrfs/14{2,3}: use dm-dust instead of fail_make_request
Date:   Wed, 15 Apr 2020 13:54:31 -0700
Message-Id: <d992390752c612acd0893ee3db929e77affded2b.1586983958.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These two tests test direct I/O and buffered read repair, respectively,
with fail_make_request. However, by using "fail_make_request/times",
they rely on repair having a specific I/O pattern. My pending Btrfs
direct I/O refactoring patch series changes this I/O pattern and thus
breaks this test.

The dm-dust target (added in v5.2) emulates a device with bad blocks
that are fixed when written to (like a device that remaps bad blocks).
This is exactly what we want for testing repair. Add some common dm-dust
helpers and update the tests to use dm-dust.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 common/dmdust   | 35 +++++++++++++++++++
 tests/btrfs/142 | 88 +++++++++++------------------------------------
 tests/btrfs/143 | 90 +++++++++++--------------------------------------
 3 files changed, 73 insertions(+), 140 deletions(-)
 create mode 100644 common/dmdust

diff --git a/common/dmdust b/common/dmdust
new file mode 100644
index 00000000..56fcc0e0
--- /dev/null
+++ b/common/dmdust
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# common functions for setting up and tearing down a dmdust device
+
+_init_dust()
+{
+	local DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+	DUST_DEV=/dev/mapper/dust-test
+	DUST_TABLE="0 $DEV_SIZE dust $SCRATCH_DEV 0 512"
+	_dmsetup_create dust-test --table "$DUST_TABLE" || \
+		_fatal "failed to create dust device"
+}
+
+_mount_dust()
+{
+	_scratch_options mount
+	_mount -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
+		$DUST_DEV $SCRATCH_MNT
+}
+
+_unmount_dust()
+{
+	$UMOUNT_PROG $SCRATCH_MNT
+}
+
+_cleanup_dust()
+{
+	# If dmsetup load fails then we need to make sure to do resume here
+	# otherwise the umount will hang
+	$DMSETUP_PROG resume dust-test > /dev/null 2>&1
+	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
+	_dmsetup_remove dust-test
+}
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index db0a3377..e495c2c6 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -30,6 +30,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/dmdust
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
@@ -39,55 +40,12 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_fs btrfs
 _supported_os Linux
-_require_fail_make_request
 _require_scratch_dev_pool 2
+_require_dm_target dust
 
 _require_btrfs_command inspect-internal dump-tree
 _require_command "$FILEFRAG_PROG" filefrag
 
-get_physical()
-{
-	local logical=$1
-	local stripe=$2
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-		grep $logical -A 6 | \
-		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
-}
-
-get_devid()
-{
-	local logical=$1
-	local stripe=$2
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-		grep $logical -A 6 | \
-		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
-}
-
-get_device_path()
-{
-	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
-}
-
-start_fail()
-{
-	local sysfs_bdev="$1"
-	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 2 > $DEBUGFS_MNT/fail_make_request/times
-	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
-	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $sysfs_bdev/make-it-fail
-}
-
-stop_fail()
-{
-	local sysfs_bdev="$1"
-	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 0 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $DEBUGFS_MNT/fail_make_request/task-filter
-	echo 0 > $sysfs_bdev/make-it-fail
-}
-
 _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
@@ -107,42 +65,34 @@ echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical=`get_physical ${logical_in_btrfs} 1`
-devid=$(get_devid ${logical_in_btrfs} 1)
-target_dev=$(get_device_path $devid)
+echo "Logical offset is $logical_in_btrfs" >>$seqres.full
+_scratch_unmount
 
-SYSFS_BDEV=`_sysfs_dev $target_dev`
+read -r stripe physical < <(
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 "$SCRATCH_DEV" |
+	grep "$logical_in_btrfs" -A 6 |
+	$AWK_PROG '$1 == "stripe" && $3 == "devid" && $4 == 1 { print $2 " " $6; exit }')
+echo "Physical offset of stripe $stripe is $physical on devid 1" >> $seqres.full
 
-_scratch_unmount
-$BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV | \
-	grep $logical_in_btrfs -A 6 >> $seqres.full
-echo "Corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
-	>> $seqres.full
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" "$SCRATCH_DEV" > /dev/null
 
-_scratch_mount -o nospace_cache
+_init_dust
+_mount_dust
 
 # step 3, 128k dio read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-# since raid1 consists of two copies, and the bad copy was put on stripe #1
-# while the good copy lies on stripe #0, the bad copy only gets access when the
-start_fail $SYSFS_BDEV
-while [[ -z ${result} ]]; do
-	# enable task-filter only fails the following dio read so the repair is
-	# supposed to work.
-	result=$(bash -c "
-	if [[ \$((\$\$ % 2)) -eq 1 ]]; then
-		echo 1 > /proc/\$\$/make-it-fail
-		exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRATCH_MNT/foobar\"
-	fi");
+$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
+$DMSETUP_PROG message dust-test 0 enable
+while [[ -z $( (( BASHPID % 2 == stripe )) &&
+	       exec $XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar") ]]; do
+	:
 done
-stop_fail $SYSFS_BDEV
 
-_scratch_unmount
+_cleanup_dust
 
 # check if the repair works
-$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev | \
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" "$SCRATCH_DEV" |
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 0388a528..07040eb3 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -37,6 +37,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/dmdust
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
@@ -46,58 +47,12 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_fs btrfs
 _supported_os Linux
-_require_fail_make_request
 _require_scratch_dev_pool 2
+_require_dm_target dust
 
 _require_btrfs_command inspect-internal dump-tree
 _require_command "$FILEFRAG_PROG" filefrag
 
-get_physical()
-{
-	local logical=$1
-	local stripe=$2
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-		grep $logical -A 6 | \
-		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
-}
-
-get_devid()
-{
-	local logical=$1
-	local stripe=$2
-	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-		grep $logical -A 6 | \
-		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
-}
-
-get_device_path()
-{
-	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
-}
-
-SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
-
-start_fail()
-{
-	local sysfs_bdev="$1"
-	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-	# the 1st one fails the first bio which is reading 4k (or more due to
-	# readahead), and the 2nd one fails the retry of validation so that it
-	# triggers read-repair
-	echo 2 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $sysfs_bdev/make-it-fail
-}
-
-stop_fail()
-{
-	local sysfs_bdev="$1"
-	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 0 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $sysfs_bdev/make-it-fail
-}
-
 _scratch_dev_pool_get 2
 # step 1, create a raid1 btrfs which contains one 128k file.
 echo "step 1......mkfs.btrfs" >>$seqres.full
@@ -117,41 +72,34 @@ echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical=`get_physical ${logical_in_btrfs} 1`
-devid=$(get_devid ${logical_in_btrfs} 1)
-target_dev=$(get_device_path $devid)
-
-SYSFS_BDEV=`_sysfs_dev $target_dev`
+echo "Logical offset is $logical_in_btrfs" >>$seqres.full
 _scratch_unmount
 
-echo "corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
-	>> $seqres.full
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev > /dev/null
+read -r stripe physical < <(
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 "$SCRATCH_DEV" |
+	grep "$logical_in_btrfs" -A 6 |
+	$AWK_PROG '$1 == "stripe" && $3 == "devid" && $4 == 1 { print $2 " " $6; exit }')
+echo "Physical offset of stripe $stripe is $physical on devid 1" >> $seqres.full
 
-_scratch_mount -o nospace_cache
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" "$SCRATCH_DEV" > /dev/null
+
+_init_dust
+_mount_dust
 
 # step 3, 128k buffered read (this read can repair bad copy)
 echo "step 3......repair the bad copy" >>$seqres.full
 
-# since raid1 consists of two copies, and the bad copy was put on stripe #1
-# while the good copy lies on stripe #0, the bad copy only gets access when the
-# reader's pid % 2 == 1 is true
-while [[ -z ${result} ]]; do
-    # invalidate the page cache.
-    _scratch_cycle_mount
-
-    start_fail $SYSFS_BDEV
-    result=$(bash -c "
-        if [[ \$((\$\$ % 2)) -eq 1 ]]; then
-                exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/foobar\"
-        fi");
-    stop_fail $SYSFS_BDEV
+$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
+$DMSETUP_PROG message dust-test 0 enable
+while [[ -z $( (( BASHPID % 2 == stripe )) &&
+	       exec $XFS_IO_PROG -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar") ]]; do
+	:
 done
 
-_scratch_unmount
+_cleanup_dust
 
 # check if the repair works
-$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev |\
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" "$SCRATCH_DEV" |
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
-- 
2.26.1

