Return-Path: <linux-btrfs+bounces-11096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18BA20B3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3AB7A1FDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65631A727D;
	Tue, 28 Jan 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q4UVLK0x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFdWiHFp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC226ACD;
	Tue, 28 Jan 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070571; cv=none; b=jqTxJHCcDKlYbzgWUwi8inInATweZiCu1S/lfXNZf4WsC1iYtyo3Ydxcnozj7N6zToBqs26JmV2WC/hYDXUXmuXQQm05klkQfRMuTDgmWU2RDC68pOuhQVtAPcslYoTOCsu+RqJ5wclBl2YvXeetw+dqeEVVbgrtWDAcT4YApbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070571; c=relaxed/simple;
	bh=42475sRPwscmQNmJjtshDrabZO1pJ0a8/C7Qg6XTlDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSfRC+WjmYn80cS4VQ/TV+w/K1JMqeTcQW6YPQt/n5Illb3nv+4WVvj5H1lnHM5v3P4IuQT05LJ5c4kTp/gn4hb2Ick1u2TYT9Y1sAPwzcvosEJGApyXqWS3H+KNp6fBeG5pmkol0Af6c3QnXXXjxqN/5QUJwHUoIbE4qA9EXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q4UVLK0x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TFdWiHFp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D68731F381;
	Tue, 28 Jan 2025 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738070566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gJzs/tpqHBikPdzno21yL6KoGazVDFdYFoI4ywacZmc=;
	b=Q4UVLK0xymjxPicUf19OcWXOlr3pffBS7tK6fMFZKMBMJQYErsRYhl8tVROTpAQD0MPS7w
	BzTJJj1E5NarkQcGVDsE+XWLO2CEH08zMiZmBMOOPqGK9S1Re8gDTHkgqgbcAt6GVM+5P3
	hb2pcs0lkLf9YHtJ/XOdgZ+Y5RrVrLY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738070564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gJzs/tpqHBikPdzno21yL6KoGazVDFdYFoI4ywacZmc=;
	b=TFdWiHFpmp760J3dNGWLfxy1mvFPfzBpTw5JPPlaUWusBxuU32CoFSHux+6hezoWTi0gM7
	FosAl+T4yV80w/ulypSZgL4+ILIbw0f5tAuMyWZ8dNDyAK3s0malpUK4KOvzZCJ/ilXAVG
	lXRdG8dmj0zZmfkfnjsrtmbl+bRaxnM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBFB613625;
	Tue, 28 Jan 2025 13:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ArpTLSTamGdPRAAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 28 Jan 2025 13:22:44 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs/zstd: enable negative compression levels mount option
Date: Tue, 28 Jan 2025 14:22:33 +0100
Message-ID: <20250128132235.1356769-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This patch allows using the fast modes (negative compression levels) of zstd
as a mount option.

As per the results, the compression ratio is lower:

for level in {-10..-1} 1 2 3; \
do printf "level %3d\n" $level; \
  mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
  grep sdb /proc/mounts; \
  cp -r /usr/bin       /mnt/test/; sync; compsize /mnt/test/bin; \
  cp -r /usr/share/doc /mnt/test/; sync; compsize /mnt/test/doc; \
  cp    enwik9         /mnt/test/; sync; compsize /mnt/test/enwik9; \
  cp    linux-6.13.tar /mnt/test/; sync; compsize /mnt/test/linux-6.13.tar; \
  rm -r /mnt/test/{bin,doc,enwik9,linux-6.13.tar}; \
  umount /mnt/test/; \
done |& tee results | \
awk '/^level/{print}/^TOTAL/{print$3"\t"$2"  |"}' | paste - - - - -

		266M	bin  |	45M	doc  |	953M	wiki |	1.4G	source
=============================+===============+===============+===============+
level -10	171M	64%  |	28M	62%  |	631M	66%  |	512M	34%  |
level  -9	165M	62%  |	27M	61%  |	615M	64%  |	493M	33%  |
level  -8	161M	60%  |	27M	59%  |	598M	62%  |	475M	32%  |
level  -7	155M	58%  |	26M	58%  |	582M	61%  |	457M	30%  |
level  -6	151M	56%  |	25M	56%  |	565M	59%  |	437M	29%  |
level  -5	145M	54%  |	24M	55%  |	545M	57%  |	417M	28%  |
level  -4	139M	52%  |	23M	52%  |	520M	54%  |	391M	26%  |
level  -3	135M	50%  |	22M	50%  |	495M	51%  |	369M	24%  |
level  -2	127M	47%  |	22M	48%  |	470M	49%  |	349M	23%  |
level  -1	120M	45%  |	21M	47%  |	452M	47%  |	332M	22%  |
level   1	110M	41%  |	17M	39%  |	362M	38%  |	290M	19%  |
level   2	106M	40%  |	17M	38%  |	349M	36%  |	288M	19%  |
level   3	104M	39%  |	16M	37%  |	340M	35%  |	276M	18%  |

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
Changes in v2:
 * Set the minimal level to -10 and add a `clip_level()` helper as suggested
   by Dave.
 * Add more filetypes to comparison in commit message.

---
 fs/btrfs/compression.c | 18 +++++++---------
 fs/btrfs/compression.h | 25 +++++++---------------
 fs/btrfs/fs.h          |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/zlib.c        |  1 +
 fs/btrfs/zstd.c        | 48 +++++++++++++++++++++++++-----------------
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0c4d486c3048d..6d073e69af4e3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -740,7 +740,7 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 	&btrfs_zstd_compress,
 };
 
-static struct list_head *alloc_workspace(int type, unsigned int level)
+static struct list_head *alloc_workspace(int type, int level)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws();
@@ -818,7 +818,7 @@ static void btrfs_cleanup_workspace_manager(int type)
  * Preallocation makes a forward progress guarantees and we do not return
  * errors.
  */
-struct list_head *btrfs_get_workspace(int type, unsigned int level)
+struct list_head *btrfs_get_workspace(int type, int level)
 {
 	struct workspace_manager *wsm;
 	struct list_head *workspace;
@@ -968,14 +968,14 @@ static void put_workspace(int type, struct list_head *ws)
  * Adjust @level according to the limits of the compression algorithm or
  * fallback to default
  */
-static unsigned int btrfs_compress_set_level(int type, unsigned level)
+static int btrfs_compress_set_level(unsigned int type, int level)
 {
 	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
 
 	if (level == 0)
 		level = ops->default_level;
 	else
-		level = min(level, ops->max_level);
+		level = min(max(level, ops->min_level), ops->max_level);
 
 	return level;
 }
@@ -1023,12 +1023,10 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
  * @total_out is an in/out parameter, must be set to the input length and will
  * be also used to return the total number of compressed bytes
  */
-int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping,
+int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
 			 u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out)
 {
-	int type = btrfs_compress_type(type_level);
-	int level = btrfs_compress_level(type_level);
 	const unsigned long orig_len = *total_out;
 	struct list_head *workspace;
 	int ret;
@@ -1592,16 +1590,16 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end)
  * Convert the compression suffix (eg. after "zlib" starting with ":") to
  * level, unrecognized string will set the default level
  */
-unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
+int btrfs_compress_str2level(unsigned int type, const char *str)
 {
-	unsigned int level = 0;
+	int level = 0;
 	int ret;
 
 	if (!type)
 		return 0;
 
 	if (str[0] == ':') {
-		ret = kstrtouint(str + 1, 10, &level);
+		ret = kstrtoint(str + 1, 10, &level);
 		if (ret)
 			level = 0;
 	}
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 954034086d0d4..933178f03d8f8 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -72,16 +72,6 @@ struct compressed_bio {
 	struct btrfs_bio bbio;
 };
 
-static inline unsigned int btrfs_compress_type(unsigned int type_level)
-{
-	return (type_level & 0xF);
-}
-
-static inline unsigned int btrfs_compress_level(unsigned int type_level)
-{
-	return ((type_level & 0xF0) >> 4);
-}
-
 /* @range_end must be exclusive. */
 static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
 {
@@ -93,7 +83,7 @@ static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
-int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping,
+int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
 int btrfs_decompress(int type, const u8 *data_in, struct folio *dest_folio,
@@ -107,7 +97,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 				   bool writeback);
 void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
-unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
+int btrfs_compress_str2level(unsigned int type, const char *str);
 
 struct folio *btrfs_alloc_compr_folio(void);
 void btrfs_free_compr_folio(struct folio *folio);
@@ -131,14 +121,15 @@ struct workspace_manager {
 	wait_queue_head_t ws_wait;
 };
 
-struct list_head *btrfs_get_workspace(int type, unsigned int level);
+struct list_head *btrfs_get_workspace(int type, int level);
 void btrfs_put_workspace(int type, struct list_head *ws);
 
 struct btrfs_compress_op {
 	struct workspace_manager *workspace_manager;
 	/* Maximum level supported by the compression algorithm */
-	unsigned int max_level;
-	unsigned int default_level;
+	int min_level;
+	int max_level;
+	int default_level;
 };
 
 /* The heuristic workspaces are managed via the 0th workspace manager */
@@ -187,9 +178,9 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
 void zstd_cleanup_workspace_manager(void);
-struct list_head *zstd_alloc_workspace(unsigned int level);
+struct list_head *zstd_alloc_workspace(int level);
 void zstd_free_workspace(struct list_head *ws);
-struct list_head *zstd_get_workspace(unsigned int level);
+struct list_head *zstd_get_workspace(int level);
 void zstd_put_workspace(struct list_head *ws);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d1..be6d5a24bd4e6 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -486,7 +486,7 @@ struct btrfs_fs_info {
 	unsigned long long mount_opt;
 
 	unsigned long compress_type:4;
-	unsigned int compress_level;
+	int compress_level;
 	u32 commit_interval;
 	/*
 	 * It is a suggestive number, the read side is safe even it gets a
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27b2fe7f735d5..fa04b027d53ac 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1013,7 +1013,7 @@ static void compress_file_range(struct btrfs_work *work)
 		compress_type = inode->prop_compress;
 
 	/* Compression level is applied here. */
-	ret = btrfs_compress_folios(compress_type | (fs_info->compress_level << 4),
+	ret = btrfs_compress_folios(compress_type, fs_info->compress_level,
 				    mapping, start, folios, &nr_folios, &total_in,
 				    &total_compressed);
 	if (ret)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7dfe5005129a1..cebbb0890c37e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -84,7 +84,7 @@ struct btrfs_fs_context {
 	u32 thread_pool_size;
 	unsigned long long mount_opt;
 	unsigned long compress_type:4;
-	unsigned int compress_level;
+	int compress_level;
 	refcount_t refs;
 };
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c9e92c6941ec4..047d30d20ff16 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -463,6 +463,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.workspace_manager	= &wsm,
+	.min_level		= 1,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
 };
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 5232b56d58925..a31975833725e 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -26,11 +26,12 @@
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
 #define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
 #define ZSTD_BTRFS_DEFAULT_LEVEL 3
+#define ZSTD_BTRFS_MIN_LEVEL -10
 #define ZSTD_BTRFS_MAX_LEVEL 15
 /* 307s to avoid pathologically clashing with transaction commit */
 #define ZSTD_BTRFS_RECLAIM_JIFFIES (307 * HZ)
 
-static zstd_parameters zstd_get_btrfs_parameters(unsigned int level,
+static zstd_parameters zstd_get_btrfs_parameters(int level,
 						 size_t src_len)
 {
 	zstd_parameters params = zstd_get_params(level, src_len);
@@ -45,8 +46,8 @@ struct workspace {
 	void *mem;
 	size_t size;
 	char *buf;
-	unsigned int level;
-	unsigned int req_level;
+	int level;
+	int req_level;
 	unsigned long last_used; /* jiffies */
 	struct list_head list;
 	struct list_head lru_list;
@@ -93,8 +94,10 @@ static inline struct workspace *list_to_workspace(struct list_head *list)
 	return container_of(list, struct workspace, list);
 }
 
-void zstd_free_workspace(struct list_head *ws);
-struct list_head *zstd_alloc_workspace(unsigned int level);
+static inline int clip_level(int level)
+{
+	return clip_level(level);
+}
 
 /*
  * Timer callback to free unused workspaces.
@@ -123,7 +126,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	list_for_each_prev_safe(pos, next, &wsm.lru_list) {
 		struct workspace *victim = container_of(pos, struct workspace,
 							lru_list);
-		unsigned int level;
+		int level;
 
 		if (time_after(victim->last_used, reclaim_threshold))
 			break;
@@ -132,13 +135,13 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 		if (victim->req_level)
 			continue;
 
-		level = victim->level;
+		level = clip_level(victim->level);
 		list_del(&victim->lru_list);
 		list_del(&victim->list);
 		zstd_free_workspace(&victim->list);
 
-		if (list_empty(&wsm.idle_ws[level - 1]))
-			clear_bit(level - 1, &wsm.active_map);
+		if (list_empty(&wsm.idle_ws[level]))
+			clear_bit(level, &wsm.active_map);
 
 	}
 
@@ -160,9 +163,11 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 static void zstd_calc_ws_mem_sizes(void)
 {
 	size_t max_size = 0;
-	unsigned int level;
+	int level;
 
-	for (level = 1; level <= ZSTD_BTRFS_MAX_LEVEL; level++) {
+	for (level = ZSTD_BTRFS_MIN_LEVEL; level <= ZSTD_BTRFS_MAX_LEVEL; level++) {
+		if (level == 0)
+			continue;
 		zstd_parameters params =
 			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
 		size_t level_size =
@@ -171,7 +176,8 @@ static void zstd_calc_ws_mem_sizes(void)
 			      zstd_dstream_workspace_bound(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
-		zstd_ws_mem_sizes[level - 1] = max_size;
+		/* Use level 1 workspace size for all the fast mode negative levels. */
+		zstd_ws_mem_sizes[clip_level(level)] = max_size;
 	}
 }
 
@@ -233,11 +239,11 @@ void zstd_cleanup_workspace_manager(void)
  * offer the opportunity to reclaim the workspace in favor of allocating an
  * appropriately sized one in the future.
  */
-static struct list_head *zstd_find_workspace(unsigned int level)
+static struct list_head *zstd_find_workspace(int level)
 {
 	struct list_head *ws;
 	struct workspace *workspace;
-	int i = level - 1;
+	int i = clip_level(level);
 
 	spin_lock_bh(&wsm.lock);
 	for_each_set_bit_from(i, &wsm.active_map, ZSTD_BTRFS_MAX_LEVEL) {
@@ -270,7 +276,7 @@ static struct list_head *zstd_find_workspace(unsigned int level)
  * attempt to allocate a new workspace.  If we fail to allocate one due to
  * memory pressure, go to sleep waiting for the max level workspace to free up.
  */
-struct list_head *zstd_get_workspace(unsigned int level)
+struct list_head *zstd_get_workspace(int level)
 {
 	struct list_head *ws;
 	unsigned int nofs_flag;
@@ -315,6 +321,7 @@ struct list_head *zstd_get_workspace(unsigned int level)
 void zstd_put_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_to_workspace(ws);
+	int level;
 
 	spin_lock_bh(&wsm.lock);
 
@@ -332,8 +339,9 @@ void zstd_put_workspace(struct list_head *ws)
 		}
 	}
 
-	set_bit(workspace->level - 1, &wsm.active_map);
-	list_add(&workspace->list, &wsm.idle_ws[workspace->level - 1]);
+	level = clip_level(workspace->level);
+	set_bit(level, &wsm.active_map);
+	list_add(&workspace->list, &wsm.idle_ws[level]);
 	workspace->req_level = 0;
 
 	spin_unlock_bh(&wsm.lock);
@@ -351,7 +359,7 @@ void zstd_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-struct list_head *zstd_alloc_workspace(unsigned int level)
+struct list_head *zstd_alloc_workspace(int level)
 {
 	struct workspace *workspace;
 
@@ -359,7 +367,8 @@ struct list_head *zstd_alloc_workspace(unsigned int level)
 	if (!workspace)
 		return ERR_PTR(-ENOMEM);
 
-	workspace->size = zstd_ws_mem_sizes[level - 1];
+	/* Use level 1 workspace size for all the fast mode negative levels. */
+	workspace->size = zstd_ws_mem_sizes[clip_level(level)];
 	workspace->level = level;
 	workspace->req_level = level;
 	workspace->last_used = jiffies;
@@ -717,6 +726,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
+	.min_level	= ZSTD_BTRFS_MIN_LEVEL,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.45.2


