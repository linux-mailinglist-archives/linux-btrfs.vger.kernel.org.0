Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD84155839
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGNRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:17:20 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34626 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:17:20 -0500
Received: by mail-wm1-f44.google.com with SMTP id s144so3173162wme.1;
        Fri, 07 Feb 2020 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fj5nXI0w4noZCGebFpVSQdEXZvsCASoCdPZNM0kY+sk=;
        b=MLCq0Fwboi7PABWcjs2cPYgiGSo2XDTqVNs1hqFeV4+4RFLT9Y7G/DUAdbNurnk7uK
         LEotUim0AiCm7NnqVsik6IhdZcVYn7SlCL/Eqn8gSPWwrbPXHi1pHooOC3LrdrFnXvLB
         egfuic8Cdavhnqnt5DylsuJBaQ+mVzs4GCYFVTZwmolVQGPzLyVI9JRQkk7HkN6w4Z4g
         f7pM/7GeVxTmABhwCy39O3U/bakHXCkbaNuM46Qj0bMDfMY39w5C0dL/hjPbgYQu0Wa+
         Da3i5W5khjtmpRVrTEjscuRFTEY4hhE9Oci65SGOedS2g00GwnlAa7g/yFTkugQorgpd
         Z/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fj5nXI0w4noZCGebFpVSQdEXZvsCASoCdPZNM0kY+sk=;
        b=qhoHcqnbWjNh+pKlzYjcwVLP45o4gcDP3qc+nUU7dbijWtysQ7ybCyuIxXn0KGqryd
         NyngydqqEklx5n/Zt65SsUXw3fVGCXoEh+GLM9muYfoZG38FtnKv95BxvxNr91UUPMmB
         wtoUT3Y26MNBIiicTNJn99wU/rSJDfR6W3fnIiYYlafnfvrbG5EFyji1G1eNukqZRKOV
         gJn7jtTAN4vibdalYo/2WXUclNSLgs4eyhsR5zWo7zv15t0eLzi8E6bqEb5538qs2ugC
         NXg6qcv7W5jpAXM20G9j/3yXHhc3V+iL3r8wqhMT0kGOG0OEmRflxnq22fi2H78MhPIH
         foiQ==
X-Gm-Message-State: APjAAAWGL2tCJowY6/kFe6Boi3srpJ0ZgB0b0vFfEtmlOs4syV8XNQjc
        +omgq0hsOM7e4hOcMQkqApg=
X-Google-Smtp-Source: APXvYqzUr2GO5/u87gQjX9jnYnkknco0lBN44ocDMi7agC5U5QkBJ5DYN6tn0oVCr1pv3YR8SNhNHg==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr4224561wme.64.1581081436555;
        Fri, 07 Feb 2020 05:17:16 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id i204sm3472723wma.44.2020.02.07.05.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:17:16 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 2/2]  btrfs: Test subvolume delete --subvolid feature
Date:   Fri,  7 Feb 2020 10:19:51 -0300
Message-Id: <20200207131951.15859-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207131951.15859-1-marcos.souza.org@gmail.com>
References: <20200207131951.15859-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers

 tests/btrfs/203     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 14 +++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

diff --git a/tests/btrfs/203 b/tests/btrfs/203
new file mode 100755
index 00000000..b9f1391f
--- /dev/null
+++ b/tests/btrfs/203
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 203
+#
+# Test subvolume deletion using the subvolume id, even when the subvolume in
+# question is in a different mount space.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/filter.btrfs
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_btrfs_command subvolume delete --subvolid
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Test creating a normal subvolumes
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
+
+echo "Current subvolume ids:"
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
+
+# Delete the subvolume subvol1 using it's subvolume id
+SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol1)
+$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID  $SCRATCH_MNT | _filter_scratch
+
+echo "After deleting one subvolume:"
+# should present only two subvolumes
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
+
+umount $SCRATCH_MNT
+
+# Now we mount the subvol2, which makes subvol3 not accessible for this mount
+# point, but we should be able to delete it using it's subvolume id
+$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
+SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol3)
+$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
+
+echo "Last remaining subvolume:"
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
+
+umount $SCRATCH_MNT
+
+# now mount the rootfs
+_scratch_mount
+
+# Delete the subvol2
+SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT subvol2)
+$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID  $SCRATCH_MNT | _filter_scratch
+
+echo "All subvolumes removed."
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{ print $NF }'
+
+umount $SCRATCH_MNT
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
new file mode 100644
index 00000000..bca18c32
--- /dev/null
+++ b/tests/btrfs/203.out
@@ -0,0 +1,14 @@
+QA output created by 203
+Current subvolume ids:
+subvol1
+subvol2
+subvol3
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
+After deleting one subvolume:
+subvol2
+subvol3
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
+Last remaining subvolume:
+subvol2
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
+All subvolumes removed.
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 79f85e97..e7744217 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -204,3 +204,4 @@
 200 auto quick send clone
 201 auto quick punch log
 202 auto quick subvol snapshot
+203 auto quick subvol
-- 
2.24.0

