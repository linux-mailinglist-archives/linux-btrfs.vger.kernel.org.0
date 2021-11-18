Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAC455D0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKRN4e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 08:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhKRN4d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 08:56:33 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB2C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 05:53:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 132so6318408qkj.11
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qz6+Ffim0VtBrei6YUdaIwmE40FCDb0WturicHRCYQ=;
        b=UsraMUZ/2+tgmZd7zNWR+NwjRnPOBSuasM1fLTPb23KFjTQlCGUi9o3x455D/Qg/oV
         ZcAFJNZ/JZSvhLYdvsSevk6DGyZaVSNSac39joHFhOxvfvGCxKTXxU1l9tECgikyHWm+
         YPbJ6CHvtppke0HwmMn8K7HvhnXnhkKC95JiVBarGOb5vE9WMJxqD79Yp4jiFv4/dG2f
         Pgfw5qSjWG0aWbF+S6PKA+yXjmivtzvqdDjaTODHd8RP3ZUE1W8iNRnql2mVt27qlRBC
         ywG6HEusGcaJfFhqlESPfzGSzBKrZD/TgZOAzJr8qeG4DwprJt1uetRHhHd1hsfxQvke
         jM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qz6+Ffim0VtBrei6YUdaIwmE40FCDb0WturicHRCYQ=;
        b=h9m2YQBCStKaRN7L9T3yaYvgWxsNz3E54cRnfKn2OhV1WccuShlvjVvShsUcjkr/tA
         FXTGJGUg1Ed4iG0aDFcgqiR2blgSdftRXf2e6lNsPFFINZYu8hgAyb5Ge7PGHEJ4HXiz
         sKn0UHJ7CSI7bFsrEyZAMJGTYNzgXWN1Tan3l+GRslw6RO4iZXsFnKDz5hwPvBcX0ZNx
         7ZFMO6zcsz55vsCTy3nOV+R3cJc+JzPkdnkMrEJjWLwGPH/1/mWv02xqb6ELBv4OTVVf
         OFhkMUjdLiuSawcthCxw26rJ9Zv2nfwBZgboBzZ94IWJztrqCHQQyXT5M5eRos+gOmP6
         SjJw==
X-Gm-Message-State: AOAM531o72Rr1gOAnOyIS1lKDLGiLc0Z+v7P71hxtz2mHDhKBXX4xB6v
        DKmG5VUVKLl90j1dIkoVp7uXWcUs+7dDfQ==
X-Google-Smtp-Source: ABdhPJwoYBBfeBcJfZTiumazakJGpXGF9KPeKxr4VFJ61H96lPeMSMe2fl7juwYbenDu4AVbecabLw==
X-Received: by 2002:a05:620a:3dd:: with SMTP id r29mr10104586qkm.208.1637243612555;
        Thu, 18 Nov 2021 05:53:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm1441190qtg.88.2021.11.18.05.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:53:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: redirect 'btrfs device add' output to seqres.full
Date:   Thu, 18 Nov 2021 08:53:30 -0500
Message-Id: <8578e51fc913f827757d70568b9b983f3af0ce88.1637243599.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I updated btrfs-progs on all my test runners and started failing tests
because I was getting the TRIM messages in the golden output.  There
were fixes that went in recently to properly detect TRIM support which
resulted in extra messages being printed.  Fix this by redirecting
stdout to $seqres.full for all 'btrfs device add' calls.  If anything
fails we'll still pollute the output, but normal status messages will
get properly eaten.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/161 | 3 ++-
 tests/btrfs/162 | 6 ++++--
 tests/btrfs/163 | 3 ++-
 tests/btrfs/164 | 3 ++-
 tests/btrfs/175 | 2 +-
 tests/btrfs/176 | 2 +-
 tests/btrfs/194 | 4 ++--
 tests/btrfs/197 | 3 ++-
 tests/btrfs/216 | 2 +-
 tests/btrfs/218 | 2 +-
 tests/btrfs/225 | 2 +-
 tests/btrfs/238 | 2 +-
 12 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/tests/btrfs/161 b/tests/btrfs/161
index 059b95ca..ed5b67fa 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -42,7 +42,8 @@ create_seed()
 
 create_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> \
+		$seqres.full
 	_scratch_unmount
 	run_check _mount $dev_sprout $SCRATCH_MNT
 	echo -- sprout --
diff --git a/tests/btrfs/162 b/tests/btrfs/162
index ba37ef0c..7680e1e4 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -45,7 +45,8 @@ create_seed()
 create_sprout_seed()
 {
 	run_check _mount $dev_seed $SCRATCH_MNT
-	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT >>\
+		$seqres.full
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_sprout_seed
 }
@@ -53,7 +54,8 @@ create_sprout_seed()
 create_next_sprout()
 {
 	run_check _mount $dev_sprout_seed $SCRATCH_MNT
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+		$seqres.full
 	_scratch_unmount
 	run_check _mount $dev_sprout $SCRATCH_MNT
 	echo -- sprout --
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 1dc081f1..59f0461b 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -58,7 +58,8 @@ create_seed()
 
 add_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+		$seqres.full
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	_mount -o remount,rw $dev_sprout $SCRATCH_MNT
 	$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 3e69b35f..8fd6ab62 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -48,7 +48,8 @@ create_seed()
 
 add_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+		$seqres.full
 	run_check mount -o rw,remount $dev_seed $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 }
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index 6f7832a5..dc6c1921 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -49,7 +49,7 @@ _scratch_mount
 # device.
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
 scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
-$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 8d624d5a..869cf2d8 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -30,7 +30,7 @@ echo "Remove device"
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
-$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # We know the swap file is on device 1 because we added device 2 after it was
 # already created.
diff --git a/tests/btrfs/194 b/tests/btrfs/194
index a994a429..2431692b 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -55,9 +55,9 @@ _scratch_mount
 # Add and remove device in a loop, each iteration will increase devid by 2.
 # So by 64 iterations, we will definitely hit that 122 limit.
 for (( i = 0; i < 64; i++ )); do
-	$BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
-	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
 done | grep -v 'Resetting device zone'
 _scratch_dev_pool_put
diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 597bc36f..22b37b4b 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -55,7 +55,8 @@ workout()
 	# don't test with the first device as auto fs check (_check_scratch_fs)
 	# picks the first device
 	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
-	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt"
+	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
+		$seqres.full
 
 	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
 	_mount -o degraded $device_2 $SCRATCH_MNT
diff --git a/tests/btrfs/216 b/tests/btrfs/216
index 38efa0f5..5d6cf902 100755
--- a/tests/btrfs/216
+++ b/tests/btrfs/216
@@ -28,7 +28,7 @@ _mkfs_dev $seed
 $BTRFS_TUNE_PROG -S 1 $seed
 _mount $seed $SCRATCH_MNT >> $seqres.full 2>&1
 cat /proc/self/mounts | grep $seed >> $seqres.full
-$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
 cat /proc/self/mounts | grep $sprout >> $seqres.full
 
 # check if the show_devname() returns the sprout device instead of seed device.
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index 5af54f3b..83ec785e 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -41,7 +41,7 @@ $BTRFS_TUNE_PROG -S 1 $dev_seed
 
 # Mount the seed device and add the rw device
 _mount -o ro $dev_seed $SCRATCH_MNT
-_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> $seqres.full
 $BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
 _scratch_unmount
 
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index 408c03d2..cfb64a34 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -48,7 +48,7 @@ $BTRFS_TUNE_PROG -S 1 $seed
 
 # Mount the seed device and add the rw device
 _mount -o ro $seed $SCRATCH_MNT
-$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
 _scratch_unmount
 
 # Now remount
diff --git a/tests/btrfs/238 b/tests/btrfs/238
index 2622f353..57245917 100755
--- a/tests/btrfs/238
+++ b/tests/btrfs/238
@@ -38,7 +38,7 @@ $BTRFS_TUNE_PROG -S 1 $seed
 _mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 
-$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
 _scratch_unmount
 
 # Now remount writeable sprout device, create some data and run fstrim
-- 
2.26.3

