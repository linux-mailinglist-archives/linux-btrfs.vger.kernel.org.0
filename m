Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736826B0E14
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjCHQED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 11:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjCHQDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 11:03:45 -0500
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8839B9D
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 08:01:54 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 05DC782477;
        Wed,  8 Mar 2023 11:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1678291272; bh=arlGtODBDc7cRV2joaGGPIkeR21yGPKb0z9yJBXHpKI=;
        h=From:To:Cc:Subject:Date:From;
        b=A/XWOhWQGj9U8xgn0mt5QgIo+dZqWdS110b6rgLncE61JInOE4zLluoLmni5T4/Wi
         zENYdWUOYoNjm+uyC1/AXZrQJ8uvFE0AsYfpqTeX52pKe24nJxGeEr4JYm8L+GzLi7
         Ir7OdoCuLaJVncE0RtMmGZCoq0oTzcFprzNlP0Ti45hjPR01x0MGtMGN/uVdPNKVI8
         y83UC5pRTxbGNWNAN76KahMTt97MdDNG9n5TD7GWO7I+mmuZd8wTOTiDtjU5XoLv9l
         5Iq/X0ZXQQG2l1DYGl5/MUvti82DU5GqCOoRRNC/zfKcNFZRAuD2HDvZXVKRVoHu80
         CEMOabfZVXbng==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] btrfs: fix compilation error on sparc/parisc
Date:   Wed,  8 Mar 2023 10:58:36 -0500
Message-Id: <dc091588d770923c3afe779e1eb512724662db71.1678290988.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 1ec49744ba83 ("btrfs: turn on -Wmaybe-uninitialized") exposed
that on sparc and parisc, gcc is unaware that fscrypt_setup_filename()
only returns negative error values or 0. This ultimately results in a
maybe-uninitialized warning in btrfs_lookup_dentry().

Change to only return negative error values or 0 from
fscrypt_setup_filename() at the relevant callsite, and assert that no
positive error codes are returned (which would have wider implications
involving other users).

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/481b19b5-83a0-4793-b4fd-194ad7b978c3@roeck-us.net/
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45102785c723..50178609f241 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5409,8 +5409,13 @@ static int btrfs_inode_by_name(struct btrfs_inode *dir, struct dentry *dentry,
 		return -ENOMEM;
 
 	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 1, &fname);
-	if (ret)
+	if (ret < 0)
 		goto out;
+	/*
+	 * fscrypt_setup_filename() should never return a positive value, but
+	 * gcc on sparc/parisc thinks it can, so assert that doesn't happen.
+	 */
+	ASSERT(ret == 0);
 
 	/* This needs to handle no-key deletions later on */
 
-- 
2.39.2

