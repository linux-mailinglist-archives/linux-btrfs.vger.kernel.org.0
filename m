Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7AA636D45
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKWWiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKWWhw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38A27B04
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q10so2214057qvt.10
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=EoelxDLVdHszLu62yTxWOgE1jRCv35pDJXF19VqEwY2zLjskOv/sOUQUlo4t69faeF
         eCdIaHU/IoxVISFiVqQp9dGKG90Z0rUBPGlGSkxC/nP+E9wrVQCmeohPLjSVy0oQ4MZk
         9wH7cXS64piRaG+93zcxiB2NY4iYfF/aEbh4bFnznKlZ6D7/Ja21OqEQBiCMK9XrQxp6
         WaOKfuPALb5+6UhoL79C1oDbnrbfGQu4mVZj6jAzrCx30zKUnLHbknwWtMGmpZ47icc7
         J7ZRhnyrfYiNV7Zrx3zQbxgUcujzY+4iCoqrS659gSfffVzDBvgeHXy++ayfdS3/T55N
         NLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEzT4z3jmt1nwFr/0QrNIzrkbNngQ1VNHZYJqlsVF6E=;
        b=WvWb2ETSJ3FhBesfndtvIWf+dLuZFvvaAgTJz3Yh5D3n0eCilj+eYNB3ygTzfqytC1
         FHPOGY/zd9WHaEQhd3fjc9mQIU6XnSwjIPJTmJtsd5e8cz80tJfK8Q8Z4LLI/897HMP6
         E3VVZ/TE22b4gSkLGpaoRVA3J/UBeXhR9jaSjCr50S2jlyQR7YgmdX9oNoUzd29aMI77
         5JPMbDdgNhV/DlrNT+nvbvKonEUpzDW5xYdma+CpVjiquykz+ajsm6hbguAbPRKis1/c
         c+ZQR8F6YkvHH9roV9o9nplJcv7dxjAmayPhjmgHYm5FBPgJ/KtJO43G3arW6SIfyIvn
         RkeQ==
X-Gm-Message-State: ANoB5pnewBG2qzfVL5veXgPrNb8aWPavxEYPw0g+5HxNonKs1MYdh9au
        BGxKah5yuhTWbW5DGQHExhkuATAm6nUCYg==
X-Google-Smtp-Source: AA0mqf7EYfYHaWCdbmo3hH+7C5+mHJGcrEzYMFMQ0aTwJFkZf9Bndn/8XIU8+JeKH85GKE2iHrysbg==
X-Received: by 2002:ad4:44a5:0:b0:4c6:b5b7:5715 with SMTP id n5-20020ad444a5000000b004c6b5b75715mr11158375qvt.91.1669243069490;
        Wed, 23 Nov 2022 14:37:49 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j24-20020ac84418000000b003a50248b89esm10401985qtn.26.2022.11.23.14.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 08/29] btrfs-progs: move NO_RESULT definition into replace.c
Date:   Wed, 23 Nov 2022 17:37:16 -0500
Message-Id: <c3684ffba5f135b2611b78f11e304fcfd27bf75f.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

