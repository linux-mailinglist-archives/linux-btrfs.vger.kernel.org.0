Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9629EB51
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgJ2MJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgJ2MJO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:09:14 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF7D2076E;
        Thu, 29 Oct 2020 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603973353;
        bh=xDv0fFIb+9ZB8QRwEh93Uhu9zJuKx+xX55+qBlezrso=;
        h=From:To:Cc:Subject:Date:From;
        b=fECxBQkbyyr75Wn1X3frKsOg1+LdUHVpd8W7A8iKC2dOUA3L0hC6BprR5h6aTuQmT
         7dui6EP1vL4j1wuv53g2jAs78pXNF0aJ3qcfAKaLIPVKe82xgNW/5HRAV3Lkk/O0JG
         mKEDw2U7V3G4QKPc3fZJYK59zpHMQpfd2uhcSoZ8=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add missing remove of the $seqres.full file for some tests
Date:   Thu, 29 Oct 2020 12:09:06 +0000
Message-Id: <8bc766361cbe31af4bc1b71f077e9561a1828ba7.1603973261.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some test cases are missing the 'rm -f $seqres.full' line but are appending
to that file, so everytime they run that file gets bigger and bigger (some
of them are using about a dozen megabytes on one of my test boxes).

So just add the 'rm -f $seqres.full' line to them, together with the comment
that the 'new' script generates for new test cases.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/033  | 3 +++
 tests/btrfs/036  | 3 +++
 tests/btrfs/114  | 3 +++
 tests/btrfs/115  | 3 +++
 tests/btrfs/205  | 3 +++
 tests/shared/298 | 3 +++
 6 files changed, 18 insertions(+)

diff --git a/tests/btrfs/033 b/tests/btrfs/033
index 0b9fbe27..d1f8a4db 100755
--- a/tests/btrfs/033
+++ b/tests/btrfs/033
@@ -25,6 +25,9 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
diff --git a/tests/btrfs/036 b/tests/btrfs/036
index cd7a81e5..36b652fd 100755
--- a/tests/btrfs/036
+++ b/tests/btrfs/036
@@ -49,6 +49,9 @@ trap "_cleanup ; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
diff --git a/tests/btrfs/114 b/tests/btrfs/114
index a4b8bafa..2d9546a1 100755
--- a/tests/btrfs/114
+++ b/tests/btrfs/114
@@ -26,6 +26,9 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
diff --git a/tests/btrfs/115 b/tests/btrfs/115
index eac0e33d..02ae4e1d 100755
--- a/tests/btrfs/115
+++ b/tests/btrfs/115
@@ -26,6 +26,9 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
diff --git a/tests/btrfs/205 b/tests/btrfs/205
index b335ac3d..b53e0e52 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -31,6 +31,9 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch_reflink
diff --git a/tests/shared/298 b/tests/shared/298
index 416a89d3..5cb30fc9 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -15,6 +15,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 . ./common/rc
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
 _supported_fs ext4 xfs btrfs
 _require_test
 _require_loop
-- 
2.28.0

