Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56C149E52
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgA0Cru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34647 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0Cru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id d10so8301177qke.1
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPzV0OIQ4owBtPZr8r9KcWGqke5FOdGDorhzXhTFsSU=;
        b=WO8Kt3S6Wqa04/JcQP7EZ8W3zp1H2XhW5p5/xXYhNbhkaMTgF/7gmT7Du1NH0GCabo
         chOWMDv2IGm8qW2DRIXo10qvU6xCpbrEuUvkiBasNTp71Zj5lcvT3uv8qw2vTvkmATgo
         lo/gvVXJKxlOiINaqTCsSx+3Yl0VfSx9PWCK/cSW0F4rYyZor1qx9w6kVvtYBj2RkA5p
         vBlwFd0K4borHgBZ+WJtfwwVhG9bAM6vAS2CDgDnAHuljFwdIlQKEthoJSjmJ4arJaCJ
         XDMaodcQnd7nP5RzALZZPHAhKW5zXmi2yw20yj16l8gP0Nls6ZKKHlREt8IsHU41Ynkc
         t7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPzV0OIQ4owBtPZr8r9KcWGqke5FOdGDorhzXhTFsSU=;
        b=UzMXpHvpu3dTw3bxzE1T/y8wUlKJBW3SF+sXes9w8V4lwQiv5BUH65k34s3UFuGIbD
         /4GKvEQYOVJYXFcI849ZaN+2W16vLzBjSsb1ESlvzu8JllykzlB+wOyOeGZEaC0sTwKO
         mtga5qL+7Wv5Qz4Ttc5HW9iex085Ocx0oXU7XllzW3hqp2dw+hMSdVy/NbTgsoEHzX6B
         Xe6JsNFPvON+PocowhvqWzOYPJElzlkACKGFlms6bWceKLccyhqu+d5KevGT/PUjTUiV
         6AHg9ahEdUHHJZWUfT+RwWY6gndMgPvRWOn8cBfSaGqv32dJk4NNNmyyfWg4A51D8xPm
         pwsw==
X-Gm-Message-State: APjAAAX3Fh1S2Spc2wOBKiAIVSoHCDdA8aO1Ekit2dARWmCC6qhZOTt+
        /bbv5OkZKKHWcsXzUXlbkk+CtiTl
X-Google-Smtp-Source: APXvYqykY361LW7q7b9hP4KHvbUCb0iAADFs7nhhGkjMKAgEN12zEzEstlvdPnH1wYxPP/M99NHvIQ==
X-Received: by 2002:a05:620a:248:: with SMTP id q8mr14831742qkn.354.1580093269207;
        Sun, 26 Jan 2020 18:47:49 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id n32sm9196963qtk.66.2020.01.26.18.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:48 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/2]  btrfs: Test subvolume delete --subvolid feature
Date:   Sun, 26 Jan 2020 23:50:29 -0300
Message-Id: <20200127025029.17545-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127025029.17545-1-marcos.souza.org@gmail.com>
References: <20200127025029.17545-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/btrfs/203     | 70 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 14 +++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

diff --git a/tests/btrfs/203 b/tests/btrfs/203
new file mode 100755
index 00000000..1765a963
--- /dev/null
+++ b/tests/btrfs/203
@@ -0,0 +1,70 @@
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
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{print $2}'
+
+# Delete the subvolume subvol1 using it's subvolume id
+$BTRFS_UTIL_PROG subvolume delete --subvolid 256  $SCRATCH_MNT | _filter_scratch
+
+echo "After deleting one subvolume:"
+# should present only two subvolumes
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{print $2}'
+
+umount $SCRATCH_MNT
+
+# Now we mount the subvol2, which makes subvol3 not accessible for this mount
+# point, but we should be able to delete it using it's subvolume id
+$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
+$BTRFS_UTIL_PROG subvolume delete --subvolid 259 $SCRATCH_MNT | _filter_scratch
+
+echo "Last remaining subvolume:"
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{print $2}'
+
+umount $SCRATCH_MNT
+
+# now mount the rootfs
+_scratch_mount
+
+# Delete the subvol2
+$BTRFS_UTIL_PROG subvolume delete --subvolid 258  $SCRATCH_MNT | _filter_scratch
+
+echo "All subvolumes removed."
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | awk '{print $2}'
+
+umount $SCRATCH_MNT
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
new file mode 100644
index 00000000..d014a4ad
--- /dev/null
+++ b/tests/btrfs/203.out
@@ -0,0 +1,14 @@
+QA output created by 203
+Current subvolume ids:
+256
+258
+259
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol1'
+After deleting one subvolume:
+258
+259
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol3'
+Last remaining subvolume:
+258
+Delete subvolume (no-commit): 'SCRATCH_MNT/subvol2'
+All subvolumes removed.
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 4b64bf8b..6b48b0c7 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -204,3 +204,4 @@
 200 auto quick send clone
 201 auto quick punch log
 202 auto quick subvol snapshot
+203 auto quick subvol
-- 
2.24.0

