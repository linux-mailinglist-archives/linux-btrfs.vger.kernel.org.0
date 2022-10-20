Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9C606674
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJTQ7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJTQ7H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:07 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ADA1C2F33;
        Thu, 20 Oct 2022 09:59:06 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 40DE3811BE;
        Thu, 20 Oct 2022 12:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1666285145; bh=6JC0+mWJqGTMpvKCsgFkL1LrgyiUyxbniwczcUOG8oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQsd/L1b0jTcgZmxH+Py+izHuesaHsYLPiO1/OzDYjU99JImXMW1hIY0AFJ6Oj40e
         4H7AlDuJnppkVuZhZpFKucdYvNcr4YS2CCaFuVBDx0TXf1ZW27/SKTFLbdhH897evz
         Y7tB/9qAXKDDcftVaOn3TsNlVndehCpTe4I0Y6rbvEkT4hX2jHROl1FhP3DCgAbmLb
         wcIk0etmCE5J9BB6RrQQDkp6OJoVVk47dz+Jtpw6fw76fVtNLwc7g2tCYKHOP3OvPn
         cI5yifzwVxJ3HmINq0oyBU0TWpcrb0gDX6GoTVJXMt76srtgegjCxxBpl1NPRAWxSP
         vRRY3RVmau0zA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 03/22] fscrypt: allow fscrypt_generate_iv() to distinguish filenames
Date:   Thu, 20 Oct 2022 12:58:22 -0400
Message-Id: <020efb334cd6dab01dd711665db8d32e77aaebf8.1666281277.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1666281276.git.sweettea-kernel@dorminy.me>
References: <cover.1666281276.git.sweettea-kernel@dorminy.me>
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

For extent-based file contents encryption, filenames will need to
generate an IV based on the inode context, while file contents will need
to generate an IV based on the extent context. Currently filenames and
the first block of file contents both pass fscrypt_generate_iv() a block
number of 0, making it hard to distinguish the two cases.

To enable distinguishing these two cases for extent-based encryption,
this change adjusts all callers to pass U64_MAX when requesting an IV
for filename encryption, and then changes fscrypt_generate_iv() to
convert U64_MAX to 0 for traditional inode-context encryption. For
extent-based encryption, any block number other than U64_MAX will get an
IV from the extent context, while U64_MAX will indicate falling back to
inode contexts.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/crypto/crypto.c | 9 ++++++++-
 fs/crypto/fname.c  | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index e78be66bbf01..7fe5979fbea2 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
 /*
  * Generate the IV for the given logical block number within the given file.
- * For filenames encryption, lblk_num == 0.
+ * For filenames encryption, lblk_num == U64_MAX.
  *
  * Keep this in sync with fscrypt_limit_io_blocks().  fscrypt_limit_io_blocks()
  * needs to know about any IV generation methods where the low bits of IV don't
@@ -84,6 +84,13 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 
 	memset(iv, 0, ci->ci_mode->ivsize);
 
+	/*
+	 * Filename encryption. For inode-based policies, filenames are
+	 * encrypted as though they are lblk 0.
+	 */
+	if (lblk_num == U64_MAX)
+		lblk_num = 0;
+
 	if (flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
 		WARN_ON_ONCE(lblk_num > U32_MAX);
 		WARN_ON_ONCE(ci->ci_inode->i_ino > U32_MAX);
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 6c092a1533f7..b3e7e3a66312 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -79,7 +79,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 	memset(out + iname->len, 0, olen - iname->len);
 
 	/* Initialize the IV */
-	fscrypt_generate_iv(&iv, 0, ci);
+	fscrypt_generate_iv(&iv, U64_MAX, ci);
 
 	/* Set up the encryption request */
 	req = skcipher_request_alloc(tfm, GFP_NOFS);
@@ -134,7 +134,7 @@ static int fname_decrypt(const struct inode *inode,
 		crypto_req_done, &wait);
 
 	/* Initialize IV */
-	fscrypt_generate_iv(&iv, 0, ci);
+	fscrypt_generate_iv(&iv, U64_MAX, ci);
 
 	/* Create decryption request */
 	sg_init_one(&src_sg, iname->name, iname->len);
-- 
2.35.1

