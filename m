Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F760BFD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 02:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJYAmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 20:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJYAmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 20:42:15 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16AEC522;
        Mon, 24 Oct 2022 16:13:47 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 94250811C2;
        Mon, 24 Oct 2022 19:13:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666653227; bh=bQnVPUnphhuCqvAhgs3/Ij/GwJw0o3dzTZwjyhzzuUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SMOsbUa1OY9SRwmo++5XKUo5ElzOj4D367lRwmbJG7qTCDEhr9fvqz7p0wsxiP4Bs
         DQmuW+e3KX6HK70U/SGHVjRWpL74HXSwVJvsN0CdhxGoBq+1YRzZezn08c0e/vneYa
         6EPK2c+Pky3jI0X/Hav3eiHOB/4xsitc2A+JrXZl9MViEpeAlx6NJWOgSnM7PF4xuc
         N1BTpha+EE+F45NP92RmKKsOJndi1dTJd3zKFUiCmQq/rsLIhBM2ShEfk/VxDGYDYY
         1SeIe6vA7Y7tTQDqJLe+XSm9c51fQIdu8imH08yRMuSWaFF4OXEW+7OmaKghJiOwYB
         Xksidtjv6+FKA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 05/21] fscrypt: direct key policies for extent-based encryption
Date:   Mon, 24 Oct 2022 19:13:15 -0400
Message-Id: <a48008c957f988edc3b4bd4dcbc4281078c66ba3.1666651724.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1666651724.git.sweettea-kernel@dorminy.me>
References: <cover.1666651724.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For inode-based direct key encryption policies, the inode provides a
nonce, and the encryption IV is generated by concatenating the nonce and
the offset into the inode. For extent-based direct key policies,
however, we would like to use 16-byte nonces in combination with various
AES modes with 16-byte IVs. Additionally, since contents and filenames
are encrypted with different context items in this case, we don't need
to require the encryption modes match in the two cases.

This change allows extent-based encryption to use 16-byte IVs with
direct key policies, and allows a mismatch of modes (under the usual
compatible modes constraints).

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c          | 15 +++++++++++++--
 fs/crypto/fscrypt_private.h |  4 +---
 fs/crypto/policy.c          |  4 ++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 08b495dc5c0c..144a3a59ce51 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -93,8 +93,19 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 		ret = fscrypt_get_extent_context(inode, lblk_num, &ctx,
 						 &extent_offset, NULL);
 		WARN_ON_ONCE(ret);
-		memcpy(iv->raw, ctx.v1.iv.raw, sizeof(*iv));
-		iv->lblk_num += cpu_to_le64(extent_offset);
+		if (ci->ci_mode->ivsize < offsetofend(union fscrypt_iv, nonce)) {
+			/*
+			 *  We need a 16 byte IV, but our nonce is 16 bytes.
+			 *  Copy to the start of the buffer and add the extent
+			 *  offset manually.
+			 */
+			memcpy(iv->raw, ctx.v1.nonce, FSCRYPT_FILE_NONCE_SIZE);
+			iv->lblk_num = cpu_to_le64(extent_offset +
+						   le64_to_cpu(iv->lblk_num));
+			return;
+		}
+		memcpy(iv->nonce, ctx.v1.nonce, FSCRYPT_FILE_NONCE_SIZE);
+		iv->lblk_num = cpu_to_le64(extent_offset);
 		return;
 	}
 
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 9c4cae2580de..bb2a18c83e56 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -292,7 +292,6 @@ union fscrypt_iv {
 	__le64 dun[FSCRYPT_MAX_IV_SIZE / sizeof(__le64)];
 };
 
-
 /*
  * fscrypt_extent_context - the encryption context for an extent
  *
@@ -304,7 +303,7 @@ union fscrypt_iv {
  */
 struct fscrypt_extent_context_v1 {
 	u8 version;
-	union fscrypt_iv iv;
+	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 } __packed;
 
 union fscrypt_extent_context {
@@ -312,7 +311,6 @@ union fscrypt_extent_context {
 	struct fscrypt_extent_context_v1 v1;
 };
 
-
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci);
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 4a86b80e7c0b..15653933f19e 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -91,6 +91,10 @@ static bool supported_direct_key_modes(const struct inode *inode,
 {
 	const struct fscrypt_mode *mode;
 
+	/* Extent-based encryption allows any mixed mode and IV size */
+	if (inode->i_sb->s_cop->get_extent_context)
+		return true;
+
 	if (contents_mode != filenames_mode) {
 		fscrypt_warn(inode,
 			     "Direct key flag not allowed with different contents and filenames modes");
-- 
2.35.1

