Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57584DCC6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiCQR13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiCQR10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B5114FC9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so6097272pju.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6mWpklEfCJElpbyli4O0vFR3E2bQpaD80/20rwpjwI=;
        b=gX6aIwz3vzUPGsvIOA7yh2C0YCkov1J+b/0PnVSr9Dhh0YsuiRmKrTU9KSEzNe2pWG
         uUWM4BQIOgCj6GN8j2ZSmPh/V/0uCQwJuTl6nqcpLFz0JuMy1j90pqGqjmy5yA9M8f4i
         wjRWp/B5DdvQAvsy4w5qvnDGjlmANjHbAcNMmqp4NgAFN8+Wqvu0zdtBoH3K9YBZGakH
         yP6y6TPoh8rpijpord+1OlTNPiHzlmEiTYbhkZ/ttKhR/zJET6NihBNV//nZoVbTDpCQ
         TFCByGjJrEY+LRfZZG4IjCfZUehdEcf27tbtPjggMAfIQKIvUn3RfmWqZZesyRRXxu1J
         9NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6mWpklEfCJElpbyli4O0vFR3E2bQpaD80/20rwpjwI=;
        b=Vm1Q5J+Kc1Ob0S+MJhR9L68akiWYScwqi8rISpLXBcMdwGmgrf+tpLiV38DBY29/gZ
         nKeCSiWtQcf88lO5EP3PwXusQ7kJXZTNa7Q6Kn+4FaBRsprPe8xgYE6WKjmNydpYzKgK
         PeqqTxmL9mj49XQCTvAR4do/tbY+1GNm7kSRdxM7UT8P+7GjdQgwOB9axBHGbl/SIrT/
         SzvAmumMooyTLuH9wHWXzvrJZ9Pv1ADpmGcOcRKOaXViZWrImQM1x42z4PBGbwEgulQa
         ZCNTca3uYmTv74baaVa/OdBosQD5JG4juY4qIydqWBfYtEA4uWZ+yrr+UcdQqAsrwKBF
         4PPw==
X-Gm-Message-State: AOAM532htAqzdejyTr5cXsv6g/QSs6vk8SeX3l+/waJ2SYQEdPcRnea7
        WNcWKdzYMXKb9g9VqYxyYnMizaLAxaPZAw==
X-Google-Smtp-Source: ABdhPJwU1GOwtGgCbtKDoHIXX8HUI3920aAKSmUqj2gj3YT1TbNPVkj5zDFWDDx6oHjdu58+ILtuvQ==
X-Received: by 2002:a17:902:7045:b0:153:a8b1:d666 with SMTP id h5-20020a170902704500b00153a8b1d666mr6224874plt.75.1647537969038;
        Thu, 17 Mar 2022 10:26:09 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:08 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 3/7] btrfs: add send stream v2 definitions
Date:   Thu, 17 Mar 2022 10:25:39 -0700
Message-Id: <40148edfb135002d33242471a87d4e7dc860b48c.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
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
index 9363f625fa17..1f141de3a7d6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7459,7 +7459,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
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
index d956b2993970..b6f26a434b10 100644
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

