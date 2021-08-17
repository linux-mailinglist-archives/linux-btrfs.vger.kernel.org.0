Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C03EF48E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhHQVIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 17:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhHQVIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41634C061292
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7405674pjn.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLV41bP8YCpuWeMuX7pqjXG4e2HqxEWq/TWGdCGU/9U=;
        b=imMxs8KI9KkN0kG9d4PV/ljPIyv2J/EKB8DnA/hn0AHw55jKzuWjuffsZvy4CZ/qZe
         nH715fTYwIBg6c9fKK50MirUWjg/IRUBh4Kx/strpA8DtK02J8wlYGiiECGvfSSAJKoE
         H5qhrrNKKW/sEvXbRbJc22T8P+cEGskp+tcVowFI9tPntEtgbVQlRwuG+kVYBIFhrSsD
         5uAU7yZMYQrHYPX+nHWxjobkwyVUJ2mIqn4EP6xy1Gj8QhQY9jtaNuK/kBS2SVtEOA9o
         efi9mJUd/tPfubzap9YFAbZowGybMF0sD3kD9Q6m6Zp0LgTmUAkzZNNH8zDSQtLDQUP4
         57Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLV41bP8YCpuWeMuX7pqjXG4e2HqxEWq/TWGdCGU/9U=;
        b=mlebZdRmqXmeUGMQJv70jNKdTx48Fel6ih2J5t59orAA6n+ONFyHh8qZ12HTiwHsKi
         eTeWbM9hk5n1kMV4FLJbcckARgPVPVBt6DF63LqGSdHgKWpTsLZLq1QhFBprpDXmqBDD
         1GDUvJdnolO5B6EAmGFySeNYzgwXs/gxgtPOIsq+3+mlqUmGuLdyrhC/dmcw3Fqir0S3
         TW47XgzDYdHwqe/NCysJwITooql1RqBm858OoWm3JB17X5H4m2CgKKLXDOnB2SIrU9+k
         rhbcsRx8OfoOVH84c9cvMXJ8am/CV2Mz6pLlbuGwqDOfcT9+21hN77mrj1AX4Jc1PbzO
         zVZw==
X-Gm-Message-State: AOAM53309OORom9A6YcBqlWyZZAVKPEFdpscPzSp08q7T6S1ZEodH4kA
        w68xPi4kTqv1F14RTkOaGY2wiGIjFpPUow==
X-Google-Smtp-Source: ABdhPJwcLCwTl1WwRMWN/ORc2HQg9nZ7MjeBh3fIRB+hryESDKkCYOlNwQLgPfwYlqcZ8/585EvhoA==
X-Received: by 2002:a63:101c:: with SMTP id f28mr5297057pgl.330.1629234457487;
        Tue, 17 Aug 2021 14:07:37 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 02/10] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Tue, 17 Aug 2021 14:06:48 -0700
Message-Id: <172e7242aee7d3a70006d9eeaf8e29e8f239c991.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
 common/send-stream.c | 55 ++++++++++++++++++++++++++++----------------
 send.h               |  2 +-
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index cd5aa311..3d3585c3 100644
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
@@ -124,18 +125,22 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		goto out;
 	}
 
-	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
-	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
-	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
-
-	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
-		ret = -EINVAL;
-		error("command length %u too big for buffer %zu",
-				cmd_len, sizeof(sctx->read_buf));
-		goto out;
+	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
+	cmd_len = le32_to_cpu(cmd_hdr->len);
+	cmd = le16_to_cpu(cmd_hdr->cmd);
+	buf_len = sizeof(*cmd_hdr) + cmd_len;
+	if (sctx->read_buf_sz < buf_len) {
+		sctx->read_buf = realloc(sctx->read_buf, buf_len);
+		if (!sctx->read_buf) {
+			ret = -ENOMEM;
+			error("failed to reallocate read buffer for cmd");
+			goto out;
+		}
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
@@ -145,11 +150,12 @@ static int read_cmd(struct btrfs_send_stream *sctx)
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
@@ -524,19 +530,28 @@ int btrfs_read_and_process_send_stream(int fd,
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
diff --git a/send.h b/send.h
index 8dd865ec..228928a0 100644
--- a/send.h
+++ b/send.h
@@ -33,7 +33,7 @@ extern "C" {
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE SZ_64K
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
 #define BTRFS_SEND_READ_SIZE (1024 * 48)
 
 enum btrfs_tlv_type {
-- 
2.32.0

