Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7CE21BD37
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJSzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 14:55:50 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:44204 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbgGJSzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 14:55:49 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 80A08400C6172
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 13:18:05 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id tyBTj6mgDSxZVtyBTjy6Bt; Fri, 10 Jul 2020 13:55:43 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BvvZbSEm1ZNc4JoyGf7Fm8POI2KzDPaSJ+MThuXX69Q=; b=RTj6yif/Cr5jh+yrf4jiC+8t20
        vgznRV+d7NuCPPQ4RVMUytH68DyImy//xFwfp2SlsniD/eXKFI+Q2tfB4kaABN3a+GsllBeRHkQdl
        iNblPBfdsEs68eVpmAqbD1tApMgHGEKl9XozsdIfkyd5o2koXO6loB34ISY1sLwTKLp/pkcjybb7x
        rMscgEbOS8uFLVn0ljad1T/wocr7vY9JikWF+bauM7M+t64e754obLSjk6nlD4VavGB6U7vAvx/wF
        v+mnNeH+usc9HEHRwEfwMNRlf0U/ZM9w8pmoaPPrB/hmSCfMnjF9YkbUDRqwJbA8BXju/fcYcsfk6
        g4fxWHdw==;
Received: from 189.26.190.158.dynamic.adsl.gvt.net.br ([189.26.190.158]:53932 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jtyBS-00049a-Of; Fri, 10 Jul 2020 15:55:43 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
Date:   Fri, 10 Jul 2020 15:55:19 -0300
Message-Id: <20200710185519.10322-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.190.158
X-Source-L: No
X-Exim-ID: 1jtyBS-00049a-Of
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.158.dynamic.adsl.gvt.net.br (hephaestus.suse.de) [189.26.190.158]:53932
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Some recent test already ignore this output, while older ones do not.
It can sometimes make tests fail because "quota rescan" can show the
message "quota rescan started". Ignoring the output of the command
solves this problem.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/btrfs/017 | 2 +-
 tests/btrfs/022 | 4 ++--
 tests/btrfs/028 | 2 +-
 tests/btrfs/057 | 2 +-
 tests/btrfs/091 | 2 +-
 tests/btrfs/104 | 2 +-
 tests/btrfs/123 | 2 +-
 tests/btrfs/126 | 2 +-
 tests/btrfs/139 | 2 +-
 tests/btrfs/153 | 2 +-
 tests/btrfs/193 | 2 +-
 tests/btrfs/210 | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 1bb8295b..a888b8db 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -64,7 +64,7 @@ $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE $SCRATCH_MNT/foo \
 	     $SCRATCH_MNT/snap/foo-reflink2
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 rm -fr $SCRATCH_MNT/foo*
 rm -fr $SCRATCH_MNT/snap/foo*
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index aaa27aaa..442cc05c 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -38,7 +38,7 @@ _basic_test()
 	echo "=== basic test ===" >> $seqres.full
 	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
 	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
 	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
 		$seqres.full 2>&1
@@ -77,7 +77,7 @@ _rescan_test()
 	echo "qgroup values before rescan: $output" >> $seqres.full
 	refer=$(echo $output | awk '{ print $2 }')
 	excl=$(echo $output | awk '{ print $3 }')
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
 	echo "qgroup values after rescan: $output" >> $seqres.full
 	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 98b9c8b9..4a574b8b 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -42,7 +42,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 # Increase the probability of generating de-refer extent, and decrease
 # other.
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 82e3162e..aa1d429c 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -47,7 +47,7 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 \
        $FSSTRESS_AVOID >&/dev/null
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 echo "Silence is golden"
 # btrfs check will detect any qgroup number mismatch.
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index 6d2a23c8..a4aeebc3 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -59,7 +59,7 @@ _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv2
 _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 # if we don't support noinode_cache mount option, then we should double check
 # whether inode cache is enabled before executing the real test payload.
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index f0cc67d6..d3338e35 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -113,7 +113,7 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-snap2
 # Enable qgroups now that we have our filesystem prepared. This
 # will kick off a scan which we will have to wait for.
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 # Remount to clear cache, force everything to disk
 _scratch_cycle_mount
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index 65177159..63b6d428 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -56,7 +56,7 @@ sync
 
 # enable quota and rescan to get correct number
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 
 # now balance data block groups to corrupt qgroup
 _run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 8635791e..eceaabb2 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount "-o enospc_debug"
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
 
 # The amount of written data may change due to different nodesize at mkfs time,
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index 1b636e81..44168e2a 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -43,7 +43,7 @@ SUBVOL=$SCRATCH_MNT/subvol
 
 _run_btrfs_util_prog subvolume create $SUBVOL
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 _run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
 
 
diff --git a/tests/btrfs/153 b/tests/btrfs/153
index f343da32..1f8e37e7 100755
--- a/tests/btrfs/153
+++ b/tests/btrfs/153
@@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
 _scratch_mount
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
 _run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
 
 testfile1=$SCRATCH_MNT/testfile1
diff --git a/tests/btrfs/193 b/tests/btrfs/193
index 16b7650c..8bdc7566 100755
--- a/tests/btrfs/193
+++ b/tests/btrfs/193
@@ -43,7 +43,7 @@ _scratch_mkfs > /dev/null
 _scratch_mount
 
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
 $BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
 
 # Create a file with the following layout:
diff --git a/tests/btrfs/210 b/tests/btrfs/210
index daa76a87..a9a04951 100755
--- a/tests/btrfs/210
+++ b/tests/btrfs/210
@@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/null
 # by qgroup
 sync
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
 $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
 
 # Create a snapshot with qgroup inherit
-- 
2.26.2

