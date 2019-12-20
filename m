Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F669127E4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 15:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfLTOk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 09:40:28 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:44379 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfLTOk1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 09:40:27 -0500
Received: by mail-qk1-f174.google.com with SMTP id w127so7757501qkb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQAjOBAg4UwpUQLN0OhUhNXuuC0VTNTUVuT+oKCzaiY=;
        b=LR3ODt6fGhfn9vm8FTOqXlXP2MBovYdOk7OSVHsMA1S7p9MFxl7NYQViLG55Ypa6Us
         8Y9rAr7I4csh2StdVlsZZW4ZedcMZeOUBbm0sGL2jOWH5U2UaGYY83QG3UG7jFRokHL0
         FUG9naYHy806uMKmumCLZLGrcEg9m+Pu5ikqiZK5aWvoaQIO6bqNWdvZq3Fhz5tkKNfP
         W8RzlwI7Du3Lb4Xp9Dosg8v4/PIUCM+h5ipUHioX8dDS/87RRkOQ1vDAt7e1DSwpRFa4
         ngcF5fhiIF+0vgwtRmI9Iu0EinLTvDu3dlvVn92rEbU6297EsjZHFTqY6hImitAg5Bp1
         G31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQAjOBAg4UwpUQLN0OhUhNXuuC0VTNTUVuT+oKCzaiY=;
        b=XY4wowm5ZFXVzvUUoNnuEuDQ5DJ3bjhzjq6w/1rXTwS5UwQQytLKcbtx3F4CyTngPx
         5SDFJ4i2gJlmZhYBlR9OGkn/ZcziyeokE//aSB71P7TEhvnC+YSMthsq7gELdOi1PdWp
         Ak4sDVX8mSkLh1xCosPn/+2JvS7denyV1k6gOiurUTay0xtEE2uLhBVc7CBl1KvRIFFg
         sS6Y+Uq5CennDwzZ3t8JEFY3fy243luXh6VUlIAfmr/p16mYLdlbih6G6b9A88fQoR93
         Zzbq1mPHlJpABhrvuRZw8UoAZHYE8LuIUmRs1KguQdnvWEYQeXwqFcdBGHCR0238JQeD
         eeTA==
X-Gm-Message-State: APjAAAWRYeK8p5qzNSZ0zZ9ZsVjsZv0GEpHtTZTsOQnfJR9qLkAFo/Ll
        GNtxJkH02jMfDUV/poCUruKOlg==
X-Google-Smtp-Source: APXvYqwRmS4Vrn4SKVlkHb72d2mmi4AIc43L7vCVPSxVEEMfll0z8PSM0BMMWprIEegLiJ0VQVwvHg==
X-Received: by 2002:a37:68a:: with SMTP id 132mr4426935qkg.139.1576852826499;
        Fri, 20 Dec 2019 06:40:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k4sm2859745qki.35.2019.12.20.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:40:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH][v2] btrfs: regression test for subvol deletion after rename
Date:   Fri, 20 Dec 2019 09:40:24 -0500
Message-Id: <20191220144024.52271-1-josef@toxicpanda.com>
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
v1->v2:
- add a comment for ls'ing the dummy subvol

 tests/btrfs/202     | 57 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/202.out |  4 ++++
 tests/btrfs/group   |  1 +
 3 files changed, 62 insertions(+)
 create mode 100755 tests/btrfs/202
 create mode 100644 tests/btrfs/202.out

diff --git a/tests/btrfs/202 b/tests/btrfs/202
new file mode 100755
index 00000000..5d56a2a2
--- /dev/null
+++ b/tests/btrfs/202
@@ -0,0 +1,57 @@
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
+
+# Need the dummy entry created so that we get the invalid removal when we rmdir
+ls $SCRATCH_MNT/c/b
+
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

