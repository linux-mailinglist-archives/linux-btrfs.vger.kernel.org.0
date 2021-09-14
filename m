Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768E640ACD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhINLxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 07:53:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhINLxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 07:53:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE87621D62;
        Tue, 14 Sep 2021 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631620340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=yS52rij573e/7nmA5rvtwQVMbZRG/ZCCMtdLxUFhUbY=;
        b=m0MBff7khhGG9qLDkIZSvXsPMenGmmZ/1ze0pZ9SRn6Ig3rlC5fqT/TV13oTs5g/HUl8ZY
        GfZTn3r+nvIOzNn7G9iYww4l3TYdMLZzee0dgJVUSI20aUnwj2+y0wY4hpwCurog65XZc4
        DshiKG6+Lae0szuJ+dOT3XRQowJLJXA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F86A13342;
        Tue, 14 Sep 2021 11:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vazHGPSMQGHMFgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Sep 2021 11:52:20 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH] btrfs: Add test for received information deletion upon RO->RW switch
Date:   Tue, 14 Sep 2021 14:52:19 +0300
Message-Id: <20210914115219.95720-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Sending this now for initial review and completness' sake and once there is a
final decision that we are taking the route of removing this functionality
for users then it can be merged.


 tests/btrfs/248     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out

diff --git a/tests/btrfs/248 b/tests/btrfs/248
new file mode 100755
index 000000000000..13a2b92900ad
--- /dev/null
+++ b/tests/btrfs/248
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 248
+#
+# Test that stransid/rtransid and received_uuid are being reset when a RO
+# snapshot is switched to RW.
+#
+. ./common/preamble
+_begin_fstest auto quick send subvol
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_command property
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# Create a snapshot and send it, so that it has the necessary fields populated
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/ro-snap &>> $seqres.full
+$BTRFS_UTIL_PROG send $SCRATCH_MNT/ro-snap -f $SCRATCH_MNT/snap.send &>>$seqres.full
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/ro-snap &>>$seqres.full
+$BTRFS_UTIL_PROG receive -f $SCRATCH_MNT/snap.send $SCRATCH_MNT 2>>$seqres.full
+
+# Flip the RO->RW switch and ensure that relevant fields are zeroed out
+$BTRFS_UTIL_PROG property set -ts $SCRATCH_MNT/ro-snap ro false
+
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV | $AWK_PROG '
+	/received_uuid/ {print "received_uuid present"}
+
+	/stransid/ {
+		if ($6 != 0) {print "send trans id not 0"}
+
+		if ($8 != 0) {print "received trans id not 0"}
+	}
+
+'
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
new file mode 100644
index 000000000000..58af9173bea3
--- /dev/null
+++ b/tests/btrfs/248.out
@@ -0,0 +1,2 @@
+QA output created by 248
+Silence is golden
--
2.17.1

