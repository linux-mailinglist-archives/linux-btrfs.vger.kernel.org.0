Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62237AF229
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjIZSDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjIZSDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC4E11F
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41820eecff2so19631741cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751414; x=1696356214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KLmh2uaP15Sf9VJ5dLtRkPlzZHoo+djMGrpIoeSOJk=;
        b=shf1DcHi9otxTUCLdnixnQHt2PLxxOP76AMPtM61f9ri8ZwhBzEMbyZaQOaPCzzSWG
         5kNyvzlII5cvi27IlmgoAzSsBTWlWFu59d2X8vpiJeSQnC72R3/wAHVVs9mbRvgnKBkS
         F52gMfUXGzKTx98MA9tUyF+g2rb1ABFBJ9yBtWhDUtXqAGI+YRJPM5CzRGan86obGScc
         HsBHmaSz6tHRwWfZrGGGnBLUAbzmzdeSa6O+AtaMKqtZR9xzxaS8biIGlpHDLeEzckWL
         2nCt8FPM6gGRtBMMpWptKOuvLzpuUAMqd0foJ96y5zUJ1QWeTDobErMNA/kVl1Rq2hMb
         lyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751414; x=1696356214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KLmh2uaP15Sf9VJ5dLtRkPlzZHoo+djMGrpIoeSOJk=;
        b=UE/AZi+GHxpJ81w/Kc848/QRCzRUtRDkxalZxQAjyrzOGbd+caCTC0Xnw6MdD1T588
         u1NMQ5OaOuwa36fWHxv6xLLU/cJefLWMmceeVGL0E+hp1zG9chMyxZx6XlzfoWqGyuGf
         GI1Wp+IK7P/izYeK1tL6PQApBe5VyxqSBYyMtF4TG/CXkwKBcOOLYekM6KsTC/hZx8lx
         8gdpYPODj8NPdmPIAYF0hjpr0yQL2smPXfIWzP8VdtTZOZLKBNq4rADA8YrE3683hLVw
         c8rQLuoXVpYOk2rw5ds0kF9lVkrDvsN0AjUt5WcD4esHb9oy+olXIt+7OSUM5ZkoBBcy
         SdSQ==
X-Gm-Message-State: AOJu0Yw0iGd9FFLAeIOxctRT1TwPiZBGvh/GBRvg9DEmvdSvPgPT0ilw
        sfawktrYWOFeTSob5aWZurETKVvTx+TEhzDGv1MqzQ==
X-Google-Smtp-Source: AGHT+IEXrkR7x9Pl2saCQ8KSIwNXmAj6BRTstm+LKNEDSuk08JhC7QykpQg3Fx5yvNLDXUu/U6NaCA==
X-Received: by 2002:a05:622a:34a:b0:417:fe9c:6dce with SMTP id r10-20020a05622a034a00b00417fe9c6dcemr12030385qtw.25.1695751413829;
        Tue, 26 Sep 2023 11:03:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm1671764qtb.89.2023.09.26.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 18/35] btrfs: turn on inlinecrypt mount option for encrypt
Date:   Tue, 26 Sep 2023 14:01:44 -0400
Message-ID: <e4816641d25052d421cf2118739e6297f225e641.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

fscrypt's extent encryption requires the use of inline encryption or the
software fallback that the block layer provides; it is rather
complicated to allow software encryption with extent encryption due to
the timing of memory allocations. Thus, if btrfs has ever had a
encrypted file, or when encryption is enabled on a directory, update the
mount flags to include inlinecrypt.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c |  3 +++
 fs/btrfs/super.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8e5f9dbb547a..33bf4d9416a9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4599,6 +4599,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 		 * state persists.
 		 */
 		btrfs_set_fs_incompat(fs_info, ENCRYPT);
+		if (!(inode->i_sb->s_flags & SB_INLINECRYPT)) {
+			inode->i_sb->s_flags |= SB_INLINECRYPT;
+		}
 		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
 	}
 	case FS_IOC_GET_ENCRYPTION_POLICY:
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2b5d60cb7fed..a8a609f4a9f4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1120,6 +1120,16 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
+		if (IS_ENABLED(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)) {
+			sb->s_flags |= SB_INLINECRYPT;
+		} else {
+			btrfs_err(fs_info, "encryption not supported");
+			err = -EINVAL;
+			goto fail_close;
+		}
+	}
+
 	inode = btrfs_iget(sb, BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.41.0

