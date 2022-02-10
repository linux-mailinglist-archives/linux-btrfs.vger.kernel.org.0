Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3972D4B15FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbiBJTKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiBJTKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7762110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w20so2655646plq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xb84Ra7GCRaPQur5sHxFQDfHS0V1ba52DoxX2Ew8cyM=;
        b=ycklHt9x8XnNWNKA2/VJbCEXvr1e6SMxnYIQ+yI5zglf4wFoQO8/gR1ngdyrDRHrF6
         JhDpY+GAayGkmc0Z9UAfcujpBJf+alNthLMXnXJWZDlP6GaIROpywOdaYVaJMiCY0n7u
         yqKiSLCACwQ30rm9XmTWIK3vW2h3OjBFVYlZBO1VT7fv/k/Bmrkw1OAqFGD9ukvRQAfF
         9m0WsB0QJL9gWIwx8fu6sMxXqK3eJCExHPRWsKdFqx9P88ocT7mPzpFvQrOdJVwmlFjI
         R+VxE5D1qiufCk7UGYaB2XE9Fa2/GG+Uz08kHGMfbIVlQIRr/lYT/IgPRTjv5fiWrTI8
         bTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xb84Ra7GCRaPQur5sHxFQDfHS0V1ba52DoxX2Ew8cyM=;
        b=J1IQMM66nBSVMe378rGlaTYPJYQkX44dfkKKVbfv+TFD5Xe6iPLG/jUUYLYfrQt43w
         Pzu89YLNtp38VCEQ1f0YvuSm1OgXO7UKu+EebFLxY0mi+y7cCjbtKQiKKXlRXo/yrQw2
         hGNVLnmzICJJ4IMXVxsROYNwK+nqxaNqcO6aULWvOKeK5jlraQXSObwO6Rx+dVjzVh9w
         4pQPVu3EgxdJcrTWznxznSWpX95lnOGK8DpjPLXMN9rQMFMmeBdbTJnh419XkjhHE2QL
         uBCVTjOwOeUBDo+CkXqcsPwAJ4aNsyA8pFUk6tU+AzXmPJAuc7gBuRICDYeDL7YBSnyc
         lLQw==
X-Gm-Message-State: AOAM531wiw77Fc/meCVINx+57d/Iuky5AWAKxqnG6lr7fdiQXsZjj1NO
        PblnVUaWG5mVW+Oh2vuXJtVwwYC9hu/u+Q==
X-Google-Smtp-Source: ABdhPJy5yYWl2epF3H2wnEPLrZRALksW+VJ4Li5Yp/RiHAZfDKZS8kEeHP0sBlh+M8ya9g9b3pXM7A==
X-Received: by 2002:a17:90a:141:: with SMTP id z1mr4330375pje.87.1644520245926;
        Thu, 10 Feb 2022 11:10:45 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:45 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 17/17] btrfs: send: enable support for stream v2 and compressed writes
Date:   Thu, 10 Feb 2022 11:10:07 -0800
Message-Id: <71ec89beca3ab00460b345e58d031680e61d22d2.1644519258.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept v2
and the compressed flag, and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 7 +++++--
 fs/btrfs/send.h            | 2 +-
 include/uapi/linux/btrfs.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5192ba58459e..7053cb2cfec3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -690,8 +690,7 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
-
+	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
 }
@@ -7768,6 +7767,10 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	} else {
 		sctx->proto = 1;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) && sctx->proto < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx->send_filp = fget(arg->send_fd);
 	if (!sctx->send_filp) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 805d8095209a..50a2aceae929 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,7 @@
 #include "ctree.h"
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 /*
  * In send stream v1, no command is larger than 64k. In send stream v2, no limit
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 38578b1ce0a3..c749a5b7a4a3 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -788,7 +788,8 @@ struct btrfs_ioctl_received_subvol_args {
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
 	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
-	 BTRFS_SEND_FLAG_VERSION)
+	 BTRFS_SEND_FLAG_VERSION | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.35.1

