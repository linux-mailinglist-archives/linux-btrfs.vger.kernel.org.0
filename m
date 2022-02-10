Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6824B15F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiBJTKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbiBJTKv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A610BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y7so2685766plp.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOzoRc6Mv2+MMUkzFwbVTCOyfssCbwP0sj0XfHUw1QI=;
        b=FOYcMPl7Lp82AplggeoruMTuMmaLdGFzzi+mRasR8twTJT32ZzBJ9lCS/7ORIw37sq
         Dc/shOsn8PszkfHR5mr5dU/onGpfI9wvjeeUrMuguy9X+28I0FUqhsiu6VQ7rBtbcY0z
         TqEsdL7Bj6hgqDQ9fvxu/aQhPaerely+xqb0gp+XWuPIL4KATmEwQVW8sC4uEvbLKm0t
         QhRqCEf9ejPb8SYHG0V2g9lGhoQqaW3ODFS828AXfX+GKHnVrR1KfTd8zaAZqcEE/Wjr
         6rpB6Wcu4pvYgJ75zb06Rx3IrcK8ALK0Ody5LYrbVoC85aoUYjdJuI1WeDV81c0299aU
         Vu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOzoRc6Mv2+MMUkzFwbVTCOyfssCbwP0sj0XfHUw1QI=;
        b=X5YXLYk0/PP1CvC2+/PBOSMm8Fnu2zwk7Dk9bbMul3RMPf/b5n9xKWJe3c6hWcTjIz
         4dH21pp37tNxBCPzBRFHr/oJNt0z0O6xSBJvgzSwMhkubL2TqpqvFNo7XYq/U2bkEBHb
         rEDdBbvHH5ypPh3IyUjJd2myF3Z3BTBwiGm7wJmMPWfuOMx6fn3akR2y3t3CPWBJq5ZF
         BL3LHiauZd35jpbnf2RQKhAeO07627Ah2W2CFXSd3SawImhVjwcCk1QqLNFdc5t7J85v
         gFc+dKN+LsIQ4GkKeXk4mdqFdz8tAYCbimn8zChbSj3ZHJ+DCndd8MfrhHv4ibOLzsLV
         3WDQ==
X-Gm-Message-State: AOAM533McaAsfsnoBUi+9cdE9KSyE0NY7tZRtHfrUGRQGAjahsqyE9+z
        laGZiiRmildemmXpt+D43Eo82+UwlH93bg==
X-Google-Smtp-Source: ABdhPJwZEPpC2iuvl4G6qEIv9WlKGZwkF/81IlfX336nXM/GzkqOotEJU6PYI0jCfAHb9rj/N4j35A==
X-Received: by 2002:a17:90b:4b84:: with SMTP id lr4mr4223981pjb.231.1644520250205;
        Thu, 10 Feb 2022 11:10:50 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:49 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 04/10] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Thu, 10 Feb 2022 11:10:11 -0800
Message-Id: <2763224b73c1188defc02ea10f91adf434781268.1644520114.git.osandov@fb.com>
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

Update our copy of send.h from the kernel. This adds the new commands
and attributes for v2 as well as explicit enum numbering.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 kernel-shared/send.h | 138 ++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 53 deletions(-)

diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index e986b6c8..b902d054 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -38,7 +38,6 @@ extern "C" {
  * should be assumed.
  */
 #define BTRFS_SEND_BUF_SIZE_V1 (64 * 1024)
-#define BTRFS_SEND_READ_SIZE (1024 * 48)
 
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
@@ -72,77 +71,110 @@ struct btrfs_tlv_header {
 
 /* commands */
 enum btrfs_send_cmd {
-	BTRFS_SEND_C_UNSPEC,
+	BTRFS_SEND_C_UNSPEC = 0,
 
-	BTRFS_SEND_C_SUBVOL,
-	BTRFS_SEND_C_SNAPSHOT,
+	/* Version 1 */
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
-	__BTRFS_SEND_C_MAX,
+	BTRFS_SEND_C_END = 21,
+	BTRFS_SEND_C_UPDATE_EXTENT = 22,
+	BTRFS_SEND_C_MAX_V1 = 22,
+
+	/* Version 2 */
+	BTRFS_SEND_C_FALLOCATE = 23,
+	BTRFS_SEND_C_SETFLAGS = 24,
+	BTRFS_SEND_C_ENCODED_WRITE = 25,
+	BTRFS_SEND_C_MAX_V2 = 25,
+
+	/* End */
+	BTRFS_SEND_C_MAX = 25,
 };
-#define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
 
 /* attributes in send stream */
 enum {
-	BTRFS_SEND_A_UNSPEC,
+	BTRFS_SEND_A_UNSPEC = 0,
 
-	BTRFS_SEND_A_UUID,
-	BTRFS_SEND_A_CTRANSID,
+	/* Version 1 */
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
+	/*
+	 * As of send stream v2, this attribute is special: it must be the last
+	 * attribute in a command, its header contains only the type, and its
+	 * length is implicitly the remaining length of the command.
+	 */
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
-#define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
 
 #ifdef __cplusplus
 }
-- 
2.35.1

