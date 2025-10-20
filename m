Return-Path: <linux-btrfs+bounces-18058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB8BF1D1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7704280DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911E323417;
	Mon, 20 Oct 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="A3hzCIp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BEF320A2C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970158; cv=none; b=kstkzCPo3krFlojR/auS9ffPOFvPIALuVsLru0+/bjr04UcpvztRuSJxMLQ18BkxuSED/w5NNFVdAvQutRswBojMozvj4lc5+4Wl8U1HkaWZnLUJlIiKcwfkB8CH5HUJovzKEahwSetPp9Uy6RJqOjm56SQ+0Txh5sC/oyBX+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970158; c=relaxed/simple;
	bh=zVDPi2NmZxQInX/GIfLgtCtgKG78R8OLu0rkid/eYv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zn+j6JPEYKlqb1Xrw1JzmpSAZpa3+XqAt99Vl69ndB8BU9t6Rlb6IiUY6r4Xl38LSIUjXmrb/2fMw1pyIwsnE8Qmj7orT8IXJTN/wF/iREw2s8xfNcMepJ+h3ZIj44WdzKhgLv8Pv+gFSRMwsiQCEwnjKpZ7vre3VZ0Hz3K1JlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=A3hzCIp6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36639c30bb7so39103701fa.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1760970154; x=1761574954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxGnzL84bOBveKtOjo7P4XxhPFp2ZO6oIYqNAjS+rn0=;
        b=A3hzCIp6o83N/f1BHNdDEheVfppO+VUPyiwv2q/uJpXLKzkvhPYPRFaRaqayvGrVUU
         eCUrMWZN3frZ/C2vT0uh1T38MYyNcElVnvJlP6LazEWDcXD5Q8okypDsgrpquN6uQG45
         VyoPyAi4o7NLQOPUjeemgqhpJeNW+HtLKBmog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970154; x=1761574954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxGnzL84bOBveKtOjo7P4XxhPFp2ZO6oIYqNAjS+rn0=;
        b=YKO8uvpRRf3b8dBTUM/inmJZWb865PiKCBdZJ6s0P0y7MiF8uW8XcJR7Z4Jkg9+KiA
         Lsv6ETxxz/eTIzCykWm8iWMuE/CFMR3rzWIjieJKyT+zih6CfgKmLKw4C6Z+afo3sIP9
         CB4tHwSFTPbCin5YA995iOmpUGoKxGwcWk9RXIufFT10SWqE2Su1qHIxtUh1898s0nVg
         471Cl+2Py8B/bC0Cv8A4W7/3R/fvQSzc4VkYlpCFQft9GU3jXugaWAYoQK2cP74Itv46
         /TwhYXTkGFbkjzugHaMz+jFs+7I0emeqT+qcWxUVLn3hy+iPg6wDh7dg4apMCwh1xi4j
         MDsA==
X-Gm-Message-State: AOJu0YwhMTEAYI/L0aQ82Dbmj3E7lMIMr0vN/H7ujW9KY4Zq2P6XC06H
	adbOfDUH37n7MlL4MYRY0F7cLtU+dp9RCzSxK/eIMKDaqMV9Sx01BNZ2ZP7rtly0gYTw0jDhYHp
	N+Q7VwYs=
X-Gm-Gg: ASbGncum9QGdESzSEInWIrNwHidAGkHAkx3X0ozRP0chedUfiHOYwZDZGE1iJmjoOhy
	N7GnJw7R52OkPiVkwsKfWVBVEpMnnHA6mb7mUrucci//Tb/QqoiFSaKk8Zq56oFmtN8Q66oyWFR
	uwHYLWciPJsWGi0mEeMWhZwBzgP/C3wnpzsFnadlUF1xtQWu1VDv9YViZzik8wMtL8q8Y0iAGBm
	2+TnA63+2FR6Oq4IhVV4V0MGOJuLCnC8J2y8BipaKJ3TPwR9tEsE8JOcb+m+WCYinAwy9j2wALl
	n0ORZ2cRs/h3l81heXkBnkoJJcLzCg8a1HczPCnxvlYTDeKRMoGwsAsepnCJEr9MlqJA4Qjw/yJ
	zFCIA5fKBfiK9gpY9aIb63lHph3JGMZEeHbB4xoHAqir2XTd8tYbj9hUnQOykdZeu2aFPNFyS56
	o+/f4PWdk7kY02PA==
X-Google-Smtp-Source: AGHT+IGb7T77vI29R8Q/U3A3JcdQs8FTAE7qJEZ47X10i86VYJPY3TK8jaZUwjb647q8hByJNP2BBQ==
X-Received: by 2002:a2e:bd86:0:b0:372:88fa:b680 with SMTP id 38308e7fff4ca-37797a3b322mr39705961fa.29.1760970154270;
        Mon, 20 Oct 2025 07:22:34 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950cb1dsm20951171fa.35.2025.10.20.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:22:34 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/2] btrfs: send: make use of -fms-extensions for defining struct fs_path
Date: Mon, 20 Oct 2025 16:22:28 +0200
Message-ID: <20251020142228.1819871-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly introduced -fms-extensions compiler flag allows defining
struct fs_path in such a way that inline_buf becomes a proper array
with a size known to the compiler.

This also makes the problem fixed by 8aec9dbf2db2 ("btrfs: send: fix
-Wflex-array-member-not-at-end warning in struct send_ctx") go
away. Whether cur_inode_path should be put back to its original place
in struct send_ctx I don't know, but at least the comment no longer
applies.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/btrfs/send.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6144e66661f5..1fe4a06e6850 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -47,28 +47,30 @@
  * It allows fast adding of path elements on the right side (normal path) and
  * fast adding to the left side (reversed path). A reversed path can also be
  * unreversed if needed.
+ *
+ * The definition of struct fs_path relies on -fms-extensions to allow
+ * including a tagged struct as an anonymous member.
  */
+struct __fs_path {
+	char *start;
+	char *end;
+
+	char *buf;
+	unsigned short buf_len:15;
+	unsigned short reversed:1;
+};
+static_assert(sizeof(struct __fs_path) < 256);
 struct fs_path {
-	union {
-		struct {
-			char *start;
-			char *end;
-
-			char *buf;
-			unsigned short buf_len:15;
-			unsigned short reversed:1;
-			char inline_buf[];
-		};
-		/*
-		 * Average path length does not exceed 200 bytes, we'll have
-		 * better packing in the slab and higher chance to satisfy
-		 * an allocation later during send.
-		 */
-		char pad[256];
-	};
+	struct __fs_path;
+	/*
+	 * Average path length does not exceed 200 bytes, we'll have
+	 * better packing in the slab and higher chance to satisfy
+	 * an allocation later during send.
+	 */
+	char inline_buf[256 - sizeof(struct __fs_path)];
 };
 #define FS_PATH_INLINE_SIZE \
-	(sizeof(struct fs_path) - offsetof(struct fs_path, inline_buf))
+	sizeof_field(struct fs_path, inline_buf)
 
 
 /* reused for each extent */
@@ -305,7 +307,6 @@ struct send_ctx {
 	struct btrfs_lru_cache dir_created_cache;
 	struct btrfs_lru_cache dir_utimes_cache;
 
-	/* Must be last as it ends in a flexible-array member. */
 	struct fs_path cur_inode_path;
 };
 
-- 
2.51.0


