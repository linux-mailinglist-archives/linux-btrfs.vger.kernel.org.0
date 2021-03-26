Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E619134A78F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 13:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCZMvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 08:51:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCZMvT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 08:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616763078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WALWdtIhALQa0NWVcsOe1ZU6qqwN4c0ANGNGUpO/vYY=;
        b=i14CL8OkaqXZ2rjorXgeJUuzQdmo+97lv7rJLCqmOGxypbBZl5VcXYbpjMPgipzCikKWrs
        wvruAZQwCa+oyd3OOCTqRNDVKYNhp2Rx479TRxdKFaetDbXvUmVycKUqlaG0zLEOpaxlnO
        nED5plDx3cCEHdQdxoe4EmZfyIsgKoU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3FBDAD8D
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Mar 2021 12:51:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: misc-tests: add test to ensure the restored image can be mounted
Date:   Fri, 26 Mar 2021 20:50:47 +0800
Message-Id: <20210326125047.123694-4-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326125047.123694-1-wqu@suse.com>
References: <20210326125047.123694-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new test case is to make sure the restored image file has been
properly enlarged so that newer kernel won't complain.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../047-image-restore-mount/test.sh           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tests/misc-tests/047-image-restore-mount/test.sh

diff --git a/tests/misc-tests/047-image-restore-mount/test.sh b/tests/misc-tests/047-image-restore-mount/test.sh
new file mode 100755
index 000000000000..7f12afa2bab6
--- /dev/null
+++ b/tests/misc-tests/047-image-restore-mount/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# Verify that the restored image of an empty btrfs can still be mounted
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs-image
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+tmp=$(mktemp -d --tmpdir btrfs-progs-image.XXXXXXXX)
+prepare_test_dev
+
+run_check_mkfs_test_dev
+run_check "$TOP/btrfs-image" "$TEST_DEV" "$tmp/dump"
+run_check "$TOP/btrfs-image" -r "$tmp/dump" "$tmp/restored"
+
+run_check $SUDO_HELPER mount -t btrfs -o loop "$tmp/restored" "$TEST_MNT"
+umount "$TEST_MNT" &> /dev/null
+rm -rf -- "$tmp"
-- 
2.30.1

