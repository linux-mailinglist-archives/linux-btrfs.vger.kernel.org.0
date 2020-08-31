Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB40C25844A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 01:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgHaXFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 19:05:47 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:54549 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgHaXFq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 19:05:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1DF54AED;
        Mon, 31 Aug 2020 19:05:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Aug 2020 19:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=WnQq9ro9JjWTYU3I/tC09OY4Tt
        P5rONZc7c7+2eUick=; b=Y0UbQCQHm1YUTAp0bBVLIS1nw6C2hqDMBbDJC39DAA
        rPq7yrzVnoSr13YfDLLAswSKDq1BiFVaLmfL7vdz8UiNktGDsM5DQxRRXDk/uNLg
        GcxAfiBA41ejRueWwESqT4psS7pp75+zBb/RHsz7JuJ5CzaV7itFWDckzdiHOYgr
        3ZxK++QvAePF6NIqdnVyOtmzEedO47qsiyGbqcEb0/5NuBOzql2Y8nUuO/FbZVKn
        kUXBnMw74onq6Ds2fZUe8/lwDNfscoJ7qoP3Q4jmWXgjwyIGwtdeNFFUAOz6Msdb
        eUGWuu9YPzjxTLxyjWy4iw9bYVcm5SKpZLl/o+CenQyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WnQq9ro9JjWTYU3I/
        tC09OY4TtP5rONZc7c7+2eUick=; b=Vu+CdjMz8gkn4Rvmr11EY1hqfj8QqJWkE
        r38BiQgBxB1T6K4EXUpkTtNAMA4MC/HvO6hQA8I5MdPnSua+TteElvnQH82xrKw/
        vRS2Y77phlvGV004/L3teexrulTUJTsX1RlhG50zNtqWPo1v7vGtMrQde10VPDZ/
        PXFVsN/vvueH5CvcBQ7x3lJH5dioEsW9MwfmyLbPJqv4hbP2kTQQq5FfT7bJXT02
        hzMMMc8W/9iKpq4txHpzBlNJs0vasJy1sqkTXQcvfTC2rpVEDg+JcclWp5QcwrqC
        LFRLLGboPBi+KjRMZbn6l4PvITmFtiQqkcaLRNcWaYSBQgdozmUOg==
X-ME-Sender: <xms:SIJNX3_7oyH5P9JFG6bvFfORid_vsiH439fGN7CErEtI4eujRpBQ8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucfkphepudeifedruddugedrudefvddrfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hioh
X-ME-Proxy: <xmx:SIJNXztL0OmWq7Oyls-2Bslm_48Y88OzSxM44w1FAWidFwuzFcKEdg>
    <xmx:SIJNX1BiCy0wg8dbUtVIOrzkmf2NVBX0wWqu7AIdKyvYuYGy-zuuLw>
    <xmx:SIJNXzco0K5vW-KlSBmHaeea9M29npRmicYeRfZ5IyGB7ighh-H9Vw>
    <xmx:SIJNXya3Ava2-E75O4FzXs2X-8sOovJezxNtHrmS2Vz-tcTBZigxpA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EAFC328006C;
        Mon, 31 Aug 2020 19:05:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test for free space tree remounts
Date:   Mon, 31 Aug 2020 16:05:40 -0700
Message-Id: <2c9c22c45c2a0876239cdb1290e62e1266160768.1598915077.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/131 covers a solid variety of free space tree scenarios, but it
does not cover remount scenarios. We are adding remount support for read
only btrfs filesystems to move to the free space tree, so add a few test
cases covering that workflow as well. Refactor out some common free
space tree code from btrfs/131 into common/btrfs.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/btrfs        | 12 +++++++++
 tests/btrfs/131     | 29 +++++++-------------
 tests/btrfs/219     | 65 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out |  9 +++++++
 tests/btrfs/group   |  1 +
 5 files changed, 96 insertions(+), 20 deletions(-)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/common/btrfs b/common/btrfs
index 6d452d4d..9517c0a4 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -411,3 +411,15 @@ _btrfs_forget_or_module_reload()
 
 	_reload_fs_module "btrfs"
 }
+
+# print whether or not the free space tree is enabled on the scratch dev
+_btrfs_free_space_tree_enabled()
+{
+	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
+		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
+	if ((compat_ro & 0x1)); then
+		echo "free space tree is enabled"
+	else
+		echo "free space tree is disabled"
+			fi
+}
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 3de7eef8..93ff59f4 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -52,17 +52,6 @@ mkfs_v2()
 	_scratch_unmount
 }
 
-check_fst_compat()
-{
-	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
-		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
-	if ((compat_ro & 0x1)); then
-		echo "free space tree is enabled"
-	else
-		echo "free space tree is disabled"
-	fi
-}
-
 # Mount options might interfere.
 export MOUNT_OPTIONS=""
 
@@ -76,19 +65,19 @@ export MOUNT_OPTIONS=""
 mkfs_v1
 echo "Using free space cache"
 _scratch_mount -o space_cache=v1
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 mkfs_v1
 echo "Enabling free space tree"
 _scratch_mount -o space_cache=v2
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 mkfs_v1
 echo "Disabling free space cache and enabling free space tree"
 _scratch_mount -o clear_cache,space_cache=v2
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 # When the free space tree is enabled:
@@ -106,32 +95,32 @@ _try_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
 mkfs_v2
 echo "Mounting existing free space tree"
 _scratch_mount
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 _scratch_mount -o space_cache=v2
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 mkfs_v2
 echo "Recreating free space tree"
 _scratch_mount -o clear_cache,space_cache=v2
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 mkfs_v2
 _scratch_mount -o clear_cache
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 mkfs_v2
 echo "Disabling free space tree"
 _scratch_mount -o clear_cache,nospace_cache
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 mkfs_v2
 echo "Reverting to free space cache"
 _scratch_mount -o clear_cache,space_cache=v1
-check_fst_compat
+_btrfs_free_space_tree_enabled
 _scratch_unmount
 
 # success, all done
diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 00000000..1b889b78
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 219
+#
+# Test free space tree remount scenarios.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_fs_feature free_space_tree
+
+# Remount:
+# -o space_cache=v1; -o remount,space_cache=v2: error
+# -o space_cache=v1,ro; -o remount,space_cache=v2: success
+echo "Trying to remount with free space tree"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o clear_cache,space_cache=v1
+_btrfs_free_space_tree_enabled
+_try_scratch_mount -o remount,space_cache=v2 >/dev/null 2>&1 || echo "remount failed"
+_scratch_unmount
+
+echo "Remount read only fs with free space tree"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o clear_cache,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_mount -o remount,ro,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_mount -o remount,space_cache=v2
+_btrfs_free_space_tree_enabled
+# ensure the free space tree is sticky across reboot
+_scratch_unmount
+_scratch_mount
+_btrfs_free_space_tree_enabled
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 00000000..0b22e258
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,9 @@
+QA output created by 219
+Trying to remount with free space tree
+free space tree is disabled
+remount failed
+Remount read only fs with free space tree
+free space tree is disabled
+free space tree is disabled
+free space tree is enabled
+free space tree is enabled
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d..f4dbfafb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -221,3 +221,4 @@
 216 auto quick seed
 217 auto quick trim dangerous
 218 auto quick volume
+219 auto quick
-- 
2.24.1

