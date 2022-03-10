Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848904D3EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiCJBdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiCJBdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:03 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C321275CD
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p17so3504144plo.9
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjNJfO/0nLKVffjSGv1g16//0T5kgy471m/QdAjG9GU=;
        b=Qkwj6FnFkcRMNZzv5yvF+Oa8QHPYsrqpN4wHPhRhfem4Q09Gui8V3ZFWwaWxlG3/Ni
         tUvnWbUkp9fjhKx+8+8dd2MnKQzobpViLHIJKOFzeR5t292KHsuuNFcWhzdkmw6cydaf
         Hthl+ZpHr4Ue2KJrVH5QqCl4XVEmGGpnKwdslarURfSFpql+sn0BooEEear3pcZhfDUM
         OuzTl6ih9c7vzmC1zvBnvLTjeONEp62Y8WeDWB3wJo0wBk5lSbIpyaXc+1bLBWX5kprE
         8YeBSfcDHWGkxM1s3DUvaUKmD5o9FHlhkGwtAqgl7hLjccXHC/eYJekVrAwYRkQXmV8h
         Uz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjNJfO/0nLKVffjSGv1g16//0T5kgy471m/QdAjG9GU=;
        b=7WO1eHkXKMM+oT83VW15qhF6qY4GDplN/BtHt4PGowxZcha2aj7OlrKfcKmKqgp+vX
         pAYDAY6j13gRBoM24mREpjt/Tyll/hUm/1hxyjiqJyNqPl9wN7czCZ/u/HmOOo1/Ndsf
         z4UDp4tV6ktUcgUnv+2em2IdQLx947SHJS7IfC6vot6r1iJnpuKDA9/b6owPp/fYAJCY
         8leMkQ3QzDiurZ1PPBZF8XXb/SAoTkzVe4h9XdgZYy0gb81ADP9fma3noQYy9HP6na8R
         IYXTI7oE1dLReUJSmfrII7lxtmJq0HhfGpnLjuiJnPZzWoD1tC2w5OLvPKBAQ+wcDA5b
         B8QA==
X-Gm-Message-State: AOAM531q7HxeBBtS20jBXNBLYiRtusgxM9qMpAT1e6uebrpJae1eLeql
        +j6yXydA0CDX7A1oKt9OjdalYHcpYakzfA==
X-Google-Smtp-Source: ABdhPJycYg4CxUBTpIT2X9q0w6WRIw8QYQi+PBYrvoOu+U0TNR1Kt9IJx27BRtE8bUlcIb14gtx+Pw==
X-Received: by 2002:a17:90a:19d2:b0:1be:d815:477f with SMTP id 18-20020a17090a19d200b001bed815477fmr2439369pjj.23.1646875922851;
        Wed, 09 Mar 2022 17:32:02 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:02 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 08/16] btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
Date:   Wed,  9 Mar 2022 17:31:38 -0800
Message-Id: <63ea10d553bfbad1ea656348c9cc3220eb25582d.1646875648.git.osandov@fb.com>
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

Commit 4a8b34afa9c9 ("btrfs: handle ACLs on idmapped mounts") added this
parameter but didn't use it. __btrfs_set_acl() is the low-level helper
that writes an ACL to disk. The higher-level btrfs_set_acl() is the one
that translates the ACL based on the user namespace.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

