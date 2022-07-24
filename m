Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7157F259
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiGXAzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbiGXAzF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 20:55:05 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1F1A3B9;
        Sat, 23 Jul 2022 17:54:53 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 20B9980BB8;
        Sat, 23 Jul 2022 20:54:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658624093; bh=tQkA6kJ/fCFGZgvfYo9gPeiRaxwV0FytgcRAx/xmXQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K407mVNVxWm2FHWCSlWISp7jXve+ywEy0YTTGzp+IFTXp8JHnmGpbT5KU5vjKRlD8
         AsvvOs34OZXjZ6w3658tqnGgq9QWxcT0WmwqXdY79vaoeO3MWuBRDLqN8cnxgoZZbR
         j6y40xoDbc49XcdrFE2fFwuog2sXHeputxqTCZQX9tBDEupOyIQfdO1LsOQfspUj7d
         HaH7GSIDjNzBb2eUy0vWxxDaas9ZiKfaNbXV2oGt26jSGzyJQ00yo9JNm1lEztQu3s
         5cT59UrfJkmL9vAPqv+RQOJaB0MBPCENaKMQm3TPh8ggODzaC5Cx4RiA3zl/0bGJ8C
         sgcqj9Z7vVNcQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH RFC v2 13/16] btrfs: reuse encrypted filename hash when possible.
Date:   Sat, 23 Jul 2022 20:53:58 -0400
Message-Id: <df842ac85f73901a6fb0717593a020e941e67e3b.1658623319.git.sweettea-kernel@dorminy.me>
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

For encrypted fscrypt_names, we can reuse fscrypt's precomputed hash of
the encrypted name to generate our own hash, instead of rehashing the
unencrypted name (which may not be possible if it's a nokey name).

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9fab4d33a326..30f390c01943 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2773,7 +2773,10 @@ static inline void btrfs_crc32c_final(u32 crc, u8 *result)
 
 static inline u64 btrfs_name_hash(const struct fscrypt_name *name)
 {
-	return crc32c((u32)~1, fname_name(name), fname_len(name));
+	if (fname_name(name))
+		return crc32c((u32)~1, fname_name(name), fname_len(name));
+	else
+		return name->hash | ((u64)name->minor_hash << 32);
 }
 
 /*
@@ -2782,8 +2785,20 @@ static inline u64 btrfs_name_hash(const struct fscrypt_name *name)
 static inline u64 btrfs_extref_hash(u64 parent_objectid,
 				    const struct fscrypt_name *name)
 {
-	return (u64) crc32c(parent_objectid, fname_name(name),
-			    fname_len(name));
+	/*
+	 * If the name is encrypted and we don't have the key, we can use the
+	 * fscrypt-provided hash instead of the normal name, and do the steps
+	 * of crc32c() manually. Else, just hash the name, parent objectid,
+	 * and name length.
+	 */
+	if (fname_name(name))
+		return (u64) crc32c(parent_objectid, fname_name(name),
+				    fname_len(name));
+	else
+		return (__crc32c_le_combine(parent_objectid,
+					    name->hash,
+					    fname_len(name)) ^
+			__crc32c_le_shift(~1, fname_len(name)));
 }
 
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
-- 
2.35.1

