Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DAC440E8F
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Oct 2021 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJaNMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Oct 2021 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhJaNMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Oct 2021 09:12:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8BC061570
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Oct 2021 06:10:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso3336531pjo.3
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Oct 2021 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3e4zSUQOZScOkx8qHUql1ILltOjElOAIAG2AS7D2oY=;
        b=bNfCumT+ZqPUACo2CQK7+YNpqxlgBPWWvkXo3gEqE2rJp1h+fJJwEtY6aytIXoj1Wc
         d6N8MKy5cqnNbOUYcUs7IPnCTMjA0HgkW9sj8a/MYev2/rZPCWmAFmC6VWTxSrxlyNl0
         7uCL3PVZ/AnhoLjNlHaZhz9jzewICEw5bwyFMSG91vAKlRsDzGVc11zZnYs9NFnHieCS
         xtDtKmv1vDiXZY9fFknbilPKeHwgxqwjwMLpvSBZyAclTSDv4dqvCS2tAVKVSg38x15p
         GpGG4hYinKP1494m+I859sKJ735aylFUdL+UpRgzOf8Sb7VzEwjpEUL2fzFrXQIBjduN
         uYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3e4zSUQOZScOkx8qHUql1ILltOjElOAIAG2AS7D2oY=;
        b=J+wHSabYLNTju9aEcR0A8vpbqzx3lWYfLRQUX2k9WrJl3CLOB/BBlDGDfjw1e6UAQz
         wRYaIDZyIKJ4a5g6TfGZVB1n+YJww1AH2/g2nVu/gdAHV4ZNWkHOTS71/t0tMGxkxGAR
         1UPbe/r6LWlWoYcwtsl7SQdUpjrH+orb8aOpWVj+F7XywQvgC9EeOb+FPtB4gX7RmRT8
         /hivVjGv+58dqKQb8O3KUplU41U7sQJn2sS3gtb1fip55hApPzsksaUh1IPFZZ/Y1YOG
         juzWmbp4DH1jECbsGcHc4WyBnQwMKI9/lXv9e9jxl/eWcue+yCRpWy0x6qKMFZCDq1Ny
         viOQ==
X-Gm-Message-State: AOAM532Lh3eSvyn3SNeqLkZ5YQexisfE+aY46Dyr+0/Cv77UcLDBPIxv
        wZ/3CqwNh8MK+hQsm32XfYdEzPypZQVtbg==
X-Google-Smtp-Source: ABdhPJwV2s+sFw69zyNlLJVUg2y/ni/cKxqxQWWGBBFzpYc9dL7ZtQwfElMwv+W45vc7LdbnS9+05Q==
X-Received: by 2002:a17:902:ea09:b0:141:ec88:4410 with SMTP id s9-20020a170902ea0900b00141ec884410mr1008plg.51.1635685819569;
        Sun, 31 Oct 2021 06:10:19 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id v16sm12382996pfu.208.2021.10.31.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 06:10:19 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Date:   Sun, 31 Oct 2021 13:10:11 +0000
Message-Id: <20211031131011.42401-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch makes old balance command to print warning message same as
in start command. It makes do_balance() checks flags that needs to
print warning message. It works in old command because old command also
uses do_balance().

Issue: #411

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Prints warning message in do_balance()
---
 cmds/balance.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 7abc69d9..2e903b5c 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -322,6 +322,24 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 		return 1;
 	}
 
+	if (!(flags & BALANCE_START_FILTERS) && !(flags & BALANCE_START_NOWARN)) {
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
 	ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
 	if (ret < 0) {
 		/*
@@ -547,24 +565,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 		printf("\nStarting conversion to RAID5/6.\n");
 	}
 
-	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
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
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
 	if (bconf.verbose > BTRFS_BCONF_QUIET)
-- 
2.25.1

