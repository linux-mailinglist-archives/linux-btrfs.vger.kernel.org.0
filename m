Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C834509A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 17:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhKOQca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 11:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhKOQc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 11:32:28 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E89C061570
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 08:29:32 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id s9so11689685qvk.12
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaEDLAMokqQVn6hz+P4o6gJ8Q61jzPkaz/oYzxJDTys=;
        b=SePy6n6kbkaDkGO2w0iqe7PNn/oRc8qD1R5l9Br24oxeD/Fz/GUjkyCxEBzaL2nH62
         VUzB6Q4myps4wk61vpSLfYBrPFV1V6HORkB5lDbRzMyRD00be1+Q6CvsFGSkaqx8iNoV
         F48zad0IWXk0A6riED8hT420jq6So9A9dookMg5zH/Io3FYRXLgmBHJYItN7AXxl3piH
         8sQCCI3QM3RMEE98fFj3lrBWyw1egkuLnhhnW7Dr7CrRIUdFJ2QKuu03uIwchPGCOVUB
         x5ynqBszXBtNtv4KFV8NvFQFFpd8dxcLmS9osBh0SIb9/FyLC5BkycsZ395AxF7jbrGu
         dEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaEDLAMokqQVn6hz+P4o6gJ8Q61jzPkaz/oYzxJDTys=;
        b=i2W/3wt8RuN5dGB0XtFv7Jzhqhv/VJBAUWcgRIZLEWwujWP6YV4Av/eE1W8X+tb0Nf
         SByUxpnFDUzpC0WK5mxsrbN0lLZUXJHmi8R/oj9m4/uUKcJ+qMZNT2L1XPFGZw6IrsPH
         3mzITUrA5O0Jip/28cCW5UJWldVtMBx/57nc6ejghOuntbWNjE2daSzD1nLy9wAhiWiV
         AbB6QyN6ZW6uEX7S5gHzjvtKptniwsQVRoPIsG7348GWihCe/Kc8/4yNxxumolajKZl7
         1vXT0JmYuxjtn0Iw4I/COxdYDhdMy6f28n7a8Y4+H0Y4QT+9/sHTYZjhUSscbAHmWCur
         UZNg==
X-Gm-Message-State: AOAM532cAgR49Xq8sPWRPoVjVS2MMESGHTZaKMe/CazY5zhHfn3WUnW7
        O46bz/MYLkDsM/MwKCb5gToE5w==
X-Google-Smtp-Source: ABdhPJz951TjnCKvz3DYZhAeG8uZxYqgf8PIM4AUgo/VRGLEm+mN5xXUadhhPju/USbLW7032oYxsA==
X-Received: by 2002:a05:6214:f6c:: with SMTP id iy12mr4915712qvb.29.1636993771407;
        Mon, 15 Nov 2021 08:29:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n20sm3640516qkp.65.2021.11.15.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:29:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2] fstests: detect btrfs compression and disable certain tests
Date:   Mon, 15 Nov 2021 11:29:29 -0500
Message-Id: <c36805e06925606a10ca844a2fa2b30a3db07bdd.1636993704.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our nightly xfstests runs exposed a set of tests that always fail if we
have compression enabled.  This is because compression obviously messes
with the amount of data space allocated on disk, and these tests are
testing either that quota is doing the correct thing, or that we're able
to completely fill the file system.

Add a helper to check to see if we have any of our compression related
mount options set and simply _not_run for these specific tests.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- added _require_no_compress(), made it call the btrfs helper for fstyp ==
  btrfs, changed all the tests to use the generic helper instead.
- added the require to btrfs/237

 common/btrfs      |  7 +++++++
 common/rc         | 11 +++++++++++
 tests/btrfs/126   |  4 ++++
 tests/btrfs/139   |  4 ++++
 tests/btrfs/230   |  4 ++++
 tests/btrfs/232   |  4 ++++
 tests/btrfs/237   |  4 ++++
 tests/generic/275 |  4 ++++
 tests/generic/427 |  4 ++++
 9 files changed, 46 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 2eab4b29..8ce8d60c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -113,6 +113,13 @@ _require_btrfs_fs_sysfs()
 
 }
 
+_require_btrfs_no_compress()
+{
+	if _normalize_mount_options | grep -q "compress"; then
+		_notrun "This test requires no compression enabled"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
diff --git a/common/rc b/common/rc
index 0d261184..9a953a36 100644
--- a/common/rc
+++ b/common/rc
@@ -1676,6 +1676,17 @@ _require_scratch_nocheck()
     rm -f ${RESULT_DIR}/require_scratch
 }
 
+_require_no_compress()
+{
+	case "$FSTYP" in
+	btrfs)
+		_require_btrfs_no_compress
+		;;
+	*)
+		;;
+	esac
+}
+
 # we need the scratch device and it should be checked post test.
 _require_scratch()
 {
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index a13a0a6e..2b0edb65 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -19,6 +19,10 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 _scratch_mkfs >/dev/null
 # Use enospc_debug mount option to trigger restrict space info check
 _scratch_mount "-o enospc_debug"
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index 7760182a..c4b09f9f 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -19,6 +19,10 @@ _supported_fs btrfs
 # We at least need 2GB of free space on $SCRATCH_DEV
 _require_scratch_size $((2 * 1024 * 1024))
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/btrfs/230 b/tests/btrfs/230
index 2daacfbe..46b0c636 100755
--- a/tests/btrfs/230
+++ b/tests/btrfs/230
@@ -17,6 +17,10 @@ _begin_fstest auto quick qgroup limit
 
 _supported_fs btrfs
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 # Need at least 2GiB
 _require_scratch_size $((2 * 1024 * 1024))
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 8691a508..02c7e49d 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -33,6 +33,10 @@ writer()
 
 _supported_fs btrfs
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 _require_scratch_size $((2 * 1024 * 1024))
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 5994edf8..5168777e 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -24,6 +24,10 @@ _require_btrfs_command filesystem sync
 _require_command "$BLKZONE_PROG" blkzone
 _require_zoned_device "$SCRATCH_DEV"
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 get_data_bg()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
diff --git a/tests/generic/275 b/tests/generic/275
index bf0aa2b3..6189edca 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -25,6 +25,10 @@ _cleanup()
 _supported_fs generic
 _require_scratch
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 echo "------------------------------"
 echo "write until ENOSPC test"
 echo "------------------------------"
diff --git a/tests/generic/427 b/tests/generic/427
index 0f99c1b2..26385d36 100755
--- a/tests/generic/427
+++ b/tests/generic/427
@@ -22,6 +22,10 @@ _require_scratch
 _require_test_program "feature"
 _require_aiodio aio-dio-eof-race
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_no_compress
+
 # limit the filesystem size, to save the time of filling filesystem
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
-- 
2.26.3

