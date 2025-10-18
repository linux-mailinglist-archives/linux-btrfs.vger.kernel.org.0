Return-Path: <linux-btrfs+bounces-17985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383ABEC762
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC698353475
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D01284884;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huiEMKil"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E02641FB;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762182; cv=none; b=LtrJtTgz+cqApQ3m5D5CFhJmsQpzJy4VZSqlbpXOmp1CHvnOy9pPbnFYjmKrbgXcFF7Vzz62L+WXrDdXl+K0XdZlso8+1Vw6iGIi76NWnFgmTxo/MAjY4f6RejucwYIaq1nAkonetF7qEc00Mwo/MYahFf2fWCypMv0KNXbz+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762182; c=relaxed/simple;
	bh=H2r2uS0vfeLAotRiFDRZo0+NWMO7YTMGMpSXPOAEWyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdZ/+QMCtGcgNduFx+5adXxupGr0jZHsOrWQvsBqHlfeOs/p9r2vMZMxD7G2bekC+i7/uNHF/mRWSOBCsH1kVYCZ2FJ7zU8tdZfDs9hyWsMYKEFk7CLmUNoYt2ebeUVZCMxgQLiAmRISYMawIskkaLJsAuSh7LpcvQ4zXzHIke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huiEMKil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A83C4CEFB;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762182;
	bh=H2r2uS0vfeLAotRiFDRZo0+NWMO7YTMGMpSXPOAEWyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huiEMKilQMldYlADDkZxoXV24XTDU4pFEWY7vkIk8tv1ID+lL8Va0h6CAFQ0bhJDp
	 vPmQcSrRTRkOJqvxyWVLapd/CtIuJZ49Pf0C4YJ9k+qmh4KYVnLNy2f6tO5tKZ01Fv
	 YY83DUY+1cTGCJhijsXuVi16IKHXDW8k+5A+jYUgqRb63+LH8wdgBtBAKFvVpaOAMz
	 LCnDl7/9m8Vg1W7LsrJEfZS0z4AuWgS8mDCu/uO+fqXVu8xzD0VBRPbCPtgtHX+QBo
	 70YKPK2YtwEbNAcFct+ri6HQZD8m1tIdYk9rBEVcbxi5wx6Q3hYrDwE6nbhfABBTAo
	 kfQPZpTbI6qKQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 04/10] lib/crypto: blake2s: Document the BLAKE2s library API
Date: Fri, 17 Oct 2025 21:31:00 -0700
Message-ID: <20251018043106.375964-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>
References: <20251018043106.375964-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kerneldoc for the BLAKE2s library API.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/crypto/blake2s.h | 58 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index 33893057eb414..648cb78243588 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -20,10 +20,19 @@ enum blake2s_lengths {
 	BLAKE2S_160_HASH_SIZE = 20,
 	BLAKE2S_224_HASH_SIZE = 28,
 	BLAKE2S_256_HASH_SIZE = 32,
 };
 
+/**
+ * struct blake2s_ctx - Context for hashing a message with BLAKE2s
+ * @h: compression function state
+ * @t: block counter
+ * @f: finalization indicator
+ * @buf: partial block buffer; 'buflen' bytes are valid
+ * @buflen: number of bytes buffered in @buf
+ * @outlen: length of output hash value in bytes, at most BLAKE2S_HASH_SIZE
+ */
 struct blake2s_ctx {
 	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
 	u32 h[8];
 	u32 t[2];
 	u32 f[2];
@@ -65,27 +74,76 @@ static inline void __blake2s_init(struct blake2s_ctx *ctx, size_t outlen,
 		memset(&ctx->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
 		ctx->buflen = BLAKE2S_BLOCK_SIZE;
 	}
 }
 
+/**
+ * blake2s_init() - Initialize a BLAKE2s context for a new message (unkeyed)
+ * @ctx: the context to initialize
+ * @outlen: length of output hash value in bytes, at most BLAKE2S_HASH_SIZE
+ *
+ * Context: Any context.
+ */
 static inline void blake2s_init(struct blake2s_ctx *ctx, size_t outlen)
 {
 	__blake2s_init(ctx, outlen, NULL, 0);
 }
 
+/**
+ * blake2s_init_key() - Initialize a BLAKE2s context for a new message (keyed)
+ * @ctx: the context to initialize
+ * @outlen: length of output hash value in bytes, at most BLAKE2S_HASH_SIZE
+ * @key: the key
+ * @keylen: the key length in bytes, at most BLAKE2S_KEY_SIZE
+ *
+ * Context: Any context.
+ */
 static inline void blake2s_init_key(struct blake2s_ctx *ctx, size_t outlen,
 				    const void *key, size_t keylen)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
 		!key || !keylen || keylen > BLAKE2S_KEY_SIZE));
 
 	__blake2s_init(ctx, outlen, key, keylen);
 }
 
+/**
+ * blake2s_update() - Update a BLAKE2s context with message data
+ * @ctx: the context to update; must have been initialized
+ * @in: the message data
+ * @inlen: the data length in bytes
+ *
+ * This can be called any number of times.
+ *
+ * Context: Any context.
+ */
 void blake2s_update(struct blake2s_ctx *ctx, const u8 *in, size_t inlen);
+
+/**
+ * blake2s_final() - Finish computing a BLAKE2s hash
+ * @ctx: the context to finalize; must have been initialized
+ * @out: (output) the resulting BLAKE2s hash.  Its length will be equal to the
+ *	 @outlen that was passed to blake2s_init() or blake2s_init_key().
+ *
+ * After finishing, this zeroizes @ctx.  So the caller does not need to do it.
+ *
+ * Context: Any context.
+ */
 void blake2s_final(struct blake2s_ctx *ctx, u8 *out);
 
+/**
+ * blake2s() - Compute BLAKE2s hash in one shot
+ * @key: the key, or NULL for an unkeyed hash
+ * @keylen: the key length in bytes (at most BLAKE2S_KEY_SIZE), or 0 for an
+ *	    unkeyed hash
+ * @in: the message data
+ * @inlen: the data length in bytes
+ * @out: (output) the resulting BLAKE2s hash, with length @outlen
+ * @outlen: length of output hash value in bytes, at most BLAKE2S_HASH_SIZE
+ *
+ * Context: Any context.
+ */
 static inline void blake2s(const u8 *key, size_t keylen,
 			   const u8 *in, size_t inlen,
 			   u8 *out, size_t outlen)
 {
 	struct blake2s_ctx ctx;
-- 
2.51.1.dirty


