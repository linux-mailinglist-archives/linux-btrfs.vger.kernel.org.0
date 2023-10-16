Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29D7CB25B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjJPSWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjJPSWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A3102
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4195fddd6d7so40974771cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480537; x=1698085337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGWYV12KzrT/LkDMZjyuAcPQCUxRjfQ2Kc6Alzssq0w=;
        b=Jqp1a8+++GYG3DkG+zjX1FQMitBmLLKMMyrPzFBK3jTryaFlyICWqA7lSefOmEAv7c
         yRa8QiqTwCROJ9nRz9TBCSktcDyK1hbeGJGvGGwpkxY43cg6AYOX9Zm8HGLHSKJUscxG
         MhoNuKQFvOaTwJDeYqEzNNoqds1Wso3Q5WFct4ZAPm0TA8faa84UbLZl4wFtwdHEFkdf
         gKdSxtp2AbycRpwuVBhHEmm+/NtxnSyWa/hnPr0bsRzRJz01Gl46biXqj7RPsePjJtYA
         9PLsAGTlS4tHMeC6xn8siwgthhwp108hGgq5VgOwt/EUYNzv+oRSPF6Zz3nGJ1AklDMU
         a/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480537; x=1698085337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGWYV12KzrT/LkDMZjyuAcPQCUxRjfQ2Kc6Alzssq0w=;
        b=k3TNabjwmCXAGQVzeXXUlFZf6KaGYK8HrXy13qr7nxWI4uatWEjv60RgdWzTko46jU
         LgyHrodet7rAgQyNBdL1dkYDmb2N1/JRZ+IE09tHqSEClGLOwdGI1y1d9XINNytN3GHq
         TE0S5UPhqKq0xDWcHSQxQ6waM+X9GpFskbtQUOWLuudCIWvoI9ywN6s0LC/x3UIek9O0
         l/SI7ksc9zN9mNF20X1eKL1HNrq6hnbrDLHiNPjszud8hMn1fQivS5u+PBQBckZ7/fdc
         Ztsc391H1khTY7lwt7/tcgJJ4cbYtZaidJgBZcdArE8H2gNduPhbG914XrmmzBR2Mf2I
         nryw==
X-Gm-Message-State: AOJu0Ywxg1XWHwETi0IfAC3MUpTGi9YIyJLIoh6OXHRN6iBZcr70Kyst
        WwHWRqaJJELRny+J2lok8gzZuW8SKIsINlOBJDlBSA==
X-Google-Smtp-Source: AGHT+IFpFBQCpz/L+PsOJixkB9x+OaNEV4rgMgl+mw13b77Ny7LoazhjHpan/seXmhWcFX5bOYMwsQ==
X-Received: by 2002:a05:622a:1a04:b0:41b:4c0:cbf4 with SMTP id f4-20020a05622a1a0400b0041b04c0cbf4mr351009qtb.7.1697480536766;
        Mon, 16 Oct 2023 11:22:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jk3-20020a05622a748300b0041aff9339a2sm3165070qtb.22.2023.10.16.11.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 17/34] btrfs: turn on inlinecrypt mount option for encrypt
Date:   Mon, 16 Oct 2023 14:21:24 -0400
Message-ID: <fbf339ef97adb23db4c93f3bb067d90216198f78.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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
index c56986031870..69ab0d7e393f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4587,6 +4587,9 @@ long btrfs_ioctl(struct file *file, unsigned int
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
index 1e4b536476cd..4fb6ce1767f3 100644
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

