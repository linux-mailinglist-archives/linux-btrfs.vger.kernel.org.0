Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB13913A8
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Aug 2019 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfHQXOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Aug 2019 19:14:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51136 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfHQXOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Aug 2019 19:14:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so6845048wml.0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2019 16:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C6JRXnjaJJgRW731XUZ/F/SCVK8s5pHSAXk+rEQ7Azo=;
        b=qBPbELslZnPMuzgUnQXdeEs3FV9ZycvFyRnJun+VbXuTpJjHe1kNbFyN9bO6v0KRTI
         FmfxB3MnTLwljUbdJlMQyP9pnpzWi4reU8CcJWqRRYPKA5Da0cCYr7LsGe+Xvl9xUk10
         ajZUYfVrTlcCmkw9QdW0cWCMb1j8yVcTPlYseqF7ojQHsF7AbBppq3Q8pSpGxp/7q6S5
         KsW1oxoTvaaP93vI8zBIq9yQ3Q2xO/kAkvfKLKvKNcvvawWzLvjXot93fNNP8TS/7aDD
         iXYN1+g8uSV3tkH/+NO6XGoptx5BM/07YwOd+bv5xkxqNJxz2BIUj5CmWntylkVqKf80
         uQBA==
X-Gm-Message-State: APjAAAXg66faIp2AkcY7msn9kzws0TLQbyYvelCjNqF1pkHJytj2Wj3j
        s/CE/2EP2dAq4yw3F15/oemR3aBeyEg=
X-Google-Smtp-Source: APXvYqw6e/4X92n8BkGm2o6IiqrAYxH/Wt675oqilzaRjH6LtwTxTm2HWd8TVt+mlKADnB6idoJpHw==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr13183400wms.141.1566083678275;
        Sat, 17 Aug 2019 16:14:38 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id u186sm19724976wmu.26.2019.08.17.16.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 16:14:37 -0700 (PDT)
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>
Subject: [PATCH] btrfs-progs: balance: check for full-balance before background fork
Date:   Sat, 17 Aug 2019 23:14:34 +0000
Message-Id: <20190817231434.1034-1-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the full-balance warning to before the fork, so that the user can
see and react to it.

Notes on test:

- Don't use grep -q, as it causes a SIGPIPE during the countdown, and
  the balance thus doesn't start.

- The "balance cancel" is superfluous as the last command, but it
  provides some idempotence and allows adding more tests below it.

Fixes: https://github.com/kdave/btrfs-progs/issues/168

Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
---
 cmds/balance.c                                | 36 +++++++++----------
 .../002-balance-full-no-filters/test.sh       |  5 +++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 6f2d4803..32830002 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -437,24 +437,6 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	if (fd < 0)
 		return 1;
 
-	if (!(flags & BALANCE_START_FILTERS) && !(flags & BALANCE_START_NOWARN)) {
-		int delay = 10;
-
-		printf("WARNING:\n\n");
-		printf("\tFull balance without filters requested. This operation is very\n");
-		printf("\tintense and takes potentially very long. It is recommended to\n");
-		printf("\tuse the balance filters to narrow down the scope of balance.\n");
-		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
-		printf("\twarning. The operation will start in %d seconds.\n", delay);
-		printf("\tUse Ctrl-C to stop it.\n");
-		while (delay) {
-			printf("%2d", delay--);
-			fflush(stdout);
-			sleep(1);
-		}
-		printf("\nStarting balance without any filters.\n");
-	}
-
 	ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
 	if (ret < 0) {
 		/*
@@ -634,6 +616,24 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 		}
 	}
 
+	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
+		int delay = 10;
+
+		printf("WARNING:\n\n");
+		printf("\tFull balance without filters requested. This operation is very\n");
+		printf("\tintense and takes potentially very long. It is recommended to\n");
+		printf("\tuse the balance filters to narrow down the scope of balance.\n");
+		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
+		printf("\twarning. The operation will start in %d seconds.\n", delay);
+		printf("\tUse Ctrl-C to stop it.\n");
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+		printf("\nStarting balance without any filters.\n");
+	}
+
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
 	if (verbose)
diff --git a/tests/cli-tests/002-balance-full-no-filters/test.sh b/tests/cli-tests/002-balance-full-no-filters/test.sh
index 9c31dd6f..daadcc44 100755
--- a/tests/cli-tests/002-balance-full-no-filters/test.sh
+++ b/tests/cli-tests/002-balance-full-no-filters/test.sh
@@ -18,4 +18,9 @@ run_check $SUDO_HELPER "$TOP/btrfs" balance start "$TEST_MNT"
 run_check $SUDO_HELPER "$TOP/btrfs" balance --full-balance "$TEST_MNT"
 run_check $SUDO_HELPER "$TOP/btrfs" balance "$TEST_MNT"
 
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" balance start --background "$TEST_MNT" |
+	grep -F "Full balance without filters requested." ||
+	_fail "full balance warning not in the output"
+run_mayfail $SUDO_HELPER "$TOP/btrfs" balance cancel "$TEST_MNT"
+
 run_check_umount_test_dev
-- 
2.22.0

