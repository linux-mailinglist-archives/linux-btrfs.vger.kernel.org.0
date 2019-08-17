Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2911F913AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2019 01:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfHQXTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Aug 2019 19:19:35 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39432 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfHQXTf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Aug 2019 19:19:35 -0400
Received: by mail-wm1-f50.google.com with SMTP id i63so6917360wmg.4
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2019 16:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKnwiKkVSvnbgFUtV72xZWm8gKPXcZZVBCOLnx02sYg=;
        b=tqUw/d9KGYrF99UWWv8e3tu51lwKvhXtj8S3yDpAhhUcIPtx36fwKM0TjGXHWH9oJy
         Dh9BC6aPKdjxy79SMJVGlCJGebLARTTXbfs5p8VyWJIvWkkRnK0vZD0hOu/XGfp5f3dY
         cFGXluiI8n9/4u9KWnYqg+73FUp8RnGuvyh/+1Im5MkGQeGOBlfgaPqAVvrMah0mta78
         48mbdAk12Xjhf5ZHH235yV8vSXrxWUmFULiSRO1EaJcb7ky26xM3CfUOfJugYnv38zzk
         2yEoaXJtEluSPTkDx5dV9mNgEKFpkeGNvdhX4XfrinWBDMJn1RAdvo+qbVbXiUvN3UUP
         70HQ==
X-Gm-Message-State: APjAAAWbaLdFF7CQcDcugYZLG82VERzzi112YgroyedH4mca9dRSmQty
        I6lmHm4Ht316ctoVD9Nlmy2qIGoqOXI=
X-Google-Smtp-Source: APXvYqy0NQx52k2DdRpLeTiE9urC+PsSqYqlf/UYTwJcjqrVw7Cyw+OzQkcGDqXO054WB6Odn2mGVQ==
X-Received: by 2002:a05:600c:1087:: with SMTP id e7mr12923549wmd.19.1566083972708;
        Sat, 17 Aug 2019 16:19:32 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id o9sm13512217wrm.88.2019.08.17.16.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 16:19:32 -0700 (PDT)
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>
Subject: [PATCH] btrfs-progs: tests: fix cli-tests/003-fi-resize-args
Date:   Sat, 17 Aug 2019 23:18:49 +0000
Message-Id: <20190817231849.18675-1-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

grep's exit code was never checked (and -o errexit is not in effect),
thus the test was ineffectual and regressed.

Add the missing exit code check, and update the error messages to
make the test pass again.

Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
---
 tests/cli-tests/003-fi-resize-args/test.sh | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tests/cli-tests/003-fi-resize-args/test.sh b/tests/cli-tests/003-fi-resize-args/test.sh
index 4249c1ce..c9267035 100755
--- a/tests/cli-tests/003-fi-resize-args/test.sh
+++ b/tests/cli-tests/003-fi-resize-args/test.sh
@@ -16,21 +16,29 @@ run_check_mount_test_dev
 # missing the one of the required arguments
 for sep in '' '--'; do
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 0 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep "$TEST_MNT" |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep -128M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep +128M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep 512M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep 1:-128M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep 1:512M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 	run_check_stdout "$TOP/btrfs" filesystem resize $sep 1:+128M |
-		grep -q "btrfs filesystem resize: too few arguments"
+		grep -q "btrfs filesystem resize: exactly 2 arguments expected, 1 given" ||
+		_fail "no expected error message in the output"
 done
 
 # valid resize
-- 
2.22.0

