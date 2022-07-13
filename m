Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104B57343D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiGMKaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiGMKai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:38 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF99AFC994
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:37 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E7CFB80025;
        Wed, 13 Jul 2022 06:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708237; bh=9fJU7whwY0k3RT5am0IMjorfCIjaTIc+WsQYac7/JLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFa2OzLGxz/kUq1WyiJySD2fjAD2r9D3mB2QyHJfGqt8ofDHoMgH9kJQYLlbUZy0n
         j6aWMMNn8+h0UiCnxFkjmOIwY5WMMRkcFu1HCNlqojj8TR3cBiNLSF0zYVSzZNBHBJ
         wlP7H3YWMz47TBrP1ZesEZmEzAwcrptD1ErrCCzWfC43d4+00I9Ixa584Y2awph0wz
         GGm3TA/Nug/Mp7zOvwzCdrSjJuTSMBSaK3+muo3kZofW/ttFrpNVXqH/bMeM+C8Yep
         F6Zz8mG0oLt7o+G79oeaGsHvKLgfOET51dBJoJDhAUGvoey+W34Z9VvE0jfTp607UJ
         dFWJVYA6DDbdg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 03/23] btrfs: add new FT_FSCRYPT flag for directories.
Date:   Wed, 13 Jul 2022 06:29:36 -0400
Message-Id: <afe4764f8fb826bc78dec8fdd883e040c8e9f738.1657707686.git.sweettea-kernel@dorminy.me>
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

The new FT_FSCRYPT indicates a (perhaps partially) encrypted directory,
which is orthogonal to file type; therefore, add the new flag, and make
conversion from directory type to file type strip the flag.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 include/uapi/linux/btrfs_tree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 15b3f2d43f6c..428ae75b9f73 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -359,10 +359,12 @@ enum btrfs_csum_type {
 #define BTRFS_FT_SYMLINK	7
 #define BTRFS_FT_XATTR		8
 #define BTRFS_FT_MAX		9
+/* Name is encrypted. */
+#define BTRFS_FT_FSCRYPT_NAME	0x80
 
 static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
 {
-	return flags;
+	return flags & ~BTRFS_FT_FSCRYPT_NAME;
 }
 
 /*
-- 
2.35.1

