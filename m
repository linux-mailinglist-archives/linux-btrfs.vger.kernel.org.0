Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D177AF231
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjIZSD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjIZSD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:03:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54F194
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4cbab83aaso4462223a34.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695751399; x=1696356199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myCIPHzyNpBOvcVkJC2tcaUDQBmAcGT4ntRHF6CAG2Q=;
        b=PKr2jF+aTS7QKck4YBjXmELd0IonZD8UnEI3H6BYHM+YUi7hvznAyHqeF5ET5OtYbl
         6bAosxADyKtkjtLeBVNjcmxa4zpHxZt2/OyRnlnurTGzdRGPXZo8zGORCbWtP+ODD0uK
         LRHCoN03DTcTq5RrlAJ0kWjyz5KLUNj8VgRk3bFq/o2q3TXFI7kPNDojXWUYMapB7OOz
         dDpPjD+YvjE8uzu5KuTsSs7g2MUGNiYWZ8cVxfVhUcndMlYVE0cZTZmUNJZNq41/r3J8
         iuQggHp/sCK1IfoTnMdVd0rMnycGzYnky8TrPbaIGWE9dNZs3d9rKZ4s2wkZ9HSC1/ey
         bL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751399; x=1696356199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myCIPHzyNpBOvcVkJC2tcaUDQBmAcGT4ntRHF6CAG2Q=;
        b=r+Iu2U8bLAAaIqGeS9quqofjX7kXamiCgX6Ljilsndc3XrmVx6z+w0TBgEIwj8ix11
         /lbX/0c95Vs6jROjHlBUyzan5DSucxIN0j5EDv3jSJVO+HS3Xv8DO1ALRvmiLnKG62nY
         k8i/s+HzyCycRlGMyuicjBx40cisE8VXXIQh93U9tgp1MMyia43/vjgN7E/n3janv/nj
         ersO/yG6ly6yu5jJ3NvFCX1fOqVO2Rz/LanPcKWiBKAcaidybk/d3BlyxrjW0U7FoR4i
         NybRhRtjHUEtp17GqyS7OlQH47kiRRvaY9vUcCkOVpSqBprG+8LW+rDlztTO2QymBgYi
         Ib2Q==
X-Gm-Message-State: AOJu0YwOTrsl7pDojSLvvtnNUnHwEQsE7AzLnKHPukQ8mB6keKfEiItA
        wcmLwqyDp+wx+DMB6b0nILyLvWr8c5nyzkTOf3zXDA==
X-Google-Smtp-Source: AGHT+IHvt82gmLlmiZ6OkuSubOdiMVUWAVbjntRU0qeCeZkB5mUCczZLR3bdNVNjIsQClTLSurTZJA==
X-Received: by 2002:a05:6830:20c7:b0:6bc:9078:81c8 with SMTP id z7-20020a05683020c700b006bc907881c8mr11125113otq.20.1695751399248;
        Tue, 26 Sep 2023 11:03:19 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mn12-20020a0562145ecc00b0065af252fe88sm3567618qvb.63.2023.09.26.11.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:03:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        ebiggers@kernel.org, linux-fscrypt@vger.kernel.org,
        ngompa13@gmail.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 05/35] fscrypt: expose fscrypt_nokey_name
Date:   Tue, 26 Sep 2023 14:01:31 -0400
Message-ID: <5f28dbfb50cf7a7beca6f0ca2f27ffe2c9366038.1695750478.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695750478.git.josef@toxicpanda.com>
References: <cover.1695750478.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

btrfs stores its data structures, including filenames in directories, in
its own buffer implementation, struct extent_buffer, composed of
several non-contiguous pages. We could copy filenames into a
temporary buffer and use fscrypt_match_name() against that buffer, such
extensive memcpying would be expensive. Instead, exposing
fscrypt_nokey_name as in this change allows btrfs to recapitulate
fscrypt_match_name() using methods on struct extent_buffer instead of
dealing with a raw byte array.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/fname.c       | 39 +--------------------------------------
 include/linux/fscrypt.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 7b3fc189593a..5607ee52703e 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -14,7 +14,6 @@
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
 #include <crypto/hash.h>
-#include <crypto/sha2.h>
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
@@ -26,43 +25,7 @@
 #define FSCRYPT_FNAME_MIN_MSG_LEN 16
 
 /*
- * struct fscrypt_nokey_name - identifier for directory entry when key is absent
- *
- * When userspace lists an encrypted directory without access to the key, the
- * filesystem must present a unique "no-key name" for each filename that allows
- * it to find the directory entry again if requested.  Naively, that would just
- * mean using the ciphertext filenames.  However, since the ciphertext filenames
- * can contain illegal characters ('\0' and '/'), they must be encoded in some
- * way.  We use base64url.  But that can cause names to exceed NAME_MAX (255
- * bytes), so we also need to use a strong hash to abbreviate long names.
- *
- * The filesystem may also need another kind of hash, the "dirhash", to quickly
- * find the directory entry.  Since filesystems normally compute the dirhash
- * over the on-disk filename (i.e. the ciphertext), it's not computable from
- * no-key names that abbreviate the ciphertext using the strong hash to fit in
- * NAME_MAX.  It's also not computable if it's a keyed hash taken over the
- * plaintext (but it may still be available in the on-disk directory entry);
- * casefolded directories use this type of dirhash.  At least in these cases,
- * each no-key name must include the name's dirhash too.
- *
- * To meet all these requirements, we base64url-encode the following
- * variable-length structure.  It contains the dirhash, or 0's if the filesystem
- * didn't provide one; up to 149 bytes of the ciphertext name; and for
- * ciphertexts longer than 149 bytes, also the SHA-256 of the remaining bytes.
- *
- * This ensures that each no-key name contains everything needed to find the
- * directory entry again, contains only legal characters, doesn't exceed
- * NAME_MAX, is unambiguous unless there's a SHA-256 collision, and that we only
- * take the performance hit of SHA-256 on very long filenames (which are rare).
- */
-struct fscrypt_nokey_name {
-	u32 dirhash[2];
-	u8 bytes[149];
-	u8 sha256[SHA256_DIGEST_SIZE];
-}; /* 189 bytes => 252 bytes base64url-encoded, which is <= NAME_MAX (255) */
-
-/*
- * Decoded size of max-size no-key name, i.e. a name that was abbreviated using
+ * Decoded size of max-size nokey name, i.e. a name that was abbreviated using
  * the strong hash and thus includes the 'sha256' field.  This isn't simply
  * sizeof(struct fscrypt_nokey_name), as the padding at the end isn't included.
  */
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 07493ad2588b..44dc10837499 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/blk-crypto.h>
+#include <crypto/sha2.h>
 #include <uapi/linux/fscrypt.h>
 
 /*
@@ -56,6 +57,42 @@ struct fscrypt_name {
 #define fname_name(p)		((p)->disk_name.name)
 #define fname_len(p)		((p)->disk_name.len)
 
+/*
+ * struct fscrypt_nokey_name - identifier for directory entry when key is absent
+ *
+ * When userspace lists an encrypted directory without access to the key, the
+ * filesystem must present a unique "no-key name" for each filename that allows
+ * it to find the directory entry again if requested.  Naively, that would just
+ * mean using the ciphertext filenames.  However, since the ciphertext filenames
+ * can contain illegal characters ('\0' and '/'), they must be encoded in some
+ * way.  We use base64url.  But that can cause names to exceed NAME_MAX (255
+ * bytes), so we also need to use a strong hash to abbreviate long names.
+ *
+ * The filesystem may also need another kind of hash, the "dirhash", to quickly
+ * find the directory entry.  Since filesystems normally compute the dirhash
+ * over the on-disk filename (i.e. the ciphertext), it's not computable from
+ * no-key names that abbreviate the ciphertext using the strong hash to fit in
+ * NAME_MAX.  It's also not computable if it's a keyed hash taken over the
+ * plaintext (but it may still be available in the on-disk directory entry);
+ * casefolded directories use this type of dirhash.  At least in these cases,
+ * each no-key name must include the name's dirhash too.
+ *
+ * To meet all these requirements, we base64url-encode the following
+ * variable-length structure.  It contains the dirhash, or 0's if the filesystem
+ * didn't provide one; up to 149 bytes of the ciphertext name; and for
+ * ciphertexts longer than 149 bytes, also the SHA-256 of the remaining bytes.
+ *
+ * This ensures that each no-key name contains everything needed to find the
+ * directory entry again, contains only legal characters, doesn't exceed
+ * NAME_MAX, is unambiguous unless there's a SHA-256 collision, and that we only
+ * take the performance hit of SHA-256 on very long filenames (which are rare).
+ */
+struct fscrypt_nokey_name {
+	u32 dirhash[2];
+	u8 bytes[149];
+	u8 sha256[SHA256_DIGEST_SIZE];
+}; /* 189 bytes => 252 bytes base64url-encoded, which is <= NAME_MAX (255) */
+
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
-- 
2.41.0

