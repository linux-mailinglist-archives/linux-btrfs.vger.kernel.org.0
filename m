Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35441142413
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgATHJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 02:09:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:34666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgATHJr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 02:09:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20889AED5;
        Mon, 20 Jan 2020 07:09:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs: Fix a bug where test case can't grab the 2nd device when glob is used
Date:   Mon, 20 Jan 2020 15:09:38 +0800
Message-Id: <20200120070938.30247-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120070938.30247-1-wqu@suse.com>
References: <20200120070938.30247-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If SCRATCH_DEV_POOL is definted using glob, e.g.
SCRATCH_DEV_POOL="/dev/mapper/test-scratch[123456]", then btrfs/175 will
fail like this:
btrfs/175 15s ... - output mismatch (see results//btrfs/175.out.bad)
    --- tests/btrfs/175.out     2019-10-22 15:18:14.085632007 +0800
    +++ results//btrfs/175.out.bad      2020-01-20 14:53:56.518567916 +0800
    @@ -6,3 +6,4 @@
     Single on multiple devices
     swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
     Single on one device
    +ERROR: checking status of : No such file or directory
    ...
    (Run 'diff -u tests/btrfs/175.out results//btrfs/175.out.bad'  to see the entire diff)

This is caused by the extra quotation mark (and the complexity nature of
bash glob).

  # SCRATCH_DEV_POOL="/dev/mapper/test-scratch[123]"
  # echo ${SCRATCH_DEV_POOL}
  /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /dev/mapper/test-scratch3
  # echo "${SCRATCH_DEV_POOL}"
  /dev/mapper/test-scratch[123]

To fix the problem, remove the quotation mark out of
${SCRATCH_DEV_POOL} or $SCRATCH_DEV_POOL for all related test cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The weirdest thing is, only btrfs/17[56], all other related test cases
pass without any problem.

Maybe it's time to provide a proper wrapper to do such thing?
---
 tests/btrfs/140 | 2 +-
 tests/btrfs/141 | 2 +-
 tests/btrfs/142 | 2 +-
 tests/btrfs/143 | 2 +-
 tests/btrfs/157 | 2 +-
 tests/btrfs/158 | 2 +-
 tests/btrfs/175 | 2 +-
 tests/btrfs/176 | 6 +++---
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index f0db8022cb48..0e6c91019854 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -65,7 +65,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index c8c184ba29b0..5678e6513f80 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -65,7 +65,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/142 b/tests/btrfs/142
index db0a3377a1ed..ae480352c4d9 100755
--- a/tests/btrfs/142
+++ b/tests/btrfs/142
@@ -66,7 +66,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 start_fail()
diff --git a/tests/btrfs/143 b/tests/btrfs/143
index 0388a52899c9..9e1e7ea0874d 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -73,7 +73,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 634370b97ec0..c60d05ce36f3 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -70,7 +70,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 4
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index d6df9eaa7dea..179c620b223f 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -62,7 +62,7 @@ get_devid()
 get_device_path()
 {
 	local devid=$1
-	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
+	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 4
diff --git a/tests/btrfs/175 b/tests/btrfs/175
index d13be3e95ed4..e1c3c28fe5a4 100755
--- a/tests/btrfs/175
+++ b/tests/btrfs/175
@@ -63,7 +63,7 @@ _scratch_mount
 # Create the swap file, then add the device. That way we know it's all on one
 # device.
 _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
-scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
+scratch_dev2="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
 $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
 swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
 swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 196ba2b8bdf6..c2d67c6f807a 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -39,9 +39,9 @@ _require_scratch_swapfile
 # We check the filesystem manually because we move devices around.
 rm -f "${RESULT_DIR}/require_scratch"
 
-scratch_dev1="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
-scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
-scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
+scratch_dev1="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $1 }')"
+scratch_dev2="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
+scratch_dev3="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $3 }')"
 
 echo "Remove device"
 _scratch_mkfs >> $seqres.full 2>&1
-- 
2.24.1

