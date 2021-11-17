Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABA9454E72
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhKQUXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240688AbhKQUXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:18 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAECC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:19 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 8so3893804qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VlFpcF51+kD/zP3+QRFIkLNzlcLX1CCKpk118zTKR2U=;
        b=sO42yY8Y13b3BIZLgmqUelHVHSUajfNGTtmteoF8iNOo/Rf1OQ30/A3+tXbg7dRE8L
         5CAozWy3IxckC/sSsPUKYn2HLkhcpr6ciyvUvhCGZwTyfkucjKPhwfreA6ca6xYFrhXm
         qqyQOdb8yJNIUDWyILPrIbs1F82zA9eT0+l2/CNf+PGNbNlHiRrTR5WdJP1HlFR8vPy3
         FAMk5MNTVdjIPoNJ6boombOgJlMA/GiC2KzW+Iwp+wByksocnIIxCYHCQ6rpibvbXoCV
         PxlcR3vTeI8BqkNl8Z2aZaY0baeVwyD+2MJ2tYNGuHJxq09eKuSGogX6c5w6miq7FKpc
         NDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlFpcF51+kD/zP3+QRFIkLNzlcLX1CCKpk118zTKR2U=;
        b=BL8uiZYwMQ8KKq0Mwxky0s4uwFOODcagbw2XGxb3GgKcQQk94mTDbFo5K77dQxFyjJ
         TV4r9zySk/cXBPwW7QKEDjjFxXrhb5/LrNo851UhJB9iIdB6pTcRFRpbmJsHgy7h3bsT
         sgyX3rw0cCvQRT7G8EiPCMtJwjJLodHNIJWhrhnrSHb1W+XnIcrloASMWVQNy6Z3+O2P
         bUcwDVft7t2PJJ+VQz1XxYMsv/xULIV7hGQFveMpnbKE8XGxXPnRRtaN+bFrLCEHVzXQ
         io06Hufu4zwgAD412aLlr7MkplCFzi015jtEdP+iJwfNpgl9EewgvCRf8Xq+fHlzPPj0
         C+Ew==
X-Gm-Message-State: AOAM530shdmOFxJI9IQ/Lcd4Q/UlZwyXaBDtdVy4udmiYD2PhXQZP4HL
        0gijjdEuy8PWF5wJett40fYlFDecTCbwSA==
X-Google-Smtp-Source: ABdhPJzR8cVw6jwpdd/svAeoCdiqyr7Y8OUP7waBR+TFCqQrNaS9RDjntRFepOeaQpeVGntEq1BzmA==
X-Received: by 2002:ac8:7f43:: with SMTP id g3mr20385273qtk.127.1637180418851;
        Wed, 17 Nov 2021 12:20:18 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:18 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 02/10] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Wed, 17 Nov 2021 12:19:29 -0800
Message-Id: <29d2d47bb9640a21c5dcb297e8b55d9ed0ab2d19.1637180270.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 kernel-shared/send.h   |  2 +-
 libbtrfs/send-stream.c |  2 +-
 3 files changed, 39 insertions(+), 21 deletions(-)

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
index e73f09df..c8003aa5 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -33,7 +33,7 @@ extern "C" {
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE  (64 * 1024)
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
2.34.0

