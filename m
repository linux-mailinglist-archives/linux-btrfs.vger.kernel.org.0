Return-Path: <linux-btrfs+bounces-17983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F62BEC76E
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C14714EB0F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242032777FD;
	Sat, 18 Oct 2025 04:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUzWACHL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0302580D7;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762182; cv=none; b=flzhweAeotguOMxlLyci10j6RYRQnMRCyZ7EBiio4Uq2fRmwp/ZytrJqBRm91wvljpi7nS4rm2jblK5+jFlV5zccea/y4974BWqpjwjaCznjABEWnkTP/coSkszz8FneS3OQOK421Dt4deGdr59KbD6AMydW29Bh3hf5fp4kkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762182; c=relaxed/simple;
	bh=YZcAgKnq2bpCew6iW0md+IWe5LVPvNh33pHxbx/GhkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/8b9+MHYgCCuVUpfF56c9dvaA0JknD3kDHrq+ci343C50XuJcWRibO06lQVMhLgdUKSPRswvwqQ3S2NKOpPnmWpKCohmV1Z2q23ebk/dc0Ti0OgZFmjFi5aFPoL7YgbVuTnDFCv5Row0oIuLdclsNWlJr47zrFCv9E6r7zgskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUzWACHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C87C116C6;
	Sat, 18 Oct 2025 04:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762181;
	bh=YZcAgKnq2bpCew6iW0md+IWe5LVPvNh33pHxbx/GhkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUzWACHLyhVJaCRbyB9btRnQenZ8WpRhhzW8WtZ+9GFRLPD9PnGoXrPNHMEWdMSYq
	 US6SVjF+fmNE4+WnOh3uB1KQKHab71GUZg6/UCXVOZ1QvS3/+RjNhkTrzH5Wv/IJhU
	 0SN9f+VeehhEABIi5ER1vIRvYo6Y/m6NmtqOe0EtLphTR3pTYj18+24sSy66sWo7Zn
	 s+mp4oGyjyers0hFQUYyQ2o/1Ted9/wOzIKUcV0Rw4QY3JryY1UOQ71qAZtyq2f7S0
	 k9Fjw86jvKRohCqyqYopO1ZD34yDHqSM/N7PM5O/mHj+ouaNx1KGQLCvUNeh4YonMk
	 l0SGb3h3zR9vg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 02/10] lib/crypto: blake2s: Rename blake2s_state to blake2s_ctx
Date: Fri, 17 Oct 2025 21:30:58 -0700
Message-ID: <20251018043106.375964-3-ebiggers@kernel.org>
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

For consistency with the SHA-1, SHA-2, SHA-3 (in development), and MD5
library APIs, rename blake2s_state to blake2s_ctx.

As a refresher, the ctx name:

- Is a bit shorter.
- Avoids confusion with the compression function state, which is also
  often called the state (but is just part of the full context).
- Is consistent with OpenSSL.

Not a big deal, of course.  But consistency is nice.  With a BLAKE2b
library API about to be added, this is a convenient time to update this.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/char/random.c            |  2 +-
 drivers/net/wireguard/cookie.c   | 14 ++++----
 drivers/net/wireguard/noise.c    | 28 +++++++--------
 include/crypto/blake2s.h         | 59 ++++++++++++++++----------------
 lib/crypto/arm/blake2s-core.S    | 10 +++---
 lib/crypto/arm/blake2s.h         |  4 +--
 lib/crypto/blake2s.c             | 58 +++++++++++++++----------------
 lib/crypto/tests/blake2s_kunit.c | 23 ++++++-------
 lib/crypto/x86/blake2s.h         | 12 +++----
 9 files changed, 104 insertions(+), 106 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 422c5c76571b9..7e0486d8c51de 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -634,11 +634,11 @@ enum {
 	POOL_READY_BITS = POOL_BITS, /* When crng_init->CRNG_READY */
 	POOL_EARLY_BITS = POOL_READY_BITS / 2 /* When crng_init->CRNG_EARLY */
 };
 
 static struct {
-	struct blake2s_state hash;
+	struct blake2s_ctx hash;
 	spinlock_t lock;
 	unsigned int init_bits;
 } input_pool = {
 	.hash.h = { BLAKE2S_IV0 ^ (0x01010000 | BLAKE2S_HASH_SIZE),
 		    BLAKE2S_IV1, BLAKE2S_IV2, BLAKE2S_IV3, BLAKE2S_IV4,
diff --git a/drivers/net/wireguard/cookie.c b/drivers/net/wireguard/cookie.c
index be1b83aae03bf..08731b3fa32b7 100644
--- a/drivers/net/wireguard/cookie.c
+++ b/drivers/net/wireguard/cookie.c
@@ -31,11 +31,11 @@ static const u8 cookie_key_label[COOKIE_KEY_LABEL_LEN] __nonstring = "cookie--";
 
 static void precompute_key(u8 key[NOISE_SYMMETRIC_KEY_LEN],
 			   const u8 pubkey[NOISE_PUBLIC_KEY_LEN],
 			   const u8 label[COOKIE_KEY_LABEL_LEN])
 {
-	struct blake2s_state blake;
+	struct blake2s_ctx blake;
 
 	blake2s_init(&blake, NOISE_SYMMETRIC_KEY_LEN);
 	blake2s_update(&blake, label, COOKIE_KEY_LABEL_LEN);
 	blake2s_update(&blake, pubkey, NOISE_PUBLIC_KEY_LEN);
 	blake2s_final(&blake, key);
@@ -89,11 +89,11 @@ static void compute_mac2(u8 mac2[COOKIE_LEN], const void *message, size_t len,
 }
 
 static void make_cookie(u8 cookie[COOKIE_LEN], struct sk_buff *skb,
 			struct cookie_checker *checker)
 {
-	struct blake2s_state state;
+	struct blake2s_ctx blake;
 
 	if (wg_birthdate_has_expired(checker->secret_birthdate,
 				     COOKIE_SECRET_MAX_AGE)) {
 		down_write(&checker->secret_lock);
 		checker->secret_birthdate = ktime_get_coarse_boottime_ns();
@@ -101,19 +101,19 @@ static void make_cookie(u8 cookie[COOKIE_LEN], struct sk_buff *skb,
 		up_write(&checker->secret_lock);
 	}
 
 	down_read(&checker->secret_lock);
 
-	blake2s_init_key(&state, COOKIE_LEN, checker->secret, NOISE_HASH_LEN);
+	blake2s_init_key(&blake, COOKIE_LEN, checker->secret, NOISE_HASH_LEN);
 	if (skb->protocol == htons(ETH_P_IP))
-		blake2s_update(&state, (u8 *)&ip_hdr(skb)->saddr,
+		blake2s_update(&blake, (u8 *)&ip_hdr(skb)->saddr,
 			       sizeof(struct in_addr));
 	else if (skb->protocol == htons(ETH_P_IPV6))
-		blake2s_update(&state, (u8 *)&ipv6_hdr(skb)->saddr,
+		blake2s_update(&blake, (u8 *)&ipv6_hdr(skb)->saddr,
 			       sizeof(struct in6_addr));
-	blake2s_update(&state, (u8 *)&udp_hdr(skb)->source, sizeof(__be16));
-	blake2s_final(&state, cookie);
+	blake2s_update(&blake, (u8 *)&udp_hdr(skb)->source, sizeof(__be16));
+	blake2s_final(&blake, cookie);
 
 	up_read(&checker->secret_lock);
 }
 
 enum cookie_mac_state wg_cookie_validate_packet(struct cookie_checker *checker,
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 306abb876c805..1fe8468f0bef3 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -31,11 +31,11 @@ static u8 handshake_init_hash[NOISE_HASH_LEN] __ro_after_init;
 static u8 handshake_init_chaining_key[NOISE_HASH_LEN] __ro_after_init;
 static atomic64_t keypair_counter = ATOMIC64_INIT(0);
 
 void __init wg_noise_init(void)
 {
-	struct blake2s_state blake;
+	struct blake2s_ctx blake;
 
 	blake2s(NULL, 0, handshake_name, sizeof(handshake_name),
 		handshake_init_chaining_key, NOISE_HASH_LEN);
 	blake2s_init(&blake, NOISE_HASH_LEN);
 	blake2s_update(&blake, handshake_init_chaining_key, NOISE_HASH_LEN);
@@ -302,37 +302,37 @@ void wg_noise_set_static_identity_private_key(
 		static_identity->static_public, private_key);
 }
 
 static void hmac(u8 *out, const u8 *in, const u8 *key, const size_t inlen, const size_t keylen)
 {
-	struct blake2s_state state;
+	struct blake2s_ctx blake;
 	u8 x_key[BLAKE2S_BLOCK_SIZE] __aligned(__alignof__(u32)) = { 0 };
 	u8 i_hash[BLAKE2S_HASH_SIZE] __aligned(__alignof__(u32));
 	int i;
 
 	if (keylen > BLAKE2S_BLOCK_SIZE) {
-		blake2s_init(&state, BLAKE2S_HASH_SIZE);
-		blake2s_update(&state, key, keylen);
-		blake2s_final(&state, x_key);
+		blake2s_init(&blake, BLAKE2S_HASH_SIZE);
+		blake2s_update(&blake, key, keylen);
+		blake2s_final(&blake, x_key);
 	} else
 		memcpy(x_key, key, keylen);
 
 	for (i = 0; i < BLAKE2S_BLOCK_SIZE; ++i)
 		x_key[i] ^= 0x36;
 
-	blake2s_init(&state, BLAKE2S_HASH_SIZE);
-	blake2s_update(&state, x_key, BLAKE2S_BLOCK_SIZE);
-	blake2s_update(&state, in, inlen);
-	blake2s_final(&state, i_hash);
+	blake2s_init(&blake, BLAKE2S_HASH_SIZE);
+	blake2s_update(&blake, x_key, BLAKE2S_BLOCK_SIZE);
+	blake2s_update(&blake, in, inlen);
+	blake2s_final(&blake, i_hash);
 
 	for (i = 0; i < BLAKE2S_BLOCK_SIZE; ++i)
 		x_key[i] ^= 0x5c ^ 0x36;
 
-	blake2s_init(&state, BLAKE2S_HASH_SIZE);
-	blake2s_update(&state, x_key, BLAKE2S_BLOCK_SIZE);
-	blake2s_update(&state, i_hash, BLAKE2S_HASH_SIZE);
-	blake2s_final(&state, i_hash);
+	blake2s_init(&blake, BLAKE2S_HASH_SIZE);
+	blake2s_update(&blake, x_key, BLAKE2S_BLOCK_SIZE);
+	blake2s_update(&blake, i_hash, BLAKE2S_HASH_SIZE);
+	blake2s_final(&blake, i_hash);
 
 	memcpy(out, i_hash, BLAKE2S_HASH_SIZE);
 	memzero_explicit(x_key, BLAKE2S_BLOCK_SIZE);
 	memzero_explicit(i_hash, BLAKE2S_HASH_SIZE);
 }
@@ -429,11 +429,11 @@ static bool __must_check mix_precomputed_dh(u8 chaining_key[NOISE_HASH_LEN],
 	return true;
 }
 
 static void mix_hash(u8 hash[NOISE_HASH_LEN], const u8 *src, size_t src_len)
 {
-	struct blake2s_state blake;
+	struct blake2s_ctx blake;
 
 	blake2s_init(&blake, NOISE_HASH_LEN);
 	blake2s_update(&blake, hash, NOISE_HASH_LEN);
 	blake2s_update(&blake, src, src_len);
 	blake2s_final(&blake, hash);
diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index a7dd678725b27..4c8d532ee97b3 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -20,11 +20,11 @@ enum blake2s_lengths {
 	BLAKE2S_160_HASH_SIZE = 20,
 	BLAKE2S_224_HASH_SIZE = 28,
 	BLAKE2S_256_HASH_SIZE = 32,
 };
 
-struct blake2s_state {
+struct blake2s_ctx {
 	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
 	u32 h[8];
 	u32 t[2];
 	u32 f[2];
 	u8 buf[BLAKE2S_BLOCK_SIZE];
@@ -41,64 +41,63 @@ enum blake2s_iv {
 	BLAKE2S_IV5 = 0x9B05688CUL,
 	BLAKE2S_IV6 = 0x1F83D9ABUL,
 	BLAKE2S_IV7 = 0x5BE0CD19UL,
 };
 
-static inline void __blake2s_init(struct blake2s_state *state, size_t outlen,
+static inline void __blake2s_init(struct blake2s_ctx *ctx, size_t outlen,
 				  const void *key, size_t keylen)
 {
-	state->h[0] = BLAKE2S_IV0 ^ (0x01010000 | keylen << 8 | outlen);
-	state->h[1] = BLAKE2S_IV1;
-	state->h[2] = BLAKE2S_IV2;
-	state->h[3] = BLAKE2S_IV3;
-	state->h[4] = BLAKE2S_IV4;
-	state->h[5] = BLAKE2S_IV5;
-	state->h[6] = BLAKE2S_IV6;
-	state->h[7] = BLAKE2S_IV7;
-	state->t[0] = 0;
-	state->t[1] = 0;
-	state->f[0] = 0;
-	state->f[1] = 0;
-	state->buflen = 0;
-	state->outlen = outlen;
+	ctx->h[0] = BLAKE2S_IV0 ^ (0x01010000 | keylen << 8 | outlen);
+	ctx->h[1] = BLAKE2S_IV1;
+	ctx->h[2] = BLAKE2S_IV2;
+	ctx->h[3] = BLAKE2S_IV3;
+	ctx->h[4] = BLAKE2S_IV4;
+	ctx->h[5] = BLAKE2S_IV5;
+	ctx->h[6] = BLAKE2S_IV6;
+	ctx->h[7] = BLAKE2S_IV7;
+	ctx->t[0] = 0;
+	ctx->t[1] = 0;
+	ctx->f[0] = 0;
+	ctx->f[1] = 0;
+	ctx->buflen = 0;
+	ctx->outlen = outlen;
 	if (keylen) {
-		memcpy(state->buf, key, keylen);
-		memset(&state->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
-		state->buflen = BLAKE2S_BLOCK_SIZE;
+		memcpy(ctx->buf, key, keylen);
+		memset(&ctx->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
+		ctx->buflen = BLAKE2S_BLOCK_SIZE;
 	}
 }
 
-static inline void blake2s_init(struct blake2s_state *state,
-				const size_t outlen)
+static inline void blake2s_init(struct blake2s_ctx *ctx, const size_t outlen)
 {
-	__blake2s_init(state, outlen, NULL, 0);
+	__blake2s_init(ctx, outlen, NULL, 0);
 }
 
-static inline void blake2s_init_key(struct blake2s_state *state,
+static inline void blake2s_init_key(struct blake2s_ctx *ctx,
 				    const size_t outlen, const void *key,
 				    const size_t keylen)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
 		!key || !keylen || keylen > BLAKE2S_KEY_SIZE));
 
-	__blake2s_init(state, outlen, key, keylen);
+	__blake2s_init(ctx, outlen, key, keylen);
 }
 
-void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen);
-void blake2s_final(struct blake2s_state *state, u8 *out);
+void blake2s_update(struct blake2s_ctx *ctx, const u8 *in, size_t inlen);
+void blake2s_final(struct blake2s_ctx *ctx, u8 *out);
 
 static inline void blake2s(const u8 *key, const size_t keylen,
 			   const u8 *in, const size_t inlen,
 			   u8 *out, const size_t outlen)
 {
-	struct blake2s_state state;
+	struct blake2s_ctx ctx;
 
 	WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
 		outlen > BLAKE2S_HASH_SIZE || keylen > BLAKE2S_KEY_SIZE ||
 		(!key && keylen)));
 
-	__blake2s_init(&state, outlen, key, keylen);
-	blake2s_update(&state, in, inlen);
-	blake2s_final(&state, out);
+	__blake2s_init(&ctx, outlen, key, keylen);
+	blake2s_update(&ctx, in, inlen);
+	blake2s_final(&ctx, out);
 }
 
 #endif /* _CRYPTO_BLAKE2S_H */
diff --git a/lib/crypto/arm/blake2s-core.S b/lib/crypto/arm/blake2s-core.S
index 293f44fa8f316..78e758a7cb3e2 100644
--- a/lib/crypto/arm/blake2s-core.S
+++ b/lib/crypto/arm/blake2s-core.S
@@ -168,24 +168,24 @@
 				\s12, \s13, \s14, \s15
 	__strd		r10, r11, sp, 20
 .endm
 
 //
-// void blake2s_compress(struct blake2s_state *state,
+// void blake2s_compress(struct blake2s_ctx *ctx,
 //			 const u8 *block, size_t nblocks, u32 inc);
 //
-// Only the first three fields of struct blake2s_state are used:
+// Only the first three fields of struct blake2s_ctx are used:
 //	u32 h[8];	(inout)
 //	u32 t[2];	(inout)
 //	u32 f[2];	(in)
 //
 	.align		5
 ENTRY(blake2s_compress)
 	push		{r0-r2,r4-r11,lr}	// keep this an even number
 
 .Lnext_block:
-	// r0 is 'state'
+	// r0 is 'ctx'
 	// r1 is 'block'
 	// r3 is 'inc'
 
 	// Load and increment the counter t[0..1].
 	__ldrd		r10, r11, r0, 32
@@ -209,11 +209,11 @@ ENTRY(blake2s_compress)
 .Lcopy_block_done:
 	str		r1, [sp, #68]		// Update message pointer
 
 	// Calculate v[8..15].  Push v[9..15] onto the stack, and leave space
 	// for spilling v[8..9].  Leave v[8..9] in r8-r9.
-	mov		r14, r0			// r14 = state
+	mov		r14, r0			// r14 = ctx
 	adr		r12, .Lblake2s_IV
 	ldmia		r12!, {r8-r9}		// load IV[0..1]
 	__ldrd		r0, r1, r14, 40		// load f[0..1]
 	ldm		r12, {r2-r7}		// load IV[3..7]
 	eor		r4, r4, r10		// v[12] = IV[4] ^ t[0]
@@ -273,11 +273,11 @@ ENTRY(blake2s_compress)
 	stm		r14, {r0-r3}		// store new h[4..7]
 
 	// Advance to the next block, if there is one.  Note that if there are
 	// multiple blocks, then 'inc' (the counter increment amount) must be
 	// 64.  So we can simply set it to 64 without re-loading it.
-	ldm		sp, {r0, r1, r2}	// load (state, block, nblocks)
+	ldm		sp, {r0, r1, r2}	// load (ctx, block, nblocks)
 	mov		r3, #64			// set 'inc'
 	subs		r2, r2, #1		// nblocks--
 	str		r2, [sp, #8]
 	bne		.Lnext_block		// nblocks != 0?
 
diff --git a/lib/crypto/arm/blake2s.h b/lib/crypto/arm/blake2s.h
index aa7a97139ea74..ce009cd98de90 100644
--- a/lib/crypto/arm/blake2s.h
+++ b/lib/crypto/arm/blake2s.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 /* defined in blake2s-core.S */
-void blake2s_compress(struct blake2s_state *state, const u8 *block,
-		      size_t nblocks, u32 inc);
+void blake2s_compress(struct blake2s_ctx *ctx,
+		      const u8 *block, size_t nblocks, u32 inc);
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 5638ed9d882d8..1ad36cb29835f 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -27,41 +27,41 @@ static const u8 blake2s_sigma[10][16] = {
 	{ 13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10 },
 	{ 6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5 },
 	{ 10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0 },
 };
 
-static inline void blake2s_increment_counter(struct blake2s_state *state,
+static inline void blake2s_increment_counter(struct blake2s_ctx *ctx,
 					     const u32 inc)
 {
-	state->t[0] += inc;
-	state->t[1] += (state->t[0] < inc);
+	ctx->t[0] += inc;
+	ctx->t[1] += (ctx->t[0] < inc);
 }
 
 static void __maybe_unused
-blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
+blake2s_compress_generic(struct blake2s_ctx *ctx, const u8 *block,
 			 size_t nblocks, const u32 inc)
 {
 	u32 m[16];
 	u32 v[16];
 	int i;
 
 	WARN_ON(IS_ENABLED(DEBUG) &&
 		(nblocks > 1 && inc != BLAKE2S_BLOCK_SIZE));
 
 	while (nblocks > 0) {
-		blake2s_increment_counter(state, inc);
+		blake2s_increment_counter(ctx, inc);
 		memcpy(m, block, BLAKE2S_BLOCK_SIZE);
 		le32_to_cpu_array(m, ARRAY_SIZE(m));
-		memcpy(v, state->h, 32);
+		memcpy(v, ctx->h, 32);
 		v[ 8] = BLAKE2S_IV0;
 		v[ 9] = BLAKE2S_IV1;
 		v[10] = BLAKE2S_IV2;
 		v[11] = BLAKE2S_IV3;
-		v[12] = BLAKE2S_IV4 ^ state->t[0];
-		v[13] = BLAKE2S_IV5 ^ state->t[1];
-		v[14] = BLAKE2S_IV6 ^ state->f[0];
-		v[15] = BLAKE2S_IV7 ^ state->f[1];
+		v[12] = BLAKE2S_IV4 ^ ctx->t[0];
+		v[13] = BLAKE2S_IV5 ^ ctx->t[1];
+		v[14] = BLAKE2S_IV6 ^ ctx->f[0];
+		v[15] = BLAKE2S_IV7 ^ ctx->f[1];
 
 #define G(r, i, a, b, c, d) do { \
 	a += b + m[blake2s_sigma[r][2 * i + 0]]; \
 	d = ror32(d ^ a, 16); \
 	c += d; \
@@ -95,11 +95,11 @@ blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 
 #undef G
 #undef ROUND
 
 		for (i = 0; i < 8; ++i)
-			state->h[i] ^= v[i] ^ v[i + 8];
+			ctx->h[i] ^= v[i] ^ v[i + 8];
 
 		block += BLAKE2S_BLOCK_SIZE;
 		--nblocks;
 	}
 }
@@ -108,49 +108,49 @@ blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 #include "blake2s.h" /* $(SRCARCH)/blake2s.h */
 #else
 #define blake2s_compress blake2s_compress_generic
 #endif
 
-static inline void blake2s_set_lastblock(struct blake2s_state *state)
+static inline void blake2s_set_lastblock(struct blake2s_ctx *ctx)
 {
-	state->f[0] = -1;
+	ctx->f[0] = -1;
 }
 
-void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen)
+void blake2s_update(struct blake2s_ctx *ctx, const u8 *in, size_t inlen)
 {
-	const size_t fill = BLAKE2S_BLOCK_SIZE - state->buflen;
+	const size_t fill = BLAKE2S_BLOCK_SIZE - ctx->buflen;
 
 	if (unlikely(!inlen))
 		return;
 	if (inlen > fill) {
-		memcpy(state->buf + state->buflen, in, fill);
-		blake2s_compress(state, state->buf, 1, BLAKE2S_BLOCK_SIZE);
-		state->buflen = 0;
+		memcpy(ctx->buf + ctx->buflen, in, fill);
+		blake2s_compress(ctx, ctx->buf, 1, BLAKE2S_BLOCK_SIZE);
+		ctx->buflen = 0;
 		in += fill;
 		inlen -= fill;
 	}
 	if (inlen > BLAKE2S_BLOCK_SIZE) {
 		const size_t nblocks = DIV_ROUND_UP(inlen, BLAKE2S_BLOCK_SIZE);
-		blake2s_compress(state, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
+		blake2s_compress(ctx, in, nblocks - 1, BLAKE2S_BLOCK_SIZE);
 		in += BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 		inlen -= BLAKE2S_BLOCK_SIZE * (nblocks - 1);
 	}
-	memcpy(state->buf + state->buflen, in, inlen);
-	state->buflen += inlen;
+	memcpy(ctx->buf + ctx->buflen, in, inlen);
+	ctx->buflen += inlen;
 }
 EXPORT_SYMBOL(blake2s_update);
 
-void blake2s_final(struct blake2s_state *state, u8 *out)
+void blake2s_final(struct blake2s_ctx *ctx, u8 *out)
 {
 	WARN_ON(IS_ENABLED(DEBUG) && !out);
-	blake2s_set_lastblock(state);
-	memset(state->buf + state->buflen, 0,
-	       BLAKE2S_BLOCK_SIZE - state->buflen); /* Padding */
-	blake2s_compress(state, state->buf, 1, state->buflen);
-	cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
-	memcpy(out, state->h, state->outlen);
-	memzero_explicit(state, sizeof(*state));
+	blake2s_set_lastblock(ctx);
+	memset(ctx->buf + ctx->buflen, 0,
+	       BLAKE2S_BLOCK_SIZE - ctx->buflen); /* Padding */
+	blake2s_compress(ctx, ctx->buf, 1, ctx->buflen);
+	cpu_to_le32_array(ctx->h, ARRAY_SIZE(ctx->h));
+	memcpy(out, ctx->h, ctx->outlen);
+	memzero_explicit(ctx, sizeof(*ctx));
 }
 EXPORT_SYMBOL(blake2s_final);
 
 #ifdef blake2s_mod_init_arch
 static int __init blake2s_mod_init(void)
diff --git a/lib/crypto/tests/blake2s_kunit.c b/lib/crypto/tests/blake2s_kunit.c
index 247bbdf7dc864..6832d9aa7b82d 100644
--- a/lib/crypto/tests/blake2s_kunit.c
+++ b/lib/crypto/tests/blake2s_kunit.c
@@ -15,21 +15,21 @@ static void blake2s_default(const u8 *data, size_t len,
 			    u8 out[BLAKE2S_HASH_SIZE])
 {
 	blake2s(NULL, 0, data, len, out, BLAKE2S_HASH_SIZE);
 }
 
-static void blake2s_init_default(struct blake2s_state *state)
+static void blake2s_init_default(struct blake2s_ctx *ctx)
 {
-	blake2s_init(state, BLAKE2S_HASH_SIZE);
+	blake2s_init(ctx, BLAKE2S_HASH_SIZE);
 }
 
 /*
  * Generate the HASH_KUNIT_CASES using hash-test-template.h.  These test BLAKE2s
  * with a key length of 0 and a hash length of BLAKE2S_HASH_SIZE.
  */
 #define HASH blake2s_default
-#define HASH_CTX blake2s_state
+#define HASH_CTX blake2s_ctx
 #define HASH_SIZE BLAKE2S_HASH_SIZE
 #define HASH_INIT blake2s_init_default
 #define HASH_UPDATE blake2s_update
 #define HASH_FINAL blake2s_final
 #include "hash-test-template.h"
@@ -42,23 +42,23 @@ static void test_blake2s_all_key_and_hash_lens(struct kunit *test)
 {
 	const size_t data_len = 100;
 	u8 *data = &test_buf[0];
 	u8 *key = data + data_len;
 	u8 *hash = key + BLAKE2S_KEY_SIZE;
-	struct blake2s_state main_state;
+	struct blake2s_ctx main_ctx;
 	u8 main_hash[BLAKE2S_HASH_SIZE];
 
 	rand_bytes_seeded_from_len(data, data_len);
-	blake2s_init(&main_state, BLAKE2S_HASH_SIZE);
+	blake2s_init(&main_ctx, BLAKE2S_HASH_SIZE);
 	for (int key_len = 0; key_len <= BLAKE2S_KEY_SIZE; key_len++) {
 		rand_bytes_seeded_from_len(key, key_len);
 		for (int out_len = 1; out_len <= BLAKE2S_HASH_SIZE; out_len++) {
 			blake2s(key, key_len, data, data_len, hash, out_len);
-			blake2s_update(&main_state, hash, out_len);
+			blake2s_update(&main_ctx, hash, out_len);
 		}
 	}
-	blake2s_final(&main_state, main_hash);
+	blake2s_final(&main_ctx, main_hash);
 	KUNIT_ASSERT_MEMEQ(test, main_hash, blake2s_keyed_testvec_consolidated,
 			   BLAKE2S_HASH_SIZE);
 }
 
 /*
@@ -73,25 +73,24 @@ static void test_blake2s_with_guarded_key_buf(struct kunit *test)
 	for (int key_len = 0; key_len <= BLAKE2S_KEY_SIZE; key_len++) {
 		u8 key[BLAKE2S_KEY_SIZE];
 		u8 *guarded_key = &test_buf[TEST_BUF_LEN - key_len];
 		u8 hash1[BLAKE2S_HASH_SIZE];
 		u8 hash2[BLAKE2S_HASH_SIZE];
-		struct blake2s_state state;
+		struct blake2s_ctx ctx;
 
 		rand_bytes(key, key_len);
 		memcpy(guarded_key, key, key_len);
 
 		blake2s(key, key_len, test_buf, data_len,
 			hash1, BLAKE2S_HASH_SIZE);
 		blake2s(guarded_key, key_len, test_buf, data_len,
 			hash2, BLAKE2S_HASH_SIZE);
 		KUNIT_ASSERT_MEMEQ(test, hash1, hash2, BLAKE2S_HASH_SIZE);
 
-		blake2s_init_key(&state, BLAKE2S_HASH_SIZE,
-				 guarded_key, key_len);
-		blake2s_update(&state, test_buf, data_len);
-		blake2s_final(&state, hash2);
+		blake2s_init_key(&ctx, BLAKE2S_HASH_SIZE, guarded_key, key_len);
+		blake2s_update(&ctx, test_buf, data_len);
+		blake2s_final(&ctx, hash2);
 		KUNIT_ASSERT_MEMEQ(test, hash1, hash2, BLAKE2S_HASH_SIZE);
 	}
 }
 
 /*
diff --git a/lib/crypto/x86/blake2s.h b/lib/crypto/x86/blake2s.h
index b6d30d2fa045e..de360935b8204 100644
--- a/lib/crypto/x86/blake2s.h
+++ b/lib/crypto/x86/blake2s.h
@@ -9,40 +9,40 @@
 #include <asm/simd.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
-asmlinkage void blake2s_compress_ssse3(struct blake2s_state *state,
+asmlinkage void blake2s_compress_ssse3(struct blake2s_ctx *ctx,
 				       const u8 *block, const size_t nblocks,
 				       const u32 inc);
-asmlinkage void blake2s_compress_avx512(struct blake2s_state *state,
+asmlinkage void blake2s_compress_avx512(struct blake2s_ctx *ctx,
 					const u8 *block, const size_t nblocks,
 					const u32 inc);
 
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_ssse3);
 static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
 
-static void blake2s_compress(struct blake2s_state *state, const u8 *block,
+static void blake2s_compress(struct blake2s_ctx *ctx, const u8 *block,
 			     size_t nblocks, const u32 inc)
 {
 	/* SIMD disables preemption, so relax after processing each page. */
 	BUILD_BUG_ON(SZ_4K / BLAKE2S_BLOCK_SIZE < 8);
 
 	if (!static_branch_likely(&blake2s_use_ssse3) || !may_use_simd()) {
-		blake2s_compress_generic(state, block, nblocks, inc);
+		blake2s_compress_generic(ctx, block, nblocks, inc);
 		return;
 	}
 
 	do {
 		const size_t blocks = min_t(size_t, nblocks,
 					    SZ_4K / BLAKE2S_BLOCK_SIZE);
 
 		kernel_fpu_begin();
 		if (static_branch_likely(&blake2s_use_avx512))
-			blake2s_compress_avx512(state, block, blocks, inc);
+			blake2s_compress_avx512(ctx, block, blocks, inc);
 		else
-			blake2s_compress_ssse3(state, block, blocks, inc);
+			blake2s_compress_ssse3(ctx, block, blocks, inc);
 		kernel_fpu_end();
 
 		nblocks -= blocks;
 		block += blocks * BLAKE2S_BLOCK_SIZE;
 	} while (nblocks);
-- 
2.51.1.dirty


