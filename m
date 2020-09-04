Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0106225CEC0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 02:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIDA0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 20:26:00 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48621 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgIDAZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 20:25:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1160FFB3;
        Thu,  3 Sep 2020 20:25:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 20:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=FC5yTaAFJrp9R
        aBl0X1Zoq38lUxabpRtFZFh533QXBk=; b=tDHeouRkmKX/1pi/oIWNuE1EV2b2Z
        OxBiQfB+V/2NZwPBJt+8xVkRNbbIudWPiXsLvbS7a7nIVjJWbf0JdBUKyPWTMbqz
        ZtWD2hyxFFbErG/NRU6ZAgq05obmx8KagJyw3kzBwblV64+5MPN8TTWBHECRVeVP
        2fOCD15N/851O3KoxTZcIYmRBHO5IwZsnavi1W4dA78i7A+oAefR1yyjrNNGPhLI
        FfjaANi5qhOmMziy9sPaAjVmlpfFGCUC+ZNr0a+k43GJ+z/P4+koDLVlLyN3J94j
        bSuHfGQ9Mz8iRJlaBi7bBkcpNqQeFy6wCw8nVQabbHzCT3lZZmBvraheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=FC5yTaAFJrp9RaBl0X1Zoq38lUxabpRtFZFh533QXBk=; b=uPTAN3gI
        ZJ0mJhdij7XK5SdvtuYtmpYGSV9OWNIU8IWL2wLC8Dyi+WMQ6aAkChmmc9q1qzBF
        kYGI8A4ZHhjv7e+v8I7tmYiU2exXa4QuUdpZesBIh6F3xpJjEk5oE55NfVzOdeGD
        anjajvhJervWIkBGij6h4kvIQNKMF3o4YkJvdSrVM0w9qlfcNl3/M/QyQW6LPO4v
        vYf6kwIVpUcOtkk2hZnxxUNFzESOTnil8A9wFw1G1FT0JH7R+/i0+yzbu32Z9qDc
        MAt2FQFGus9SLoYsX18r4jPQQGxWNmtjLRPyQqy9xuZN6YK2t50jd/jx85kK5vvN
        wntUnjfVosj5Dw==
X-ME-Sender: <xms:lYlRX85udS1OsaBhiYbzfJUqgxckz5JE6UbU13bbAQ3SFxmLwu0Ljw>
    <xme:lYlRX95da-7Xut2W_l-iwAeOGCETGERtkxphkn2zJKzpAnIDkeyNHUPmJwc5pl7c1
    vvnehBu-3iJMgz6BpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecukfhp
    peduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lYlRX7fDFP5jVwb8e70fDA4YvXWGySfhBEEvSu_winbJ4mJFUiZfcQ>
    <xmx:lYlRXxIrRTqcNTbUcXOY76FO2rwUc7kCzk3dH81v19ICKHoMJcpxYA>
    <xmx:lYlRXwJHAYExjegzLHJQrAEleBvqXYZpHS9SKbpN31GeAWDbiVT-TQ>
    <xmx:lYlRX6jGm_t4SFqIGmB_fstax31hP2jh4omBHR-R1Tf_MlOFvty-QQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A919E3280059;
        Thu,  3 Sep 2020 20:25:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs: add test for free space tree remounts
Date:   Thu,  3 Sep 2020 17:25:50 -0700
Message-Id: <d63835858b32cf692993766caa3650eec83d8b32.1599178894.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <61d279c1-1e2d-a59d-c14b-339ea859549b@suse.com>
References: <61d279c1-1e2d-a59d-c14b-339ea859549b@suse.com>
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
v2:
- added a new test for ro->ro remount
- used _scratch_remount
- used _scratch_cycle_mount

 common/btrfs        | 12 ++++++++
 tests/btrfs/131     | 29 ++++++------------
 tests/btrfs/219     | 74 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out | 13 ++++++++
 tests/btrfs/group   |  1 +
 5 files changed, 109 insertions(+), 20 deletions(-)
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
index 00000000..e6c8cb60
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,74 @@
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
+# -o space_cache=v1,ro; -o remount,ro,space_cache=v2: error
+# -o space_cache=v1,ro; -o remount,space_cache=v2: success
+echo "Trying to remount with free space tree"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o clear_cache,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_remount space_cache=v2 >/dev/null 2>&1 || echo "remount failed"
+_scratch_unmount
+
+echo "Trying to remount read-only with free space tree"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o clear_cache,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_remount ro,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_remount ro,space_cache=v2 >/dev/null 2>&1 || echo "remount failed"
+_scratch_unmount
+
+echo "Remount read-only to read-write with free space tree"
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount -o clear_cache,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_remount ro,space_cache=v1
+_btrfs_free_space_tree_enabled
+_scratch_remount space_cache=v2
+_btrfs_free_space_tree_enabled
+# ensure the free space tree is sticky across reboot
+_scratch_cycle_mount
+_btrfs_free_space_tree_enabled
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 00000000..1d5624a7
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,13 @@
+QA output created by 219
+Trying to remount with free space tree
+free space tree is disabled
+remount failed
+Trying to remount read-only with free space tree
+free space tree is disabled
+free space tree is disabled
+remount failed
+Remount read-only to read-write with free space tree
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

