Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5E41F146
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355041AbhJAPbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 11:31:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36834 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355061AbhJAPbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Oct 2021 11:31:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D3C820068;
        Fri,  1 Oct 2021 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633102163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqlYvWnT0geuj0PGl5+u1ht5e2ld+WV+1AqvroJEhDw=;
        b=tbBw5QO4Gg2sWYoj2mZp9t6AhXmAZdQOa8EsGyHH+dSXpRFHncywlpC0w5s+ZabyhkqEON
        DO9es3xC4tBmkEPOWfw3lAiIDa4zyce4zhF+QokvlvbYxJr88V7oPrh6h1tnJf5pwfSkA5
        mh0FOoSZ3t582hnZ+VZEl3r7Z66xaDw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 56E77A3B8D;
        Fri,  1 Oct 2021 15:29:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3881DA7F3; Fri,  1 Oct 2021 17:29:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs-progs: tests: subvolume ro->rw switch and received_uuid
Date:   Fri,  1 Oct 2021 17:29:05 +0200
Message-Id: <a50ec1d102b17e35d515404c087efc335858be71.1633101904.git.dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633101904.git.dsterba@suse.com>
References: <cover.1633101904.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 .../050-receive-prop-ro-to-rw/test.sh         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tests/misc-tests/050-receive-prop-ro-to-rw/test.sh

diff --git a/tests/misc-tests/050-receive-prop-ro-to-rw/test.sh b/tests/misc-tests/050-receive-prop-ro-to-rw/test.sh
new file mode 100755
index 000000000000..fb1e0e64040d
--- /dev/null
+++ b/tests/misc-tests/050-receive-prop-ro-to-rw/test.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+# Prevent changing subvolume ro->rw status with received_uuid set, unless forced
+
+source "$TEST_TOP/common"
+
+setup_root_helper
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+
+run_check $SUDO_HELPER mkdir "$TEST_MNT/src" "$TEST_MNT/dst"
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/src/subvol1"
+for i in `seq 10`; do
+	run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file$1" bs=10K count=1
+done
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/src/subvol1" "$TEST_MNT/src/snap1"
+
+for i in `seq 10`; do
+	run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT/file-new$1" bs=1K count=1
+done
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/src/subvol1" "$TEST_MNT/src/snap2"
+
+touch send1.stream send2.stream
+chmod a+w send1.stream send2.stream
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send1.stream "$TEST_MNT/src/snap1"
+run_check $SUDO_HELPER "$TOP/btrfs" send -f send2.stream -p "$TEST_MNT/src/snap1" "$TEST_MNT/src/snap2"
+
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send1.stream -m "$TEST_MNT" "$TEST_MNT/dst"
+run_check $SUDO_HELPER "$TOP/btrfs" receive -f send2.stream -m "$TEST_MNT" "$TEST_MNT/dst"
+
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume show "$TEST_MNT/dst/snap2"
+run_check $SUDO_HELPER "$TOP/btrfs" property get "$TEST_MNT/dst/snap2" ro
+run_mustfail "ro->rw switch and received_uuid not reset" \
+	$SUDO_HELPER "$TOP/btrfs" property set "$TEST_MNT/dst/snap2" ro false
+
+run_check $SUDO_HELPER "$TOP/btrfs" property set -f "$TEST_MNT/dst/snap2" ro false
+run_check $SUDO_HELPER "$TOP/btrfs" subvolume show "$TEST_MNT/dst/snap2"
+
+run_check_umount_test_dev
+
+rm -f send1.stream send2.stream
-- 
2.33.0

