Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3124A32FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 02:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353631AbiA3BJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Jan 2022 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiA3BJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Jan 2022 20:09:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82970C061714
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jan 2022 17:09:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so14572952pjj.4
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Jan 2022 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwpTIDSEYkFYWmNT8FPsKsZY1G/J5A8A+NXudUgq050=;
        b=ANxDZUgz6j+kiLyb8y7FU9tcP218tQ2CxjGYETXmMUjuEFinzinZAC+GB/erHP5Iwd
         iqwpBuwY51aWw/NSX3g7zdKDdMr6L4cuIiTZAKKMla2pFtYHdcsM9QDHVUho1mj/2xqQ
         HaJbdXIXjWFo3lpdGwtHdEnHOS77wXy+UYEixpgxMiugI/BA0fHo6qEfnWRxNwwmsjtu
         u4VWkhZsWR4vEPtDGsZewnJKyMqsN2mjoWyOBcbiwAWxbM1aQ7z9ZY5QEPM+yd1Nxtf9
         QjHhT+5rOMtkpwbQCfd4tbtqNN9Kv9xk09jfMQ0s3vAZ2EKkeLGRzc4dEefD28Xe6H7n
         CmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwpTIDSEYkFYWmNT8FPsKsZY1G/J5A8A+NXudUgq050=;
        b=Ie4a0umLdctg02GSvizCxJ/RTbvXpWKBcyGnOA3W7jlXnzdjuQhA731wjQS7EWO2Rl
         Rb2vcYXip2mRqDP6BTG2dteYBkal5WDHyxUwWIQJqlHP4gYnJNcl328ASguNTTGYkt0f
         7C1vkXKEdxbr3RM3byfybd2nu0MiyKZHPCQhiZzFY038Z/BK1C8nNKER7LQcTZdHXiId
         sXai7hbipAtPhCMdUo9Hig3PV4R71uT7lb1D47u9amuO47YGy8E7GyATE+ha3astRIiV
         Ftj7HsA8DyeElDdVjB8K9DHfsKs+BPx5L8IG16cP8F8SbWNgMbDReQF1cLL8GnrWi+gM
         dcwQ==
X-Gm-Message-State: AOAM533f+n+gbO3UN5bAQ2fByJwSSccqB7Gub9jm/yY4yIYmy6q914ze
        Oyt7g5KXffuY8Ojq/+qvTwz6KUFad3k=
X-Google-Smtp-Source: ABdhPJxWMHJc5gg/1Lmskat0/8zO8o28HLGNIfgzd+hSuUZZr48qdY4VtJcmT4hX0nlxijLCaZGswg==
X-Received: by 2002:a17:90b:3b52:: with SMTP id ot18mr15371038pjb.34.1643504997757;
        Sat, 29 Jan 2022 17:09:57 -0800 (PST)
Received: from ryzen.lan ([2601:648:8600:e74::8c6])
        by smtp.gmail.com with ESMTPSA id 202sm25830943pga.72.2022.01.29.17.09.57
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 17:09:57 -0800 (PST)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix 64-bit mips and powerpc types
Date:   Sat, 29 Jan 2022 17:09:56 -0800
Message-Id: <20220130010956.1459147-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel uses unsigned long specifically for ppc64 and mips64. This
fixes that.

Removed asm/types.h include as it will get included properly later.

Fixes -Wformat warnings.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 cmds/receive-dump.c | 1 -
 kerncompat.h        | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 47a0a30e..00ad4fd1 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -31,7 +31,6 @@
 #include <stdlib.h>
 #include <time.h>
 #include <ctype.h>
-#include <asm/types.h>
 #include <uuid/uuid.h>
 #include "common/utils.h"
 #include "cmds/commands.h"
diff --git a/kerncompat.h b/kerncompat.h
index 6ca1526e..4b36b45a 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -19,6 +19,10 @@
 #ifndef __KERNCOMPAT_H__
 #define __KERNCOMPAT_H__
 
+#ifndef __SANE_USERSPACE_TYPES__
+#define __SANE_USERSPACE_TYPES__	/* For PPC64, to get LL64 types */
+#endif
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
-- 
2.34.1

