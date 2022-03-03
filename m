Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C34CC9F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiCCXUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiCCXUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1611637DD
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z11so6149985pla.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSocfw/j6YhN1pnIQTfafZfw9HaRlXIpVkHJDXiZ97g=;
        b=A13m55KRV88w+eJQjqorDcUO27NEReHmBOpptlUYmxZOis1hVc2HqkGYBO0Jze+uDq
         BM5YjQPStw5ThPx19z8lmWD1+jXoQK8+os/gdgsU7vxRfu7f64Mw5M3Nso42ANcbGXob
         AulhB1hqC7sBDMh+BgjbGYgHIBBisLaTNDUBY0L9K14M7FEmRaqu6stQ66o8l/xx4mWF
         L4pA3g6v981iHzy747HEsPY7yIeQmcscPa/vRSArjEYKFDGR0wCuibilbVStPgjCn3eT
         zfeSG7dtPzoYnR2lvUrCLgbypFWwrfpOqiagdqyUPd5yrUQJX8ApKfcG4P+g1zn2GHau
         yIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSocfw/j6YhN1pnIQTfafZfw9HaRlXIpVkHJDXiZ97g=;
        b=k1M8xLN7uDp0WvSkgn2KYAlcyMZxUrq7aZ6UgaaTKEl6MH6Ssn2iHX/OPJiF1SLYYC
         hwBdN8oB+GrHclJpEY9W9aX3Qrc11Ov4wTir4bKhhVgZybk0jHQTXEWvsbkr2WiAKFX7
         nVAukTxySX/nD9fh7ZJyvhEus8RgAVd01wgxCrkg7US6L45nS04Pm+sZHUrGCbbAwk7p
         UaIEIdcGSPjhuZj+IE9vkKVKHb6KMJMXAwJCTLLi4DnKitgZwbxIs/71bM83PFPdAs5s
         DJwH3s8EaNEbM32m6ZtGe6pjfRyVMYoLOYLUke0plMlj84PXMTQoYb7nSbJq13sKRM9M
         pUfg==
X-Gm-Message-State: AOAM5305BaO6c9wEDsGGQ6ocOSxYtm2+cXrU2kRf7gku2tya6RJc+1SH
        MphcUtxNMwCuPU+nuMXaWaoCZ/u2Xe2+HA==
X-Google-Smtp-Source: ABdhPJwC7q49CkV5T0wK2EKPRTEQ/8BZgF8/EPmQDuT7U+ze2pXAJ7IJ+yL+b09hZIQTqW5iVQZBPg==
X-Received: by 2002:a17:902:758f:b0:14f:b5ee:cc5a with SMTP id j15-20020a170902758f00b0014fb5eecc5amr38676013pll.43.1646349567567;
        Thu, 03 Mar 2022 15:19:27 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:27 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 07/12] btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
Date:   Thu,  3 Mar 2022 15:18:57 -0800
Message-Id: <7317dc7ab52abf02fe0e6dcddab2a8ffc7ed372d.1646348486.git.osandov@fb.com>
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

Commit 4a8b34afa9c9 ("btrfs: handle ACLs on idmapped mounts") added this
parameter but didn't use it. __btrfs_set_acl() is the low-level helper
that writes an ACL to disk. The higher-level btrfs_set_acl() is the one
that translates the ACL based on the user namespace.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/acl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 0a0d0eccee4e..a6909ec9bc38 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -56,7 +56,6 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 }
 
 static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
-			   struct user_namespace *mnt_userns,
 			   struct inode *inode, struct posix_acl *acl, int type)
 {
 	int ret, size = 0;
@@ -123,7 +122,7 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		if (ret)
 			return ret;
 	}
-	ret = __btrfs_set_acl(NULL, mnt_userns, inode, acl, type);
+	ret = __btrfs_set_acl(NULL, inode, acl, type);
 	if (ret)
 		inode->i_mode = old_mode;
 	return ret;
@@ -144,14 +143,14 @@ int btrfs_init_acl(struct btrfs_trans_handle *trans,
 		return ret;
 
 	if (default_acl) {
-		ret = __btrfs_set_acl(trans, &init_user_ns, inode, default_acl,
+		ret = __btrfs_set_acl(trans, inode, default_acl,
 				      ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
 	}
 
 	if (acl) {
 		if (!ret)
-			ret = __btrfs_set_acl(trans, &init_user_ns, inode, acl,
+			ret = __btrfs_set_acl(trans, inode, acl,
 					      ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
 	}
-- 
2.35.1

