Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C64B15ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiBJTKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbiBJTKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C02188
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so6509502pjh.3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKSwvtRJZ5m4PGB7c0Qwfqimj9skuzXlOIMMYp9iF6U=;
        b=52GQekDgkPQhK+5mM8xkCZtiT1R/HpG/sJSJJQEOn3mslhoHFIdRYs/VirfvyExt3Y
         VjiPlQlsj1jk7SvWU9cIXfFtvCjR2MB+KhKaQzsYlnA1/MUZD7mcCTnrpxiSMWlVcxc+
         pA8ANNaq6nfaBgFkEmyjIQHav/TvnHQn9wU3AaI6f9lY00Ef/4Ip/yjIMLZu8CVvuszg
         0F3suTxHorQwBHwxiW0eK3dXSo12zAnqqgwQgMgC5c+hwiMrYF14T6z/mwj+n7o8vkoN
         adlFncKwPvXug1rJ1Vhrw0ZVOtGQx0FpjV6hbE+n087DI0XavEpOSvrHAi8J+lByE9Dv
         G2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKSwvtRJZ5m4PGB7c0Qwfqimj9skuzXlOIMMYp9iF6U=;
        b=PtbwRndqq/f74NMzYbgrUPTuXwEDwq4Yn4BlARQfo7RzkJd0Qh6BI9Bp2qTX5zr0Nf
         P7q3Cjd8i02yxZikoKqQpPS5j+8FS1JiNOSWV49IXIKky+shCZArLzv3G2xGeqr4+V8q
         99mPeDnpeuFR5qwNjiyafn0PQbV0E52sXfNfHgnwWIUuzquho+i82mP8mkj1+Dy/E+b7
         OqZ95yJOPROthFgKcDWLu2/sf/xIZXocwooB46YkTkxZ28Z6240/XZ7TSaSlXtgCJlPM
         S5jVTOQIYqTQXRO+buQFws7S61j0+zysLI8VJFi38h7nnR5jJuTAd8XldHqrbctFqzNR
         KfUg==
X-Gm-Message-State: AOAM532TrMFrNJ3kjx9nvpeOieI3zHVPxs/iBtyQgykMnIHULwGtBlBA
        9ErkO/8YcjYdi6t9cyXx6YSxML/CuGBfIw==
X-Google-Smtp-Source: ABdhPJz8hkKVYm/HbJyf0OuPd+qd8vMu1+TRUHfYgQGndS2P6qDvYe7Q+O90FjxBxzosckvOI9aaZw==
X-Received: by 2002:a17:903:300d:: with SMTP id o13mr8800085pla.27.1644520248068;
        Thu, 10 Feb 2022 11:10:48 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:47 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 02/10] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Thu, 10 Feb 2022 11:10:09 -0800
Message-Id: <b509c89313f748e90b9f2fb36ced64e60448c337.1644520114.git.osandov@fb.com>
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

From: Boris Burkov <boris@bur.io>

In send stream v2, write commands can now be an arbitrary size. For that
reason, we can no longer allocate a fixed array in sctx for read_cmd.
Instead, read_cmd dynamically allocates sctx->read_buf. To avoid
needless reallocations, we reuse read_buf between read_cmd calls by also
keeping track of the size of the allocated buffer in sctx->read_buf_sz.

We do the first allocation of the old default size at the start of
processing the stream, and we only reallocate if we encounter a command
that needs a larger buffer.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c   | 56 ++++++++++++++++++++++++++++--------------
 kernel-shared/send.h   |  6 ++++-
 libbtrfs/send-stream.c |  2 +-
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index 7d182238..421cd1bb 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -35,11 +35,11 @@ struct btrfs_send_attribute {
 };
 
 struct btrfs_send_stream {
-	char read_buf[BTRFS_SEND_BUF_SIZE];
+	char *read_buf;
+	size_t read_buf_sz;
 	int fd;
 
 	int cmd;
-	struct btrfs_cmd_header *cmd_hdr;
 	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
@@ -111,11 +111,12 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 	u32 pos;
 	u32 crc;
 	u32 crc2;
+	struct btrfs_cmd_header *cmd_hdr;
+	size_t buf_len;
 
 	memset(sctx->cmd_attrs, 0, sizeof(sctx->cmd_attrs));
 
-	ASSERT(sizeof(*sctx->cmd_hdr) <= sizeof(sctx->read_buf));
-	ret = read_buf(sctx, sctx->read_buf, sizeof(*sctx->cmd_hdr));
+	ret = read_buf(sctx, sctx->read_buf, sizeof(*cmd_hdr));
 	if (ret < 0)
 		goto out;
 	if (ret) {
@@ -124,18 +125,25 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		goto out;
 	}
 
-	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
-	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
-	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
+	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
+	cmd_len = le32_to_cpu(cmd_hdr->len);
+	cmd = le16_to_cpu(cmd_hdr->cmd);
+	buf_len = sizeof(*cmd_hdr) + cmd_len;
+	if (sctx->read_buf_sz < buf_len) {
+		void *new_read_buf;
 
-	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
-		ret = -EINVAL;
-		error("command length %u too big for buffer %zu",
-				cmd_len, sizeof(sctx->read_buf));
-		goto out;
+		new_read_buf = realloc(sctx->read_buf, buf_len);
+		if (!new_read_buf) {
+			ret = -ENOMEM;
+			error("failed to reallocate read buffer for cmd");
+			goto out;
+		}
+		sctx->read_buf = new_read_buf;
+		sctx->read_buf_sz = buf_len;
+		/* We need to reset cmd_hdr after realloc of sctx->read_buf */
+		cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
 	}
-
-	data = sctx->read_buf + sizeof(*sctx->cmd_hdr);
+	data = sctx->read_buf + sizeof(*cmd_hdr);
 	ret = read_buf(sctx, data, cmd_len);
 	if (ret < 0)
 		goto out;
@@ -145,11 +153,12 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		goto out;
 	}
 
-	crc = le32_to_cpu(sctx->cmd_hdr->crc);
-	sctx->cmd_hdr->crc = 0;
+	crc = le32_to_cpu(cmd_hdr->crc);
+	/* in send, crc is computed with header crc = 0, replicate that */
+	cmd_hdr->crc = 0;
 
 	crc2 = crc32c(0, (unsigned char*)sctx->read_buf,
-			sizeof(*sctx->cmd_hdr) + cmd_len);
+			sizeof(*cmd_hdr) + cmd_len);
 
 	if (crc != crc2) {
 		ret = -EINVAL;
@@ -537,19 +546,28 @@ int btrfs_read_and_process_send_stream(int fd,
 		goto out;
 	}
 
+	sctx.read_buf = malloc(BTRFS_SEND_BUF_SIZE_V1);
+	if (!sctx.read_buf) {
+		ret = -ENOMEM;
+		error("unable to allocate send stream read buffer");
+		goto out;
+	}
+	sctx.read_buf_sz = BTRFS_SEND_BUF_SIZE_V1;
+
 	while (1) {
 		ret = read_and_process_cmd(&sctx);
 		if (ret < 0) {
 			last_err = ret;
 			errors++;
 			if (max_errors > 0 && errors >= max_errors)
-				goto out;
+				break;
 		} else if (ret > 0) {
 			if (!honor_end_cmd)
 				ret = 0;
-			goto out;
+			break;
 		}
 	}
+	free(sctx.read_buf);
 
 out:
 	if (last_err && !ret)
diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index e73f09df..e986b6c8 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -33,7 +33,11 @@ extern "C" {
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE  (64 * 1024)
+/*
+ * In send stream v1, no command is larger than 64k. In send stream v2, no limit
+ * should be assumed.
+ */
+#define BTRFS_SEND_BUF_SIZE_V1 (64 * 1024)
 #define BTRFS_SEND_READ_SIZE (1024 * 48)
 
 enum btrfs_tlv_type {
diff --git a/libbtrfs/send-stream.c b/libbtrfs/send-stream.c
index 2b21d846..39cbb3ed 100644
--- a/libbtrfs/send-stream.c
+++ b/libbtrfs/send-stream.c
@@ -22,7 +22,7 @@
 #include "crypto/crc32c.h"
 
 struct btrfs_send_stream {
-	char read_buf[BTRFS_SEND_BUF_SIZE];
+	char read_buf[BTRFS_SEND_BUF_SIZE_V1];
 	int fd;
 
 	int cmd;
-- 
2.35.1

