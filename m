Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9354B15E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiBJTKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbiBJTKm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA8110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l9so1068292plg.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzdNK/xxnsl8agLtteSaV3bTofU+kl6waZ9fLxf1ucQ=;
        b=IoFbHLJMGmXdYs7kMJM5x9e0VFBVyRLYFANlA0CrrcOmoFOA32jvlrr5U2/FyfoGei
         4m3qSL43J3sg4zOkWTy6h65Nql5dBg+g1+xZOerMzUQ0hZCvzN0MziiVJqt8KMHKeIe6
         G/XVYptj5/fOIUKriMeWm70u7oKb7vXvTykwwFl+YAPaSncQutNBqOzn/f9+evpBOGWF
         WbkzDQQzQkxDgVR4lNCMdi4+RiWVJab/YBKWTeVNfGPz4J7ZWnXo/gdFXaI0JPFKGhGc
         z10CLtkf9SQupZfPJKz4oqwMqitOK0oJxS1z2ujG1gpM+IfKdwR2fAT/bhWwTBPtXFec
         RINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzdNK/xxnsl8agLtteSaV3bTofU+kl6waZ9fLxf1ucQ=;
        b=QvO4mhTGG+MjIt/dbomWgw2WZOVsnMqOxszhicNtllnDT27B5ojrJFY9oY1CP5rD0R
         sRgOaUJzLz8thfMY7H3uvOvzn4TW9odqVyBAf+OAeyefsgfPBsLB9LZGYE8hhrpabsFP
         GuHEFMoXEeAPLzIa9vNfKXEKfxsyNEO7ahGY4rKHaFCBmHyNP2uuK17Cdqe3veRY/l+r
         HDt3ebrwnfT+uViTsZrtStwYUn9uSQSo8BMe6DI9bV/teE7/t6zhaH8kVLhjrTxsSjtk
         Z58jG/ch67YueXWg5aUbeM56Cf8t3lv9Kca4tSasi4RNcl51dy/k/eAPGtdTr6v2alpA
         3mNQ==
X-Gm-Message-State: AOAM532HFIrF8n3pxBiVYeGEnkBuvqt6S7+kLiYX9WQOi4bajRNfNCtB
        VYdesnaevbaP76q1ajJAQkiZ/TA8+sHU2g==
X-Google-Smtp-Source: ABdhPJzA++uEFFdWT/rkX2vJtxrfdfOI5Th9QnIMmUdNI8S2r+0ljuBYIo8N7eA3wG9MrT1hGPG+2Q==
X-Received: by 2002:a17:902:b215:: with SMTP id t21mr8641409plr.69.1644520242332;
        Thu, 10 Feb 2022 11:10:42 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:41 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 13/17] btrfs: add send stream v2 definitions
Date:   Thu, 10 Feb 2022 11:10:03 -0800
Message-Id: <f4f287602133eeaae3de0241e76f820ffed0384e.1644519257.git.osandov@fb.com>
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
 fs/btrfs/send.h            | 40 ++++++++++++++++++++++++++++++++++----
 include/uapi/linux/btrfs.h |  7 +++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4fcfd81ade5e..9c9be0983cb3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7564,7 +7564,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
+	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 67721e0281ba..805d8095209a 100644
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
@@ -80,16 +84,20 @@ enum btrfs_send_cmd {
 	BTRFS_SEND_C_MAX_V1 = 22,
 
 	/* Version 2 */
-	BTRFS_SEND_C_MAX_V2 = 22,
+	BTRFS_SEND_C_FALLOCATE = 23,
+	BTRFS_SEND_C_SETFLAGS = 24,
+	BTRFS_SEND_C_ENCODED_WRITE = 25,
+	BTRFS_SEND_C_MAX_V2 = 25,
 
 	/* End */
-	BTRFS_SEND_C_MAX = 22,
+	BTRFS_SEND_C_MAX = 25,
 };
 
 /* attributes in send stream */
 enum {
 	BTRFS_SEND_A_UNSPEC = 0,
 
+	/* Version 1 */
 	BTRFS_SEND_A_UUID = 1,
 	BTRFS_SEND_A_CTRANSID = 2,
 
@@ -112,6 +120,11 @@ enum {
 	BTRFS_SEND_A_PATH_LINK = 17,
 
 	BTRFS_SEND_A_FILE_OFFSET = 18,
+	/*
+	 * As of send stream v2, this attribute is special: it must be the last
+	 * attribute in a command, its header contains only the type, and its
+	 * length is implicitly the remaining length of the command.
+	 */
 	BTRFS_SEND_A_DATA = 19,
 
 	BTRFS_SEND_A_CLONE_UUID = 20,
@@ -120,7 +133,26 @@ enum {
 	BTRFS_SEND_A_CLONE_OFFSET = 23,
 	BTRFS_SEND_A_CLONE_LEN = 24,
 
-	BTRFS_SEND_A_MAX = 24,
+	BTRFS_SEND_A_MAX_V1 = 24,
+
+	/* Version 2 */
+	BTRFS_SEND_A_FALLOCATE_MODE = 25,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS = 26,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN = 27,
+	BTRFS_SEND_A_UNENCODED_LEN = 28,
+	BTRFS_SEND_A_UNENCODED_OFFSET = 29,
+	/*
+	 * COMPRESSION and ENCRYPTION default to NONE (0) if omitted from
+	 * BTRFS_SEND_C_ENCODED_WRITE.
+	 */
+	BTRFS_SEND_A_COMPRESSION = 30,
+	BTRFS_SEND_A_ENCRYPTION = 31,
+	BTRFS_SEND_A_MAX_V2 = 31,
+
+	/* End */
+	BTRFS_SEND_A_MAX = 31,
 };
 
 #ifdef __KERNEL__
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 1a96645243e0..38578b1ce0a3 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -777,6 +777,13 @@ struct btrfs_ioctl_received_subvol_args {
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
2.35.1

