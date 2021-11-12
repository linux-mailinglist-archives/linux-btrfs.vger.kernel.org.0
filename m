Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952944EE5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 22:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhKLVNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 16:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhKLVNW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 16:13:22 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C79C061767
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 13:10:30 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j17so9768312qtx.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7DQrMaofDnA8zAUMO/Qm4x8IIEkSx3eDtzbWt8rQfo=;
        b=e99ej0OvRxWLPOrHrElBNZizZ9CVI6vTO/s05d8fetx9DUf/j+/pnOTSIy7e5S/Fzo
         x9ILC7odQv9IKTw3t/ZsdArdjfXr2OTLUkTRN60nD4QYYmLCVmZ44cMYOrSNp5Y+7/ZA
         1dFtzw8wztTzkLkY5g+sHZbrXsGMsYjWlNzVq6e1wrXjrNKzi56rUt3ud5MLwly7IN1N
         k8YCbFETgDrzpLdyDcqgHb5x/rNo9n+J+GaXjgc1g6sYF/UVcgPPYTdWhgpSmchI5HIS
         k6oUde6EOt/6rm6UTZd4bx5Hyl6vSwcyW6ySsR803uRe/pXbLlMk7bBMOjy748lFvPxK
         nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7DQrMaofDnA8zAUMO/Qm4x8IIEkSx3eDtzbWt8rQfo=;
        b=M8HB+kn7JjsATzFufOzEARQiuCOfUb3LAqB13VCSZXiYWpnl5jL7xHCJr+R1gTIISl
         K1Rlxff6bGU08VLWjE1Dabw0JbrdWEjAasSiuacJZtNRrT3f4/PLO4dDJZj7/JvPXss2
         Ybc1Sbdjjs0MDoWbaf8lcJA/dKYRTyZuUDWaVRMYrDbSxNcFDT+Lvx0PgnHJTxj0KO50
         z1jSXp4/y6HTkgp8qvJjhY0oHGVQF3jpFkqQBCr4cNwNasN64YTiI8NirQPJ+D/u/KRY
         BxBAedSad8r3dB0rO4nXnJ525CnXew81hgESaR/+wE2ElNWgareiK6SJWN/AphbV+e9c
         7p4A==
X-Gm-Message-State: AOAM530zWVdEhBnqte6zutjBZZ4LnVUNL6gn8bytn9gSmHeNEjTwdUbi
        3yrxSwB89dQqoymqSfWy6XiLt0CmqnyLvg==
X-Google-Smtp-Source: ABdhPJzTLqNfWYuBb5YYlkb1YgeV5SP8SADSqlh2NzrtdC20V664lKOgBnGRyqxNT5YVMOrxga2kFw==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr19223731qtx.158.1636751429114;
        Fri, 12 Nov 2021 13:10:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm3812012qtb.85.2021.11.12.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:10:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: check if the scratch device is an lv device for certain tests
Date:   Fri, 12 Nov 2021 16:10:27 -0500
Message-Id: <e8889f411f37867d3740f623508fd2d3415b63ba.1636751413.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I use lvm to carve up a large disk so I can run the btrfs raid related xfstests.
However this messes with tests that try to greate lvm devices ontop of
SCRATCH_DEV.  Handle this by adding a _require_scratch_nolvm helper to skip
tests that are going to try and create lvm devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/rc         | 11 +++++++++++
 tests/generic/081 |  2 +-
 tests/generic/108 |  2 +-
 tests/generic/459 |  2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 0d261184..c0fb11c6 100644
--- a/common/rc
+++ b/common/rc
@@ -1676,6 +1676,17 @@ _require_scratch_nocheck()
     rm -f ${RESULT_DIR}/require_scratch
 }
 
+# we need the scratch device and it needs to not be an lvm device
+_require_scratch_nolvm()
+{
+	_require_scratch_nocheck
+
+	# This works if we don't have LVM, all we want is to skip if the scratch
+	# device is an lvm device.
+	$LVM_PROG lvdisplay $SCRATCH_DEV > /dev/null 2>&1
+	[ $? -eq 0 ] && _notrun "test requires a non-lvm scratch device"
+}
+
 # we need the scratch device and it should be checked post test.
 _require_scratch()
 {
diff --git a/tests/generic/081 b/tests/generic/081
index 9f294c11..22ac94de 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -50,7 +50,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_test
-_require_scratch_nocheck
+_require_scratch_nolvm
 _require_dm_target snapshot
 _require_command $LVM_PROG lvm
 
diff --git a/tests/generic/108 b/tests/generic/108
index 6e1ea5b9..ad43269f 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -32,7 +32,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs generic
-_require_scratch_nocheck
+_require_scratch_nolvm
 _require_block_device $SCRATCH_DEV
 _require_scsi_debug
 _require_command "$LVM_PROG" lvm
diff --git a/tests/generic/459 b/tests/generic/459
index 5b44e245..cda19e6e 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -39,7 +39,7 @@ _cleanup()
 # This tests for filesystem lockup not consistency, so don't check for fs
 # consistency after test
 _supported_fs generic
-_require_scratch_nocheck
+_require_scratch_nolvm
 _require_dm_target thin-pool
 _require_dm_target snapshot
 _require_command $LVM_PROG lvm
-- 
2.26.3

