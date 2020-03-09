Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D77017DDC6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 11:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCIKg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 06:36:56 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.124]:37468 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbgCIKg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 06:36:56 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 28DFD35A00
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Mar 2020 05:36:54 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id BFmIjoSzKEfyqBFmIjrBxt; Mon, 09 Mar 2020 05:36:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=elJeF7K6y9JBNeL9AEZ3/QkiKaX0fMBmVIjJ08SoDqY=; b=WiwDeEGRLLq5ghGTMy3ndX2Qi+
        Wf1Bv5KEHtIYFYIjEv/SQpuzfb08Y0RgvL8DYhvg2EtpsQyx9qMgfwRwIbQdiJX2Ofllpf/nxhRmj
        FTWo+O50Ca5dzL+y2MPrQn54WT+tmBAjQWPPAws6NPV9kALulPliFmRVIiMGc8Rw8/B/ZkEyHOdqZ
        nHIY64/Afgte2b+WRplOdAaIfQaDic7McAHVwJzSdfHE3glAcLjRukfLYsTjaAnwfuQ8/cVtGCdrs
        PiOwQ4cGlOPVoKaCoL9fBh08EBUstjgF73La5Y/SUQKm2qMziCoYaupB3tQfIM5Uwab763lHcrNX9
        j/1WUlEg==;
Received: from 189.26.190.248.dynamic.adsl.gvt.net.br ([189.26.190.248]:34340 helo=hephaestus.suse.cz)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jBFmH-002Aq1-JD; Mon, 09 Mar 2020 07:36:53 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, guaneryu@gmail.com,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv4 fstests] btrfs: Test subvolume delete --subvolid feature
Date:   Mon,  9 Mar 2020 07:39:56 -0300
Message-Id: <20200309103956.1697-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.190.248
X-Source-L: No
X-Exim-ID: 1jBFmH-002Aq1-JD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.248.dynamic.adsl.gvt.net.br (hephaestus.suse.cz) [189.26.190.248]:34340
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Now btrfs can delete subvolumes based in ther subvolume id. This makes
easy for the user willing to delete a subvolume that cannot be accessed
by the mount point, since btrfs allows to mount a specific subvolume and
hiding the other from the mount point.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes from v3:
* Changes test 203 -> 208, since other tests were merged
* The first patch was merged, so remove it from sending again
  [https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=2f9b4039253d3a6f91cb2a22639a243b5a27e110]

Changes from v2:
* Added Reviewed-by from Nikolay to patch 0001
* Changed awk to $AWK_PROG, suggested by Eryu
* Changed _run_btrfs_util_prog to $BTRFS_UTIL_PROG, suggested by Eryu
* Use _scratch_unmount instead of executing umount by hand, sugested by Eryu
* Created a local function to delete and list subvolumes, suggested by Eryu

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

 tests/btrfs/208     | 68 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/208.out | 17 ++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/208
 create mode 100644 tests/btrfs/208.out

diff --git a/tests/btrfs/208 b/tests/btrfs/208
new file mode 100755
index 00000000..4ffc8719
--- /dev/null
+++ b/tests/btrfs/208
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 208
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
diff --git a/tests/btrfs/208.out b/tests/btrfs/208.out
new file mode 100644
index 00000000..9b660699
--- /dev/null
+++ b/tests/btrfs/208.out
@@ -0,0 +1,17 @@
+QA output created by 208
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
index 94090758..4dfed8db 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -210,3 +210,4 @@
 205 auto quick clone compress
 206 auto quick log replay
 207 auto rw raid
+208 auto quick subvol
-- 
2.25.0

