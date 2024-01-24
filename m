Return-Path: <linux-btrfs+bounces-1689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A066583AF92
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6801BB2A9A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C374823D6;
	Wed, 24 Jan 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vEWmGDll"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A481AD7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116771; cv=none; b=K3x+B382sx9/F9HYuL0ccecv3E56ZXXhbCN6vPNKTm6DvSxM3GD5pparuphSVeixNTACfLRmkoWz1R1X0Wic1G536Vn6XeUDMqHVhMTAHwBWFEF3DWOMt8YZcsYe2Cl2RmwhMF7FJtZrsJA1wTn01GhjCM5m8rNu6IHPrDOhSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116771; c=relaxed/simple;
	bh=Uu7YV5yLr+hEql+nzXLoNu2mALbE3xnZm69CLggz7r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTeZXo/Nw9EARGCh5jl5J/YkQhAEAyxc0CWVwdbMFLgGX1DrEO3fkIJBL6ccbTCWWa6l0ZdjsxjKsD9j4v+YOd0P/CdBBJE2G7TkQ3Ix2BG/XWnjAXcF5ONQSrX2UhKZWpkkIMYjXXyfWOts7zx3RuNPk9MnXnFeDo+lGQcaEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vEWmGDll; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4734497276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116769; x=1706721569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpViKIiaU00vd91Jd8ebfAvhrj8KwHij6IqIKuBGBFs=;
        b=vEWmGDlls+cxq28XlcsssZVUXouHcvlekkWm39ZZ+SKsXcW2O4KQqJO/fCSLZKlzda
         qRk6ldHtxs4lPZdFfkdxxHvnIxTK3OnREXbuOhKfn+WZV/Uq5OaE7OHRDQdCVa3BznHN
         cli+qrkgL1+r+aso64kye+5I3nQqKl6tdfGGPqbpVv9sL6u7WRq6hKIcYswLoDaDr3In
         BP1fd4uyUNwJP2Z7zjRnvASdi4VnBsfruJrNwM+VjHpR3hsumirRJADzH03K7A0g3DVq
         ngsEI1dF96bc3xtEAczo7U7VvAXqNsHM7+qWJEDHYfGDiBZJ67H/Amg6u9RT7WTcGYTW
         yPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116769; x=1706721569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpViKIiaU00vd91Jd8ebfAvhrj8KwHij6IqIKuBGBFs=;
        b=gZ2+rCJq08c9AMrTicLme/yDtr5oS26ZVZ6W+GEfTHvmLZ5RUDIWIQ52OXtvhaM4DR
         Ng0nF+C9wY0CGMv77ttPe9RXGOz0m0iLaEjyWOPzlzXHxi5+bowGjDJ3R8BwjgjSGAWl
         W7VW0BJA8PYaDF33E+n2DHILOToLhP1loGRx6IlxBsRYDe1npIQFoyGNNq1+rhTkv6Zm
         caE/9aoNof4Ujld9U376RNQSbdTBr0ypKQag6eQT6E8moucaRx+8064dKfSvMoYS/nnZ
         PfzS7jhVcSgsl5P+EX+cSWIacfjOvrfkTVK4g6mlzDEi9Ka8KVCeKSrEMDWkNeeZIQEH
         GKNg==
X-Gm-Message-State: AOJu0YwWz0oGofUtWf7nYzwJLNK7tappfbdAcYYB/zOEs/mb+Ii3uUc/
	yJc2Y+Hl/d6x9jdw1cInhxyS6ooBmWyZHGwnfhflqXlRQFZ2Yaul4iReYNS1GRXnJt50Kwq1iUP
	+
X-Google-Smtp-Source: AGHT+IE6+aUQj2Vu/z1LuyBy5pWU9s8FQ1RxgYLn7+HV7gzojx2HElf2LVFdGXHnSD4XDTeUfIjl9Q==
X-Received: by 2002:a81:52d3:0:b0:5ff:7f14:a5af with SMTP id g202-20020a8152d3000000b005ff7f14a5afmr748320ywb.16.1706116768678;
        Wed, 24 Jan 2024 09:19:28 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i5-20020a815405000000b005de8c10f283sm61461ywb.102.2024.01.24.09.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:28 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 07/52] fscrypt: expose fscrypt_nokey_name
Date: Wed, 24 Jan 2024 12:18:29 -0500
Message-ID: <132b64edf1e6b705995fb1a6dc2f194527f6be75.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 fs/crypto/fname.c       | 36 ------------------------------------
 include/linux/fscrypt.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 7b3fc189593a..3e8210036f15 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -25,42 +25,6 @@
  */
 #define FSCRYPT_FNAME_MIN_MSG_LEN 16
 
-/*
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
 /*
  * Decoded size of max-size no-key name, i.e. a name that was abbreviated using
  * the strong hash and thus includes the 'sha256' field.  This isn't simply
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index ea3033956208..fc8b2156e444 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -56,6 +56,42 @@ struct fscrypt_name {
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
+	u8 sha256[32];
+}; /* 189 bytes => 252 bytes base64url-encoded, which is <= NAME_MAX (255) */
+
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
-- 
2.43.0


