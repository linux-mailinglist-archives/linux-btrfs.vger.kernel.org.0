Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0426785A77
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjHWO2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:28:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB2E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58e6c05f529so61765277b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692800878; x=1693405678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9F083effnyrHv6DM5fa5wc8MYG4nWEGrJ2ZWF7jd1hE=;
        b=2ddBzWobwOupvwGCpSgVA/AI5y+iGjK1z+sNq31EoUyIxE8Jd8VfvKX2N8+o9v/3H3
         BvCKBY18USPTu074ikqVKLfEOVLmo/Skh77R6RyK9xk2/1iXmfpujUf9thidqycfFRhl
         iqpR6P72vN/AJi5tiAnVVn5U7csUSG35pkesIoPxHObeS9qQSgXCQ9ROxAsFACS8x5Jc
         CVtPzd6G+VPuaQH1kLpLDdR1V8k5nOiGcjOKsRiFup3LMWje7Dl6EQeFmm4OHcQY6CVT
         iGL90/Io6d51OtH9G8uFBDR/Sknn7NB8nKFd5NolpCeF/UYaJfWmKVAIZeTxhvM+gOcF
         KGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800878; x=1693405678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F083effnyrHv6DM5fa5wc8MYG4nWEGrJ2ZWF7jd1hE=;
        b=A7h4aOHsGprZkon47/8K9Gv7qQnu+QO5z1ieuObt6ob3dS3162FXixaPtR26yHtVrL
         /9+GSuSkbRJMOrwNIot7ex52DpgbTOHhQGSRRJ7/yT2eCxqDQVbGNYxCdYMriVshcV3P
         zePy0ZQxbVXQNkaa0KlgNrurMKcX8p+VTNmyp0ZB+E0ZIpn0AO4jXnHcW00qhFtOM4TG
         2RC+le9sSIzT9OuJIImlvXPnNulIt3aVtyfxfdoTPTp4NYCC8UMABZcfKrdYaWXZqDex
         RYq+l7RTj7TTD9AW0d6jbjbrgfIN/9FwWmlcLjgSSswQbN/Hm3QF/MgtVlw17MACdFtO
         3t9w==
X-Gm-Message-State: AOJu0YyKCaQ9xPC4ejDiruscapsviKswkrkyU7/I/5AgLbDWKI+5phBl
        JQ1SDM2y6XbRm0v+v/jYuVe50NRoIxAc7k70b7U=
X-Google-Smtp-Source: AGHT+IHN5roVoPpG6rEcwqfh5sDFZ1z+tbu/zgXvYz/KaK/+USZ7L1kMPbLH+/1sE7EbTKokUAb31Q==
X-Received: by 2002:a81:9e4d:0:b0:57a:250:27ec with SMTP id n13-20020a819e4d000000b0057a025027ecmr13438313ywj.32.1692800877878;
        Wed, 23 Aug 2023 07:27:57 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j195-20020a8192cc000000b00576c727498dsm3349119ywg.92.2023.08.23.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:27:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs-progs: fix improper error handling in btrfs filesystem usage
Date:   Wed, 23 Aug 2023 10:27:50 -0400
Message-ID: <6c916b6ad8042d676c17be3b3a3f78c7b5cb62cf.1692800798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800798.git.josef@toxicpanda.com>
References: <cover.1692800798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was seeing test-cli/016 failures because it claimed we were getting
EPERM from the TREE_SEARCH ioctl to get the chunk info out of the file
system.  This turned out to be because errno was already set going into
this function, the ioctl itself wasn't actually failing.  Fix this by
checking for a return value from the ioctl first, and then returning
-EPERM if appropriate.  This fixed the failures in my setup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/filesystem-usage.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 73b0ca35..f38051a2 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -145,7 +145,7 @@ static int load_chunk_info(int fd, struct chunk_info **chunkinfo_ret,
 	struct btrfs_ioctl_search_key *sk = &args.key;
 	struct btrfs_ioctl_search_header *sh;
 	unsigned long off = 0;
-	int i, e;
+	int i;
 
 	memset(&args, 0, sizeof(args));
 
@@ -168,11 +168,9 @@ static int load_chunk_info(int fd, struct chunk_info **chunkinfo_ret,
 
 	while (1) {
 		ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
-		e = errno;
-		if (e == EPERM)
-			return -e;
-
 		if (ret < 0) {
+			if (errno == EPERM)
+				return -errno;
 			error("cannot look up chunk tree info: %m");
 			return 1;
 		}
-- 
2.41.0

