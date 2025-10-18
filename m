Return-Path: <linux-btrfs+bounces-17981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD967BEC756
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110746E22C9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4A1261B99;
	Sat, 18 Oct 2025 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7y0asHm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F3849C;
	Sat, 18 Oct 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762182; cv=none; b=SZd6XKEepNitt0dTRhKIcQrSeItkw8iDyT/SfOifTcExNMIhtWQOLaO7lQZuzH5hN+uYUCTl0m4gh3wkXiDAQGn9Y+djLbgHTcwFXKwsASIkXVfohRF4FAvbw2D1CZyPpQceQfvooKepDAcOOo8qKP7NTZSaAQepMlRj6GaFxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762182; c=relaxed/simple;
	bh=kOA606aVAxE3TRQL8vdaWgZTVsUeiIEnVCeGBkLNdAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndEaNXlJ1we+kT2kRg1h9byM8eQphiwRpaaNcurqObT/ig+csBUccbXhRD9rJ1OJk0811CMVIFcsq2gSLO+uj9NKeABHn6cjH17jVw1LsMLEvoOxkJmglFaS9lVrfYGmwAcTAbnFBSIGFP5y2oM5dza854/k6Mh1KcNCWiipS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7y0asHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46851C4CEFB;
	Sat, 18 Oct 2025 04:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762181;
	bh=kOA606aVAxE3TRQL8vdaWgZTVsUeiIEnVCeGBkLNdAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7y0asHmyTunCL4AmckL+PNdC1+gTenLrPulzo6YOURTc2c7Wj3HYaqpL21IlQdLU
	 +duonXPinkg91//UbfrIboDlUMOOSOeQLj6+KqAeDMiGSp+XiuwFJ+RE4h0MjsBhB0
	 K4or7pKkv/BEM9lBGMo75UX3WRdXx87ym4GQBbjyxg7pqp9eW4fg7Ll76xpXV/MPEv
	 47KFjEACtS6ACRKS77T59L+XVB94NeJ3p5uPJp4BAqkDvg7U1X+LbfGP5jN6evDdNe
	 jLJnSeqDp7CKP/RKYvEzyjRbr5RirAEGZuRPylKbc5qW0027KvbBaoW5y377/8tD2l
	 SZorri/6Cqh2Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 01/10] lib/crypto: blake2s: Adjust parameter order of blake2s()
Date: Fri, 17 Oct 2025 21:30:57 -0700
Message-ID: <20251018043106.375964-2-ebiggers@kernel.org>
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

Reorder the parameters of blake2s() from (out, in, key, outlen, inlen,
keylen) to (key, keylen, in, inlen, out, outlen).

This aligns BLAKE2s with the common conventions of pairing buffers and
their lengths, and having outputs follow inputs.  This is widely used
elsewhere in lib/crypto/ and crypto/, and even elsewhere in the BLAKE2s
code itself such as blake2s_init_key() and blake2s_final().  So
blake2s() was a bit of an exception.

Notably, this results in the same order as hmac_*_usingrawkey().

Note that since the type signature changed, it's not possible for a
blake2s() call site to be silently missed.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/char/random.c            |  4 ++--
 drivers/net/wireguard/cookie.c   |  4 ++--
 drivers/net/wireguard/noise.c    |  4 ++--
 include/crypto/blake2s.h         |  6 +++---
 lib/crypto/tests/blake2s_kunit.c | 16 ++++++++--------
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6ed3fe4..422c5c76571b9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -699,21 +699,21 @@ static void extract_entropy(void *buf, size_t len)
 	/* seed = HASHPRF(last_key, entropy_input) */
 	blake2s_final(&input_pool.hash, seed);
 
 	/* next_key = HASHPRF(seed, RDSEED || 0) */
 	block.counter = 0;
-	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block), sizeof(seed));
+	blake2s(seed, sizeof(seed), (const u8 *)&block, sizeof(block), next_key, sizeof(next_key));
 	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE, next_key, sizeof(next_key));
 
 	spin_unlock_irqrestore(&input_pool.lock, flags);
 	memzero_explicit(next_key, sizeof(next_key));
 
 	while (len) {
 		i = min_t(size_t, len, BLAKE2S_HASH_SIZE);
 		/* output = HASHPRF(seed, RDSEED || ++counter) */
 		++block.counter;
-		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), sizeof(seed));
+		blake2s(seed, sizeof(seed), (const u8 *)&block, sizeof(block), buf, i);
 		len -= i;
 		buf += i;
 	}
 
 	memzero_explicit(seed, sizeof(seed));
diff --git a/drivers/net/wireguard/cookie.c b/drivers/net/wireguard/cookie.c
index 94d0a7206084e..be1b83aae03bf 100644
--- a/drivers/net/wireguard/cookie.c
+++ b/drivers/net/wireguard/cookie.c
@@ -75,19 +75,19 @@ void wg_cookie_init(struct cookie *cookie)
 static void compute_mac1(u8 mac1[COOKIE_LEN], const void *message, size_t len,
 			 const u8 key[NOISE_SYMMETRIC_KEY_LEN])
 {
 	len = len - sizeof(struct message_macs) +
 	      offsetof(struct message_macs, mac1);
-	blake2s(mac1, message, key, COOKIE_LEN, len, NOISE_SYMMETRIC_KEY_LEN);
+	blake2s(key, NOISE_SYMMETRIC_KEY_LEN, message, len, mac1, COOKIE_LEN);
 }
 
 static void compute_mac2(u8 mac2[COOKIE_LEN], const void *message, size_t len,
 			 const u8 cookie[COOKIE_LEN])
 {
 	len = len - sizeof(struct message_macs) +
 	      offsetof(struct message_macs, mac2);
-	blake2s(mac2, message, cookie, COOKIE_LEN, len, COOKIE_LEN);
+	blake2s(cookie, COOKIE_LEN, message, len, mac2, COOKIE_LEN);
 }
 
 static void make_cookie(u8 cookie[COOKIE_LEN], struct sk_buff *skb,
 			struct cookie_checker *checker)
 {
diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
index 7eb9a23a3d4d9..306abb876c805 100644
--- a/drivers/net/wireguard/noise.c
+++ b/drivers/net/wireguard/noise.c
@@ -33,12 +33,12 @@ static atomic64_t keypair_counter = ATOMIC64_INIT(0);
 
 void __init wg_noise_init(void)
 {
 	struct blake2s_state blake;
 
-	blake2s(handshake_init_chaining_key, handshake_name, NULL,
-		NOISE_HASH_LEN, sizeof(handshake_name), 0);
+	blake2s(NULL, 0, handshake_name, sizeof(handshake_name),
+		handshake_init_chaining_key, NOISE_HASH_LEN);
 	blake2s_init(&blake, NOISE_HASH_LEN);
 	blake2s_update(&blake, handshake_init_chaining_key, NOISE_HASH_LEN);
 	blake2s_update(&blake, identifier_name, sizeof(identifier_name));
 	blake2s_final(&blake, handshake_init_hash);
 }
diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index f9ffd39194eb8..a7dd678725b27 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -84,13 +84,13 @@ static inline void blake2s_init_key(struct blake2s_state *state,
 }
 
 void blake2s_update(struct blake2s_state *state, const u8 *in, size_t inlen);
 void blake2s_final(struct blake2s_state *state, u8 *out);
 
-static inline void blake2s(u8 *out, const u8 *in, const u8 *key,
-			   const size_t outlen, const size_t inlen,
-			   const size_t keylen)
+static inline void blake2s(const u8 *key, const size_t keylen,
+			   const u8 *in, const size_t inlen,
+			   u8 *out, const size_t outlen)
 {
 	struct blake2s_state state;
 
 	WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
 		outlen > BLAKE2S_HASH_SIZE || keylen > BLAKE2S_KEY_SIZE ||
diff --git a/lib/crypto/tests/blake2s_kunit.c b/lib/crypto/tests/blake2s_kunit.c
index 057c40132246f..247bbdf7dc864 100644
--- a/lib/crypto/tests/blake2s_kunit.c
+++ b/lib/crypto/tests/blake2s_kunit.c
@@ -12,11 +12,11 @@
  */
 
 static void blake2s_default(const u8 *data, size_t len,
 			    u8 out[BLAKE2S_HASH_SIZE])
 {
-	blake2s(out, data, NULL, BLAKE2S_HASH_SIZE, len, 0);
+	blake2s(NULL, 0, data, len, out, BLAKE2S_HASH_SIZE);
 }
 
 static void blake2s_init_default(struct blake2s_state *state)
 {
 	blake2s_init(state, BLAKE2S_HASH_SIZE);
@@ -50,11 +50,11 @@ static void test_blake2s_all_key_and_hash_lens(struct kunit *test)
 	rand_bytes_seeded_from_len(data, data_len);
 	blake2s_init(&main_state, BLAKE2S_HASH_SIZE);
 	for (int key_len = 0; key_len <= BLAKE2S_KEY_SIZE; key_len++) {
 		rand_bytes_seeded_from_len(key, key_len);
 		for (int out_len = 1; out_len <= BLAKE2S_HASH_SIZE; out_len++) {
-			blake2s(hash, data, key, out_len, data_len, key_len);
+			blake2s(key, key_len, data, data_len, hash, out_len);
 			blake2s_update(&main_state, hash, out_len);
 		}
 	}
 	blake2s_final(&main_state, main_hash);
 	KUNIT_ASSERT_MEMEQ(test, main_hash, blake2s_keyed_testvec_consolidated,
@@ -78,14 +78,14 @@ static void test_blake2s_with_guarded_key_buf(struct kunit *test)
 		struct blake2s_state state;
 
 		rand_bytes(key, key_len);
 		memcpy(guarded_key, key, key_len);
 
-		blake2s(hash1, test_buf, key,
-			BLAKE2S_HASH_SIZE, data_len, key_len);
-		blake2s(hash2, test_buf, guarded_key,
-			BLAKE2S_HASH_SIZE, data_len, key_len);
+		blake2s(key, key_len, test_buf, data_len,
+			hash1, BLAKE2S_HASH_SIZE);
+		blake2s(guarded_key, key_len, test_buf, data_len,
+			hash2, BLAKE2S_HASH_SIZE);
 		KUNIT_ASSERT_MEMEQ(test, hash1, hash2, BLAKE2S_HASH_SIZE);
 
 		blake2s_init_key(&state, BLAKE2S_HASH_SIZE,
 				 guarded_key, key_len);
 		blake2s_update(&state, test_buf, data_len);
@@ -105,12 +105,12 @@ static void test_blake2s_with_guarded_out_buf(struct kunit *test)
 	rand_bytes(test_buf, data_len);
 	for (int out_len = 1; out_len <= BLAKE2S_HASH_SIZE; out_len++) {
 		u8 hash[BLAKE2S_HASH_SIZE];
 		u8 *guarded_hash = &test_buf[TEST_BUF_LEN - out_len];
 
-		blake2s(hash, test_buf, NULL, out_len, data_len, 0);
-		blake2s(guarded_hash, test_buf, NULL, out_len, data_len, 0);
+		blake2s(NULL, 0, test_buf, data_len, hash, out_len);
+		blake2s(NULL, 0, test_buf, data_len, guarded_hash, out_len);
 		KUNIT_ASSERT_MEMEQ(test, hash, guarded_hash, out_len);
 	}
 }
 
 static struct kunit_case blake2s_test_cases[] = {
-- 
2.51.1.dirty


