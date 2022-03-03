Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284D4CC9F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiCCXUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiCCXUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:10 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290DA3B285
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e6so6004417pgn.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZMRcA/nkkrjVGlPpNGs4B0U5XQyrY4BMsA0jv2oD0E=;
        b=BNZ9eaOO7c9FQqMFUv/9wFxXD9GlD0tCDhM4ywlOLHt0zY+5lITa1TYhZLKjSKqga8
         6RIG7hOg5wgEPZqaMPjp2En+gRIArPyDcOfJyYKm0D08mxqs/SyoN5T0hIsYSzHFnFT2
         pul5bjRpb/6XHtwDMdvskQAqbZiZS/rUt4ynIC9Mt0bQfhCXT64HVrAFKgaX6fIen9lm
         YJAnvvRh3WNkokpDr/iKG8NvtesxGgokYwUx3vtEorPKLGmuSJWrBQi6iDB8YN5gT3J+
         mJ8K56LH1eJJSRyFw0SoiwP1z8MWnG3hd1cqvIYdUqgdPkosRBuesmmAlnZc/bYALZp8
         dsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZMRcA/nkkrjVGlPpNGs4B0U5XQyrY4BMsA0jv2oD0E=;
        b=UrQcK16Q06XtEL/aEErFxYaPmHa0aBpuPnJyawjyo7dHDNnFYFf3ETh557cn5dFEwy
         vmrLdcUoFWTPH2mB3QqwRPr+oVoZeUKzpcoBK4STer+/IwdZ2EzRcdrGxz53iRAU06iI
         uaLsh6jYCIi+PmzbpxUDA6D19dNHHjM+ZwB5Xx7ELs5+rWXsnudH2U/zjlyFgIsagcbm
         Bh/fcd5q0pnhmgz2/YQ6fTC82v6PDHqdhT3l718RCaPhy9pP+QqSL0vcLxzAOhvtCsgX
         i42E9VXxUkWEAHdnWjEt7A9qAF8wif43WROgTzTAHppONInH0AOAfIRoqxALn+El1jV8
         o01g==
X-Gm-Message-State: AOAM530Ha9g0xIPKBjnTaFk3sLsI2gzRLzzyuHjh+ANTcP0puTORy46h
        ra70BGbTkL0i9NJSyBFvHvCd/ZW7qP5JWg==
X-Google-Smtp-Source: ABdhPJxfF97yFD0RMFjwwNZZmUMi5/SMJFDobAxoOFDwyXgWZ8PBU1b6nUQF80CfBZyWocn/bcdm2Q==
X-Received: by 2002:a05:6a00:15cd:b0:4f6:6895:739b with SMTP id o13-20020a056a0015cd00b004f66895739bmr6319045pfu.60.1646349563346;
        Thu, 03 Mar 2022 15:19:23 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:23 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 03/12] btrfs: get rid of btrfs_add_nondir()
Date:   Thu,  3 Mar 2022 15:18:53 -0800
Message-Id: <1d1af5e40beeb1d9e67c3b78b8f97537e0c4cdc0.1646348486.git.osandov@fb.com>
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

This is a trivial wrapper around btrfs_add_link(). The only thing it
does other than moving arguments around is translating a > 0 return
value to -EEXIST. As far as I can tell, btrfs_add_link() won't return >
0 (and if it did, the existing callsites in, e.g., btrfs_mkdir() would
be broken). The check itself dates back to commit 2c90e5d65842 ("Btrfs:
still corruption hunting"), so it's probably left over from debugging.
Let's just get rid of btrfs_add_nondir().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index be51630160f5..9c838bdd51cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6355,18 +6355,6 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_add_nondir(struct btrfs_trans_handle *trans,
-			    struct btrfs_inode *dir, struct dentry *dentry,
-			    struct btrfs_inode *inode, int backref, u64 index)
-{
-	int err = btrfs_add_link(trans, dir, inode,
-				 dentry->d_name.name, dentry->d_name.len,
-				 backref, index);
-	if (err > 0)
-		err = -EEXIST;
-	return err;
-}
-
 static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
@@ -6413,8 +6401,8 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			0, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (err)
 		goto out_unlock;
 
@@ -6481,8 +6469,8 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			0, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (err)
 		goto out_unlock;
 
@@ -6541,8 +6529,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			1, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 1, index);
 
 	if (err) {
 		drop_inode = 1;
@@ -9324,8 +9312,8 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = btrfs_add_nondir(trans, BTRFS_I(dir), dentry,
-				BTRFS_I(inode), 0, index);
+	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (ret)
 		goto out;
 
@@ -9863,8 +9851,9 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 * elsewhere above.
 	 */
 	if (!err)
-		err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry,
-				BTRFS_I(inode), 0, index);
+		err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+				     dentry->d_name.name, dentry->d_name.len, 0,
+				     index);
 	if (err)
 		goto out_unlock;
 
-- 
2.35.1

