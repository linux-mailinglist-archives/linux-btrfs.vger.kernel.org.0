Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2183E28DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbhHFKrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 06:47:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhHFKrH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 06:47:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FD982242F;
        Fri,  6 Aug 2021 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628246811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AKHK7gqYk/XaXZkTjOYPV1UxRpq4IfbDz4xd5x4SpyY=;
        b=tp8tfVV43Z9I4H3nR06YJ7R2TksxUSEYuFFK9JgcbLw+8ymRaGowCR4h3CQmYNOkWKsN79
        SS1A/CT/b1uk9J2SjPHL9Olkcme7wmpyV4HGNZSik5wy3DYMIeqCCjyQSvEzep4JxzHQq3
        /8WLBoEgqTVQY+qvTHu3Wt58tHkTi/Y=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 19FF513A70;
        Fri,  6 Aug 2021 10:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JTEAMxkTDWHAUwAAGKfGzw
        (envelope-from <wqu@suse.com>); Fri, 06 Aug 2021 10:46:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/244: add test case to make sure kernel won't crash when deleting non-existing device
Date:   Fri,  6 Aug 2021 18:46:47 +0800
Message-Id: <20210806104647.312765-1-wqu@suse.com>
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

The fix is titled "btrfs: fix NULL pointer dereference when deleting
device by invalid id".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/244     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/244.out |  2 ++
 2 files changed, 44 insertions(+)
 create mode 100755 tests/btrfs/244
 create mode 100644 tests/btrfs/244.out

diff --git a/tests/btrfs/244 b/tests/btrfs/244
new file mode 100755
index 00000000..56eb9e8c
--- /dev/null
+++ b/tests/btrfs/244
@@ -0,0 +1,42 @@
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
+# should just fail.
+# We don't care about the failure itself, but care whether this would cause
+# kernel crash.
+$BTRFS_UTIL_PROG device remove 3 $SCRATCH_MNT >> $seqres.full 2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/244.out b/tests/btrfs/244.out
new file mode 100644
index 00000000..440da1f2
--- /dev/null
+++ b/tests/btrfs/244.out
@@ -0,0 +1,2 @@
+QA output created by 244
+Silence is golden
-- 
2.31.1

