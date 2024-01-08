Return-Path: <linux-btrfs+bounces-1294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854282675C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227121F2167A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F217E9;
	Mon,  8 Jan 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wx5xZRm6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wx5xZRm6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E87F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 442181FCF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 03:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704684047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbuuyT+QHigL8OZVciRikSTYJ4eeDLDED9N7Sexb8Rc=;
	b=Wx5xZRm6sSGLpWk8istKzfwaKcOJ40/1Dh4rlu28XKvpVsdBkwviAgHRJKrJR0VkrCXTDG
	SEmPpfsdGFjxPATXLml1EnrvwVgzmKfbaQ7nSSIClYiWQtJqKwUvSaCEUNFEdj4mAQjBIk
	u0RWUZQ7iSQR7/9bpc0gtyeQqNzmFFE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704684047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZbuuyT+QHigL8OZVciRikSTYJ4eeDLDED9N7Sexb8Rc=;
	b=Wx5xZRm6sSGLpWk8istKzfwaKcOJ40/1Dh4rlu28XKvpVsdBkwviAgHRJKrJR0VkrCXTDG
	SEmPpfsdGFjxPATXLml1EnrvwVgzmKfbaQ7nSSIClYiWQtJqKwUvSaCEUNFEdj4mAQjBIk
	u0RWUZQ7iSQR7/9bpc0gtyeQqNzmFFE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BA1313496
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 03:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fjYOLwtqm2VKOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 03:20:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the pg_offset parameter from btrfs_get_extent()
Date: Mon,  8 Jan 2024 13:50:20 +1030
Message-ID: <b9e7e1925514a545c91f7e67cace5feda37fc82e.1704684018.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wx5xZRm6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 442181FCF8
X-Spam-Flag: NO

The parameter @pg_offset of btrfs_get_extent() is only utilized for
inlined extent, and we already have an ASSERT() and tree-checker, to
make sure we can only get inline extent at file offset 0.

Any invalid inline extent with non-zero file offset would be rejected by
tree-checker in the first place.

Thus the @pg_offset parameter is not really necessary, just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h       |  3 +--
 fs/btrfs/extent_io.c         |  8 ++++----
 fs/btrfs/file.c              | 10 ++++-----
 fs/btrfs/inode.c             | 15 ++++++--------
 fs/btrfs/tests/inode-tests.c | 40 ++++++++++++++++++------------------
 5 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 7f7c5a92d2b8..83d78a6f3aa2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -490,8 +490,7 @@ struct inode *btrfs_iget_path(struct super_block *s, u64 ino,
 			      struct btrfs_root *root, struct btrfs_path *path);
 struct inode *btrfs_iget(struct super_block *s, u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len);
+				    struct page *page, u64 start, u64 len);
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8bac62be0831..3f9d2ed4b192 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -984,7 +984,7 @@ void btrfs_clear_data_folio_managed(struct folio *folio)
 }
 
 static struct extent_map *
-__get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
+__get_extent_map(struct inode *inode, struct page *page,
 		 u64 start, u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
@@ -1001,7 +1001,7 @@ __get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
 		*em_cached = NULL;
 	}
 
-	em = btrfs_get_extent(BTRFS_I(inode), page, pg_offset, start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), page, start, len);
 	if (em_cached && !IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
@@ -1064,7 +1064,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			end_page_read(page, true, cur, iosize);
 			break;
 		}
-		em = __get_extent_map(inode, page, pg_offset, cur,
+		em = __get_extent_map(inode, page, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			unlock_extent(tree, cur, end, NULL);
@@ -1384,7 +1384,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		em = btrfs_get_extent(inode, NULL, 0, cur, len);
+		em = btrfs_get_extent(inode, NULL, cur, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR_OR_ZERO(em);
 			goto out_error;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b6362b381f14..314f8aa11533 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2176,7 +2176,7 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	struct extent_map *em;
 	int ret = 0;
 
-	em = btrfs_get_extent(inode, NULL, 0,
+	em = btrfs_get_extent(inode, NULL,
 			      round_down(*start, fs_info->sectorsize),
 			      round_up(*len, fs_info->sectorsize));
 	if (IS_ERR(em))
@@ -2835,7 +2835,7 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	int ret;
 
 	offset = round_down(offset, sectorsize);
-	em = btrfs_get_extent(inode, NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(inode, NULL, offset, sectorsize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -2866,7 +2866,7 @@ static int btrfs_zero_range(struct inode *inode,
 	u64 bytes_to_reserve = 0;
 	bool space_reserved = false;
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
 			      alloc_end - alloc_start);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -2909,7 +2909,7 @@ static int btrfs_zero_range(struct inode *inode,
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start,
 				      sectorsize);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
@@ -3126,7 +3126,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	/* First, check if we exceed the qgroup limit */
 	while (cur_offset < alloc_end) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, cur_offset,
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, cur_offset,
 				      alloc_end - cur_offset);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index acc5835c9777..8f0ca1366a94 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2632,7 +2632,7 @@ static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
 		u64 em_len;
 		int ret = 0;
 
-		em = btrfs_get_extent(inode, NULL, 0, search_start, search_len);
+		em = btrfs_get_extent(inode, NULL, search_start, search_len);
 		if (IS_ERR(em))
 			return PTR_ERR(em);
 
@@ -4888,7 +4888,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 					   &cached_state);
 	cur_offset = hole_start;
 	while (1) {
-		em = btrfs_get_extent(inode, NULL, 0, cur_offset,
+		em = btrfs_get_extent(inode, NULL, cur_offset,
 				      block_end - cur_offset);
 		if (IS_ERR(em)) {
 			err = PTR_ERR(em);
@@ -6737,7 +6737,6 @@ static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path
  *
  * @inode:	file to search in
  * @page:	page to read extent data into if the extent is inline
- * @pg_offset:	offset into @page to copy to
  * @start:	file offset
  * @len:	length of range starting at @start
  *
@@ -6751,8 +6750,7 @@ static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path
  * Return: ERR_PTR on error, non-NULL extent_map on success.
  */
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
-				    struct page *page, size_t pg_offset,
-				    u64 start, u64 len)
+				    struct page *page, u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
@@ -6895,7 +6893,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		 * ensured by tree-checker and inline extent creation path.
 		 * Thus all members representing file offsets should be zero.
 		 */
-		ASSERT(pg_offset == 0);
 		ASSERT(extent_start == 0);
 		ASSERT(em->start == 0);
 
@@ -7536,7 +7533,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (ret < 0)
 		goto err;
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto unlock_err;
@@ -10124,7 +10121,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		cond_resched();
 	}
 
-	em = btrfs_get_extent(inode, NULL, 0, start, lockend - start + 1);
+	em = btrfs_get_extent(inode, NULL, start, lockend - start + 1);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_unlock_extent;
@@ -10697,7 +10694,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		struct btrfs_block_group *bg;
 		u64 len = isize - start;
 
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 9957de9f7806..99da9d34b77a 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -258,7 +258,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 
 	/* First with no extents */
 	BTRFS_I(inode)->root = root;
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize);
 	if (IS_ERR(em)) {
 		em = NULL;
 		test_err("got an error when we shouldn't have");
@@ -278,7 +278,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	 */
 	setup_file_extents(root, sectorsize);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, (u64)-1);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, (u64)-1);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -316,7 +316,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -339,7 +339,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Regular extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -367,7 +367,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are split extents */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -396,7 +396,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -418,7 +418,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -452,7 +452,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -481,7 +481,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* The next 3 are a half written prealloc extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -511,7 +511,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -544,7 +544,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -579,7 +579,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Now for the compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -613,7 +613,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* Split compressed extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -648,7 +648,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -675,7 +675,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -710,7 +710,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	free_extent_map(em);
 
 	/* A hole between regular extents but no hole extent */
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset + 6, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset + 6, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -737,7 +737,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, SZ_4M);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, SZ_4M);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -770,7 +770,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	offset = em->start + em->len;
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, offset, sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -850,7 +850,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	insert_inode_item_key(root);
 	insert_extent(root, sectorsize, sectorsize, sectorsize, 0, sectorsize,
 		      sectorsize, BTRFS_FILE_EXTENT_REG, 0, 1);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 0, 2 * sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, 2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
@@ -872,7 +872,7 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	}
 	free_extent_map(em);
 
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, sectorsize, 2 * sectorsize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, sectorsize, 2 * sectorsize);
 	if (IS_ERR(em)) {
 		test_err("got an error when we shouldn't have");
 		goto out;
-- 
2.43.0


