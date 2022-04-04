Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FE4F1C25
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbiDDVZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379560AbiDDRbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 13:31:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17BC6248
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 10:29:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so8879858pgn.8
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Apr 2022 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYIkGFxqBfHzN8fuX297o8OxjST47VKXqSChN4K1sNM=;
        b=HbJ/UK5sksxD0lSBhP1NbP7emIVUQ0mVyjCZl56LcrQi8HQS/k4m5oP6C/oU7796sQ
         sfO+np38ZV5S1N5/mCQDK9REX7Lr6izLPpy7XywuJJT5T/6F0JLJYX+ieNjBohDe1rKq
         MCRtHifsUdclcqpnL5Thd0p2SQzWfyGNGaBL+92rh8Hq8bADKgl0nlEo1HdJP9tOZaBj
         6klFRNNZqLZz3GsA2Rbx36N4ihpSiWlmet+kBzuxU2ezjVz3LlGPmcX3ZXEkWg2Qz2mk
         x1qcL028BWTK8kn7nIcY+7c79Ic+rLNCW89D5Rkmt/8QjLyUbwTaYm9k/S2i4YwtXahM
         GWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYIkGFxqBfHzN8fuX297o8OxjST47VKXqSChN4K1sNM=;
        b=099J6mvQwrFGl7aRjN8i8ep+jy1U0o06K7xLZnT5+RnJ1sVqYa9yJkgfnZdUFH0Z0k
         thL7y5kbjVP2cuZ+ES2m8djw/dMFigVts19SPw93RSPnWlxufy9CqxTQVl5ZX76GH3zi
         bvIQ/bACx9pRWpMZYEGe5vdjxnAjTkt5DnXeLJQXVobug8uDd4HRSErAYWFU+Lc33f0f
         MqrXbNLeXcjbk/bWz42XgaKVBMRNiwFgZiwidLzO7elbnuG0HR0YEd24KUftDAZB3RgT
         p+qGosDHWfRPrYqXFFVizju0kZQ9UIRZOH9CCzIpGlC473rKedPWzfTr8FyZMZla0c+g
         pGRQ==
X-Gm-Message-State: AOAM530lA8wvkmNrPZ5S9zvx7qujX5qJrpCvuJK8d6iXdCdC6MdDAI71
        g1mUdCYLS1oXsXGs8TLSyG1TGdVM71jRYw==
X-Google-Smtp-Source: ABdhPJy+0TR3o0LGqL+3wHhpP/S8MCYoTn7sSwdtD+mcSbEDwiSYU02Ctlz1wTMDUUauGveT/IBOCg==
X-Received: by 2002:a05:6a00:134f:b0:4fb:1307:ceed with SMTP id k15-20020a056a00134f00b004fb1307ceedmr1119112pfu.23.1649093361888;
        Mon, 04 Apr 2022 10:29:21 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:eb9])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm12880787pfv.123.2022.04.04.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:29:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v15 2/7] btrfs: send: explicitly number commands and attributes
Date:   Mon,  4 Apr 2022 10:29:04 -0700
Message-Id: <50061db343aa530e65b68e0be85ff246da5b1e7e.1649092662.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649092662.git.osandov@fb.com>
References: <cover.1649092662.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit e77fbf990316 ("btrfs: send: prepare for v2 protocol") added
_BTRFS_SEND_C_MAX_V* macros equal to the maximum command number for the
version plus 1, but as written this creates gaps in the number space.
The maximum command number is currently 22, and __BTRFS_SEND_C_MAX_V1 is
accordingly 23. But then __BTRFS_SEND_C_MAX_V2 is 24, suggesting that v2
has a command numbered 23, and __BTRFS_SEND_C_MAX is 25, suggesting that
23 and 24 are valid commands.

Instead, let's explicitly number all of the commands, attributes, and
sentinel MAX constants.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c |   4 +-
 fs/btrfs/send.h | 106 ++++++++++++++++++++++++------------------------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6d36dee1505f..9363f625fa17 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -326,8 +326,8 @@ __maybe_unused
 static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
 {
 	switch (sctx->proto) {
-	case 1:	 return cmd < __BTRFS_SEND_C_MAX_V1;
-	case 2:	 return cmd < __BTRFS_SEND_C_MAX_V2;
+	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
+	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
 	default: return false;
 	}
 }
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 08602fdd600a..67721e0281ba 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -46,84 +46,82 @@ struct btrfs_tlv_header {
 
 /* commands */
 enum btrfs_send_cmd {
-	BTRFS_SEND_C_UNSPEC,
+	BTRFS_SEND_C_UNSPEC = 0,
 
 	/* Version 1 */
-	BTRFS_SEND_C_SUBVOL,
-	BTRFS_SEND_C_SNAPSHOT,
+	BTRFS_SEND_C_SUBVOL = 1,
+	BTRFS_SEND_C_SNAPSHOT = 2,
 
-	BTRFS_SEND_C_MKFILE,
-	BTRFS_SEND_C_MKDIR,
-	BTRFS_SEND_C_MKNOD,
-	BTRFS_SEND_C_MKFIFO,
-	BTRFS_SEND_C_MKSOCK,
-	BTRFS_SEND_C_SYMLINK,
+	BTRFS_SEND_C_MKFILE = 3,
+	BTRFS_SEND_C_MKDIR = 4,
+	BTRFS_SEND_C_MKNOD = 5,
+	BTRFS_SEND_C_MKFIFO = 6,
+	BTRFS_SEND_C_MKSOCK = 7,
+	BTRFS_SEND_C_SYMLINK = 8,
 
-	BTRFS_SEND_C_RENAME,
-	BTRFS_SEND_C_LINK,
-	BTRFS_SEND_C_UNLINK,
-	BTRFS_SEND_C_RMDIR,
+	BTRFS_SEND_C_RENAME = 9,
+	BTRFS_SEND_C_LINK = 10,
+	BTRFS_SEND_C_UNLINK = 11,
+	BTRFS_SEND_C_RMDIR = 12,
 
-	BTRFS_SEND_C_SET_XATTR,
-	BTRFS_SEND_C_REMOVE_XATTR,
+	BTRFS_SEND_C_SET_XATTR = 13,
+	BTRFS_SEND_C_REMOVE_XATTR = 14,
 
-	BTRFS_SEND_C_WRITE,
-	BTRFS_SEND_C_CLONE,
+	BTRFS_SEND_C_WRITE = 15,
+	BTRFS_SEND_C_CLONE = 16,
 
-	BTRFS_SEND_C_TRUNCATE,
-	BTRFS_SEND_C_CHMOD,
-	BTRFS_SEND_C_CHOWN,
-	BTRFS_SEND_C_UTIMES,
+	BTRFS_SEND_C_TRUNCATE = 17,
+	BTRFS_SEND_C_CHMOD = 18,
+	BTRFS_SEND_C_CHOWN = 19,
+	BTRFS_SEND_C_UTIMES = 20,
 
-	BTRFS_SEND_C_END,
-	BTRFS_SEND_C_UPDATE_EXTENT,
-	__BTRFS_SEND_C_MAX_V1,
+	BTRFS_SEND_C_END = 21,
+	BTRFS_SEND_C_UPDATE_EXTENT = 22,
+	BTRFS_SEND_C_MAX_V1 = 22,
 
 	/* Version 2 */
-	__BTRFS_SEND_C_MAX_V2,
+	BTRFS_SEND_C_MAX_V2 = 22,
 
 	/* End */
-	__BTRFS_SEND_C_MAX,
+	BTRFS_SEND_C_MAX = 22,
 };
-#define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
 
 /* attributes in send stream */
 enum {
-	BTRFS_SEND_A_UNSPEC,
+	BTRFS_SEND_A_UNSPEC = 0,
 
-	BTRFS_SEND_A_UUID,
-	BTRFS_SEND_A_CTRANSID,
+	BTRFS_SEND_A_UUID = 1,
+	BTRFS_SEND_A_CTRANSID = 2,
 
-	BTRFS_SEND_A_INO,
-	BTRFS_SEND_A_SIZE,
-	BTRFS_SEND_A_MODE,
-	BTRFS_SEND_A_UID,
-	BTRFS_SEND_A_GID,
-	BTRFS_SEND_A_RDEV,
-	BTRFS_SEND_A_CTIME,
-	BTRFS_SEND_A_MTIME,
-	BTRFS_SEND_A_ATIME,
-	BTRFS_SEND_A_OTIME,
+	BTRFS_SEND_A_INO = 3,
+	BTRFS_SEND_A_SIZE = 4,
+	BTRFS_SEND_A_MODE = 5,
+	BTRFS_SEND_A_UID = 6,
+	BTRFS_SEND_A_GID = 7,
+	BTRFS_SEND_A_RDEV = 8,
+	BTRFS_SEND_A_CTIME = 9,
+	BTRFS_SEND_A_MTIME = 10,
+	BTRFS_SEND_A_ATIME = 11,
+	BTRFS_SEND_A_OTIME = 12,
 
-	BTRFS_SEND_A_XATTR_NAME,
-	BTRFS_SEND_A_XATTR_DATA,
+	BTRFS_SEND_A_XATTR_NAME = 13,
+	BTRFS_SEND_A_XATTR_DATA = 14,
 
-	BTRFS_SEND_A_PATH,
-	BTRFS_SEND_A_PATH_TO,
-	BTRFS_SEND_A_PATH_LINK,
+	BTRFS_SEND_A_PATH = 15,
+	BTRFS_SEND_A_PATH_TO = 16,
+	BTRFS_SEND_A_PATH_LINK = 17,
 
-	BTRFS_SEND_A_FILE_OFFSET,
-	BTRFS_SEND_A_DATA,
+	BTRFS_SEND_A_FILE_OFFSET = 18,
+	BTRFS_SEND_A_DATA = 19,
 
-	BTRFS_SEND_A_CLONE_UUID,
-	BTRFS_SEND_A_CLONE_CTRANSID,
-	BTRFS_SEND_A_CLONE_PATH,
-	BTRFS_SEND_A_CLONE_OFFSET,
-	BTRFS_SEND_A_CLONE_LEN,
+	BTRFS_SEND_A_CLONE_UUID = 20,
+	BTRFS_SEND_A_CLONE_CTRANSID = 21,
+	BTRFS_SEND_A_CLONE_PATH = 22,
+	BTRFS_SEND_A_CLONE_OFFSET = 23,
+	BTRFS_SEND_A_CLONE_LEN = 24,
 
-	__BTRFS_SEND_A_MAX,
+	BTRFS_SEND_A_MAX = 24,
 };
-#define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
 
 #ifdef __KERNEL__
 long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg);
-- 
2.35.1

