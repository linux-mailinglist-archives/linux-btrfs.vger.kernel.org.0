Return-Path: <linux-btrfs+bounces-1382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3982C82A5AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD91284B2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 01:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0421A44;
	Thu, 11 Jan 2024 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IfR5fs/1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AQrsvPlC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b1p0IdlB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9V3xrnjf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC7EA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B5F9221DF
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704938014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+dZRRA6hng4T0Ccbd9TCPjVu6LUr5vTTbPSsVr94p7k=;
	b=IfR5fs/10WcEGL7XMtGCef2lax+ZqSb4TJq+XeGyRbsgA8fWiyLTtcL0PLv5plGkqWq8Zz
	bnrUB0khweWBui94Ug3GQT5VAyRQVuB53S7qTZiiUgWYk6aW8YqbbcfyRE+9l5QksF1wn5
	0dCiLqNf8NnQj0d6A5j8ndcF4ZhSxU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704938014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+dZRRA6hng4T0Ccbd9TCPjVu6LUr5vTTbPSsVr94p7k=;
	b=AQrsvPlCXZmsGhtAAJyhcZn7d834xsmCe3AdpMWfZ+aFiy3QUaZ1QDCJLmpBFRxTlQP9nV
	JSEqQL9+xkU8bZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704938090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+dZRRA6hng4T0Ccbd9TCPjVu6LUr5vTTbPSsVr94p7k=;
	b=b1p0IdlBijTjRWwfWS8e1hFTqfWw9ECdVBJ+tW6gPoMlqz0NLQ3Yh1dpVdIBcf7yIOp+u8
	fhm77bjHzGMuVx4HDrWBo8unlmltlj/rrYh9gzH2S+UoWEPJVHNLKFpYxLsnvZjvWXFfD7
	KOQ/qwQ4CosnUrS6TIlbx5OubQip1rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704938090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+dZRRA6hng4T0Ccbd9TCPjVu6LUr5vTTbPSsVr94p7k=;
	b=9V3xrnjfkplGNKc1ceIM1lTRHjnxN04d3HbqmwIbo6LiBnxf1N0dBjoev2k1B/jZxYb59x
	YTm7a55EktRnpmCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C5EE2139D7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 01:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VHqjJB1Kn2WaYAAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 01:53:33 +0000
Date: Wed, 10 Jan 2024 19:56:13 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: page to folio conversion in btrfs_truncate_block()
Message-ID: <cn7d3gijpqxtmlytcv4ztac3eb7ukd54co4csitaw6czn6bfxr@3wopycxp755q>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b1p0IdlB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9V3xrnjf
X-Spamd-Result: default: False [-6.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8B5F9221DF
X-Spam-Level: 
X-Spam-Score: -6.31
X-Spam-Flag: NO

Convert use of struct page to struct folio inside btrfs_truncate_block().
The only page based function is set_page_extent_mapped(). All other
functions have folio equivalents.

Had to use __filemap_get_folio() because filemap_grab_folio() does not
allow passing allocation mask as a parameter.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e285ddbcdee0..12c040328742 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4680,7 +4680,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	u32 blocksize = fs_info->sectorsize;
 	pgoff_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (blocksize - 1);
-	struct page *page;
+	struct folio *folio;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
 	size_t write_bytes = blocksize;
 	int ret = 0;
@@ -4712,8 +4712,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		goto out;
 	}
 again:
-	page = find_or_create_page(mapping, index, mask);
-	if (!page) {
+	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+	if (!folio) {
 		btrfs_delalloc_release_space(inode, data_reserved, block_start,
 					     blocksize, true);
 		btrfs_delalloc_release_extents(inode, blocksize);
@@ -4721,15 +4721,15 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		goto out;
 	}
 
-	if (!PageUptodate(page)) {
-		ret = btrfs_read_folio(NULL, page_folio(page));
-		lock_page(page);
-		if (page->mapping != mapping) {
-			unlock_page(page);
-			put_page(page);
+	if (!folio_test_uptodate(folio)) {
+		ret = btrfs_read_folio(NULL, folio);
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
-		if (!PageUptodate(page)) {
+		if (!folio_test_uptodate(folio)) {
 			ret = -EIO;
 			goto out_unlock;
 		}
@@ -4741,19 +4741,19 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	 * folio private, but left the page in the mapping.  Set the page mapped
 	 * here to make sure it's properly set for the subpage stuff.
 	 */
-	ret = set_page_extent_mapped(page);
+	ret = set_page_extent_mapped(&folio->page);
 	if (ret < 0)
 		goto out_unlock;
 
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
 	lock_extent(io_tree, block_start, block_end, &cached_state);
 
 	ordered = btrfs_lookup_ordered_extent(inode, block_start);
 	if (ordered) {
 		unlock_extent(io_tree, block_start, block_end, &cached_state);
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
@@ -4774,15 +4774,13 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 		if (!len)
 			len = blocksize - offset;
 		if (front)
-			memzero_page(page, (block_start - page_offset(page)),
-				     offset);
+			folio_zero_range(folio, block_start - folio_pos(folio), offset);
 		else
-			memzero_page(page, (block_start - page_offset(page)) + offset,
-				     len);
+			folio_zero_range(folio, (block_start - folio_pos(folio)) + offset, len);
 	}
-	btrfs_folio_clear_checked(fs_info, page_folio(page), block_start,
+	btrfs_folio_clear_checked(fs_info, folio, block_start,
 				  block_end + 1 - block_start);
-	btrfs_folio_set_dirty(fs_info, page_folio(page), block_start,
+	btrfs_folio_set_dirty(fs_info, folio, block_start,
 			      block_end + 1 - block_start);
 	unlock_extent(io_tree, block_start, block_end, &cached_state);
 
@@ -4799,8 +4797,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 					block_start, blocksize, true);
 	}
 	btrfs_delalloc_release_extents(inode, blocksize);
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 out:
 	if (only_release_metadata)
 		btrfs_check_nocow_unlock(inode);
-- 
2.43.0


-- 
Goldwyn

