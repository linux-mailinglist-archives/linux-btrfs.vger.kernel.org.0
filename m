Return-Path: <linux-btrfs+bounces-2643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DBF85F7D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534AF2887C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62F60873;
	Thu, 22 Feb 2024 12:15:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8E60ED5
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604115; cv=none; b=PdTt5lQzRZK/Jh70hRRJwlAXEa98RSo1OAx6uH9zRqvdBjA9oY8/ooBYz3+Puw0kJQ5YXsb7zF9yFWLJCwo3ldbJ2W5BunyGpmyAXr7WjnZxYm97mAspWm4UwnCAGVP34v3+hA0TWHZlNaFl3wi+ae0wlwpqHtKJqjWS3KeMGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604115; c=relaxed/simple;
	bh=Gs4j4xr3e0XrvlVS1JNbbB644Gsqaa2q+yGzn8vPPHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4BcUGpwcLLdRYP7hyu9UdX01b1JjyI8HZ9FpQEmA7xoXpBC1ICdTTxf6a2+HxSz81yUNR800dKBu4zK2SE3jOpS3KIIt5srEYNNKYLlIi5DyIp7FJiFhNqXKUAzhJ9NAdWv27vkzbfwHLUS0UlDOMxqhnhZKrHyacaLlcBPDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A10CE22040;
	Thu, 22 Feb 2024 12:15:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A02313A6B;
	Thu, 22 Feb 2024 12:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id re+WJc4612WlRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 12:15:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: pass a valid extent map cache pointer to __get_extent_map()
Date: Thu, 22 Feb 2024 13:14:33 +0100
Message-ID: <cdec7ef7d6543d1e96406822334f15882cd99dc6.1708603965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>
References: <cover.1708603965.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A10CE22040
X-Spam-Flag: NO

We can pass a valid em cache pointer down to __get_extent_map() and
drop the validity check. This avoids the special case, the call stacks
are simple:

btrfs_read_folio
  btrfs_do_readpage
    __get_extent_map

extent_readahead
  contiguous_readpages
    btrfs_do_readpage
      __get_extent_map

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e2dbadfc082f..43496a07ee42 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -970,7 +970,9 @@ static struct extent_map *__get_extent_map(struct inode *inode, struct page *pag
 {
 	struct extent_map *em;
 
-	if (em_cached && *em_cached) {
+	ASSERT(em_cached);
+
+	if (*em_cached) {
 		em = *em_cached;
 		if (extent_map_in_tree(em) && start >= em->start &&
 		    start < extent_map_end(em)) {
@@ -983,7 +985,7 @@ static struct extent_map *__get_extent_map(struct inode *inode, struct page *pag
 	}
 
 	em = btrfs_get_extent(BTRFS_I(inode), page, start, len);
-	if (em_cached && !IS_ERR(em)) {
+	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
@@ -1154,11 +1156,12 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
+	struct extent_map *em_cached = NULL;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(page, &em_cached, &bio_ctrl, NULL);
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
 	 * bio to do the cleanup.
@@ -1176,6 +1179,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	struct btrfs_inode *inode = page_to_inode(pages[0]);
 	int index;
 
+	ASSERT(em_cached);
+
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	for (index = 0; index < nr_pages; index++) {
-- 
2.42.1


