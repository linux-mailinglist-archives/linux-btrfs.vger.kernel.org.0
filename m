Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27A43F1A23
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhHSNPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 09:15:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhHSNPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 09:15:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2AF21FBB;
        Thu, 19 Aug 2021 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629378898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=obXqKBThWDb3zDdkdCUjvXDdSe3DjtTr2TkDlkssQng=;
        b=gC6vHrtaSN+tRCCbolMXKjwbEdOC/c0NIu5QMJO32JKlkCSsEPD9/PI/L7WzEhPPeqhPEL
        YbjxLzOsmofklP/TrsY8ZEDEfdVZiSq1FPABOFfM/06tTwHlWt5o0/rHoHZWQXr0Mk3cR0
        5vjhmtkte9cDir3iT6++YvFNkyOIdAc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C2A6F1340C;
        Thu, 19 Aug 2021 13:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gcPXLFFZHmFvdQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 19 Aug 2021 13:14:57 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Add test for rename exchange behavior between subvolumes
Date:   Thu, 19 Aug 2021 16:14:56 +0300
Message-Id: <20210819131456.304721-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/246     | 46 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/246.out | 27 ++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/btrfs/246
 create mode 100644 tests/btrfs/246.out

diff --git a/tests/btrfs/246 b/tests/btrfs/246
new file mode 100755
index 000000000000..0934932d1f22
--- /dev/null
+++ b/tests/btrfs/246
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 246
+#
+# Tests rename exchange behavior across subvolumes 
+#
+. ./common/preamble
+_begin_fstest auto quick rename
+
+# Import common functions.
+ . ./common/renameat2
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_renameat2 exchange
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Create 2 subvols to use as parents for the rename ops
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
+
+# _rename_tests_source_dest internally expects the flags variable to contain
+# specific options to rename syscall. Ensure cross subvol ops are forbidden
+flags="-x"
+_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol"
+
+# Prepare a subvolume and a directory whose parents are different subvolumes
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev/null
+mkdir $SCRATCH_MNT/subvol2/dir
+
+# Ensure exchanging a subvol with a dir when both parents are different fails
+$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol2/dir
+
+# force transaction commit which runs the tree checker 
+sync
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
new file mode 100644
index 000000000000..d50dc28b1b40
--- /dev/null
+++ b/tests/btrfs/246.out
@@ -0,0 +1,27 @@
+QA output created by 246
+cross-subvol none/none -> No such file or directory
+cross-subvol none/regu -> No such file or directory
+cross-subvol none/symb -> No such file or directory
+cross-subvol none/dire -> No such file or directory
+cross-subvol none/tree -> No such file or directory
+cross-subvol regu/none -> No such file or directory
+cross-subvol regu/regu -> Invalid cross-device link
+cross-subvol regu/symb -> Invalid cross-device link
+cross-subvol regu/dire -> Invalid cross-device link
+cross-subvol regu/tree -> Invalid cross-device link
+cross-subvol symb/none -> No such file or directory
+cross-subvol symb/regu -> Invalid cross-device link
+cross-subvol symb/symb -> Invalid cross-device link
+cross-subvol symb/dire -> Invalid cross-device link
+cross-subvol symb/tree -> Invalid cross-device link
+cross-subvol dire/none -> No such file or directory
+cross-subvol dire/regu -> Invalid cross-device link
+cross-subvol dire/symb -> Invalid cross-device link
+cross-subvol dire/dire -> Invalid cross-device link
+cross-subvol dire/tree -> Invalid cross-device link
+cross-subvol tree/none -> No such file or directory
+cross-subvol tree/regu -> Invalid cross-device link
+cross-subvol tree/symb -> Invalid cross-device link
+cross-subvol tree/dire -> Invalid cross-device link
+cross-subvol tree/tree -> Invalid cross-device link
+Invalid cross-device link
-- 
2.17.1

