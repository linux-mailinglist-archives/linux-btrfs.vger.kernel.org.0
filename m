Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4144EBED
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhKLR0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 12:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhKLR0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 12:26:13 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C40C061767
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 09:23:22 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q14so9093082qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 09:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x80ZsYZiRMe7lGDzinCxwHtmc2IuxrZ10F8z4YfMDmo=;
        b=EtZmcX26BRljvVJt+zcKzeJsonnFIiCSbIqjigQdr3M1HnVPOZxBXmPuM7iSDlVJhY
         UHfeD+0LQ4NP+07iCHJLqCMUCz7IbK6UQ4Ap7s52zcVk2qq9rYy/ldXn1Rz7KugI8nbc
         zwXSISxfGv5FVid0LtRb9Pi3QyTbWP62ZHGZtpdUYwjPZqcn9zP1Wyl+H0bI2NpI7l+X
         AXvDA6nYyacfsMq3JrIKphB+m1fT0Xpp/iuMP4UrknmZzQLMgy7t1VtF0ZcFDtmOVnTt
         oIgRZ4owCfGFbk3x8/DdbwCx6wRgUW77Bpfd4zZXVQgIrQKARFX1Qj5fjXYEPI8hluPE
         +PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x80ZsYZiRMe7lGDzinCxwHtmc2IuxrZ10F8z4YfMDmo=;
        b=1NsBCit8I3IXRdppHtJ+coC1kvg0B3s+e1ORwmFjP4N51jdqFlqNXClFPhj51lXYaG
         gX0cwis6HM4p8eLq5RMIflME5fAvaDWoQji37yvaO8G47OCMgFH0evnaCtOcSnu7mzFi
         MfZUZUyIL70QHDd4tCd5QC2blPIJexTWb14HX0Fka50QAqRcB1qnuaNdebn1Muv08g7H
         ghHeiEETpiEB+v27uch6qWLYpJ9/bELHLaX3Hjdl2arAnIO77NzA0eeTIizUwrUuEMNa
         OTSRzUZBuI6AW3GUDQTP/6N0BPXa/JH533Bg/sCVf9KEWH3mNuT/Xx/641El5wrRe7kO
         ojuA==
X-Gm-Message-State: AOAM531d+XBYKSdHunT2JRXHfWYoI3zEu1Efup+4w74YxKn6MuClATK1
        TAru6MQ7Fl23xmujkIsPgzMk7aVawfgjDw==
X-Google-Smtp-Source: ABdhPJwRUU6p/rtRZ3BsF2NwkM7TdkknS7yrCzj3uLzk8XiikFPVb5wGMB2J3kO7k60egfJkQVUEyQ==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr17944758qtl.390.1636737800828;
        Fri, 12 Nov 2021 09:23:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a38sm2018942qkp.80.2021.11.12.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:23:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: detect btrfs compression and disable certain tests
Date:   Fri, 12 Nov 2021 12:23:18 -0500
Message-Id: <f2b314338ecd06ae734ff0f0537f0cdf247db8f6.1636737764.git.josef@toxicpanda.com>
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
 common/btrfs      | 10 ++++++++++
 tests/btrfs/126   |  4 ++++
 tests/btrfs/139   |  4 ++++
 tests/btrfs/230   |  4 ++++
 tests/btrfs/232   |  4 ++++
 tests/generic/275 |  4 ++++
 tests/generic/427 |  4 ++++
 7 files changed, 34 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 2eab4b29..b4067121 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -113,6 +113,16 @@ _require_btrfs_fs_sysfs()
 
 }
 
+_require_btrfs_no_compress()
+{
+	if [ "$FSTYP" != "btrfs" ]; then
+		return
+	fi
+
+	_scratch_mount_options | grep -q "compress"
+	[ $? -eq 0 ] && _notrun "This test requires no compression enabled"
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index a13a0a6e..d9b638fd 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -19,6 +19,10 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 _scratch_mkfs >/dev/null
 # Use enospc_debug mount option to trigger restrict space info check
 _scratch_mount "-o enospc_debug"
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index 7760182a..dcf85416 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -19,6 +19,10 @@ _supported_fs btrfs
 # We at least need 2GB of free space on $SCRATCH_DEV
 _require_scratch_size $((2 * 1024 * 1024))
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 
diff --git a/tests/btrfs/230 b/tests/btrfs/230
index 2daacfbe..d431be50 100755
--- a/tests/btrfs/230
+++ b/tests/btrfs/230
@@ -17,6 +17,10 @@ _begin_fstest auto quick qgroup limit
 
 _supported_fs btrfs
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 # Need at least 2GiB
 _require_scratch_size $((2 * 1024 * 1024))
 _scratch_mkfs > /dev/null 2>&1
diff --git a/tests/btrfs/232 b/tests/btrfs/232
index 8691a508..eca1bf41 100755
--- a/tests/btrfs/232
+++ b/tests/btrfs/232
@@ -33,6 +33,10 @@ writer()
 
 _supported_fs btrfs
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 _require_scratch_size $((2 * 1024 * 1024))
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
diff --git a/tests/generic/275 b/tests/generic/275
index bf0aa2b3..012bd45f 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -25,6 +25,10 @@ _cleanup()
 _supported_fs generic
 _require_scratch
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 echo "------------------------------"
 echo "write until ENOSPC test"
 echo "------------------------------"
diff --git a/tests/generic/427 b/tests/generic/427
index 0f99c1b2..2ebcbf43 100755
--- a/tests/generic/427
+++ b/tests/generic/427
@@ -22,6 +22,10 @@ _require_scratch
 _require_test_program "feature"
 _require_aiodio aio-dio-eof-race
 
+# This test requires specific data space usage, skip if we have compression
+# enabled.
+_require_btrfs_no_compress
+
 # limit the filesystem size, to save the time of filling filesystem
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
-- 
2.26.3

