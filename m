Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E422BFEF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 05:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKWEMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Nov 2020 23:12:38 -0500
Received: from gateway36.websitewelcome.com ([192.185.184.18]:17077 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgKWEMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Nov 2020 23:12:38 -0500
X-Greylist: delayed 1297 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Nov 2020 23:12:37 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 9CE29400CF14B
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Nov 2020 21:50:59 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id h2sVk00lfYLDnh2sVkzTCY; Sun, 22 Nov 2020 21:50:59 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzUl/OA+elutv3PgG4jfRtkmxPAF/uzTf0X4MmLH7XA=; b=H+pfUldEekIRr2dTUfcLNy1Q8N
        7+iWM6vrpEYbW2K0uP6AwEjmtSE5LqoxiRzNDX1yXubFqczPVlicNU2/HwmXJ3Ya3HxJatSZ+bSmp
        wzGGK5YxiJAU1F2+GvWh1xUnZlvEW+flRl/uTScuR95gYM/kpCN9PI7X6QeUHEBYJE/crGwkexCZ3
        2wTB9FiHRsxFU5OFMCKgUGPrpP5d/H1iPgFCbWnLasYnn+54zevCEGXdvMYzK7ZRm+QZMJdBQldAX
        EgjFE+jd5+XTJyGDUFjDzam+kPrIaXDCAngYAvOvMaovaDwuT4bEOwJ20YibqBhoARHpRmi61fySj
        +VzNgpfw==;
Received: from [191.249.68.105] (port=43094 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kh2sV-0007ir-4B; Mon, 23 Nov 2020 00:50:59 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v3 3/3] btrfs-progs: tests: Add new logical-resolve test
Date:   Mon, 23 Nov 2020 00:50:26 -0300
Message-Id: <20201123035026.7282-4-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123035026.7282-1-marcos@mpdesouza.com>
References: <20201123035026.7282-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.68.105
X-Source-L: No
X-Exim-ID: 1kh2sV-0007ir-4B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.suse.de) [191.249.68.105]:43094
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 16
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 .../test.sh                                   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 tests/misc-tests/042-inspect-internal-logical-resolve/test.sh

diff --git a/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
new file mode 100755
index 00000000..fcf1147f
--- /dev/null
+++ b/tests/misc-tests/042-inspect-internal-logical-resolve/test.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# Check if logical-resolve is resolving the paths correctly for different
+# subvolume tree configurations. This used to fail when a child subvolume was
+# mounted without the parent subvolume being accessible.
+
+source "$TEST_TOP/common"
+
+setup_root_helper
+prepare_test_dev
+
+check_prereq btrfs
+check_prereq mkfs.btrfs
+
+check_logical_offset_filename()
+{
+	local filename
+	local offset
+	offset="$1"
+	filename="$2"
+
+	while read file; do
+		if [[ "$file" = *"inode "* ]]; then
+			_log "$file"
+		elif [ ! -f $file ]; then
+			_fail "Path not $file file cannot be accessed"
+		elif [ ! $filename = $file ]; then
+			_fail "logical-resolve failed. Expected $filename but returned $file"
+		else
+			_log "$file"
+		fi
+	done < <($TOP/btrfs inspect-internal logical-resolve "$offset" "$TEST_MNT")
+}
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+# create top subvolume called '@'
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/@"
+
+# create a file in eacch subvolume of @, and each file will have 2 EXTENT_DATA
+# items, and also create a snapshot to have a extent being referenced by two
+# different fs trees
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/@/vol1"
+vol1id=$($SUDO_HELPER "$TOP/btrfs" inspect-internal rootid "$TEST_MNT/@/vol1")
+run_check $SUDO_HELPER dd if=/dev/zero bs=1M count=150 of="$TEST_MNT/@/vol1/file1"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1" "$TEST_MNT/@/snap1"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/@/vol1/subvol1"
+subvol1id=$($SUDO_HELPER "$TOP/btrfs" inspect-internal rootid "$TEST_MNT/@/vol1/subvol1")
+run_check $SUDO_HELPER dd if=/dev/zero bs=1M count=150 of="$TEST_MNT/@/vol1/subvol1/file2"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT/@/vol1/subvol1" \
+							"$TEST_MNT/@/vol1/snapshot1"
+
+"$TOP/btrfs" filesystem sync "$TEST_MNT"
+
+run_check_umount_test_dev
+
+# to be used later
+mkdir -p mnt2
+
+$SUDO_HELPER mount -o subvol=/@/vol1 $TEST_DEV "$TEST_MNT"
+# create a bind mount to the vol1. logical-resolve should avoid bind mounts,
+# otherwise the test will fail
+mkdir -p "$TEST_MNT/dir"
+$SUDO_HELPER mount --bind "$TEST_MNT/dir" mnt2
+
+for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$vol1id" \
+		"$TEST_DEV" | awk '/disk byte/ { print $5 }'); do
+	check_logical_offset_filename "$offset" "$TEST_MNT/file1"
+done
+
+run_check_umount_test_dev mnt2
+run_check_umount_test_dev
+
+$SUDO_HELPER mount -o subvol=/@/vol1/subvol1 $TEST_DEV "$TEST_MNT"
+for offset in $("$TOP/btrfs" inspect-internal dump-tree -t "$subvol1id" \
+		"$TEST_DEV" | awk '/disk byte/ { print $5 }'); do
+	check_logical_offset_filename "$offset" "$TEST_MNT/file2"
+done
+
+run_check_umount_test_dev
-- 
2.26.2

