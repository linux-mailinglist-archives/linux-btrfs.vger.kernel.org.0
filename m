Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7F454E6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbhKQUXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbhKQUXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A75C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:14 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a11so3864189qkh.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHlERDHKyp9NFrg1TfRbEDXur2CZfF7mBtc6t/fE2V8=;
        b=cnSrLtBb/UjIx7e/RHQoXm3XtMkrQE1+PCztE7evTXOFHhYE/s9pQu9UFOnAPS9jww
         sTP9S4Flu80UAlaNo7NLRXE9OPJj2mrt/vo833QNGwG1FVEuq9W/QYAiitahLN2G+hK8
         4HvoZQmRC2WFHAsSM/xmFcKdwLyZ/hQHdwWAHi8mHlKBOllxRWtas6tfRCIp2rf6D31w
         DVJD/JUnSPmZ5WASmoURJRwFhMTt5JGbos/OgIJF5VCT5fFv5JjAXXikElGAQGXIH+Em
         0S4185xeB7mT0YhvdzDNObJ6X1n1kSs6IYr6PKDYKGbnpMdNw9OSdpHbQqTIknkjdxly
         mEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHlERDHKyp9NFrg1TfRbEDXur2CZfF7mBtc6t/fE2V8=;
        b=GmEtuAfwcqfjxCIEa+KIEM26J1p2OnCefrhwl/7ltjMQZmi7OPXK236fcUaXp8UFz0
         Amua9ynv27CAv1/6yAakiUhLQ7t8Ix22m0MKEHYgxPad9XOzfwxEoRp3XjhLCtGwj3jI
         l8vDNZy/eB1jAIRty141PYqFp12HMXbYkhcCQlgG/19KoZ7HWc67TG7qJk5Svfky65vR
         MJvyvrezaOBoVOoi+oHDkz+dZqpqgPmlBQZ9E26YM2qZ62bOveUR1qGm/YwiJzbKJz9W
         gZmFc03NMTcnCplfGPYC2yl5ttRLHHmS2cyKaClem21S2p5+pZVOWwCm40Ya9ZTYz5Hu
         1OUQ==
X-Gm-Message-State: AOAM530D8xPoaaNR79FNWf5nIGXG394gSKlHbOfscWu6bhQZnueLm010
        C6ap8yYLSwe8t7XxbZlY/B1kTE4iGWxh1Q==
X-Google-Smtp-Source: ABdhPJxeq3CgeDAbUbufE4hBolDaon4mXShFLLa1lpuZiCP0oPGlJLZkhT+F1RugDEVm3RRVAWS7HQ==
X-Received: by 2002:a05:620a:24c9:: with SMTP id m9mr15099164qkn.317.1637180413071;
        Wed, 17 Nov 2021 12:20:13 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:12 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 13/17] btrfs: add send stream v2 definitions
Date:   Wed, 17 Nov 2021 12:19:23 -0800
Message-Id: <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds the definitions of the new commands for send stream version 2
and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
chattr), and encoded writes. It also documents two changes to the send
stream format in v2: the receiver shouldn't assume a maximum command
size, and the DATA attribute is encoded differently to allow for writes
larger than 64k. These will be implemented in subsequent changes, and
then the ioctl will accept the new version and flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            |  2 +-
 fs/btrfs/send.h            | 35 +++++++++++++++++++++++++++++++++--
 include/uapi/linux/btrfs.h |  7 +++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 450c873684e8..53b3cc2276ea 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7292,7 +7292,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
+	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 59a4be3b09cd..50c2284f08af 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -12,7 +12,11 @@
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE SZ_64K
+/*
+ * In send stream v1, no command is larger than 64k. In send stream v2, no limit
+ * should be assumed.
+ */
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
 
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
@@ -80,7 +84,10 @@ enum btrfs_send_cmd {
 	BTRFS_SEND_C_MAX_V1 = BTRFS_SEND_C_UPDATE_EXTENT,
 
 	/* Version 2 */
-	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_MAX_V1,
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_ENCODED_WRITE,
 
 	/* End */
 	__BTRFS_SEND_C_MAX,
@@ -91,6 +98,7 @@ enum btrfs_send_cmd {
 enum {
 	BTRFS_SEND_A_UNSPEC,
 
+	/* Version 1 */
 	BTRFS_SEND_A_UUID,
 	BTRFS_SEND_A_CTRANSID,
 
@@ -113,6 +121,11 @@ enum {
 	BTRFS_SEND_A_PATH_LINK,
 
 	BTRFS_SEND_A_FILE_OFFSET,
+	/*
+	 * In send stream v2, this attribute is special: it must be the last
+	 * attribute in a command, its header contains only the type, and its
+	 * length is implicitly the remaining length of the command.
+	 */
 	BTRFS_SEND_A_DATA,
 
 	BTRFS_SEND_A_CLONE_UUID,
@@ -120,7 +133,25 @@ enum {
 	BTRFS_SEND_A_CLONE_PATH,
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
+	BTRFS_SEND_A_MAX_V1 = BTRFS_SEND_A_CLONE_LEN,
 
+	/* Version 2 */
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	/*
+	 * COMPRESSION and ENCRYPTION default to NONE (0) if omitted from
+	 * BTRFS_SEND_C_ENCODED_WRITE.
+	 */
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+	BTRFS_SEND_A_MAX_V2 = BTRFS_SEND_A_ENCRYPTION,
+
+	/* End */
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7505acfa18d7..9d5fbe8c36c4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -776,6 +776,13 @@ struct btrfs_ioctl_received_subvol_args {
  */
 #define BTRFS_SEND_FLAG_VERSION			0x8
 
+/*
+ * Send compressed data using the ENCODED_WRITE command instead of decompressing
+ * the data and sending it with the WRITE command. This requires protocol
+ * version >= 2.
+ */
+#define BTRFS_SEND_FLAG_COMPRESSED		0x10
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-- 
2.34.0

