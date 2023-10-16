Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63AB7CB23B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjJPSWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjJPSWE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C58A2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:02 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77410032cedso344614085a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480521; x=1698085321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ubwOKPnw/IU4g90S+kgqMqAvosFRnP9dYqQa/ogHNg=;
        b=R82MS0EbHIUaKUkAptka6kKpTlfoyoMhFiNS8Hp7imjtIRC1IUX3Lwfr+RfENynWrG
         +y2hmd3Oy/piK8dh41a2bncRI/GntIJCFWqiL+sQCGv6kuZnfTOlLp/hyl8Oy1cBltsG
         7uxaIjsNWEfjJPSzzPT1PImg4k7kaYQ/YFI1XTBKuQkqQoMy53NXv5F+s8o0DSH9mXZa
         Zcv+bIfd0npPah5UY6b5vFVoEODtO/tuGOD3aoaSMYNibx01iy5UEjJH8NPc/XojlzWa
         TmYWU/JtWUNMFwQ3gCoX1gb78BXYRvU2bMXtfaEELZKvf56A+nlavXjuh+2EP13/sj8/
         71Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480521; x=1698085321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ubwOKPnw/IU4g90S+kgqMqAvosFRnP9dYqQa/ogHNg=;
        b=FUMm8TpeM0FQQRisHw5Ned/D1yAxL2GWae5QqjD1rrkkr1XoAWDD7O26Zl/6456qg5
         LfnxE+gx7sp75NMq1qyGIqGPxY7cwqLvAX1KRGI8oW28dKVOLJLBg94FqVdJXrDCoRF9
         89DWQ2qCJl1wRytg/8k1tX7mFmoM3ciSsADL3iOnXFBgewCcoKjMafJRVgq4mwkZ91Nk
         IGKJJ13qw15RFdMKoxlGfSKwD8Nm9wh0AfvUMoVaAauZbzpGwA7lSD7CbFnvsvFn6x3P
         KmS+iCUSfncixupIVnew6mEGOA98tuZ9wZkyKjFN4ogZrNcWq6XL+qD24cOyqQ/mDSal
         s6QQ==
X-Gm-Message-State: AOJu0YzSrbLBaG02VD4DZMudCNTmdU3aBteDK8yquDCimfuQlvtQ5I1K
        JYHhuYYjmwMW033mM+ZVmkBtO5ogxMncKOI/JeKuZg==
X-Google-Smtp-Source: AGHT+IHxa3WYiOYjWhcfQgcHDP8/OmA6Is7DfCY8R3YH7Qd1Ni3plIh9QqpoeC3PYdUz6ogFrwU5+Q==
X-Received: by 2002:a05:620a:170d:b0:767:f1de:293c with SMTP id az13-20020a05620a170d00b00767f1de293cmr42283020qkb.59.1697480521112;
        Mon, 16 Oct 2023 11:22:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k12-20020ae9f10c000000b007742c2ad7dfsm3174298qkg.73.2023.10.16.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3 04/34] fscrypt: expose fscrypt_nokey_name
Date:   Mon, 16 Oct 2023 14:21:11 -0400
Message-ID: <db29a41629ea1b88900525b49fef08e559657c3d.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
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

