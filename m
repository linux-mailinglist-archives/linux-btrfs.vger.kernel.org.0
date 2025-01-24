Return-Path: <linux-btrfs+bounces-11056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E301A1B128
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943C53A43EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7361DB150;
	Fri, 24 Jan 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rou1YSxL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rou1YSxL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794F1DB136;
	Fri, 24 Jan 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705402; cv=none; b=iBc5E65sOCgd6TGNJtgqLfR9/o4IeSr6Kc11utM6H8BZFTU1zJ2MGbkAy7Rk/ZrugpZud67OY9tqOWubcse9dar7G2bSpixQW+l+t+4mY3BV98hXF3qwOGOWjSjC6wziGeDRfG6mNxEaREfftjuO3HB3DuP2F/utD89MiyheBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705402; c=relaxed/simple;
	bh=mWX8imjAkQOH6ub1XKFRIr3v1s7PH1UpNU3Xf8fQcbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqv7cgGuy77UbV1d1P7o8pI2jIPrrxtFCU/NG3B/xeFAwH3TVa5ygtUuRVXP8VvW9igGL9TSO6ZnpF/BTr+NcoQI3jOQg3TagGawPTDn8yD2NDBlmmBPlNI6fIE8gRT7SdHLnv10ENjMP1vtxJqc7fiz+bzRbBmLYQQxoVLBn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rou1YSxL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rou1YSxL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27F3C21172;
	Fri, 24 Jan 2025 07:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737705397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PApYwJrIklKuElqFyvlMcfeT/8UyBnpIr3Lhqi+sUzc=;
	b=rou1YSxLWeXhKDiukdc8UhKXs+YAdcyhfCz8HoyON9yGhml3wPDvSuiV3Kyv0TZxAKj3wU
	yyzGHWeO7NB/yUMehi9fWaJjOCCEjrD4rTXZk1Gz+KY8g+mayHZgw80OcltKF9UHLqVzAL
	R5SKgkWMCnfk9fAxWIoN34/+9im8EUM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rou1YSxL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737705397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PApYwJrIklKuElqFyvlMcfeT/8UyBnpIr3Lhqi+sUzc=;
	b=rou1YSxLWeXhKDiukdc8UhKXs+YAdcyhfCz8HoyON9yGhml3wPDvSuiV3Kyv0TZxAKj3wU
	yyzGHWeO7NB/yUMehi9fWaJjOCCEjrD4rTXZk1Gz+KY8g+mayHZgw80OcltKF9UHLqVzAL
	R5SKgkWMCnfk9fAxWIoN34/+9im8EUM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BDCA13999;
	Fri, 24 Jan 2025 07:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h+VTArVHk2dQCQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 24 Jan 2025 07:56:37 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs/zstd: enable negative compression levels mount option
Date: Fri, 24 Jan 2025 08:55:56 +0100
Message-ID: <20250124075558.530088-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27F3C21172
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This patch allows using the fast modes (negative compression levels) of zstd.

The performance benchmarks do not show any significant (positive or negative)
influence other than the lower compression ratio. But %system CPU usage
should also be lower which is not clearly visible from the results below.
That's because with the fast modes the processing is IO-bound and not CPU-bound.

for level in {-15..-1} {1..15}; \
do printf "level %3d\n" $level; \
  mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
  grep sdb /proc/mounts; \
  sync; time { time cp /dev/shm/linux-6.13.tar.xz /mnt/test/; sync; }; \
  compsize /mnt/test/linux-6.13.tar.xz; \
  sync; time { time cp /dev/shm/linux-6.13.tar /mnt/test/; sync; }; \
  compsize /mnt/test/linux-6.13.tar; \
  rm /mnt/test/linux-6.13.tar*; \
  umount /mnt/test/; \
done |& tee results | \
awk '/^level/{print}/^real/{print$2}/^TOTAL/{print$3"\t"$2"  |"}' | \
paste - - - - - - -

			linux-6.13.tar.xz	141M	      |		linux-6.13.tar		1.4G
		copy wall time	sync wall time	usage	ratio | copy wall time	sync wall time	usage	ratio
==============================================================+===============================================
level -15	0m0,261s	0m0,329s	141M	100%  |	0m2,511s	0m2,794s	598M	40%  |
level -14	0m0,145s	0m0,291s	141M	100%  |	0m1,829s	0m2,443s	581M	39%  |
level -13	0m0,141s	0m0,289s	141M	100%  |	0m1,832s	0m2,347s	566M	38%  |
level -12	0m0,140s	0m0,291s	141M	100%  |	0m1,879s	0m2,246s	548M	37%  |
level -11	0m0,133s	0m0,271s	141M	100%  |	0m1,789s	0m2,257s	530M	35%  |
level -10	0m0,146s	0m0,318s	141M	100%  |	0m1,769s	0m2,228s	512M	34%  |
level  -9	0m0,138s	0m0,288s	141M	100%  |	0m1,869s	0m2,304s	493M	33%  |
level  -8	0m0,146s	0m0,294s	141M	100%  |	0m1,846s	0m2,446s	475M	32%  |
level  -7	0m0,151s	0m0,298s	141M	100%  |	0m1,877s	0m2,319s	457M	30%  |
level  -6	0m0,134s	0m0,271s	141M	100%  |	0m1,918s	0m2,314s	437M	29%  |
level  -5	0m0,139s	0m0,307s	141M	100%  |	0m1,860s	0m2,254s	417M	28%  |
level  -4	0m0,153s	0m0,295s	141M	100%  |	0m1,916s	0m2,272s	391M	26%  |
level  -3	0m0,145s	0m0,308s	141M	100%  |	0m1,830s	0m2,369s	369M	24%  |
level  -2	0m0,150s	0m0,294s	141M	100%  |	0m1,841s	0m2,344s	349M	23%  |
level  -1	0m0,150s	0m0,312s	141M	100%  |	0m1,872s	0m2,487s	332M	22%  |
level   1	0m0,142s	0m0,310s	141M	100%  |	0m1,880s	0m2,331s	290M	19%  |
level   2	0m0,144s	0m0,286s	141M	100%  |	0m1,933s	0m2,266s	288M	19%  |
level   3	0m0,146s	0m0,304s	141M	100%  |	0m1,966s	0m2,300s	276M	18% *|
level   4	0m0,146s	0m0,287s	141M	100%  |	0m2,173s	0m2,496s	275M	18%  |
level   5	0m0,146s	0m0,304s	141M	100%  |	0m2,307s	0m2,728s	261M	17%  |
level   6	0m0,138s	0m0,267s	141M	100%  |	0m2,435s	0m3,151s	253M	17%  |
level   7	0m0,142s	0m0,301s	141M	100%  |	0m2,274s	0m3,617s	251M	16%  |
level   8	0m0,136s	0m0,291s	141M	100%  |	0m2,066s	0m3,913s	249M	16%  |
level   9	0m0,134s	0m0,283s	141M	100%  |	0m2,676s	0m4,496s	247M	16%  |
level  10	0m0,151s	0m0,297s	141M	100%  |	0m2,424s	0m5,102s	247M	16%  |
level  11	0m0,149s	0m0,296s	141M	100%  |	0m3,485s	0m7,803s	245M	16%  |
level  12	0m0,144s	0m0,304s	141M	100%  |	0m3,954s	0m9,067s	244M	16%  |
level  13	0m0,148s	0m0,319s	141M	100%  |	0m5,350s	0m13,307s	247M	16%  |
level  14	0m0,145s	0m0,296s	141M	100%  |	0m6,916s	0m18,218s	238M	16%  |
level  15	0m0,145s	0m0,293s	141M	100%  |	0m8,304s	0m24,675s	233M	15%  |

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
Checking the ZSTD workspace memory sizes it looks like sharing
the level 1 workspace with all the fast modes should be safe.
From the debug printf output:

                                 level_size  max_size
[   11.032659] btrfs zstd ws: -15  926969  926969
[   11.032662] btrfs zstd ws: -14  926969  926969
[   11.032663] btrfs zstd ws: -13  926969  926969
[   11.032664] btrfs zstd ws: -12  926969  926969
[   11.032665] btrfs zstd ws: -11  926969  926969
[   11.032665] btrfs zstd ws: -10  926969  926969
[   11.032666] btrfs zstd ws:  -9  926969  926969
[   11.032666] btrfs zstd ws:  -8  926969  926969
[   11.032667] btrfs zstd ws:  -7  926969  926969
[   11.032668] btrfs zstd ws:  -6  926969  926969
[   11.032668] btrfs zstd ws:  -5  926969  926969
[   11.032669] btrfs zstd ws:  -4  926969  926969
[   11.032670] btrfs zstd ws:  -3  926969  926969
[   11.032670] btrfs zstd ws:  -2  926969  926969
[   11.032671] btrfs zstd ws:  -1  926969  926969
[   11.032672] btrfs zstd ws:   1  943353  943353
[   11.032673] btrfs zstd ws:   2 1041657 1041657
[   11.032674] btrfs zstd ws:   3 1303801 1303801
[   11.032674] btrfs zstd ws:   4 1959161 1959161
[   11.032675] btrfs zstd ws:   5 1697017 1959161
[   11.032676] btrfs zstd ws:   6 1697017 1959161
[   11.032676] btrfs zstd ws:   7 1697017 1959161
[   11.032677] btrfs zstd ws:   8 1697017 1959161
[   11.032678] btrfs zstd ws:   9 1697017 1959161
[   11.032679] btrfs zstd ws:  10 1697017 1959161
[   11.032679] btrfs zstd ws:  11 1959161 1959161
[   11.032680] btrfs zstd ws:  12 2483449 2483449
[   11.032681] btrfs zstd ws:  13 2632633 2632633
[   11.032681] btrfs zstd ws:  14 3277111 3277111
[   11.032682] btrfs zstd ws:  15 3277111 3277111

Hence the implementation uses `zstd_ws_mem_sizes[0]` for all negative levels.

I also plan to update the `btrfs fi defrag` interface to be able to use
these levels (or any levels at all).

---
 fs/btrfs/compression.c | 18 ++++++++---------
 fs/btrfs/compression.h | 25 ++++++++---------------
 fs/btrfs/fs.h          |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/zlib.c        |  1 +
 fs/btrfs/zstd.c        | 46 ++++++++++++++++++++++++------------------
 7 files changed, 46 insertions(+), 50 deletions(-)

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
index 5232b56d58925..54036417b2f33 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -26,11 +26,12 @@
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
 #define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
 #define ZSTD_BTRFS_DEFAULT_LEVEL 3
+#define ZSTD_BTRFS_MIN_LEVEL -15
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
@@ -93,9 +94,6 @@ static inline struct workspace *list_to_workspace(struct list_head *list)
 	return container_of(list, struct workspace, list);
 }
 
-void zstd_free_workspace(struct list_head *ws);
-struct list_head *zstd_alloc_workspace(unsigned int level);
-
 /*
  * Timer callback to free unused workspaces.
  *
@@ -123,7 +121,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	list_for_each_prev_safe(pos, next, &wsm.lru_list) {
 		struct workspace *victim = container_of(pos, struct workspace,
 							lru_list);
-		unsigned int level;
+		int level;
 
 		if (time_after(victim->last_used, reclaim_threshold))
 			break;
@@ -132,13 +130,13 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 		if (victim->req_level)
 			continue;
 
-		level = victim->level;
+		level = max(0, victim->level - 1);
 		list_del(&victim->lru_list);
 		list_del(&victim->list);
 		zstd_free_workspace(&victim->list);
 
-		if (list_empty(&wsm.idle_ws[level - 1]))
-			clear_bit(level - 1, &wsm.active_map);
+		if (list_empty(&wsm.idle_ws[level]))
+			clear_bit(level, &wsm.active_map);
 
 	}
 
@@ -160,9 +158,11 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
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
@@ -171,7 +171,9 @@ static void zstd_calc_ws_mem_sizes(void)
 			      zstd_dstream_workspace_bound(ZSTD_BTRFS_MAX_INPUT));
 
 		max_size = max_t(size_t, max_size, level_size);
-		zstd_ws_mem_sizes[level - 1] = max_size;
+//		printk("btrfs zstd ws: %3i %lu %lu\n", level, level_size, max_size);
+		/* Use level 1 workspace size for all the fast mode negative levels. */
+		zstd_ws_mem_sizes[max(0, level - 1)] = max_size;
 	}
 }
 
@@ -233,11 +235,11 @@ void zstd_cleanup_workspace_manager(void)
  * offer the opportunity to reclaim the workspace in favor of allocating an
  * appropriately sized one in the future.
  */
-static struct list_head *zstd_find_workspace(unsigned int level)
+static struct list_head *zstd_find_workspace(int level)
 {
 	struct list_head *ws;
 	struct workspace *workspace;
-	int i = level - 1;
+	int i = max(0, level - 1);
 
 	spin_lock_bh(&wsm.lock);
 	for_each_set_bit_from(i, &wsm.active_map, ZSTD_BTRFS_MAX_LEVEL) {
@@ -270,7 +272,7 @@ static struct list_head *zstd_find_workspace(unsigned int level)
  * attempt to allocate a new workspace.  If we fail to allocate one due to
  * memory pressure, go to sleep waiting for the max level workspace to free up.
  */
-struct list_head *zstd_get_workspace(unsigned int level)
+struct list_head *zstd_get_workspace(int level)
 {
 	struct list_head *ws;
 	unsigned int nofs_flag;
@@ -315,6 +317,7 @@ struct list_head *zstd_get_workspace(unsigned int level)
 void zstd_put_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_to_workspace(ws);
+	int level;
 
 	spin_lock_bh(&wsm.lock);
 
@@ -332,8 +335,9 @@ void zstd_put_workspace(struct list_head *ws)
 		}
 	}
 
-	set_bit(workspace->level - 1, &wsm.active_map);
-	list_add(&workspace->list, &wsm.idle_ws[workspace->level - 1]);
+	level = max(0, workspace->level - 1);
+	set_bit(level, &wsm.active_map);
+	list_add(&workspace->list, &wsm.idle_ws[level]);
 	workspace->req_level = 0;
 
 	spin_unlock_bh(&wsm.lock);
@@ -351,7 +355,7 @@ void zstd_free_workspace(struct list_head *ws)
 	kfree(workspace);
 }
 
-struct list_head *zstd_alloc_workspace(unsigned int level)
+struct list_head *zstd_alloc_workspace(int level)
 {
 	struct workspace *workspace;
 
@@ -359,7 +363,8 @@ struct list_head *zstd_alloc_workspace(unsigned int level)
 	if (!workspace)
 		return ERR_PTR(-ENOMEM);
 
-	workspace->size = zstd_ws_mem_sizes[level - 1];
+	/* Use level 1 workspace size for all the fast mode negative levels. */
+	workspace->size = zstd_ws_mem_sizes[max(0, level - 1)];
 	workspace->level = level;
 	workspace->req_level = level;
 	workspace->last_used = jiffies;
@@ -717,6 +722,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	/* ZSTD uses own workspace manager */
 	.workspace_manager = NULL,
+	.min_level	= ZSTD_BTRFS_MIN_LEVEL,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.45.2


