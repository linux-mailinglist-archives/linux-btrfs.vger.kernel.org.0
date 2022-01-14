Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9148E1C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiANAvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiANAvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87E8D218FC
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pOz1rcOUZQnL2crfuM1r+IGadqeCzPten/QZhYarPg=;
        b=G8wURoWbPLAucm+YCShFs8faEIx0h7IR07aRWjO/w9bfwO3JKbf38EqZ3ip1YwEIWz+d14
        5/IWg8m2wKUafQ+U272EoIbAOthNRp/QPvHG5LDWuVI5tKzzz8BUs9P/3O9i2Om8clnUF7
        p09jLiXCsTubcqLgeuEyT7bHkDT4yWg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF2CD1344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AIbcJCLJ4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs-progs: fsck-tests: add test case for init-csum-tree
Date:   Fri, 14 Jan 2022 08:51:23 +0800
Message-Id: <20220114005123.19426-6-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
References: <20220114005123.19426-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new test script will create a fs with the following situations:

- Preallocated extents (no data csum)
- Nodatasum inodes (no data csum)
- Partially written preallocated extents (no data csum for part of the
  extent)
- Regular data extents (with data csum)
- Regular data extents then hole punched (with data csum)
- Preallocated data, then written, then hole punched (with data csum)
- Compressed extents (with data csum)

And make sure after --init-csum-tree (with or without
--init-extent-tree) the result fs can still pass fsck.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/052-init-csum-tree/test.sh | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100755 tests/fsck-tests/052-init-csum-tree/test.sh

diff --git a/tests/fsck-tests/052-init-csum-tree/test.sh b/tests/fsck-tests/052-init-csum-tree/test.sh
new file mode 100755
index 000000000000..34ca50e5c85f
--- /dev/null
+++ b/tests/fsck-tests/052-init-csum-tree/test.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+#
+# Verify that `btrfs check --init-csum-tree` can handle various nodatasum
+# cases.
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+check_global_prereq fallocate
+check_global_prereq dd
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+
+# Create an inode with nodatasum and some content
+run_check_mount_test_dev -o nodatasum
+
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/nodatasum_file" \
+	bs=16k count=1 status=noxfer > /dev/null 2>&1
+
+# Revert to default datasum
+run_check $SUDO_HELPER mount -o remount,datasum "$TEST_MNT"
+
+# Then create an inode with datasum, but all preallocated extents
+run_check fallocate -l 32k "$TEST_MNT/prealloc1"
+
+# Create preallocated extent but partially written
+run_check fallocate -l 32k "$TEST_MNT/prealloc2"
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/prealloc2" \
+	bs=16k count=1 conv=notrunc status=noxfer> /dev/null 2>&1
+
+# Then some regular files
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/regular" \
+	bs=16k count=1 status=noxfer > /dev/null 2>&1
+
+# And some regular files with holes
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/regular_with_holes" \
+	bs=16k count=1 status=noxfer > /dev/null 2>&1
+run_check $SUDO_HELPER fallocate -p -o 4096 -l 4096 "$TEST_MNT/regular_with_holes"
+
+# And the most complex one, preallocated, written, then hole
+run_check $SUDO_HELPER fallocate  -l 8192 "$TEST_MNT/complex"
+run_check $SUDO_HELPER dd if=/dev/urandom of="$TEST_MNT/compex" \
+	bs=4k count=1 conv=notrunc status=noxfer > /dev/null 2>&1
+sync
+run_check $SUDO_HELPER fallocate -p -l 4096 "$TEST_MNT/regular_with_holes"
+
+# Create some compressed file
+run_check $SUDO_HELPER mount -o remount,compress "$TEST_MNT"
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/compressed" \
+	bs=16k count=4 conv=notrunc status=noxfer> /dev/null 2>&1
+
+# And create a snapshot, every data extent is at least shared twice
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot "$TEST_MNT" \
+	"$TEST_MNT/snapshot"
+run_check_umount_test_dev
+
+# --init-csum-tree should not fail
+run_check $SUDO_HELPER "$TOP/btrfs" check --force \
+	--init-csum-tree "$TEST_DEV"
+
+# No error should be found
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+btrfs ins dump-tree "$TEST_DEV" > /tmp/dump
+
+# --init-csum-tree with --init-extent-tree should not fail
+#run_check $SUDO_HELPER "$TOP/btrfs" check --force \
+#	--init-csum-tree --init-extent-tree "$TEST_DEV"
+
+# No error should be found
+#run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
-- 
2.34.1

