Return-Path: <linux-btrfs+bounces-1263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A5824E26
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 06:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42031F22823
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E455CBE;
	Fri,  5 Jan 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m5MY00rd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m5MY00rd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094E566E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C98322154
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704432976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YQKYRByrxh6wdAy3T1WjFkzSGXCFMRP3drOz0doG58g=;
	b=m5MY00rdrKYYp1mQYpLO3jDounpjfb7+/1pwPlANP1kx/prfrCw5QTzFU5WMlw+cdfko6F
	2BKQhxMEB/TXou12tSot+2+7C3pcvpyH1PiknwrS1PBNrxdrLXVyLzm94FeoudFxDVHg4/
	koHj3ifKTIwOn8TDIxr8jBqPBEeo4zs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704432976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YQKYRByrxh6wdAy3T1WjFkzSGXCFMRP3drOz0doG58g=;
	b=m5MY00rdrKYYp1mQYpLO3jDounpjfb7+/1pwPlANP1kx/prfrCw5QTzFU5WMlw+cdfko6F
	2BKQhxMEB/TXou12tSot+2+7C3pcvpyH1PiknwrS1PBNrxdrLXVyLzm94FeoudFxDVHg4/
	koHj3ifKTIwOn8TDIxr8jBqPBEeo4zs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B45513AC6
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HJJxCU+Vl2VQFAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jan 2024 05:36:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: cache folio size and shift in extent_buffer
Date: Fri,  5 Jan 2024 16:05:55 +1030
Message-ID: <b4e58a4cbe2b457e5d0a7f844cdbe035103179c2.1704432940.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spam-Level: 
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 8C98322154
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m5MY00rd
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

After the conversion to folio interfaces (but without the patch to
enable larger folio allocation), there is a LTP report about observable
performance drop on metadata heavy operations.

This drop is caused by the extra code of calculating the
folio_size()/folio_shift(), instead of the old hard coded
PAGE_SIZE/PAGE_SHIFT.

To slightly reduce the overhead, just cache both folio_size and
folio_shift in extent_buffer.

The two new members (u32 folio_size and u8 folio_shift) is stored inside
the holes of extent_buffer. (folio_size is shared with len, which is
reduced to u32).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.c | 12 ++++++------
 fs/btrfs/ctree.c     |  2 +-
 fs/btrfs/disk-io.c   |  2 +-
 fs/btrfs/extent_io.c | 38 +++++++++++++++++++++-----------------
 fs/btrfs/extent_io.h | 16 +++++++++++++---
 5 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 1925a0919ca6..6eb850ad37d2 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -63,8 +63,8 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	const unsigned long idx = get_eb_folio_index(token->eb, member_offset); \
 	const unsigned long oil = get_eb_offset_in_folio(token->eb,	\
 							 member_offset);\
-	const int unit_size = folio_size(token->eb->folios[0]);		\
-	const int unit_shift = folio_shift(token->eb->folios[0]);	\
+	const int unit_size = token->eb->folio_size;			\
+	const int unit_shift = token->eb->folio_shift;			\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = unit_size - oil;				\
@@ -94,7 +94,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	const int unit_size = folio_size(eb->folios[0]);		\
+	const int unit_size = eb->folio_size;				\
 	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = unit_size - oil;				\
@@ -117,8 +117,8 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	const unsigned long idx = get_eb_folio_index(token->eb, member_offset); \
 	const unsigned long oil = get_eb_offset_in_folio(token->eb,	\
 							 member_offset);\
-	const int unit_size = folio_size(token->eb->folios[0]);		\
-	const int unit_shift = folio_shift(token->eb->folios[0]);	\
+	const int unit_size = token->eb->folio_size;			\
+	const int unit_shift = token->eb->folio_shift;			\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
 	const int part = unit_size - oil;				\
@@ -151,7 +151,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	const int unit_size = folio_size(eb->folios[0]);		\
+	const int unit_size = eb->folio_size;				\
 	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
 	const int part = unit_size - oil;				\
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e65e012bac55..33145da449cc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -820,7 +820,7 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 	}
 
 	while (low < high) {
-		const int unit_size = folio_size(eb->folios[0]);
+		const int unit_size = eb->folio_size;
 		unsigned long oil;
 		unsigned long offset;
 		struct btrfs_disk_key *tmp;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c6907d533fe8..57be7dd44da5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -193,7 +193,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 		struct folio *folio = eb->folios[i];
 		u64 start = max_t(u64, eb->start, folio_pos(folio));
 		u64 end = min_t(u64, eb->start + eb->len,
-				folio_pos(folio) + folio_size(folio));
+				folio_pos(folio) + eb->folio_size);
 		u32 len = end - start;
 
 		ret = btrfs_repair_io_failure(fs_info, 0, start, len,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a0ffd41c5cc1..6ee63ff61e4a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -78,7 +78,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		eb = list_first_entry(&fs_info->allocated_ebs,
 				      struct extent_buffer, leak_list);
 		pr_err(
-	"BTRFS: buffer leak start %llu len %lu refs %d bflags %lu owner %llu\n",
+	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
 		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
 		       btrfs_header_owner(eb));
 		list_del(&eb->leak_list);
@@ -738,6 +738,8 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, gfp_t extra_gfp)
 
 	for (int i = 0; i < num_pages; i++)
 		eb->folios[i] = page_folio(page_array[i]);
+	eb->folio_size = PAGE_SIZE;
+	eb->folio_shift = PAGE_SHIFT;
 	return 0;
 }
 
@@ -1739,10 +1741,10 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			folio_lock(folio);
 			folio_clear_dirty_for_io(folio);
 			folio_start_writeback(folio);
-			ret = bio_add_folio(&bbio->bio, folio, folio_size(folio), 0);
+			ret = bio_add_folio(&bbio->bio, folio, eb->folio_size, 0);
 			ASSERT(ret);
 			wbc_account_cgroup_owner(wbc, folio_page(folio, 0),
-						 folio_size(folio));
+						 eb->folio_size);
 			wbc->nr_to_write -= folio_nr_pages(folio);
 			folio_unlock(folio);
 		}
@@ -3534,7 +3536,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	/* For now, we should only have single-page folios for btree inode. */
 	ASSERT(folio_nr_pages(existing_folio) == 1);
 
-	if (folio_size(existing_folio) != folio_size(eb->folios[0])) {
+	if (folio_size(existing_folio) != eb->folio_size) {
 		folio_unlock(existing_folio);
 		folio_put(existing_folio);
 		return -EAGAIN;
@@ -3677,6 +3679,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
+		eb->folio_size = folio_size(folio);
+		eb->folio_shift = folio_shift(folio);
 		spin_lock(&mapping->private_lock);
 		/* Should not fail, as we have preallocated the memory */
 		ret = attach_extent_buffer_folio(eb, folio, prealloc);
@@ -4126,7 +4130,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		for (int i = 0; i < num_folios; i++) {
 			struct folio *folio = eb->folios[i];
 
-			ret = bio_add_folio(&bbio->bio, folio, folio_size(folio), 0);
+			ret = bio_add_folio(&bbio->bio, folio, eb->folio_size, 0);
 			ASSERT(ret);
 		}
 	}
@@ -4146,7 +4150,7 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
 			    unsigned long len)
 {
 	btrfs_warn(eb->fs_info,
-		"access to eb bytenr %llu len %lu out of range start %lu len %lu",
+		"access to eb bytenr %llu len %u out of range start %lu len %lu",
 		eb->start, eb->len, start, len);
 	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 
@@ -4175,7 +4179,7 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 			unsigned long start, unsigned long len)
 {
-	const int unit_size = folio_size(eb->folios[0]);
+	const int unit_size = eb->folio_size;
 	size_t cur;
 	size_t offset;
 	char *dst = (char *)dstv;
@@ -4215,7 +4219,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dstv,
 				       unsigned long start, unsigned long len)
 {
-	const int unit_size = folio_size(eb->folios[0]);
+	const int unit_size = eb->folio_size;
 	size_t cur;
 	size_t offset;
 	char __user *dst = (char __user *)dstv;
@@ -4255,7 +4259,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len)
 {
-	const int unit_size = folio_size(eb->folios[0]);
+	const int unit_size = eb->folio_size;
 	size_t cur;
 	size_t offset;
 	char *kaddr;
@@ -4326,7 +4330,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 				  const void *srcv, unsigned long start,
 				  unsigned long len, bool use_memmove)
 {
-	const int unit_size = folio_size(eb->folios[0]);
+	const int unit_size = eb->folio_size;
 	size_t cur;
 	size_t offset;
 	char *kaddr;
@@ -4375,7 +4379,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 				 unsigned long start, unsigned long len)
 {
-	const int unit_size = folio_size(eb->folios[0]);
+	const int unit_size = eb->folio_size;
 	unsigned long cur = start;
 
 	if (eb->addr) {
@@ -4406,7 +4410,7 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src)
 {
-	const int unit_size = folio_size(src->folios[0]);
+	const int unit_size = src->folio_size;
 	unsigned long cur = 0;
 
 	ASSERT(dst->len == src->len);
@@ -4428,7 +4432,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len)
 {
-	const int unit_size = folio_size(dst->folios[0]);
+	const int unit_size = dst->folio_size;
 	u64 dst_len = dst->len;
 	size_t cur;
 	size_t offset;
@@ -4484,10 +4488,10 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
 	 * the bitmap item in the extent buffer + the offset of the byte in the
 	 * bitmap item.
 	 */
-	offset = start + offset_in_folio(eb->folios[0], eb->start) + byte_offset;
+	offset = start + offset_in_eb_folio(eb, eb->start) + byte_offset;
 
-	*folio_index = offset >> folio_shift(eb->folios[0]);
-	*folio_offset = offset_in_folio(eb->folios[0], offset);
+	*folio_index = offset >> eb->folio_shift;
+	*folio_offset = offset_in_eb_folio(eb, offset);
 }
 
 /*
@@ -4601,7 +4605,7 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
-	const int unit_size = folio_size(dst->folios[0]);
+	const int unit_size = dst->folio_size;
 	unsigned long cur_off = 0;
 
 	if (check_eb_range(dst, dst_offset, len) ||
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 46050500529b..8e5639597800 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -8,6 +8,7 @@
 #include <linux/fiemap.h>
 #include <linux/btrfs_tree.h>
 #include "compression.h"
+#include "messages.h"
 #include "ulist.h"
 #include "misc.h"
 
@@ -75,7 +76,8 @@ void __cold extent_buffer_free_cachep(void);
 #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
-	unsigned long len;
+	u32 len;
+	u32 folio_size;
 	unsigned long bflags;
 	struct btrfs_fs_info *fs_info;
 
@@ -90,6 +92,7 @@ struct extent_buffer {
 	int read_mirror;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
+	u8 folio_shift;
 	struct rcu_head rcu_head;
 
 	struct rw_semaphore lock;
@@ -113,6 +116,13 @@ struct btrfs_eb_write_context {
 	struct btrfs_block_group *zoned_bg;
 };
 
+static inline unsigned long offset_in_eb_folio(const struct extent_buffer *eb,
+					       u64 start)
+{
+	ASSERT(eb->folio_size);
+	return start & (eb->folio_size - 1);
+}
+
 /*
  * Get the correct offset inside the page of extent buffer.
  *
@@ -151,13 +161,13 @@ static inline unsigned long get_eb_folio_index(const struct extent_buffer *eb,
 	 *	   the folio_shift would be large enough to always make us
 	 *	   return 0 as index.
 	 *    1.2) Several page sized folios
-	 *         The folio_shift() would be PAGE_SHIFT, giving us the correct
+	 *         The folio_shift would be PAGE_SHIFT, giving us the correct
 	 *         index.
 	 *
 	 * 2) sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE case
 	 *    The folio would only be page sized, and always give us 0 as index.
 	 */
-	return offset >> folio_shift(eb->folios[0]);
+	return offset >> eb->folio_shift;
 }
 
 /*
-- 
2.43.0


