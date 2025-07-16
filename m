Return-Path: <linux-btrfs+bounces-15530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7572B07F61
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446761C426A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 21:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3C28BA8B;
	Wed, 16 Jul 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EfZ8ffzz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EfZ8ffzz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC921D79BE
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700524; cv=none; b=e7Oe78vweTg040Qke7LfWUlkkwTzP/ty/Ts5rlxpW9Jz63MAZgkWt7V7UEgpdXXSm9mywywnObbCd+zkMvTW5SYKNjz5fp3llflShnWryYRMElegkg2J0SZk51OJ4RsIuv3/nGGLocJhBBLDbGx81X7IIoKVOy3Q5uG9/LUOFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700524; c=relaxed/simple;
	bh=DDmjuXiovzl6i2lE+RJ1JaCzos2czKrXggEyYv59KOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBn7V2TcGjzac4pGF+5xtvmjm0cCarsibR4QEqAJVS7uYxr5krKV4o3RFw6Xu/Kt0nQz7Zixrl1ndvzjJqzLa0yxSBGhhP1xEeOZBbHaV3UiUkANUevocdLn9f4rR2rgB9OOQJ0Ec0X8+RpDJj4COAukSp552Ewr+pD/nMY+0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EfZ8ffzz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EfZ8ffzz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44A5321216
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjVEPH0sni9BzUUjgc7J8sO/iaJX6arnHG3DK8n/SpU=;
	b=EfZ8ffzzOeezZTa4+jbzGsgZVu2Svpyh2VUwt+GsJbYoxOC0ir9GW0/cUtj/K4vEUjtBww
	nPpcWxISIM9/2GbgojJsCNsvRpPSQI4WvX3FG43+MFa0UK5xsTQ8vWMBLY0iRYlFgQ0UIR
	RU4hjVL5XUFAPAv8oscInyin4DekwmQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EfZ8ffzz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjVEPH0sni9BzUUjgc7J8sO/iaJX6arnHG3DK8n/SpU=;
	b=EfZ8ffzzOeezZTa4+jbzGsgZVu2Svpyh2VUwt+GsJbYoxOC0ir9GW0/cUtj/K4vEUjtBww
	nPpcWxISIM9/2GbgojJsCNsvRpPSQI4WvX3FG43+MFa0UK5xsTQ8vWMBLY0iRYlFgQ0UIR
	RU4hjVL5XUFAPAv8oscInyin4DekwmQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470D913306
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sI3IOmYWeGipBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: reloc: unconditionally invalidate the page cache for each cluster
Date: Thu, 17 Jul 2025 06:44:57 +0930
Message-ID: <82c8337542eee11ad3c8b05b5278f88599ce4496.1752700452.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752700452.git.wqu@suse.com>
References: <cover.1752700452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 44A5321216
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Commit 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially
overwriting last page data") fixed a bug when relocating data block
groups for subpage cases.

However for the incoming large folios for data reloc inode, we can hit
the same situation where block size is the same as page size, but the
folio we got is still larger than a block.

In that case, the old subpage specific check is no longer reliable.

Here we have to enhance the handling by:

- Unconditionally invalidate the page cache for the current cluster
  We set the @flush to true so that any dirty folios are properly
  written back first.

  And this time instead of dropping the whole page cache, just drop the
  range covered by the current cluster.

  This will bring some minor performance drop, as for a large folio, the
  heading half will be read twice (read by previous cluster, then
  invalidated, then read again by the current cluster).

  However that is required to support large folios, and this gets rid of
  the kinda tricky manual uptodate flag clearing for each block.

- Remove the special handling of writing back the whole page cache
  filemap_invalidate_inode() handles the write back already, and since
  we're invalidating all pages in the range, we no longer need to
  manually clear the uptodate flags for involved blocks.

  Thus there is no need to manually write back the whole page cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 58 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8a71cffb4dfb..fa93ba40278d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2666,66 +2666,24 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	u64 num_bytes;
 	int nr;
 	int ret = 0;
-	u64 i_size = i_size_read(&inode->vfs_inode);
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
 	u64 cur_offset = prealloc_start;
 
 	/*
-	 * For subpage case, previous i_size may not be aligned to PAGE_SIZE.
-	 * This means the range [i_size, PAGE_END + 1) is filled with zeros by
-	 * btrfs_do_readpage() call of previously relocated file cluster.
+	 * For blocksize < folio size case (either bs < page size or large folios),
+	 * beyond i_size, all blocks are filled with zero.
 	 *
-	 * If the current cluster starts in the above range, btrfs_do_readpage()
+	 * If the current cluster covers above range, btrfs_do_readpage()
 	 * will skip the read, and relocate_one_folio() will later writeback
 	 * the padding zeros as new data, causing data corruption.
 	 *
-	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
+	 * Here we have to invalidate the cache covering our cluster.
 	 */
-	if (!PAGE_ALIGNED(i_size)) {
-		struct address_space *mapping = inode->vfs_inode.i_mapping;
-		struct btrfs_fs_info *fs_info = inode->root->fs_info;
-		const u32 sectorsize = fs_info->sectorsize;
-		struct folio *folio;
-
-		ASSERT(sectorsize < PAGE_SIZE);
-		ASSERT(IS_ALIGNED(i_size, sectorsize));
-
-		/*
-		 * Subpage can't handle page with DIRTY but without UPTODATE
-		 * bit as it can lead to the following deadlock:
-		 *
-		 * btrfs_read_folio()
-		 * | Page already *locked*
-		 * |- btrfs_lock_and_flush_ordered_range()
-		 *    |- btrfs_start_ordered_extent()
-		 *       |- extent_write_cache_pages()
-		 *          |- lock_page()
-		 *             We try to lock the page we already hold.
-		 *
-		 * Here we just writeback the whole data reloc inode, so that
-		 * we will be ensured to have no dirty range in the page, and
-		 * are safe to clear the uptodate bits.
-		 *
-		 * This shouldn't cause too much overhead, as we need to write
-		 * the data back anyway.
-		 */
-		ret = filemap_write_and_wait(mapping);
-		if (ret < 0)
-			return ret;
-
-		folio = filemap_lock_folio(mapping, i_size >> PAGE_SHIFT);
-		/*
-		 * If page is freed we don't need to do anything then, as we
-		 * will re-read the whole page anyway.
-		 */
-		if (!IS_ERR(folio)) {
-			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
-					round_up(i_size, PAGE_SIZE) - i_size);
-			folio_unlock(folio);
-			folio_put(folio);
-		}
-	}
+	ret = filemap_invalidate_inode(&inode->vfs_inode, true, prealloc_start,
+				       prealloc_end);
+	if (ret < 0)
+		return ret;
 
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	ret = btrfs_alloc_data_chunk_ondemand(inode,
-- 
2.50.0


