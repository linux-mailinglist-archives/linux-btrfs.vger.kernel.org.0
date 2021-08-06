Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5713E29C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbhHFLdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 07:33:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbhHFLdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 07:33:53 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0F421FECB;
        Fri,  6 Aug 2021 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628249616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wnG4tAIQhWsfbOkKU7cjWQIDDvmRWW2pgwsX1qhHHDs=;
        b=Zdw5D65taKUF2XFPGOJxyFEhXpIrG5vHYmeHUsfxpCmjXDrqUSRs7rR4j30oaAyr6nx2XY
        q5BypR4mrgf1Y50D/s0ApIlZwraQizbAvbAPO4YgN+uA0B/oThP/4z4yRWl+aWtCG+ePsv
        Jpw2SmEBblHMCjjH/5Rn+SrdDdqlMKI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B066C13A7D;
        Fri,  6 Aug 2021 11:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lilrHA8eDWEVYgAAGKfGzw
        (envelope-from <wqu@suse.com>); Fri, 06 Aug 2021 11:33:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/244: add test case to verify the behavior of deleting non-existing device
Date:   Fri,  6 Aug 2021 19:33:33 +0800
Message-Id: <20210806113333.328261-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a kernel regression for btrfs, that when passing non-existing
devid to "btrfs device remove" command, kernel will crash due to NULL
pointer dereference.

The test case is for such regression, it will:

- Create and mount an empty single-device btrfs
- Try to remove devid 3, which doesn't exist for above fs
- Make sure the command exits properly with expected error message

The kernel fix is titled "btrfs: fix NULL pointer dereference when
deleting device by invalid id".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Change the subject to also verify the error behavior
- Include the error message into golden output
- Also verify the return value of btrfs command
---
 tests/btrfs/244     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/244.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/btrfs/244
 create mode 100644 tests/btrfs/244.out

diff --git a/tests/btrfs/244 b/tests/btrfs/244
new file mode 100755
index 00000000..fbefeedf
--- /dev/null
+++ b/tests/btrfs/244
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 244
+#
+# Make sure "btrfs device remove" won't crash when non-existing devid
+# is provided
+#
+. ./common/preamble
+_begin_fstest auto quick volume dangerous
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Above created fs only contains one device with devid 1, device remove 3
+# should just fail with proper error message showing devid 3 can't be found.
+# Although on unpatched kernel, this will trigger a NULL pointer dereference.
+$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT
+ret=$?
+
+if [ $ret -ne 1 ]; then
+	echo "Unexpected return value from btrfs command, has $ret expected 1"
+fi
+
+# Fstests will automatically check the filesystem to make sure metadata is not
+# corrupted.
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
new file mode 100644
index 00000000..629adf2a
--- /dev/null
+++ b/tests/btrfs/244.out
@@ -0,0 +1,2 @@
+QA output created by 244
+ERROR: error removing devid 3: No such file or directory
-- 
2.31.1

