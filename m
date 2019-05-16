Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D12017A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEPImz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfEPImy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42F71AED5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 08:42:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs-progs: tests: Test fs on image files is correctly recognised
Date:   Thu, 16 May 2019 11:42:50 +0300
Message-Id: <20190516084250.19363-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516084250.19363-1-nborisov@suse.com>
References: <20190516084250.19363-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This ensures that 'btrfs filesystem show' can correctly identify a
filesystem on a newly created local file.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/cli-tests/010-fi-show-on-new-file/test.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100755 tests/cli-tests/010-fi-show-on-new-file/test.sh

diff --git a/tests/cli-tests/010-fi-show-on-new-file/test.sh b/tests/cli-tests/010-fi-show-on-new-file/test.sh
new file mode 100755
index 000000000000..668f0f9b2cfe
--- /dev/null
+++ b/tests/cli-tests/010-fi-show-on-new-file/test.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# test for 'filesystem show' on fresh local file
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+IMAGE=$(mktemp -u btrfs-XXXXXX.img)
+
+truncate -s3g "$IMAGE"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$IMAGE"
+run_check $SUDO_HELPER "$TOP/btrfs" filesystem show "$IMAGE"
+
+rm -f "$IMAGE"
+
-- 
2.7.4

