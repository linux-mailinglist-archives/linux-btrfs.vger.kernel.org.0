Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716C4B15E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbiBJTKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiBJTKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FB110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id on2so6024113pjb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUUCIYm5W31hLoWrGj3mWOGa1Y94atwoF4AGBZVVvjY=;
        b=wP87yrorEcSWjq+e14UiLqoCfHRVJDtUNsvXUqU63cH0t0VVOguzS1Qn4z0gt2UiDd
         9j5p+9xLPD43lZ2pWyzIFEJFj+FgqtPGElUEzxg4VPXlusax4LhDLpFq49ciKEbU0Kw+
         DPbAlzGngUXMxvvk24nskyXvAouXVPx9rjQ+OqoAVr1X27k9tlLWwipSY3R0+y0N6zj2
         F/LAYk2u5CIdlecoUYokBUa1Irz1qyVPeBVaKO2fjCOEckmzHgKDNEjSPIdEwmhl5eBg
         sOGI6d1teF2OquezFhXa7LaS25LnLZXZ4Onyp5PQrdDeyRF7Tu0DEBUp/W/Fvd8QrMmU
         evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUUCIYm5W31hLoWrGj3mWOGa1Y94atwoF4AGBZVVvjY=;
        b=ZRxrQdDuqd3l0vXcU3e8B2axfbcv8BL/Xqjv6ho79u/K6K6Kv5atyQhPgniU/Yi5pw
         m8fGqSKgPDlXHd8o5BvXE0zvgg15+7UyJNTyoRp/dfRNslWft61jcbapUEPq20czt+FZ
         Nd9RgyieFEXUEPRxtEg5A8MM18QJn25KQI8mVvDtF0gXj6oeJ96KK9Hhbh0I63DzuUiy
         L7EKED16SbWsI/0pRbuwXMUtCw4TcBOYPjxICZn5As3X8irp4u6V5VZqQDL8pIpVdyuZ
         42VCHoIDGfeM4/nVea4ov3dCAn/SZVjIrKZrL0DszV4k+6JVv37XRFS/Y2fqF0V8fErb
         r9KA==
X-Gm-Message-State: AOAM533R4J/Tn3BfbdZ5V6qqGsNBiRPeGGCd+bJ9BaT8r7GWaXZ43X6J
        LNpbbff1kzLrrgMe/XzBWUFr2AKhJM4Ahw==
X-Google-Smtp-Source: ABdhPJyDUypIV15aVvlSg9IQ6IY+0cAFX99Pm+stFRbOQtjyRnFUSkmNSQ+hd6VwQzWeF4UiYWF2BA==
X-Received: by 2002:a17:90b:354:: with SMTP id fh20mr4267345pjb.134.1644520241231;
        Thu, 10 Feb 2022 11:10:41 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:40 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 12/17] btrfs: send: explicitly number commands and attributes
Date:   Thu, 10 Feb 2022 11:10:02 -0800
Message-Id: <23d929398ec3abee3b5b3e140b28470e26ce8bc1.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c |   4 +-
 fs/btrfs/send.h | 106 ++++++++++++++++++++++++------------------------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 97e97aa7f4d7..4fcfd81ade5e 100644
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

