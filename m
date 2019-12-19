Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9D1264A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 15:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSO2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 09:28:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37048 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLSO2i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 09:28:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so4785921qky.4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvqY5TvLs2EG4Ubsh3PQ2JzrxSkMhMPV6qsK0WJpGKw=;
        b=sPzbSWgMnZcCv3QxfuwTEh8TQ0G0wtRC7QspVh3RgKDukoy+ILoAunU8r2lKSsESoX
         JQWDUs/wIFL3hOLb0thCbGEJCWt67nq04wNi3LipsC7DcVXnj2tahqkcwMxtsrSHYTpv
         tjyzvVQBuyBjT9c2WGAIzer5Nx3snHdA8LMWDeha6HP+4ymp69ByT86iGc9S0gySdhu9
         t08urhD7JsMUwnXNZbFV0w7aOOB/BToODPnWKqfaMYgYa85JqOghpRtvbIeidnYN4Tu0
         TDxE6TkVjF8BMoJq7puMh1+kpoBWeHDdDDu/CsSjI8REtfnbuIxIvzFQTSn0LxpwR+wH
         B1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvqY5TvLs2EG4Ubsh3PQ2JzrxSkMhMPV6qsK0WJpGKw=;
        b=DSkeHP7K04/Smb17kFH92LSxtl+Chth/Rf5L2X6uwWgS6MP3Nhb1jyWx2afEfrP9KE
         hMV/XVWF8APdR0CsYTXTmppjTXKs6b6ERVowjZZboZacvzmNsY0haVlWJ6KTiyDp3Do3
         W15vqIr7uC7tNOMfJAARW/gGcw+fXcUiDl4xZLampzVOTvBb4V2grziVyNx4q5TTRxZf
         t8NR91G4hMxflsDDpf7gDiM/ME0C3QTyRulqG47rvV7ZpluPbFI5U8EPkjT+Om55HGdy
         Nr1UPk3VdogxZwvI8BKS8oHae2YGD5Z6dSUIm/yldpADUpkm00/c+GdI8il5XvuFHJtf
         F8qQ==
X-Gm-Message-State: APjAAAUuzgjlEy6dIOZYoN+C23eDn6qLhVlaH+4bJ7jeB1t16/GCvX8L
        PFN46BMCbkMU+JRdQ+Tz5j26oNrz0l45GQ==
X-Google-Smtp-Source: APXvYqz1jDbORjr+hxhQaQ9oa2hWthuxh6OPG3MhHEHOlu6PCBIdzBqsfsFe9ZOvj/EUY54beGULUQ==
X-Received: by 2002:ae9:e30b:: with SMTP id v11mr8551777qkf.434.1576765717461;
        Thu, 19 Dec 2019 06:28:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q73sm1750009qka.56.2019.12.19.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:28:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] btrfs: regression test for subvol deletion after rename
Date:   Thu, 19 Dec 2019 09:28:35 -0500
Message-Id: <20191219142835.50371-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test removal of a subvolume via rmdir after it has been renamed into a
snapshot of the volume that originally contained the subvolume
reference.

This currently fails on btrfs but is fixed by the patch with the title

  "btrfs: fix invalid removal of root ref"

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/202     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/202.out |  4 ++++
 tests/btrfs/group   |  1 +
 3 files changed, 59 insertions(+)
 create mode 100755 tests/btrfs/202
 create mode 100644 tests/btrfs/202.out

diff --git a/tests/btrfs/202 b/tests/btrfs/202
new file mode 100755
index 00000000..b02ee446
--- /dev/null
+++ b/tests/btrfs/202
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 201
+#
+# Regression test for fix "btrfs: fix invalid removal of root ref"
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
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+_supported_fs btrfs
+_supported_os Linux
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Create a subvol b under a and then snapshot a into c.  This create's a stub
+# entry in c for b because c doesn't have a reference for b.
+#
+# But when we rename b c/foo it creates a ref for b in c.  However if we go to
+# remove c/b btrfs used to depend on not finding the root ref to handle the
+# unlink properly, but we now have a ref for that root.  We also had a bug that
+# would allow us to remove mis-matched refs if the keys matched, so we'd end up
+# removing too many entries which would cause a transaction abort.
+
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
+	| _filter_scratch
+ls $SCRATCH_MNT/c/b
+mkdir $SCRATCH_MNT/c/foo
+mv $SCRATCH_MNT/a/b $SCRATCH_MNT/c/foo
+rm -rf $SCRATCH_MNT/*
+touch $SCRATCH_MNT/blah
+
+status=0
+exit
diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
new file mode 100644
index 00000000..938870cf
--- /dev/null
+++ b/tests/btrfs/202.out
@@ -0,0 +1,4 @@
+QA output created by 201
+Create subvolume 'SCRATCH_MNT/a'
+Create subvolume 'SCRATCH_MNT/a/b'
+Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d7eeb45d..7abc5f07 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -204,3 +204,4 @@
 199 auto quick trim
 200 auto quick send clone
 201 auto quick punch log
+202 auto quick volume
-- 
2.23.0

