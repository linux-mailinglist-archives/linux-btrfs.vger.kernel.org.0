Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE032CD11F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgLCISc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:18:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:35108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgLCISb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 03:18:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606983464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lh88YFF1gX1g9q/sERF7VEXgoaHAGYwJWq2ZJfDufrk=;
        b=OdoAqnSmkmLqVKAtWtP3Y5cChCq/CmCym9FwpgJqMoCyqrrg+aL/ORskSOgZmSI3PXMSs8
        1K1laG8nBSpZJBy9HMdb+sDofxO5qG3838TS8TVH46qLTmJV+aB9d7HGqf4PQN5liAuujC
        49c9CYBAV4AplLSDO6Sk76vjIYTnlWk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EC1DAEAB;
        Thu,  3 Dec 2020 08:17:44 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs-progs: tests: Test operation of newly added --clear-ino-cache
Date:   Thu,  3 Dec 2020 10:17:42 +0200
Message-Id: <20201203081742.3759528-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203081742.3759528-1-nborisov@suse.com>
References: <20201203081742.3759528-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pre-created image contains a subvol and a snapshot so that cleaning of
multiple roots is also tested.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 .../ino-cache-enabled.raw.xz                  | Bin 0 -> 160420 bytes
 tests/misc-tests/042-ino-cache-clean/test.sh  |  51 ++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 tests/misc-tests/042-ino-cache-clean/ino-cache-enabled.raw.xz
 create mode 100755 tests/misc-tests/042-ino-cache-clean/test.sh

diff --git a/tests/misc-tests/042-ino-cache-clean/ino-cache-enabled.raw.xz b/tests/misc-tests/042-ino-cache-clean/ino-cache-enabled.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..721c9521441e3adf3769b1a2ed61fa0e78ba63f8
GIT binary patch
literal 160420
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
M@_W)6se$2t0ZWXoq5uE@

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/042-ino-cache-clean/test.sh b/tests/misc-tests/042-ino-cache-clean/test.sh
new file mode 100755
index 000000000000..cb977b8267c6
--- /dev/null
+++ b/tests/misc-tests/042-ino-cache-clean/test.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# Ensure that clearning ino cache works as expected
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+setup_root_helper
+
+image=$(extract_image "./ino-cache-enabled.raw.xz")
+
+run_check $SUDO_HELPER "$TOP/btrfs" check --clear-ino-cache "$image"
+run_check $SUDO_HELPER "$TOP/btrfs" check "$image"
+
+# check for FREE_INO items for main subvol
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t5 \
+	"$image" | grep -c 'item [0-9].* key (FREE_INO')
+[ $item_count -eq 0 ] || _fail "FREE_INO items for main vol present"
+# check for bitmap item for main subvol
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t5 \
+	"$image" | grep -c '(FREE_SPACE')
+[ $item_count -eq 0 ] || _fail "FREE_SPACE items for main vol present"
+
+# check for FREE_INO items for snapshot
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t256 \
+	"$image" | grep -c 'item [0-9].* key (FREE_INO')
+[ $item_count -eq 0 ] || _fail "ino cache items for subvol present"
+# check for bitmap item for subvol
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t256 \
+	"$image" | grep -c '(FREE_SPACE')
+[ $item_count -eq 0 ] || _fail "FREE_SPACE items for subvol present"
+
+# check for FREE_INO items for snapshot
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t257  \
+	"$image" | grep -c 'item [0-9].* key (FREE_INO')
+[ $item_count -eq 0 ] || _fail "ino cache items for snapshot present"
+# check for bitmap item for snapshot
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree -t257 \
+	"$image" | grep -c '(FREE_SPACE')
+[ $item_count -eq 0 ] || _fail "FREE_SPACE items for snapshot present"
+
+# Finally test that the csum tree is empty as ino cache also uses it. At this
+# point all ino items/extents should have been deleted hence the csum tree should
+# be empty
+item_count=$(run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal \
+	dump-tree -t7 "$image" | sed  -n -e 's/^.* items \([0-9]*\).*/\1/p')
+
+[ $item_count -eq 0 ] || _fail "csum tree not empty"
+
+rm -f "$image"
+
-- 
2.17.1

