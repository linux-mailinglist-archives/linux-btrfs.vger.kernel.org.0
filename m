Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D7169CA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXDez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:34:55 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.107]:12393 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXDez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:34:55 -0500
X-Greylist: delayed 1430 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 22:34:54 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id CA1761F50AA
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2020 21:11:03 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 6499jOhrdAGTX6499jYYIe; Sun, 23 Feb 2020 21:11:03 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7JRT5r8RLeIgYN6SDD7YhCROHMFu/0ikSZV4whiHNvE=; b=AEGCw4zWGBtjaY7Thq/YiDHNI9
        u5b2g8vK2SKXfeHybd9OgMQR7p5Ds/XBNUhp2Mrq/f5jMhWRvDhlf9aqmgBy1Hbn/pIvR+d5jTFK+
        ltKCRXGxR5rzOXKyrJnC59iZBoSR4tsc3JO5W/B7qG55RejWkarM59rjYNWIot1Eh6rGL46nJYWR4
        IISboPla7KPbNO85bKVIzebIlUUSKSjb/AbrqADJ9qAvCaYp7DSu4Lo2aplp0Ek9ALWs1/JJuF2AY
        bUd1ihDG1AkOu6reQXOAj8DV+3ade6vz6YOX1T5gv+mSo8CiX5q8DNCYFKUs4lC2gL/YlSwpfuzjr
        ERCMOj9A==;
Received: from [179.185.222.161] (port=40232 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j6498-0034Sn-NH; Mon, 24 Feb 2020 00:11:03 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [ fstests PATCHv3 2/2] btrfs: Test subvolume delete --subvolid feature
Date:   Mon, 24 Feb 2020 00:13:41 -0300
Message-Id: <20200224031341.27740-3-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224031341.27740-1-marcos@mpdesouza.com>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.222.161
X-Source-L: No
X-Exim-ID: 1j6498-0034Sn-NH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.222.161]:40232
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 16
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v2:
* Added 'Created subvolume...' into 203.out to match the subvolume creating command
* Changed awk to $AWK_PROG, suggested by Eryu
* Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
* Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
* Created a local function to delete and list subvolumes, suggested by Eryu

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers


 tests/btrfs/203     | 68 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 17 ++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

diff --git a/tests/btrfs/203 b/tests/btrfs/203
new file mode 100755
index 00000000..0f662db1
--- /dev/null
+++ b/tests/btrfs/203
@@ -0,0 +1,68 @@
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
+_delete_and_list()
+{
+	local subvol_name="$1"
+	local msg="$2"
+
+	SUBVOLID=$(_btrfs_get_subvolid $SCRATCH_MNT "$subvol_name")
+	$BTRFS_UTIL_PROG subvolume delete --subvolid $SUBVOLID $SCRATCH_MNT | _filter_scratch
+
+	echo "$msg"
+	$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
+}
+
+# Test creating a normal subvolumes
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol3 | _filter_scratch
+
+echo "Current subvolume ids:"
+$BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{ print $NF }'
+
+# Delete the subvolume subvol1, and list the remaining two subvolumes
+_delete_and_list subvol1 "After deleting one subvolume:"
+_scratch_unmount
+
+# Now we mount the subvol2, which makes subvol3 not accessible for this mount
+# point, but we should be able to delete it using it's subvolume id
+$MOUNT_PROG -o subvol=subvol2 $SCRATCH_DEV $SCRATCH_MNT
+_delete_and_list subvol3 "Last remaining subvolume:"
+_scratch_unmount
+
+# now mount the rootfs
+_scratch_mount
+# Delete the subvol2
+_delete_and_list subvol2 "All subvolumes removed."
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
new file mode 100644
index 00000000..3301852b
--- /dev/null
+++ b/tests/btrfs/203.out
@@ -0,0 +1,17 @@
+QA output created by 203
+Create subvolume 'SCRATCH_MNT/subvol1'
+Create subvolume 'SCRATCH_MNT/subvol2'
+Create subvolume 'SCRATCH_MNT/subvol3'
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
2.25.0

