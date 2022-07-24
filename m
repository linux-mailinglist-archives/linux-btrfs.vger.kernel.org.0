Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81C57F255
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiGXAzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiGXAyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:46 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184517583;
        Sat, 23 Jul 2022 17:54:45 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 19CBC807A4;
        Sat, 23 Jul 2022 20:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624085; bh=TAg5/4aHXU1bFAJanLoEe80cY8bgO/5Yu5sEPkM7Jno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWemjfEfq8jOBAcylvbkDmQ2OAhLtO6W4TJskVpS7u4NqIsRPpQGn7YUTAz4jVokM
         9kTJG1ACiKra2pMoeLt0FYj9vA7l/fBF+4NrbGalTO4jwyRXKEJSH3qAJzOnJgGD/+
         yXTRGYUEH4qnvt/bSg29sgCY5ha2Rv1JC3wjx95NQ/Xv3FvnQm0dFnu0EgnouB/H32
         JbGni79XQUiawrak35iPm7SDSR+ptCKJTy7Xe/4m2rGgEjYi6kbAGkBcdAhVjHTHow
         ywU/ZEwoZsXl09y/qaR6Y0jcB3lWXiSc14qUAHktuytNLTg83r6nMakdX5+uHJy3WE
         dwNEeJOyTzNBA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 10/16] btrfs: add iv generation function for fscrypt
Date:   Sat, 23 Jul 2022 20:53:55 -0400
Message-Id: <fc6d7cdc524e0e5aee08e7b067f2e589626215a0.1658623319.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658623319.git.sweettea-kernel@dorminy.me>
References: <cover.1658623319.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As btrfs cannot use the standard inode or logical block based encryption
for data block encryption, it must provide a IV generation function and
users must use the IV_FROM_FS policy. For filenames, we can just use the
nonce that fscrypt stores per-inode, since these encrypted datum are not
shared between inodes; later on, we will store an IV per file extent,
and return it in this function for data encryption.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/fscrypt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 0e92acdac6d7..a11bf78c2a33 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -187,9 +187,21 @@ static bool btrfs_fscrypt_empty_dir(struct inode *inode)
 	return true;
 }
 
+static void btrfs_fscrypt_get_iv(u8 *iv, int ivsize, struct inode *inode,
+				 u64 lblk_num)
+{
+	/*
+	 * For encryption that doesn't involve extent data, juse use the
+	 * nonce already loaded into the iv buffer.
+	 */
+	return;
+}
+
 const struct fscrypt_operations btrfs_fscrypt_ops = {
+	.flags = FS_CFLG_ALLOW_PARTIAL,
 	.key_prefix = "btrfs:",
 	.get_context = btrfs_fscrypt_get_context,
 	.set_context = btrfs_fscrypt_set_context,
 	.empty_dir = btrfs_fscrypt_empty_dir,
+	.get_fs_defined_iv = btrfs_fscrypt_get_iv,
 };
-- 
2.35.1

