Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF957344D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiGMKba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiGMKb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:31:28 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC4FD20A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:31:27 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E59D0802A1;
        Wed, 13 Jul 2022 06:31:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708287; bh=tBxdg+R0rmQtLfQGtJYt9PMrVuz4BaRzfoygAJm/H8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4eRCMNKttN58u1UDOGWB2LOs399Se4jX/B+MqmF7Bj3PP1QmNrvPHDS72IdPYtt5
         lieUR8dDBvr7iLtvFe4WuooznJgtmbtJ66kPLdpiH7Q55BtPV7VABfXvB4LtgGLKoU
         Fhb6vlK/cMqDO/+4SV1B1eiuxc8t7NnvPsWOS6l5ku5yHq8/8sk5jU8nmLsgAndktH
         zj4kecqY8UcuMTL9en5Yk3rzQSHatdKGP7VEFygJktcZKtyVrVvyJJ4KuIyA7BInhe
         KMhU6S2bXnaEdI07vY/sPFusv7HrecP7BLiCO8Xc9qcpYN5muQYqyQQQPLUgTw775/
         52Fjx4CS7H+Vg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 20/23] btrfs: reuse encrypted filename hash when possible.
Date:   Wed, 13 Jul 2022 06:29:53 -0400
Message-Id: <059bd4813915c875104c188a7c7b0bccd4b7da4b.1657707687.git.sweettea-kernel@dorminy.me>
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

For encrypted fscrypt_names, we can reuse fscrypt's precomputed hash of
the encrypted name to generate our own hash, instead of rehashing the
unencrypted name (which may not be possible if it's a nokey name).

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 522bb3452768..2c6baf6cd718 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2775,7 +2775,10 @@ static inline void btrfs_crc32c_final(u32 crc, u8 *result)
 
 static inline u64 btrfs_name_hash(struct fscrypt_name *name)
 {
-	return crc32c((u32)~1, fname_name(name), fname_len(name));
+	if (fname_name(name))
+		return crc32c((u32)~1, fname_name(name), fname_len(name));
+	else
+		return name->hash | ((u64)name->minor_hash << 32);
 }
 
 /*
@@ -2784,8 +2787,20 @@ static inline u64 btrfs_name_hash(struct fscrypt_name *name)
 static inline u64 btrfs_extref_hash(u64 parent_objectid,
 				    struct fscrypt_name *name)
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

