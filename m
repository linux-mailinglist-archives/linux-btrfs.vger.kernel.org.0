Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A124DCC64
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiCQR1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiCQR1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825A6114FD1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so1371062pjo.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOzoRc6Mv2+MMUkzFwbVTCOyfssCbwP0sj0XfHUw1QI=;
        b=0S2HtqHWBjvF+76lsQbxA6RwrlloDnT4xvkIdX486Y6b7AbCDgCwtMRbhiPMgbaAiB
         YQWEEq3+brZcukgtyUascNoa2LLepCWybpVxpsqEltddEmCkUEK5q3iy/7JqmB8u8PU0
         lHXGJKWK67SPSk4vI1UO6kGQZa+7FpzfnvYh5jLZihsd3ELgvS3cSvJfYNCj6myAaKjC
         Q7wr4N9sYQvASIniqSS3ev9hbWTL3beiu5CqPWhUBaoPqKYXBR+6dhU8v2g28tAUyWGO
         +BVcdieeRx47JwBYXoC8sb7Cb9LzW+RlQs7ZPkJ5JPhqOMAYB7OWfgdhfuorfbssrfp/
         Xi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOzoRc6Mv2+MMUkzFwbVTCOyfssCbwP0sj0XfHUw1QI=;
        b=Qz4FN6gOBuSfpsY5cnZvQkmcDJ7s+RigFzxe6NZKUGcbap5o/f50Jrf6x0bBLP7eUX
         NasdtaLVCqz2JjEuIJr47NxC0RF693DulDyNAB4eSDIR6EjaIHdM/zwftf215bmR9vte
         7J2ISeSq0B+GStwghFNAaOO+q5b7IbMi/fd59lmTQIoH+5Gd6qQSdnO+kaMdAVGLwiDP
         OICTx/FTLRjtRXnYusspol6N9Jy3JOBeFNfH6SCXXJI5S/QwAN2m9m2uAi43/avLGlFz
         H+Pf5rmpkTQlMMFKjvpDiB6oJwd6pYHaxF3VakObfl/dutGq3qvImZMB2bF3daBcuDGB
         yHoA==
X-Gm-Message-State: AOAM533HGsSwCjchuVPK0k6CzpPPhcFxH5N+i6v6V4UYaqLs5QwNSfCn
        H8H1Cd8ZoHjtftlkbcl7mxFPSbSfEcWUHg==
X-Google-Smtp-Source: ABdhPJxQAiZ2JvDHGBdQVbanDOtHaFcYK0Yn6+2FlEZVXEq3TVhr2Ca4nNPHevkADyUc9nYmm969zw==
X-Received: by 2002:a17:902:db0f:b0:153:b671:21d8 with SMTP id m15-20020a170902db0f00b00153b67121d8mr5771799plx.128.1647537976675;
        Thu, 17 Mar 2022 10:26:16 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:16 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 04/10] btrfs-progs: receive: add send stream v2 cmds and attrs to send.h
Date:   Thu, 17 Mar 2022 10:25:47 -0700
Message-Id: <bab5662e5f58859240ebd0e93f7795b40829f9d0.1647537098.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
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

