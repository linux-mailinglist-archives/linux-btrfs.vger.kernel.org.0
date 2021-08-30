Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413663FB914
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhH3Phi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 11:37:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbhH3Phh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 11:37:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8159A200D5;
        Mon, 30 Aug 2021 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630337802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AN0f7m6ssa/pOf/g/W6KgPIkYYzGx5+b+JDbYkjTeoE=;
        b=GO3OwdFf5Xu4g75LvRAG3xW1TmpGoKN1FpwEqxzjzjspdIipzjUQiJIWljPWRpqEfKEVa9
        2hgWvcoG9YDnHyJldsVR1MYWDHfDmX4ojsNTZctW27hxgOUU4eBxEMSHm1zKjjDoPEdxOv
        uJV8AxpDk2R212cHRjDsq6eawOjJrOk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4408F139A5;
        Mon, 30 Aug 2021 15:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id l2TuDQr7LGEcGAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 15:36:42 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Add test for rename/exchange behavior between subvolumes
Date:   Mon, 30 Aug 2021 18:36:41 +0300
Message-Id: <20210830153641.893416-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830122306.882081-2-nborisov@suse.com>
References: <20210830122306.882081-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This tests ensures that renames/exchanges across subvolumes work only
for other subvolumes and are otherwise forbidden and fail.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
This is the real v2.

Changes in V2:
 * Added cross-subvol rename tests
 * Added cross-subvol subvolume rename test
 * Added ordinary volume rename test
 * Removed explicit sync


 tests/btrfs/246     | 60 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/246.out | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100755 tests/btrfs/246
 create mode 100644 tests/btrfs/246.out

diff --git a/tests/btrfs/246 b/tests/btrfs/246
new file mode 100755
index 000000000000..53039df38993
--- /dev/null
+++ b/tests/btrfs/246
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 246
+#
+# Tests rename/exchange behavior when subvolumes are involved. Rename/exchanges
+# across subvolumes are forbidden. This is also a regression test for
+# 3f79f6f6247c ("btrfs: prevent rename2 from exchanging a subvol with a
+# directory from different parents").
+#
+. ./common/preamble
+_begin_fstest auto quick rename subvol
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
+# Ensure cross subvol ops are forbidden
+_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol" "-x"
+
+# Prepare a subvolume and a directory whose parents are different subvolumes
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev/null
+mkdir $SCRATCH_MNT/subvol2/dir
+
+# Ensure exchanging a subvol with a dir when both parents are different fails
+$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol2/dir
+
+echo "ordinary rename"
+# Test also ordinary renames
+_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/dst "cross-subvol"
+
+echo "subvolumes rename"
+# Rename subvol1/sub-subvol -> subvol2/sub-subvol
+$here/src/renameat2  $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol2/sub-subvol
+# Now create another subvol under subvol1/
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev/null
+# and exchange the two
+$here/src/renameat2 -x $SCRATCH_MNT/subvol2/sub-subvol $SCRATCH_MNT/subvol1/sub-subvol
+
+# simple rename of a subvolume in the same directory, should catch
+# 4871c1588f92 ("Btrfs: use right root when checking for hash collision")
+mv $SCRATCH_MNT/subvol2/ $SCRATCH_MNT/subvol2.
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
new file mode 100644
index 000000000000..5db90cf2bd9a
--- /dev/null
+++ b/tests/btrfs/246.out
@@ -0,0 +1,54 @@
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
+ordinary rename
+cross-subvol none/none -> No such file or directory
+cross-subvol none/regu -> No such file or directory
+cross-subvol none/symb -> No such file or directory
+cross-subvol none/dire -> No such file or directory
+cross-subvol none/tree -> No such file or directory
+cross-subvol regu/none -> Invalid cross-device link
+cross-subvol regu/regu -> Invalid cross-device link
+cross-subvol regu/symb -> Invalid cross-device link
+cross-subvol regu/dire -> Is a directory
+cross-subvol regu/tree -> Is a directory
+cross-subvol symb/none -> Invalid cross-device link
+cross-subvol symb/regu -> Invalid cross-device link
+cross-subvol symb/symb -> Invalid cross-device link
+cross-subvol symb/dire -> Is a directory
+cross-subvol symb/tree -> Is a directory
+cross-subvol dire/none -> Invalid cross-device link
+cross-subvol dire/regu -> Not a directory
+cross-subvol dire/symb -> Not a directory
+cross-subvol dire/dire -> Invalid cross-device link
+cross-subvol dire/tree -> Invalid cross-device link
+cross-subvol tree/none -> Invalid cross-device link
+cross-subvol tree/regu -> Not a directory
+cross-subvol tree/symb -> Not a directory
+cross-subvol tree/dire -> Invalid cross-device link
+cross-subvol tree/tree -> Invalid cross-device link
+subvolumes rename
--
2.17.1

