Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630E0324A48
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 06:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhBYF6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 00:58:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:35568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233860AbhBYF6L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 00:58:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614232643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BlYa0M5/rwS6XZJimjdWVKI7S/hsCrurKfM7w6bNeKg=;
        b=i5av/pNYtUMM8DPFxUKi5wxAFx6EJL67oHWA6HQDH1Rp52hFBOuGwmlZBbSW6KKa+nhJFm
        pthhUgsrrcS22bUzilcOwoAJMhNEtnwX7LlYF/gjF6QoVJlp0FVQMbrPFaUkhEI3/bENKA
        Fvf0MFq405QJrn6XYgz9MR2hWEOukPc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08B78AE6E;
        Thu, 25 Feb 2021 05:57:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] fstests: make sure we rescan all devices after unregistering
Date:   Thu, 25 Feb 2021 13:57:17 +0800
Message-Id: <20210225055717.70679-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some btrfs test cases utilizing
_btrfs_forget_or_module_reload() to unregister all btrfs devices.

However _btrfs_forget_or_module_reload() will unregister all devices,
meaning if TEST_DEV is part of a multi-device btrfs, after those test
cases TEST_DEV will no longer be mountable.

This patch will introduce a new function, btrfs_rescan_devices() to undo
the unregister, so that all later test cases can mount TEST_DEV without
any problem.

Since we are here, also add a missing
_require_btrfs_forget_or_module_loadable for btrfs/225.

Reported-by: Eric Sandeen <sandeen@sandeen.net>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs    | 8 ++++++++
 tests/btrfs/124 | 2 ++
 tests/btrfs/125 | 2 ++
 tests/btrfs/163 | 2 ++
 tests/btrfs/164 | 2 ++
 tests/btrfs/219 | 2 ++
 tests/btrfs/225 | 3 +++
 7 files changed, 21 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 6d452d4d..ebe6ce26 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -411,3 +411,11 @@ _btrfs_forget_or_module_reload()
 
 	_reload_fs_module "btrfs"
 }
+
+# Test cases which utilized _btrfs_forget_or_module_reload() must call this
+# to make sure TEST_DEV can still be mounted. As TEST_DEV can be part of a
+# multi-device btrfs.
+_btrfs_rescan_devices()
+{
+	$BTRFS_UTIL_PROG device scan &> /dev/null
+}
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index c9729cb4..4588264c 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -35,6 +35,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -144,6 +145,7 @@ fi
 
 $UMOUNT_PROG $dev2
 _scratch_dev_pool_put
+_btrfs_rescan_devices
 _test_mount
 
 status=0
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 41d22d0b..d125b111 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -34,6 +34,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -161,6 +162,7 @@ fi
 
 $UMOUNT_PROG $dev2
 _scratch_dev_pool_put
+_btrfs_rescan_devices
 _test_mount
 
 status=0
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 735881c6..b6bd6906 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -26,6 +26,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -102,6 +103,7 @@ replace_sprout
 seed_is_mountable
 
 _scratch_dev_pool_put
+_btrfs_rescan_devices
 
 status=0
 exit
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 55d4a683..ad22b6a4 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -22,6 +22,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -90,6 +91,7 @@ delete_seed
 seed_is_mountable
 
 _scratch_dev_pool_put
+_btrfs_rescan_devices
 
 status=0
 exit
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 78fca035..bff6003e 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -35,6 +35,7 @@ _cleanup()
 	[ ! -z "$fs_img1" ] && rm -rf $fs_img1
 	[ ! -z "$fs_img2" ] && rm -rf $fs_img2
 	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -97,6 +98,7 @@ _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
 _mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
 	_fail "We were allowed to mount when we should have failed"
 
+_btrfs_rescan_devices
 # success, all done
 echo "Silence is golden"
 status=0
diff --git a/tests/btrfs/225 b/tests/btrfs/225
index 730d9645..b745b536 100755
--- a/tests/btrfs/225
+++ b/tests/btrfs/225
@@ -25,6 +25,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	_btrfs_rescan_devices
 }
 
 # get standard environment, filters and checks
@@ -40,6 +41,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _require_test
 _require_scratch_dev_pool 2
+_require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 2
 
@@ -76,6 +78,7 @@ od -x $SCRATCH_MNT/foo
 od -x $SCRATCH_MNT/bar
 
 _scratch_dev_pool_put
+_btrfs_rescan_devices
 
 # success, all done
 status=0
-- 
2.30.1

