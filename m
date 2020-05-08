Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1F1CB8CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHUNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 16:13:45 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:35499 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbgEHUNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 16:13:44 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 16:13:43 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 3994718425
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 14:52:39 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id X931j2VAsVQh0X931j8A5e; Fri, 08 May 2020 14:52:39 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gr0dIfhy6RMLLBqFhfcrRgx4n8qmRR+qB0M8zbkN094=; b=fS7LhX9EETqcUkIV3dPwYPy7/m
        wIpVWNFMtezVoqinbZOSk62pScqh7mdpmDHU9W6CwxquvzzzPDeY4tF1rYX11x6G7NUk/SdRLuINw
        RAy56ixl1/iziyOm312nY3FkeTEVj2O4DYojMB9sdmOViLpMDMtjS2w5YPtqZaPvFX6xwTQygLZi4
        OVDEarHgP/z1zET0H8QoaWF8VLAti2mhelVIo9qunUmOlfPuxg/YnZ6nUzYmJF3l+gy1mBFja6Z/h
        1OrYtSmyvJBwD77eQh7+osFkmNotPCS2XQ+gdvG6FSvMMmRlwWdTwUa6ce86Ep/upTDa8g/2PEmnz
        Q3ZhKyGQ==;
Received: from [186.212.88.45] (port=46964 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jX930-003Vp4-Jb; Fri, 08 May 2020 16:52:38 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com,
        fdmanana@suse.com, fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: test if the capability is kept on incremental send
Date:   Fri,  8 May 2020 16:55:48 -0300
Message-Id: <20200508195548.25429-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 186.212.88.45
X-Source-L: No
X-Exim-ID: 1jX930-003Vp4-Jb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [186.212.88.45]:46964
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 11
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

There is a situation where the incremental send can drop the capability
from the receiving side. If you have a file that changed the group, but
the capability was the same of before the group changed, the current
kernel code will only emit a chown, since the capability is the same.

The steps bellow can reproduce the problem.

$ mount /dev/sda fs1
$ mount /dev/sdb fs2

$ touch fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar
$ btrfs subvol snap -r fs1 fs1/snap_init
$ btrfs send fs1/snap_init | btrfs receive fs2

$ chgrp adm fs1/foo.bar
$ setcap cap_sys_nice+ep fs1/foo.bar

$ btrfs subvol snap -r fs1 fs1/snap_complete
$ btrfs subvol snap -r fs1 fs1/snap_incremental

$ btrfs send fs1/snap_complete | btrfs receive fs2
$ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2

At this point, a chown was emitted by "btrfs send" since only the group
was changed. This makes the cap_sys_nice capability to be dropped from
fs2/snap_incremental/foo.bar

This test fails on current kernel, the fix was submitted to the btrfs
mailing list titled:

"btrfs: send: Emit file capabilities after chown"

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/btrfs/211     | 153 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/211.out |   6 ++
 tests/btrfs/group   |   1 +
 3 files changed, 160 insertions(+)
 create mode 100755 tests/btrfs/211
 create mode 100644 tests/btrfs/211.out

diff --git a/tests/btrfs/211 b/tests/btrfs/211
new file mode 100755
index 00000000..e9aeaef3
--- /dev/null
+++ b/tests/btrfs/211
@@ -0,0 +1,153 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 211
+#
+# Test if the file capabilities aren't lost after full and incremental send
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
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_command "$SETCAP_PROG" setcap
+_require_command "$GETCAP_PROG" getcap
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+_check_xattr()
+{
+	local RET
+	local FILE
+	local CAP
+	FILE="$1"
+	CAP="$2"
+	RET=$($GETCAP_PROG "$FILE")
+	if [ -z "$RET" ]; then
+		echo "$RET"
+		_fail "missing capability in file $FILE"
+	fi
+	if [[ "$RET" != *$CAP* ]]; then
+		echo "$RET"
+		echo "$CAP"
+		_fail "Capability do not match. Output: $RET"
+	fi
+}
+
+_setup()
+{
+	_scratch_mkfs >/dev/null
+	_scratch_mount
+
+	FS1="$SCRATCH_MNT/fs1"
+	FS2="$SCRATCH_MNT/fs2"
+
+	$BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
+	$BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
+}
+
+_full_nocap_inc_withcap_send()
+{
+	_setup
+
+	# Test full send containing a file with no capability
+	touch "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
+	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
+	# ensure that we don't have caps set
+	RET=$($GETCAP_PROG "$FS2/snap_init/foo.bar")
+	if [ -n "$RET" ]; then
+		_fail "File contain capabilities when it shouldn't"
+	fi
+
+	# Test if  incremental send bring the newly added capability
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
+					$BTRFS_UTIL_PROG receive "$FS2" -q
+	_check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	_scratch_unmount
+}
+
+_roundtrip_send()
+{
+	local FILES
+	local FS1
+	local FS2
+
+	# FILES should include foo.bar
+	FILES="$1"
+
+	_setup
+
+	# create files on fs1, must contain foo.bar
+	for f in $FILES; do
+		touch "$FS1/$f"
+	done
+
+	# Test full send, checking if the receiving side keeps the capability
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
+	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
+	_check_xattr "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	# Test incremental send with different owner/group but same capability
+	chgrp 100 "$FS1/foo.bar"
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
+	_check_xattr "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
+				$BTRFS_UTIL_PROG receive "$FS2" -q
+	_check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	# Test capability after incremental send with different capability and group
+	chgrp 0 "$FS1/foo.bar"
+	$SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/dev/null
+	_check_xattr "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
+				$BTRFS_UTIL_PROG receive "$FS2"  -q
+	_check_xattr "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+
+	_scratch_unmount
+}
+
+# real QA test starts here
+
+echo "Test full send + file without caps, then inc send bringing a new cap"
+_full_nocap_inc_withcap_send
+
+echo "Testing if foo.bar alone can keep it's capability"
+_roundtrip_send "foo.bar"
+
+echo "Test foo.bar being the first item among other files"
+_roundtrip_send "foo.bar foo.bax foo.baz"
+
+echo "Test foo.bar with objectid between two other files"
+_roundtrip_send "foo1 foo.bar foo3"
+
+echo "Test foo.bar being the last item among other files"
+_roundtrip_send "foo1 foo2 foo.bar"
+
+status=0
+exit
diff --git a/tests/btrfs/211.out b/tests/btrfs/211.out
new file mode 100644
index 00000000..fc50c923
--- /dev/null
+++ b/tests/btrfs/211.out
@@ -0,0 +1,6 @@
+QA output created by 211
+Test full send + file without caps, then inc send bringing a new cap
+Testing if foo.bar alone can keep it's capability
+Test foo.bar being the first item among other files
+Test foo.bar with objectid between two other files
+Test foo.bar being the last item among other files
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9426fb17..437d4431 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -213,3 +213,4 @@
 208 auto quick subvol
 209 auto quick log
 210 auto quick qgroup snapshot
+211 auto quick snapshot
-- 
2.25.1

