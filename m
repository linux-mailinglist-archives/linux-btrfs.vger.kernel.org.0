Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1605D33DDFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhCPTqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbhCPTpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15FC0613DF
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q5so10654514pgk.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3VnBuWPqboPwPuwDX4KEFwl4968vOutKRgPYHRDSQo=;
        b=Ynuu7XhXLzvhhyPyPgN7sje6eAPgaLgmFeSzcp3IPReFzV6GyodYGq+oocJJaZKtTR
         NqxUpwcvw+k9uIKfxE2H3id4iBaH2Mf7NL/hZkNUY1mImfiFnWtx0458NMCzC+/MrZ7P
         tKI8Z+KjMPj5QKDX8Vqf0PCDWk+d12xySgtfyKaqN//TgmG+Ptg8ulVK3SOxLgj8FBeM
         ETRiBXeqEUCgZbZQaIkFabjCAwsPsvl19GU1tAtjgfNv4ZqQNJJUGx3zaWwmoGy4Mv0g
         6LHRqmtBNqrt5Nc4JOOco3/Tjzc9U5urYC1vqRlkGjYbN7kmYPz6aLcReiplxPPlZoQ7
         4iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3VnBuWPqboPwPuwDX4KEFwl4968vOutKRgPYHRDSQo=;
        b=PddK0kUAxQeVTGTIQH3N0+ybktEnMNAy3M1qiKr9kUmdkpc6zqc/IIYa6NgblNnVJO
         jJ+thLHJXuhgWe3IV5vzV8fU7E2es956VbdwfGLUcOhYN9ujANSvepmiqE907bno7ezV
         fEbeY3cB8DlfjzBkk3udvhW8mJyUIvZ9DNigNWPUjEDZT6lDS55sGSq9xydEoMbllYkb
         m2yUyNrj51ooewErpS+DrdpCyDrBC+h+uj46NDJN6h4lIHPFyy42G9CDroYf/9UxL6b1
         6fDHsYcFCF865gHeXikg+zXQQDhTUT5x0T/+4ENgFxU7JtljI0FF4xaewfJONvqiB2yd
         eFjA==
X-Gm-Message-State: AOAM5331705fX19ORpYESolEgWLuOMsNHZxlkgaRKZDgewz5LtNuYpVB
        Q16bjkCEY1aURUdYdZFa86RCynPRX2G45A==
X-Google-Smtp-Source: ABdhPJyTFq14PGme72u+qlyTvCUxFlVHt1qDRWBRvYM3yKTfFOldqIrj0sTqY1YfJdA+aZlT4NG55Q==
X-Received: by 2002:a62:e10f:0:b029:1f5:42b6:7113 with SMTP id q15-20020a62e10f0000b02901f542b67113mr917750pfh.63.1615923880456;
        Tue, 16 Mar 2021 12:44:40 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:39 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/5] btrfs: send: enable support for stream v2 and compressed writes
Date:   Tue, 16 Mar 2021 12:43:59 -0700
Message-Id: <d8e787b3ee721d404ac56ed2af65a6bbe06b14c4.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept the
flags and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 10 +++++++++-
 fs/btrfs/send.h            |  2 +-
 include/uapi/linux/btrfs.h |  4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7516eba701af..cb824d1271fa 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -671,7 +671,10 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2)
+		hdr.version = cpu_to_le32(2);
+	else
+		hdr.version = cpu_to_le32(1);
 
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
@@ -7446,6 +7449,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		ret = -EINVAL;
 		goto out;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	    !(arg->flags & BTRFS_SEND_FLAG_STREAM_V2)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx = kzalloc(sizeof(struct send_ctx), GFP_KERNEL);
 	if (!sctx) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 9f4f7b96b1eb..9c83e14a43b2 100644
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
index 93aa0932234e..b12a9a1a106c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -786,7 +786,9 @@ struct btrfs_ioctl_received_subvol_args {
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_STREAM_V2 | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.30.2

