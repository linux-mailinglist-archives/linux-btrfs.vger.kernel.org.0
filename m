Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592602AB0EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 06:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgKIFkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 00:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgKIFkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 00:40:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604900408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hFD8KvVGSFDA50FpA4xWu1hhGZ+xVvwREDbw7J4TKw0=;
        b=L6pq1Ah+RAauvu8/T52QMyZsk0fQ8pWGBy065YL9s5j0woXoNq9oRHwOS6m+GjZJDf1FCB
        p8dozWzrPBPjBdbsekVhN/xOWB5vzMkvzOOIBPE21mEfN3lLgQUDwK0UdsuXnHnJb7kSPa
        R5C4NUkmA+8UQvlzdy63jIouIFx/czQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C60A4ABD1
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 05:40:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: tests: check the result log for critical warnings
Date:   Mon,  9 Nov 2020 13:39:52 +0800
Message-Id: <20201109053952.490678-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109053952.490678-1-wqu@suse.com>
References: <20201109053952.490678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new function, check_test_results(), for
misc/fsck/convert/mkfs test cases.

This function is currently to catch warning message for subpage support,
but can be later expanded for other usages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common           | 12 ++++++++++++
 tests/convert-tests.sh |  1 +
 tests/fsck-tests.sh    |  1 +
 tests/misc-tests.sh    |  1 +
 tests/mkfs-tests.sh    |  1 +
 5 files changed, 16 insertions(+)

diff --git a/tests/common b/tests/common
index b3f5cc139525..f1314d8f5a20 100644
--- a/tests/common
+++ b/tests/common
@@ -817,4 +817,16 @@ init_env()
 		echo "  convert: $TEST_ARGS_CONVERT" >> "$RESULTS"
 	fi
 }
+
+# Catch critical warning messages
+check_test_results()
+{
+	local results="$1"
+	local testname="$2"
+
+	# Check subpage related warning
+	if grep -q "crrosses 64K page boundary" "$results"; then
+		_fail "found subpage related warning for case $testname"
+	fi
+}
 init_env
diff --git a/tests/convert-tests.sh b/tests/convert-tests.sh
index 24b3ec0df144..9653033fe09a 100755
--- a/tests/convert-tests.sh
+++ b/tests/convert-tests.sh
@@ -70,6 +70,7 @@ run_one_test() {
 			fi
 			_fail "test failed for case $testname"
 		fi
+		check_test_results "$RESULTS" "$testname"
 	else
 		_fail "custom test script not found"
 	fi
diff --git a/tests/fsck-tests.sh b/tests/fsck-tests.sh
index 15e3d8d5995c..ed18136f3ab9 100755
--- a/tests/fsck-tests.sh
+++ b/tests/fsck-tests.sh
@@ -64,6 +64,7 @@ run_one_test() {
 			fi
 			_fail "test failed for case $(basename $testname)"
 		fi
+		check_test_results "$RESULTS" "$testname"
 	else
 		# Type 1
 		check_all_images
diff --git a/tests/misc-tests.sh b/tests/misc-tests.sh
index 3b49ab012e78..7da13513641a 100755
--- a/tests/misc-tests.sh
+++ b/tests/misc-tests.sh
@@ -66,6 +66,7 @@ do
 			fi
 			_fail "test failed for case $(basename $i)"
 		fi
+		check_test_results "$RESULTS" "$(basename $i)"
 	fi
 	cd "$TEST_TOP"
 done
diff --git a/tests/mkfs-tests.sh b/tests/mkfs-tests.sh
index 150f094f2303..d6e8bb6702c9 100755
--- a/tests/mkfs-tests.sh
+++ b/tests/mkfs-tests.sh
@@ -61,6 +61,7 @@ do
 			fi
 			_fail "test failed for case $(basename $i)"
 		fi
+		check_test_results "$RESULTS" "$(basename $i)"
 	fi
 	cd "$TEST_TOP"
 done
-- 
2.29.2

