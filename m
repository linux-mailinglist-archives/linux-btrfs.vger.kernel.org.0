Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBD57F256
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiGXAyk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbiGXAyg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:36 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62B167C1;
        Sat, 23 Jul 2022 17:54:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 09E71807A4;
        Sat, 23 Jul 2022 20:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624075; bh=COQBy9pOcpCvnrHMZE0Cv+NvvD5RaLx8uFecu+F6YvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCvubZAl+wjui1LUJYulFHf5hUb22aD3J9T8q8zI7F3j6hVmPS6MypQJb7IYknFNG
         hPfvqLWn2bnW6JAbCwQ/2X2d3RRE620yRbbwXZFe/+zEicOECn7nNV0OgI8mJv5cKw
         iv5j3Qcqq8NXBjwnyutBgJ/qZ3RByWUg+PTVskrBgP12pLTLQVd7uyzS4vZgvn/4pZ
         b4DCdcpcbJopFmb0RXuYzYYeW7Y5ZuAPyJL5ZlwmvuX7YicEz5JN3ZGcA4wcLQNYv1
         hyIT+LIC1/4iQq3qdZV+eOpgTIoDv/4o96FY+tStQ+p8YhpUJDwBJhfVWfUHAZfEIK
         x3Hsb4qreRSeg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 06/16] btrfs: add fscrypt operation table to superblock
Date:   Sat, 23 Jul 2022 20:53:51 -0400
Message-Id: <95482e35f5ea655d1d09172c24245fc416698463.1658623319.git.sweettea-kernel@dorminy.me>
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

From: Omar Sandoval <osandov@osandov.com>

To use fscrypt_prepare_new_inode(), the superblock must have fscrypt
operations registered.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
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

