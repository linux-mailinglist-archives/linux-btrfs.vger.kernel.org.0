Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9388D7C4176
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjJJUlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJJUlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:15 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FCDDE
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7be88e9ccso14561787b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696970472; x=1697575272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ubwOKPnw/IU4g90S+kgqMqAvosFRnP9dYqQa/ogHNg=;
        b=IsgsZQ53c2ojlz4XL8cwdY0o08WZpPXIKBe0B1nn+50H16Sh3BBg2Shl/YhN5QltyM
         YuHIcONRdMn/rQmIJ5MamwgOOhpWK6AEJoTcWHgQJIY0FaBzawfanoWdRZ/oqr8wfQbB
         PFBFM7UP0JSXdn3rBlT9vjglFIxBIkwCk3tJtyA6xdGiBsNJ3IpLfaLnWxZqAsA6LB9L
         4r5HuQlehIjPNg4JfQtnkAfLBDx5oSAoSPJhusCcTXBJSsRk/XyV+NpuH/rVh6OEIdKi
         3FTu76qTbwmUB+78UdO2lytbsYBVzccuZObr1k1M/shqeeuOrzhksYIq+5/4ahs93krf
         PPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970472; x=1697575272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ubwOKPnw/IU4g90S+kgqMqAvosFRnP9dYqQa/ogHNg=;
        b=eCSQBLRpzTAYf8qcTUkZyf30hKb+LDKpeJ9pHhs9Lneq8a/cK3XDCcSWmtgA7XPhdk
         S4yYy0S5kgjoLkJuJZLVeT30q7th8gIAD7SxguxuPAbUApIZchKVF6z9VXANjSqCUYu2
         OvoVds857QClYGhfU7m0S8WncqtifbQABpoIYQ8zj7LaNXR9OUFct7LO0cV32oVxiriF
         KLDD1wXewxcWE5gEaUAVFhQfw0Kkcvk3u8xELxuJG6bGuOJblsRDWD3ft+a5jKQYuCHr
         xKMTK4RohDUhWb/AU2nawFod06dSNnzfFBbIpkodcg5MEyxNjum07DCS+jJZXKiDR7v9
         2Xrg==
X-Gm-Message-State: AOJu0YxSt+RtAe1UutSlvhiVltE3vBOagM3JNm5Yg6ygzJTxcnHeQLxi
        LLHsSt6DiNLp8vSzt/29zUW4FQ==
X-Google-Smtp-Source: AGHT+IH0MlH/PDspUNysTV3KeSuwCl0LUpu4ueM813c521XL7wiLcvRf96YhXEAhQolyRKkNPb4LdQ==
X-Received: by 2002:a81:a156:0:b0:5a7:dbf4:6a1a with SMTP id y83-20020a81a156000000b005a7dbf46a1amr350771ywg.7.1696970471523;
        Tue, 10 Oct 2023 13:41:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v203-20020a8148d4000000b005a7c00bdc79sm696290ywa.49.2023.10.10.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:41:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-fscrypt@vger.kernel.org, ebiggers@kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 06/36] fscrypt: expose fscrypt_nokey_name
Date:   Tue, 10 Oct 2023 16:40:21 -0400
Message-ID: <5f7c3adb304bc3b5263af215f6b476275fdecc47.1696970227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696970227.git.josef@toxicpanda.com>
References: <cover.1696970227.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index a3576da6a9fa..9a7cd1e2146e 100644
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

