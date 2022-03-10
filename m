Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CC4D3ECA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiCJBdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiCJBdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:04 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD968127575
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:04 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id bc27so3437027pgb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgAYno85M9bTd3aFk11JT75m83OY0Pzg4ZAsIHc1FFc=;
        b=hKa/ZDG1O6Ex9i1WJzqLCSrJ5yiEqN72UQiG93vJwx6mHmZqFYmW4OfjBWm6eY97pn
         ICN6AhM/zc9fg5SO4KN9eyrmakzdW+6vKZStyTUlw1ynkJE2VzajNyNP+2TxGPCPPacO
         GZ0+4WX0p7FYRUQeoTevnied7oDnXM/jlTGFpdO+JKiZMLdO736G2nhCMZe/zT1dIFuP
         5bgw8SA+pcJXo+udvq1sVm5kU9YwFIkCRC7mUsnfvHyZRHWLvWoTjOOXpm9lRoV+I2Kx
         J1EEN9q3XtTVGcjrDpz1xecr+8pwMY8MQCkNCQ2uaEGAmXBoZO+MUanG+l5eCpyf8C+Y
         4qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgAYno85M9bTd3aFk11JT75m83OY0Pzg4ZAsIHc1FFc=;
        b=revzOZSM4OErkuGcWsBvM30n04x7jcP384IU3tVR8cbq7q/gf3Zf8laQW1oZnfxJTI
         m1N5quPOu6C7DjBibdLyTaRFrIXPIjpvGwWks3yLX96tL/lJDhz4hwP4xAC1cZWOJrpP
         TvRSdYP0L5Hu5r/7XB1Xnmp7TbR5yV2J6JkVStqe0Dud0qST0Hgh95gBhv8Mf/cFPw7K
         fVziUBNILxJC0XVhyHI6xEn4rwAIkO8ooXUDCfk0FHnlKmc2Z4OUwyhj2wYYCzD4f62N
         vHkzan/KQEQ0slnfIJaZyyehLYWHq9oC4r6Sh2nxVgp1tDCneKt4UEQB5wii+1I4JEqH
         Xg1g==
X-Gm-Message-State: AOAM53132TsY3BuU/omYdlB3ME6gBTj473OZdMzspaZgxXiPDdeSOb+n
        Cgl4aNYwq6lNfpjSRX8UebvvYZtXQDIyHA==
X-Google-Smtp-Source: ABdhPJzXzu7fFL8JUeTU2Vs1H98r297odta7jP22Pk+Nl/GmZr9uNwLti++J/P3cSfufSdYr5hPMoQ==
X-Received: by 2002:a65:6943:0:b0:376:333b:1025 with SMTP id w3-20020a656943000000b00376333b1025mr2061636pgq.164.1646875924067;
        Wed, 09 Mar 2022 17:32:04 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:03 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 09/16] btrfs: remove redundant name and name_len parameters to create_subvol
Date:   Wed,  9 Mar 2022 17:31:39 -0800
Message-Id: <d0909dccfbb5d9762d6f972d473eb914b806fa62.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
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

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d04870ea6a21..891352fd6d0f 100644
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
@@ -980,7 +981,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (snap_src)
 		error = create_snapshot(snap_src, dir, dentry, readonly, inherit);
 	else
-		error = create_subvol(mnt_userns, dir, dentry, name, namelen, inherit);
+		error = create_subvol(mnt_userns, dir, dentry, inherit);
 
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
-- 
2.35.1

