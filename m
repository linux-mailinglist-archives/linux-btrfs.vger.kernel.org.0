Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD437573443
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiGMKbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiGMKbD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:03 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F191BFC9A9
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:02 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 15F9F81123;
        Wed, 13 Jul 2022 06:31:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708262; bh=6MCJ+e5/PWfvm4utkrpeR7F142iqBtAIuLdFWHDFdkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLk1vdq6kzC10JsSdwFbBizpuDmz/7xfl9YT6Y1/S1D49+KdDv9CAAEi9iqf3TXlz
         +gzstzehPvHiVXdV/FWpgl97YHY3ivIugB6/qLQTBjX7qaw+TirERVHIJCAh0ACjnD
         igDjY/JoM32ZLX9kc9RfzhhLuA4ybj9b2nwXIUumdQXXAI1fgsTNipXesslsTdE7bC
         HsW2HIkv+puc8sPow3DTNZfG9pULEzORBuL+i1cPLndx3wVSvCeUfxsbn7kzHiKlTy
         lfrPmDor9FN20DoNHuKYFDeuQpEPUOk1c2Azz9mQn95NAgx8pLY8mECtEniUHbG1UP
         dx6QFwfGKsQYQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 11/23] fscrypt: add fscrypt_have_same_policy() to check inode's compatibility
Date:   Wed, 13 Jul 2022 06:29:44 -0400
Message-Id: <98d767bfecf4c88b2cf40d2ad202ae89a2663811.1657707687.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

btrfs will have the possibility of encrypted and unencrypted files in
the same directory, and it's important to not allow these two files to
become linked together. Therefore, add a function which allows checking
the encryption policies of two inodes to ensure they are compatible.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/policy.c      | 26 ++++++++++++++++++++++++++
 include/linux/fscrypt.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 5f858cee1e3b..5763462af9e8 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -407,6 +407,32 @@ static int fscrypt_get_policy(struct inode *inode, union fscrypt_policy *policy)
 	return fscrypt_policy_from_context(policy, &ctx, ret);
 }
 
+/**
+ * fscrypt_have_same_policy() - check whether two inodes have the same policy
+ * @inode1: the first inode
+ * @inode2: the second inode
+ *
+ * Return: %true if equal, else %false
+ */
+int fscrypt_have_same_policy(struct inode *inode1, struct inode *inode2)
+{
+	union fscrypt_policy policy1, policy2;
+	int err;
+
+	if (!IS_ENCRYPTED(inode1) && !IS_ENCRYPTED(inode2))
+		return true;
+	else if (!IS_ENCRYPTED(inode1) || !IS_ENCRYPTED(inode2))
+		return false;
+	err = fscrypt_get_policy(inode1, &policy1);
+	if (err)
+		return err;
+	err = fscrypt_get_policy(inode2, &policy2);
+	if (err)
+		return err;
+	return fscrypt_policies_equal(&policy1, &policy2);
+}
+EXPORT_SYMBOL(fscrypt_have_same_policy);
+
 static int set_encryption_policy(struct inode *inode,
 				 const union fscrypt_policy *policy)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 70d8a710ad39..f3d1f5438a6c 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -322,6 +322,7 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
 void fscrypt_free_bounce_page(struct page *bounce_page);
 
 /* policy.c */
+int fscrypt_have_same_policy(struct inode *inode1, struct inode *inode2);
 int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg);
 int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg);
 int fscrypt_ioctl_get_policy_ex(struct file *filp, void __user *arg);
-- 
2.35.1

