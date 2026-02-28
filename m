Return-Path: <linux-btrfs+bounces-22109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L0xISqwomnk4wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22109-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 10:06:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C661C1964
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E5BB3038F3A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DAE3EFD0C;
	Sat, 28 Feb 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPBo45MT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043263F0744
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269600; cv=none; b=p4G15AYmRmNqhQr49I8bJMKUTXD7JuKIat/HA+vvsHtjwOZLSut3b9OvXwuVG/6LGMLbWKWRqyt/bVJspsBUm582ROdDEtHZAr67gPJZlbV1xozz/TdLIARka57215zjWYHUZ6HeuAMvFTfiZzUx5/hPxBpXK5B57fzpIxJT8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269600; c=relaxed/simple;
	bh=p8A1Dkwi3C0NzjV0IGFQxl3s0g7d6zP1w1h4b33L508=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4OGKGO5bYymC5FQJJgNz4j2inK/RRNlOSJRQPCSdd1ahDQO2/+nz+ODti09U9nP2PXAfX5+KDuki0T7wss8qml++kwskMYQNRBH8pRuGux4x3o/NAqs6wEQl0y7ekmZ1d1qh7JPctRFr47lCfNOsWLox3fOwDdJ9HvGKZnse1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPBo45MT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358fb86de36so2479734a91.1
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772269598; x=1772874398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAbrvZKE7mrL9ubvX/4PNKmQLVQgatjwm1rpQ10ifJk=;
        b=jPBo45MTPZwS9Bw7fdkEO9feP9TqwysHz1xqMJv7BloAwFvTWMjRBl1cjK8hurBGw5
         /VlHz4PCOd+b4ETjwfwVWVutDFWrfiIKoI9EhjvO1ZqulT9oQZIaeoEI+WWKD79ZdlwC
         6NQJiGKiz0aDmtcrJ9roehZKc1+iis+9jRk+NjWKJ9YzzNCv9rJvxzdDdTj3eWeAlRhS
         8f9maeBPgl2KJygGuJcoGU/nFRe521vVTXf+m6I8dGNgqyx98UoXTG+y7CsAQztGkqh7
         9ivXpP4tRNni36Ir+4QctplbKHl+uwHJIlyK8rtxo9gm+9Sj4PlJlk9QJ5BEwP+oLzHq
         HAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772269598; x=1772874398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAbrvZKE7mrL9ubvX/4PNKmQLVQgatjwm1rpQ10ifJk=;
        b=HWhC+skb4Ugm6rkReSfchGwcDRjlDLUshUHL0/NtyrNhIxBjyflir3+GYcjSaryiwx
         umDKQe71PWGbrvzJyqlUdxEgQou442h07h8udyehl8KhY8grGLZJjD2mYKp9cTb4t24X
         si/gxGjTL0hX7g/qhKyb//STsdE0VbqkOUZ4ENXUKyD7UYcv2cz3ez5teQjEkVXL5bpN
         g7ZlWwz0CJ+9VjolfEHax8Iw5x1OaMCR3EbfVtI1zNc9WTNcFEH/p7/L81S01ovmmXTA
         tfZK8PmqiXRENqMfh91IP5lkAVgHR7A4pblPzHSD8UMNy63bvkre4cZMCL6JAZjw0nfT
         MGnw==
X-Forwarded-Encrypted: i=1; AJvYcCUln89TR2V9zw0lOKVydsAtniEznYFJyWXd9o2UShXzJGr9/CIPMhCqspXmcIQaCAHohjGg6JrkQARg4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAk8rSaGy+X6LIlpBB7SvNja9QS5+oxrKNUbjCvEH3utSvtn5
	3E8y57tvkyU1IXyZe77+Sc4Ke0xg9Es8A2QKQDNYbiMczuoWVT+Eahtx
X-Gm-Gg: ATEYQzy7wWS9ZsZtTI7T+bnUzdCgEOx46Tvq7mwRXKmxIzIjOmKisLtBtfAUB38RX6L
	AGpaXds4FN2mxkL04km6SzKCwy1m0kqVhkVSTQtgZ0ZazjaSeTQI6eyRuNtJrp9TcFxPjSxHwHO
	LhhbITYVSdWJuZTYh9KxkTnY/Nna33aT8+6ajhOBmnOmSmH3oOUCWWPlfdkn8mrWQgf0nJhEcdx
	JK5n0tium0sZpO4m2O6zgy5fvTzXSUaroTYJasaw0Q8FgqjK2qdJeYRAm+weBqI1OOEG0B8RFno
	F03pDerNb2RRvnUri0/Pupu8GzcaCmvAxeu3yY7KLq9WfGPaIDRghRAEJMzkOk5Lx51NWChrotP
	U/WqoDcoYQXjg1cSTXVaCPDyizEko2ywvhprYmyQUjlLrMSrRq3ayUAf3uVmw/yWwTXQnTPVLTk
	05dTysUiGyTqrahLTN0ia32JfP
X-Received: by 2002:a17:90b:2e0b:b0:358:f0d0:1a19 with SMTP id 98e67ed59e1d1-35965c4965cmr5403279a91.12.1772269598272;
        Sat, 28 Feb 2026 01:06:38 -0800 (PST)
Received: from archlinux ([103.208.68.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dda5ec8sm7589488a91.12.2026.02.28.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:06:38 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: terrelln@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH v2 1/2] btrfs: replace BUG() with error handling in compression.c
Date: Sat, 28 Feb 2026 14:36:20 +0530
Message-ID: <20260228090621.100841-2-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228090621.100841-1-adarshdas950@gmail.com>
References: <20260228090621.100841-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-22109-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0C661C1964
X-Rspamd-Action: no action

v2:
- use ASSERT() instead of btrfs_err() + -EUCLEAN
- remove default: branches and add upfront ASSERT() for type validation
- fold coding style fixes into this patch

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/compression.c | 74 ++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 790518a8c803..0d8da8ce5fd3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -36,9 +36,9 @@
 
 static struct bio_set btrfs_compressed_bioset;
 
-static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
+static const char * const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
-const char* btrfs_compress_type2str(enum btrfs_compression_type type)
+const char *btrfs_compress_type2str(enum btrfs_compression_type type)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB:
@@ -89,24 +89,21 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
 static int compression_decompress_bio(struct list_head *ws,
 				      struct compressed_bio *cb)
 {
+	ASSERT(cb->compress_type > BTRFS_COMPRESS_NONE &&
+	       cb->compress_type < BTRFS_NR_COMPRESS_TYPES);
 	switch (cb->compress_type) {
 	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
-	case BTRFS_COMPRESS_NONE:
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
+	return -EUCLEAN;
 }
 
 static int compression_decompress(int type, struct list_head *ws,
 		const u8 *data_in, struct folio *dest_folio,
 		unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
+	ASSERT(type > BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_folio,
 						dest_pgoff, srclen, destlen);
@@ -114,14 +111,8 @@ static int compression_decompress(int type, struct list_head *ws,
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_folio,
 						dest_pgoff, srclen, destlen);
-	case BTRFS_COMPRESS_NONE:
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
+	return -EUCLEAN;
 }
 
 static int btrfs_decompress_bio(struct compressed_bio *cb);
@@ -484,6 +475,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 			if (zero_offset) {
 				int zeros;
+
 				zeros = folio_size(folio) - zero_offset;
 				folio_zero_range(folio, zero_offset, zeros);
 			}
@@ -697,33 +689,25 @@ static const struct btrfs_compress_levels * const btrfs_compress_levels[] = {
 
 static struct list_head *alloc_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
+
+	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
 	switch (type) {
 	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(fs_info);
 	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(fs_info, level);
 	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(fs_info);
 	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(fs_info, level);
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
+	return ERR_PTR(-EUCLEAN);
 }
 
 static void free_workspace(int type, struct list_head *ws)
 {
+	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
 	switch (type) {
 	case BTRFS_COMPRESS_NONE: return free_heuristic_ws(ws);
 	case BTRFS_COMPRESS_ZLIB: return zlib_free_workspace(ws);
 	case BTRFS_COMPRESS_LZO:  return lzo_free_workspace(ws);
 	case BTRFS_COMPRESS_ZSTD: return zstd_free_workspace(ws);
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
 }
 
@@ -792,7 +776,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
 	struct workspace_manager *wsm = fs_info->compr_wsm[type];
 	struct list_head *workspace;
 	int cpus = num_online_cpus();
-	unsigned nofs_flag;
+	unsigned int nofs_flag;
 	struct list_head *idle_ws;
 	spinlock_t *ws_lock;
 	atomic_t *total_ws;
@@ -868,18 +852,14 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
 
 static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type, int level)
 {
+	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
 	switch (type) {
 	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(fs_info, type, level);
 	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(fs_info, level);
 	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, type, level);
 	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, level);
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
+	return ERR_PTR(-EUCLEAN);
 }
 
 /*
@@ -919,17 +899,12 @@ void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_he
 
 static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws)
 {
+	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
 	switch (type) {
 	case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(fs_info, type, ws);
 	case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(fs_info, type, ws);
 	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, type, ws);
 	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
-	default:
-		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here.
-		 */
-		BUG();
 	}
 }
 
@@ -1181,17 +1156,17 @@ static u64 file_offset_from_bvec(const struct bio_vec *bvec)
  * @buf:		The decompressed data buffer
  * @buf_len:		The decompressed data length
  * @decompressed:	Number of bytes that are already decompressed inside the
- * 			compressed extent
+ *			compressed extent
  * @cb:			The compressed extent descriptor
  * @orig_bio:		The original bio that the caller wants to read for
  *
  * An easier to understand graph is like below:
  *
- * 		|<- orig_bio ->|     |<- orig_bio->|
- * 	|<-------      full decompressed extent      ----->|
- * 	|<-----------    @cb range   ---->|
- * 	|			|<-- @buf_len -->|
- * 	|<--- @decompressed --->|
+ *		|<- orig_bio ->|     |<- orig_bio->|
+ *	|<-------      full decompressed extent      ----->|
+ *	|<-----------    @cb range   ---->|
+ *	|			|<-- @buf_len -->|
+ *	|<--- @decompressed --->|
  *
  * Note that, @cb can be a subpage of the full decompressed extent, but
  * @cb->start always has the same as the orig_file_offset value of the full
@@ -1313,7 +1288,8 @@ static u32 shannon_entropy(struct heuristic_ws *ws)
 #define RADIX_BASE		4U
 #define COUNTERS_SIZE		(1U << RADIX_BASE)
 
-static u8 get4bits(u64 num, int shift) {
+static u8 get4bits(u64 num, int shift)
+{
 	u8 low4bits;
 
 	num >>= shift;
@@ -1388,7 +1364,7 @@ static void radix_sort(struct bucket_item *array, struct bucket_item *array_buf,
 		 */
 		memset(counters, 0, sizeof(counters));
 
-		for (i = 0; i < num; i ++) {
+		for (i = 0; i < num; i++) {
 			buf_num = array_buf[i].count;
 			addr = get4bits(buf_num, shift);
 			counters[addr]++;
-- 
2.53.0


