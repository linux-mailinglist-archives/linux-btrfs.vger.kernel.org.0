Return-Path: <linux-btrfs+bounces-13247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA9A971BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7956C17E854
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EB28FFE4;
	Tue, 22 Apr 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PkmI6u8C";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PkmI6u8C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232B27BF7F
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337350; cv=none; b=T2RPsRzBBh86MvvLTqtqihwCAOVuvhUyhAkmGeG6So4LJ2ZQD3mltdnFrMPBNNUnLzVXWhqyknM48N665aNzw+DKPtuK0C+kJ/v8O4zhQMGZ9rFz4ZREU7jUtlsXtMHnVy5OneSCkiEkgeF+8NBAOcCcyjouMiRYKBgjV1UIHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337350; c=relaxed/simple;
	bh=iRrEG5mO028vlHb78mqw7VBDxAmytE2h78b1VVO0J48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+ddXNa/zL0YWccv6KEc7Le7InjT2BIyBK6zSINOAxTpPn/Tmp+9iv9/0EifhAcnkH+DH/CvLTDL9uyokKBq57Cjof+GUlGVVVQcSoRa3xW+GcPGljoz+4Zxa8Q3l84E5/YAicf80Z4xPmwedLDlcJ/MFPHwsacTn/EMvTv3jFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PkmI6u8C; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PkmI6u8C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CF621F38D;
	Tue, 22 Apr 2025 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745337346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/UpKrpXqo8FIE1Tk/+7ao1euhMlILbSKyZ3GPkJ/BRA=;
	b=PkmI6u8CKXF8syVhpjk+KpBmsby6A2ICG9twAS6qs2Hx7sJFGFfBVl2UPK647VlMCXOL1j
	f/BiVEy5j1Kqg71glpzQ8KW8uNqs0C3NbeptdOTDnYkNBwkOuzVTgBvfGRBMOH9AD+Mgm/
	bq1294rOy0g8xMXHyGGAJaUfG/dfdvM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PkmI6u8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745337346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/UpKrpXqo8FIE1Tk/+7ao1euhMlILbSKyZ3GPkJ/BRA=;
	b=PkmI6u8CKXF8syVhpjk+KpBmsby6A2ICG9twAS6qs2Hx7sJFGFfBVl2UPK647VlMCXOL1j
	f/BiVEy5j1Kqg71glpzQ8KW8uNqs0C3NbeptdOTDnYkNBwkOuzVTgBvfGRBMOH9AD+Mgm/
	bq1294rOy0g8xMXHyGGAJaUfG/dfdvM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14FE1139D5;
	Tue, 22 Apr 2025 15:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1AaBQK8B2iZZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 22 Apr 2025 15:55:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use unsigned types for constants defined as bit shifts
Date: Tue, 22 Apr 2025 17:55:41 +0200
Message-ID: <20250422155541.296808-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CF621F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The unsigned type is a recommended practice (CWE-190, CWE-194) for bit
shifts to avoid problems with potential unwanted sign extensions.
Although there are no such cases in btrfs codebase, follow the
recommendation.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.h               |  4 ++--
 fs/btrfs/direct-io.c             |  4 ++--
 fs/btrfs/extent_io.h             |  2 +-
 fs/btrfs/inode.c                 | 12 ++++++------
 fs/btrfs/ordered-data.c          |  4 ++--
 fs/btrfs/raid56.c                |  5 ++---
 fs/btrfs/tests/extent-io-tests.c |  6 +++---
 fs/btrfs/zstd.c                  |  2 +-
 8 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 74e6140312747f..953637115956b9 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -423,8 +423,8 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		struct btrfs_backref_cache *cache);
 
-#define		LINK_LOWER	(1 << 0)
-#define		LINK_UPPER	(1 << 1)
+#define		LINK_LOWER	(1U << 0)
+#define		LINK_UPPER	(1U << 1)
 
 void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
 			     struct btrfs_backref_node *lower,
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 3a03142dee099b..fde612d9b077e3 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -151,8 +151,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
-					     (1 << type) |
-					     (1 << BTRFS_ORDERED_DIRECT));
+					     (1U << type) |
+					     (1U << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
 			btrfs_free_extent_map(em);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index bcdb067da06d1e..b677006ab14ee6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -67,7 +67,7 @@ enum {
  *    single word in a bitmap may straddle two pages in the extent buffer.
  */
 #define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
-#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
+#define BYTE_MASK ((1U << BITS_PER_BYTE) - 1)
 #define BITMAP_FIRST_BYTE_MASK(start) \
 	((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
 #define BITMAP_LAST_BYTE_MASK(nbits) \
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 652db811e5cabd..73ef9b9b2b2cd3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1151,7 +1151,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-					     1 << BTRFS_ORDERED_COMPRESSED);
+					     1U << BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1396,7 +1396,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		btrfs_free_extent_map(em);
 
 		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-						     1 << BTRFS_ORDERED_REGULAR);
+						     1U << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
 			btrfs_unlock_extent(&inode->io_tree, start,
 					    start + cur_alloc_size - 1, &cached);
@@ -1976,8 +1976,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 
 	ordered = btrfs_alloc_ordered_extent(inode, file_pos, &nocow_args->file_extent,
 					     is_prealloc
-					     ? (1 << BTRFS_ORDERED_PREALLOC)
-					     : (1 << BTRFS_ORDERED_NOCOW));
+					     ? (1U << BTRFS_ORDERED_PREALLOC)
+					     : (1U << BTRFS_ORDERED_NOCOW));
 	if (IS_ERR(ordered)) {
 		if (is_prealloc)
 			btrfs_drop_extent_map_range(inode, file_pos, end, false);
@@ -9688,8 +9688,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-				       (1 << BTRFS_ORDERED_ENCODED) |
-				       (1 << BTRFS_ORDERED_COMPRESSED));
+				       (1U << BTRFS_ORDERED_ENCODED) |
+				       (1U << BTRFS_ORDERED_COMPRESSED));
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b5b544712e93a3..6151d32704d2da 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -155,7 +155,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	u64 qgroup_rsv = 0;
 
 	if (flags &
-	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
+	    ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -253,7 +253,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * @disk_bytenr:     Offset of extent on disk.
  * @disk_num_bytes:  Size of extent on disk.
  * @offset:          Offset into unencoded data where file data starts.
- * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ * @flags:           Flags specifying type of extent (1U << BTRFS_ORDERED_*).
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4657517f5480b7..06670e987f92f8 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -203,8 +203,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	struct btrfs_stripe_hash_table *x;
 	struct btrfs_stripe_hash *cur;
 	struct btrfs_stripe_hash *h;
-	int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
-	int i;
+	unsigned int num_entries = 1U << BTRFS_STRIPE_HASH_TABLE_BITS;
 
 	if (info->stripe_hash_table)
 		return 0;
@@ -225,7 +224,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 	h = table->table;
 
-	for (i = 0; i < num_entries; i++) {
+	for (unsigned int i = 0; i < num_entries; i++) {
 		cur = h + i;
 		INIT_LIST_HEAD(&cur->hash_list);
 		spin_lock_init(&cur->lock);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index b603563bd20986..d6aff41c38b165 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -14,9 +14,9 @@
 #include "../disk-io.h"
 #include "../btrfs_inode.h"
 
-#define PROCESS_UNLOCK		(1 << 0)
-#define PROCESS_RELEASE		(1 << 1)
-#define PROCESS_TEST_LOCKED	(1 << 2)
+#define PROCESS_UNLOCK		(1U << 0)
+#define PROCESS_RELEASE		(1U << 1)
+#define PROCESS_TEST_LOCKED	(1U << 2)
 
 static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 				       unsigned long flags)
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 75efca4da194c6..4a796a049b5a24 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -24,7 +24,7 @@
 #include "super.h"
 
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
-#define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
+#define ZSTD_BTRFS_MAX_INPUT (1U << ZSTD_BTRFS_MAX_WINDOWLOG)
 #define ZSTD_BTRFS_DEFAULT_LEVEL 3
 #define ZSTD_BTRFS_MIN_LEVEL -15
 #define ZSTD_BTRFS_MAX_LEVEL 15
-- 
2.49.0


