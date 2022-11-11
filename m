Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF16263AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiKKVal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiKKVa3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C54AE02A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:28 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z1so3748935qkl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=pCaXby5y03BIJyblb3OQUAKKHmvViiHRO93Go/hk9wsjmBwUISchfzR8xQ8GoItQ0n
         PnX5RR3YBoDfSWDSA/X/fGefk8ma8TkbeaUYJdLlp8ixKyKh/yBIVIAs4xutK9AyfQO+
         Ty+zAC2b16Q2qCUpZ8IKVZnqjeys9uA+H5GBHaWMcKixY+NigHcmvpBGnJLig66GvaPr
         441pXygmCjLlvTYj8A9cOrMpa1G4EuEGngmqHGMdTjLcf6VRPkTDKExg3ymcIwXR5vzy
         Vd3AlTv/EaVhWOMMc0hHJ72R6NAfkTEysRWLLRVsgkj7MXKV2CYff0IOs3+Nr46ga0Nj
         ooEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=QSA/Z5v6rUGGDGS6v7ow1R03yo2LLHCDWyYlgO7j3+yiNZPUVnYbLcK5Yzb8sbBqVs
         bnmjUslRwSgM5q8gnDOqlfWnFBd3GBNfg4s9rXRO0L4t9+L46j5eMG/B/VaxG8MtGsUL
         NQ4hYTCGWy2aD7t81pj82roFDYbToa9sIqC75Ig+lvGF2XnDBzqWSlmuTU/GZf3AJEYc
         RrtVJiJfbxVy2HJexJA6mVoSo6OSMLLxjksMVG1EF6L4Sjedlr5JiWzZ156vUvG5rs90
         aJPjaC7/zcxvpWRuuJDL/Z7eqQcwTDSSj0IdlZdsTuy4b0Tk4GCtQ3RbzZ0+5xhwmRUC
         bsCA==
X-Gm-Message-State: ANoB5plnPIYgzZKCKnwd+L3da3fwvmjiYUQlbEokz22Xu/i9AoFLM6oQ
        o4k9xnaxjPK6dODnYL68JNvDIvtH0CYLYQ==
X-Google-Smtp-Source: AA0mqf7s9henKzxAQTCGye8MFB6d35R1YIsgmbZuBTulDoJHYjjqQ1rjUAiPZkz1fYt11Z1T02IL4w==
X-Received: by 2002:a37:aa54:0:b0:6f4:be21:ee27 with SMTP id t81-20020a37aa54000000b006f4be21ee27mr2881544qke.700.1668202227162;
        Fri, 11 Nov 2022 13:30:27 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g19-20020ac84b73000000b003a50c9993e1sm1818468qts.16.2022.11.11.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/14] btrfs-progs: move NO_RESULT definition into replace.c
Date:   Fri, 11 Nov 2022 16:30:08 -0500
Message-Id: <908de6d5455a88ca8760b9162efd158efb809cc0.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT is defined to make sure we
differentiate internal errors from actual error codes that come back
from the device replace ioctl.  Take this out of ioctl.c and move it
into replace.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/replace.c | 2 ++
 ioctl.h        | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 28e70b04..bdb74dff 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -45,6 +45,8 @@ static int print_replace_status(int fd, const char *path, int once);
 static char *time2string(char *buf, size_t s, __u64 t);
 static char *progress2string(char *buf, size_t s, int progress_1000);
 
+/* Used to separate internal errors from actual dev replace ioctl results. */
+#define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT		-1
 
 static const char *replace_dev_result2string(__u64 result)
 {
diff --git a/ioctl.h b/ioctl.h
index 21aaedde..686c1035 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -192,7 +192,6 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_replace_status_params) == 48);
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_START			0
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS			1
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_CANCEL			2
-#define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT		-1
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_ERROR			0
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_NOT_STARTED		1
 #define BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED		2
-- 
2.26.3

