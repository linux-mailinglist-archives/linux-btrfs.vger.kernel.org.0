Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07F6A281F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 10:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBYJPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Feb 2023 04:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYJO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Feb 2023 04:14:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B221214EB4;
        Sat, 25 Feb 2023 01:14:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5189A6732D;
        Sat, 25 Feb 2023 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677316497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3nwbi0effX7GgL/EA5NGDc+u5LtfDzv18CAFsxXImkE=;
        b=VcEqmxQIv3m3Vbbz60+spjzNAUiu0RevLWYkXEQSc0wstiOVMk1LFMOAYRDHObK5Nl3Zej
        /BH3a4I0NroIGzhNQ+D0Sc/MrzNtsil9ZjTgDMMGNQ9sQVESJE7KxBz6SmDPfx/AnJ6RAA
        QS1weIRAuzZYBccbpSqSWu6Wumg0myE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63BEF13A42;
        Sat, 25 Feb 2023 09:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vNjiCpDR+WMPWQAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 25 Feb 2023 09:14:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: add a test case to check btrfs won't crash on certain corruption
Date:   Sat, 25 Feb 2023 17:14:38 +0800
Message-Id: <20230225091438.55728-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There seems to be a newly introduced regression that btrfs no longer
properly handles critical errors during mount.

Such regression lead to crash when mounting an fs with a corrupted tree
root.

The test case would reproduce the situation by creating an empty fs,
with SINGLE metadata profile, then corrupt the tree root manually.
Finally try mounting the corrupted fs, the mount should fail while our
kernel should not fail.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The fix is titled "btrfs: fix the mount crash caused by confusing return
value", and is already submitted to the btrfs list.

Unfortunately git blame doesn't give a good enough clue on which commit
introduced the regression.
---
 tests/btrfs/288     | 37 +++++++++++++++++++++++++++++++++++++
 tests/btrfs/288.out |  2 ++
 2 files changed, 39 insertions(+)
 create mode 100755 tests/btrfs/288
 create mode 100644 tests/btrfs/288.out

diff --git a/tests/btrfs/288 b/tests/btrfs/288
new file mode 100755
index 00000000..029603c8
--- /dev/null
+++ b/tests/btrfs/288
@@ -0,0 +1,37 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 288
+#
+# Make sure btrfs handles critical errors gracefully during mount.
+#
+. ./common/preamble
+_begin_fstest auto quick dangerous
+
+. ./common/filter
+_supported_fs btrfs
+_require_scratch
+
+# Use single metadata profile so we only need to corrupt one copy of tree block
+_scratch_mkfs -m single > $seqres.full
+
+logical_root=$($BTRFS_UTIL_PROG inspect dump-tree -t root "$SCRATCH_DEV" | grep leaf | head -n1 | cut -f2 -d\  )
+physical_root=$(_btrfs_get_physical $logical_root 1)
+
+echo "tree root logical=$logical_root" >> $seqres.full
+echo "tree root physical=$physical_root" >> $seqres.full
+
+_pwrite_byte 0x00 "$physical_root" 4 $SCRATCH_DEV > $seqres.full
+
+# For unpatched kernel, the mount may lead to crash
+_try_scratch_mount >> $seqres.full 2>&1
+
+echo "Silence is golden"
+
+# Re-create the fs to avoid false alert from the corrupted fs.
+_scratch_mkfs -m single > $seqres.full
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
new file mode 100644
index 00000000..2958a5c3
--- /dev/null
+++ b/tests/btrfs/288.out
@@ -0,0 +1,2 @@
+QA output created by 288
+Silence is golden
-- 
2.39.0

