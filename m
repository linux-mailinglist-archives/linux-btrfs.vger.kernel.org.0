Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013836E79E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhD2JH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240148AbhD2JH4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:07:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619687229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGMFhLDvA8Q3WfafxCnO2/WWDNBUw2lX4Hai6PgD1Ug=;
        b=kZviSmJjDqnDdtT+JTayT3g9n8o9hRBSnRQa+byIGan99F8AlYho1De/hzTSYpVYl3J0A/
        hAasCr9rhxSwA925CiLtzQOsf9ADqclmdDFkUudlNXQjkCHNSyaureT0JjFbMRL6vsfBSt
        ohG3StRGNjvd2TXM+DgF8PtFqe/l/cw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 606B0AF83
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 09:07:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: misc-tests: add test to ensure the restored image can be mounted
Date:   Thu, 29 Apr 2021 17:06:58 +0800
Message-Id: <20210429090658.245238-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429090658.245238-1-wqu@suse.com>
References: <20210429090658.245238-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new test case is to make sure the restored image file has been
properly enlarged so that newer kernel won't complain.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../048-image-restore-mount/test.sh           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 tests/misc-tests/048-image-restore-mount/test.sh

diff --git a/tests/misc-tests/048-image-restore-mount/test.sh b/tests/misc-tests/048-image-restore-mount/test.sh
new file mode 100755
index 000000000000..b61b7a7188cf
--- /dev/null
+++ b/tests/misc-tests/048-image-restore-mount/test.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# Verify that the restored image of an empty btrfs filesystem can still be
+# mounted
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
2.31.1

