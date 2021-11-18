Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE2455EB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKRO4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhKRO4X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 09:56:23 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C91C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 06:53:23 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j9so4714555qvm.10
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvsCelSA9qojSBYYxQN9cQ7TeHm9LJ7pYSgc1zZBMbY=;
        b=fhcMzhjJWeWJTEr7FUlp8X/fSYqoYdg7+gGr1HTto0Sq84d4ezjd/nnlCvsIZdrK+y
         xRdS6H4fp0hg/G1CAK971DhJSao1VDBrWPn5bdqWQE4PoMO02UxC1qiB1yfpWF9zfrmd
         7c5O+355h5UJzxfKshhW2ES2/VjUNePeN1jXQBqamjOB7pV7RBRltQ2NRktA6FNFfq7W
         pBXVapCSIcVNFX3FDhUWn9suqtHNUHBChKi14dirlpgQ8hDdSiPsbphrlDNuyFSPlUR4
         gCFgZZKg+iuJ2UlqRw5liVHCJF8Z531IBrs8gz97Du3XJqyAx//zCTZu9Bsa66mkBu4Z
         rdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvsCelSA9qojSBYYxQN9cQ7TeHm9LJ7pYSgc1zZBMbY=;
        b=41Q+KImC4hvKAuMpDyjMFqsj7k1GPsX6HlNUwkFMjENDyGB0NB6mVl4rp6PDCvTH2E
         Eo9T2NUoV4IbsfpUiK9cEJ8+Yt5r/xdgJZodAxewuj72/y99/Vr+djyHKljTTrkRP8rO
         lTLTgF0x2GHFgM1Vg6TW+eG1lH1Jex4y0CpsY0coBEjoNjjMIbkDc+Q4FKN3ZUTEN9bL
         rHOHx7V2JA74Peadtzg7FSnElt2MO2G+Grxqofv7u0g5ZBZyMKavbz8sIyqKWF2SxDOP
         L8XiHMX1CIkfs0v2jklBHA350b/L+eALJsQ7K5wpyUi7Gkzgf2dDTIRv+eawOmqxp/Z1
         Maxg==
X-Gm-Message-State: AOAM531+ImhOAZ2KRYqqV36dAxVEnsxOq/8o206uRVDkvl1oSjWKJCj0
        4l2sh1jJF6lYZWeb+8RLeJHqX91XLNprcg==
X-Google-Smtp-Source: ABdhPJxogNm17rr8TKveROFcn2FSiS6C7qtDjvsZ1voP5LmLuGswtO5QEd0//ahhpAdznLdaW9524Q==
X-Received: by 2002:ad4:446f:: with SMTP id s15mr64355224qvt.1.1637247202230;
        Thu, 18 Nov 2021 06:53:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d13sm28823qkn.100.2021.11.18.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:53:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH v2] fstests: redirect 'btrfs device add' output to seqres.full
Date:   Thu, 18 Nov 2021 09:53:20 -0500
Message-Id: <bf24618b10a75719a23dda2f0a742bd322ec8d46.1637247167.git.josef@toxicpanda.com>
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
v1->v2:
- I missed some of the device add calls in btrfs/176 somehow, fixed it.

 tests/btrfs/161 | 3 ++-
 tests/btrfs/162 | 6 ++++--
 tests/btrfs/163 | 3 ++-
 tests/btrfs/164 | 3 ++-
 tests/btrfs/175 | 2 +-
 tests/btrfs/176 | 6 +++---
 tests/btrfs/194 | 4 ++--
 tests/btrfs/197 | 3 ++-
 tests/btrfs/216 | 2 +-
 tests/btrfs/218 | 2 +-
 tests/btrfs/225 | 2 +-
 tests/btrfs/238 | 2 +-
 12 files changed, 22 insertions(+), 16 deletions(-)

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
index 8d624d5a..9a833575 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -30,14 +30,14 @@ echo "Remove device"
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
-$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # We know the swap file is on device 1 because we added device 2 after it was
 # already created.
 $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
 # Deleting/readding device 2 should still work.
 $BTRFS_UTIL_PROG device delete "$scratch_dev2" "$SCRATCH_MNT"
-$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 # Deleting device 1 should work again after swapoff.
 $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
@@ -48,7 +48,7 @@ echo "Replace device"
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
-$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 # Again, we know the swap file is on device 1.
 $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev3" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
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

