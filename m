Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17980573439
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiGMKbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGMKbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:10 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66AFB8DD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:08 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 21A27806E0;
        Wed, 13 Jul 2022 06:31:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708268; bh=76m7XqeFwSYU/5SFiP7vimnMTtvT/a0hy+gLNau89is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n273QGxN3dN9eQvRkBT+QNTVUAybUOGXk/g2TjTw4dFlFBpE4/n6eKGSmx6G49xPv
         NttIBWf8ZPie2MnHa0ZiCmh10Zrb5u7zRhlvgivh9zp5UGWj0wyMRNcyIRIEIS9Ssc
         0SwGW+DZWyeguGxOhgQXqQMbju27xCbSAs80+BVJRoZOvd1xwuoAq1aZkr23gS3ZtL
         jSl7xfNySmaGSrmJvJKzcMTY8l9fuiuUL0dyDUfysBK73NFsRUj9OjfmrxSV4sCEa7
         JHtNCW8a0zS1AeulYoHJ6EaYVzCZtGrioLQTh7WzNFNgdHJGVy3RNcvW7sr9o4KVdk
         KCnqBfVg+NasQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 13/23] btrfs: add fscrypt operation table to superblock
Date:   Wed, 13 Jul 2022 06:29:46 -0400
Message-Id: <cdb6d1a9af14296cfa48cc4826623e90f16efb59.1657707687.git.sweettea-kernel@dorminy.me>
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

To use fscrypt_prepare_new_inode(), the superblock must have fscrypt
operations registered.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/fscrypt.c | 3 +++
 fs/btrfs/fscrypt.h | 1 +
 fs/btrfs/super.c   | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
index 2ed844dd61d0..9829d280a6bc 100644
--- a/fs/btrfs/fscrypt.c
+++ b/fs/btrfs/fscrypt.c
@@ -30,3 +30,6 @@ bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
 			     de_name_len - sizeof(nokey_name->bytes), digest);
 	return !memcmp(digest, nokey_name->sha256, sizeof(digest));
 }
+
+const struct fscrypt_operations btrfs_fscrypt_ops = {
+};
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
index 7f24d12e6ee0..07884206c8a1 100644
--- a/fs/btrfs/fscrypt.h
+++ b/fs/btrfs/fscrypt.h
@@ -22,4 +22,5 @@ static bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
 }
 #endif
 
+extern const struct fscrypt_operations btrfs_fscrypt_ops;
 #endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 55af04fae075..e017e976c679 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -47,6 +47,8 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
+#include "fscrypt.h"
+
 #include "qgroup.h"
 #include "raid56.h"
 #define CREATE_TRACE_POINTS
@@ -1443,6 +1445,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_vop = &btrfs_verityops;
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
+	fscrypt_set_ops(sb, &btrfs_fscrypt_ops);
 	sb->s_time_gran = 1;
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
-- 
2.35.1

