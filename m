Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20F91EB004
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 22:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFAUKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 16:10:14 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:36517 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgFAUKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 16:10:14 -0400
X-Greylist: delayed 1488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 16:10:12 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 9C1532171A32
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jun 2020 14:45:24 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id fqNAjjJiHXVkQfqNAjkoOK; Mon, 01 Jun 2020 14:45:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q1JreXTZjrSrmapWwl5nnZf/bmirF8RiJudrX89Jpk8=; b=BXucgNdg2y94QtR6EokKp9ulvQ
        EsT1Ycq/0jYdhHzqz85wMsZLVVy/Q7aV9BiCkFBmAdbeHPpyP68BciBjMsjUJQLjXC/GPtOrOBPVQ
        ilUp3ZHdyXqkotXuLbd+YtNY113ffYw29fN3GueGZxDEcv7u9s7f/1VVgg8s5uTyrxNjpS/o67BQS
        8FJULRmFFPj7QbDgeXO4qcOBPf5SnFEat3KD7EBwDaBmuexeDpCdz51iaA2nt0z31sCHOgABIMoGV
        za74wB5UPyBhHerLBHnZLBY8+o6nqk7SnoiCjSzoSrN0em2j/GCBZwp/SvR4bWcIZEv4lBTXxOYDD
        r9D46a4g==;
Received: from 179.187.207.6.dynamic.adsl.gvt.net.br ([179.187.207.6]:60492 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jfqN9-002a1h-TG; Mon, 01 Jun 2020 16:45:24 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, fdmanana@suse.com,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2] btrfs: test if the capability is kept on incremental send
Date:   Mon,  1 Jun 2020 16:48:45 -0300
Message-Id: <20200601194845.11829-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.207.6
X-Source-L: No
X-Exim-ID: 1jfqN9-002a1h-TG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.207.6.dynamic.adsl.gvt.net.br (hephaestus.suse.de) [179.187.207.6]:60492
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This test exercises full send and incremental send operations for cases
where files have capabilities, ensuring the capabilities aren't lost in
the process.

There was a problem with kernel <=5.7 that was making capabilities to be lost
after a combination of full + incremental send. This behavior was fixed by the
following patch:

btrfs: send: Emit file capabilities after chown

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Changes from v1:
 * Remove the steps to reproduce a problem fixes in btrfs code. (Filipe)
 * Remove the underscore from the local function names (Filipe)
 * Change function name _check_xattr -> check_capabilities (Filipe)
 * Rename all local variables to be lowercase (Filipe)
 * Put FS1 and FS2 variables in the global context of the test (Filipe)
 * Changes all occurrences of _fail into a simple echo (Filipe)
 * Declare some local variables as "local" (Filipe)
 * Some Capability -> Capabilities, since we are dealing with multiple capabilities (Filipe)
 * Some cap -> capabilities, inc -> incremental (Filipe)
 * Add missing "send group" (Filipe)

 tests/btrfs/214     | 152 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/214.out |   6 ++
 tests/btrfs/group   |   1 +
 3 files changed, 159 insertions(+)
 create mode 100755 tests/btrfs/214
 create mode 100644 tests/btrfs/214.out

diff --git a/tests/btrfs/214 b/tests/btrfs/214
new file mode 100755
index 00000000..113bbb27
--- /dev/null
+++ b/tests/btrfs/214
@@ -0,0 +1,152 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 214
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
+trap "cleanup; exit \$status" 0 1 2 3 15
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
+FS1="$SCRATCH_MNT/fs1"
+FS2="$SCRATCH_MNT/fs2"
+
+cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+check_capabilities()
+{
+	local file
+	local cap
+	local ret
+	file="$1"
+	cap="$2"
+	ret=$($GETCAP_PROG "$file")
+	if [ -z "$ret" ]; then
+		echo "$ret"
+		echo "missing capability in file $file"
+	fi
+	if [[ "$ret" != *$cap* ]]; then
+		echo "$cap"
+		echo "Capabilities do not match. Output: $ret"
+	fi
+}
+
+setup()
+{
+	_scratch_mkfs >/dev/null
+	_scratch_mount
+
+	$BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
+	$BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
+}
+
+full_nocap_inc_withcap_send()
+{
+	local ret
+
+	setup
+
+	# Test full send containing a file without capabilities
+	touch "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
+	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
+	# ensure that we don't have capabilities set
+	ret=$($GETCAP_PROG "$FS2/snap_init/foo.bar")
+	if [ -n "$ret" ]; then
+		echo "File contains capabilities when it shouldn't"
+	fi
+
+	# Test if incremental send brings the newly added capability
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
+					$BTRFS_UTIL_PROG receive "$FS2" -q
+	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	_scratch_unmount
+}
+
+roundtrip_send()
+{
+	local files
+
+	# files should include foo.bar
+	files="$1"
+
+	setup
+
+	# create files on fs1, must contain foo.bar
+	for f in $files; do
+		touch "$FS1/$f"
+	done
+
+	# Test full send, checking if the receiving side keeps the capabilities
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
+	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
+	check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	# Test incremental send with different owner/group but same capabilities
+	chgrp 100 "$FS1/foo.bar"
+	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
+	check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
+				$BTRFS_UTIL_PROG receive "$FS2" -q
+	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
+
+	# Test capabilities after incremental send with different group and capabilities
+	chgrp 0 "$FS1/foo.bar"
+	$SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
+	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/dev/null
+	check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+	$BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
+				$BTRFS_UTIL_PROG receive "$FS2"  -q
+	check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
+
+	_scratch_unmount
+}
+
+# real QA test starts here
+
+echo "Test full send + file without capabilities, then incremental send bringing a new capability"
+full_nocap_inc_withcap_send
+
+echo "Testing if foo.bar alone can keep its capabilities"
+roundtrip_send "foo.bar"
+
+echo "Test foo.bar being the first item among other files"
+roundtrip_send "foo.bar foo.bax foo.baz"
+
+echo "Test foo.bar with objectid between two other files"
+roundtrip_send "foo1 foo.bar foo3"
+
+echo "Test foo.bar being the last item among other files"
+roundtrip_send "foo1 foo2 foo.bar"
+
+status=0
+exit
diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
new file mode 100644
index 00000000..197a39a9
--- /dev/null
+++ b/tests/btrfs/214.out
@@ -0,0 +1,6 @@
+QA output created by 214
+Test full send + file without capabilities, then incremental send bringing a new capability
+Testing if foo.bar alone can keep its capabilities
+Test foo.bar being the first item among other files
+Test foo.bar with objectid between two other files
+Test foo.bar being the last item among other files
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9e48ecc1..505665b5 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -216,3 +216,4 @@
 211 auto quick log prealloc
 212 auto balance dangerous
 213 auto balance dangerous
+214 auto quick send snapshot
-- 
2.26.2

