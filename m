Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14C147EBD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Dec 2021 06:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbhLXFuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Dec 2021 00:50:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbhLXFuo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Dec 2021 00:50:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C6FE1F396
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1640325043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1e1iIHKO4Rhy1uYlColn051KhxRjY4uPAfvqZ62ViJ8=;
        b=s9AWxoeIYm/qOPlhTftzf4N/pxAAQSPFlQNSqcXXj4Z5yt7CpDmWvMiT1LA7cEGL1h8YAV
        wG+RFxHX1jLTCZpN2M99qNXcvo2hd5Lald3rQrj4Tdb+p/6DOXcIvtf2Si9iV5fNCJe5sO
        7n0/2G/1M6e+NuDFX/v/iBKWOzXsz3M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C35AD13A97
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2NPwIbJfxWGCGQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Dec 2021 05:50:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: fsck-tests: add test case for init-csum-tree
Date:   Fri, 24 Dec 2021 13:50:19 +0800
Message-Id: <20211224055019.51555-6-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211224055019.51555-1-wqu@suse.com>
References: <20211224055019.51555-1-wqu@suse.com>
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

And make sure after --init-csum-tree (with or without
--init-extent-tree) the result fs can still pass fsck.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests/052-init-csum-tree/test.sh | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100755 tests/fsck-tests/052-init-csum-tree/test.sh

diff --git a/tests/fsck-tests/052-init-csum-tree/test.sh b/tests/fsck-tests/052-init-csum-tree/test.sh
new file mode 100755
index 000000000000..d3bf03fab491
--- /dev/null
+++ b/tests/fsck-tests/052-init-csum-tree/test.sh
@@ -0,0 +1,54 @@
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
+
+# --init-csum-tree with --init-extent-tree should not fail
+run_check $SUDO_HELPER "$TOP/btrfs" check --force \
+	--init-csum-tree --init-extent-tree "$TEST_DEV"
+
+# No error should be found
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
-- 
2.34.1

