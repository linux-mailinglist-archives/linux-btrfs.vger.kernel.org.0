Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43637454E70
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbhKQUX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbhKQUXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B0C061766
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id t34so3862665qtc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZiABG78Z6NCxyx4F8b5qP9JCofCOP7XTYPRaUs8yaA=;
        b=3cjQ5gzyaW+s+0LgAdtOudktUM8NK65ifyegjteuhtr5b51ai9LwCjQUpyMfMIMbaS
         1lRRKI0G4p3SL//pG+d/zqQm1bCZ5S2ohC0RXNP3OzXhuC02bcbs6jpuOnLnzGX+ZOoB
         +c0e2c4Y76mK3AHQkr9IMD5PF8cSVtuA595mwsEw8ZN4gqW0n9CSULoSEkraFC/jMoy+
         2z9x7Qz9r+dG5zRYhrP3mtlMAD171jqlPZyLmwG1/sPOGrnVMsAreIBRxDVlsTqwsuQn
         0SThhxkh4aFc3G+J/n4D9YxjGDjUMk7qsF3cABVVO1WBNXxefPSMRYlZXtS58IBG1NQO
         fF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZiABG78Z6NCxyx4F8b5qP9JCofCOP7XTYPRaUs8yaA=;
        b=h4xMSV3ftT3ur0Dq2JEAXAFs5ucP1Sb4veHdTAsFTct5UxX3Y6FROQX57dMSShZeng
         QP/gAaJ/nQ1m88i0iX1fQj0AJWd0kw8HpUgtkaSz1wLJi+wAb8AJ6pZ5mh3RMLgS7Din
         nG+g5ogNeoDwgel0Kfam/X/XhDcGpBzWLdCqtvWVIjTj5c/TIHINK5P0K3d3Ns1gWZsZ
         g4JznjLMFMZQxiML1Xi+D1ULLn/K3sRh6KaUBk9/gTY7H/xj40tJZSdQDj3SEYXhfHCz
         JwEqEE8hheWZaAbB0Jttt/ZrTxK/Tbh8XHMPzlNhkrLoIDudXCeBb9c8h+BUOkdtpZfO
         xKQA==
X-Gm-Message-State: AOAM532Jr/4rFt6Wg8qXnuPfdUcgsUGFR29vNOwj6Y46jH4u9IBVTuwt
        /pCi8uncrC4BidrOkH+Fhf8jWeRPGWXWMw==
X-Google-Smtp-Source: ABdhPJx2+eo8lp+abaNDbuBlmvNF3ln7wPVVjMStOG+GFFaEXo/eBO92TCDwR/HGPdIudX9lzrQiJQ==
X-Received: by 2002:a05:622a:1888:: with SMTP id v8mr19662221qtc.206.1637180416826;
        Wed, 17 Nov 2021 12:20:16 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:16 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 17/17] btrfs: send: enable support for stream v2 and compressed writes
Date:   Wed, 17 Nov 2021 12:19:27 -0800
Message-Id: <a5811f269abad35318ef8c2867566bab66860fe1.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept the
v2 and the compressed flag, and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 7 +++++--
 fs/btrfs/send.h            | 2 +-
 include/uapi/linux/btrfs.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7a6a23a63950..e199b85e9c2c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -685,8 +685,7 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
-
+	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
 }
@@ -7496,6 +7495,10 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
index 50c2284f08af..cf15d4078ac6 100644
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
index 9d5fbe8c36c4..2533da0a0de1 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -787,7 +787,8 @@ struct btrfs_ioctl_received_subvol_args {
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
 	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
-	 BTRFS_SEND_FLAG_VERSION)
+	 BTRFS_SEND_FLAG_VERSION | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.34.0

