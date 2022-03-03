Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F434CC9F9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiCCXUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiCCXUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:15 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846633BA6E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so3776225pjb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNsLLoJu73El0qniKSCwdUnuPvYFzqryV3hEiCaBQSc=;
        b=vCPsEiySHRk1V5PsrftqMs3w4GV1zm+TIoZqNGLxWH/vo6pHwdhokSkkDwantdAwtn
         V1mHeQnQiv2Mv+iJTk2SFdQ99CdQ6soVV2+ackEF+7pwiTGTJ1NIOzn03mZL5TX9kVSr
         2mjXH5fyioZofSNPt+wfSU6f0+gf47n7XwpakgZa92fmpP9Q0QuFnsHoMckdGgO85nBH
         r5DCVeDvw/kjwInPKV1nCyaavJyBKum9BIFyXltVFBNRbgEI/ldLxWhnhcGDFeJj0d2I
         hLfLYGjcJ1N1HxQKrQYaswIs53h3d9qDYSllPnAg3C7+mHCfOPIz8tu1HOvmL3y/VlNu
         niZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNsLLoJu73El0qniKSCwdUnuPvYFzqryV3hEiCaBQSc=;
        b=R5Tm9PixxRLsJUrAsB5BR1Hg8QSP345i5O5rF9WjA4MN144+lY/NvBzp/hfdWdKDiX
         bCW5dfi5R9DJv/XHNFBq1ronheTJc2LcIyw+FZHMZJDHXP41hMTSBLAoaHwHhnG4qfGJ
         SwWemPVcVFSSOvSBhmLgqVZbdH5gFBrJ3zxDzQ/6w2t1M+qPcqR3DFV12pE04NkZpiPa
         k21pPPWL4oWMxYebH+fmMMffrXxF/Mo4P2yJweDr9uAmq1ZnNgMQXkdWwWHl5Z1nfWj1
         C9rhK4KRdZ/ORR0ORwpPFBVqbSeA7NNPjE/ZCEHfJ1o3uwDI1/mibeC8ncPnWH5132TW
         3PBQ==
X-Gm-Message-State: AOAM530lnwmJe0qV/jnMlIiddfgZ9YGL9XHxuXZyRICYWlSfZmEZ24Zk
        /gYtkSHqRAh7JBTGIsSDMGhnJHiJURKymg==
X-Google-Smtp-Source: ABdhPJw9lWGTkGRdF2zDtYiiFUKtDJLEyNOdQrhbK9AKLgjWl6RworCt+KZLviskSyM90HldXIUcuA==
X-Received: by 2002:a17:902:d2ce:b0:151:6781:affa with SMTP id n14-20020a170902d2ce00b001516781affamr23643418plc.168.1646349568483;
        Thu, 03 Mar 2022 15:19:28 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:28 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 08/12] btrfs: remove redundant name and name_len parameters to create_subvol
Date:   Thu,  3 Mar 2022 15:18:58 -0800
Message-Id: <42d46e9d36ca960d6c5b64e14ecdea0b3cd1393b.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
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

The passed dentry already contains the name.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 238cee5b5254..3cea5530ad83 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -546,9 +546,10 @@ int __pure btrfs_is_empty_uuid(u8 *uuid)
 
 static noinline int create_subvol(struct user_namespace *mnt_userns,
 				  struct inode *dir, struct dentry *dentry,
-				  const char *name, int namelen,
 				  struct btrfs_qgroup_inherit *inherit)
 {
+	const char *name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
@@ -983,7 +984,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (snap_src)
 		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(mnt_userns, dir, dentry, name, namelen, inherit);
+		error = create_subvol(mnt_userns, dir, dentry, inherit);
 
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
-- 
2.35.1

