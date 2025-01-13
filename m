Return-Path: <linux-btrfs+bounces-10931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC45A0B362
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056EE1881994
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85C621ADAA;
	Mon, 13 Jan 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n8ha2e6X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n8ha2e6X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930911FDA96
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761357; cv=none; b=mmvLaBNvCv1MnYVXQM7tvwlgXOQT6D0iX7ihKBS60PRo9p+87RGKG5EmNAUMS3c1kSdF38mDozbJEK8e2GW1/8AXvqymdu521WUxI9+MvczBAHGjtp9n9nqCynmQzx7G1JDFwhTzjJzYi5ESOU81uVDZkN+QcR07azOBguAwSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761357; c=relaxed/simple;
	bh=AL5uYGuxCY00QM3R98sQ1LdpNpeTG6EIWioAg3o8iEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHLj2oZW84o2Hnu2RXQrox7/puexLb7rfBTP53CMWys2Z+2YCHid9Z/oYntT4dvnb66iDwKOzdQyP2ST3C9sizf/peSNhbX3meu8647+Zd5nFgrFETi9Ad5jixi2GSmxXwhAi2d+emrodZoUa0bsEY5ZI1fxMqn7BluMFs3MQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n8ha2e6X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n8ha2e6X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A40D821167
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W39wqmL5drYwOXIeOeLBFIhcyynOMZAFH+L8jJBlZcU=;
	b=n8ha2e6XcdqH4zCFSPYKNDLOuVqVq8Xp7Uyp5M+mSDlmYvL7p3YtSU8CIwVCk+idUkyd/m
	jAeUJt/g69Sd8Jx0CXjLWvhuRWZnyAH8jtxraIeR+Hf4UCQcSEndEFeVrRNJXvM459lcV0
	30fbuGiGrUMlDCIFn8dSwzGuvWpBMDg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736761353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W39wqmL5drYwOXIeOeLBFIhcyynOMZAFH+L8jJBlZcU=;
	b=n8ha2e6XcdqH4zCFSPYKNDLOuVqVq8Xp7Uyp5M+mSDlmYvL7p3YtSU8CIwVCk+idUkyd/m
	jAeUJt/g69Sd8Jx0CXjLWvhuRWZnyAH8jtxraIeR+Hf4UCQcSEndEFeVrRNJXvM459lcV0
	30fbuGiGrUMlDCIFn8dSwzGuvWpBMDg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E094113310
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LFOKAjghGf0WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 09:42:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: extract the nocow ordered extent and extent map generation into a helper
Date: Mon, 13 Jan 2025 20:12:12 +1030
Message-ID: <044a1ae92ce797c5c9be5ab43359ec820ed151fd.1736759698.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736759698.git.wqu@suse.com>
References: <cover.1736759698.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Currently we're doing all the ordered extent and extent map generation
inside a while() loop of run_delalloc_nocow().

This makes it pretty hard to read, nor do proper error handling.

So move that part of code into a helper, nocow_one_range().

This should not change anything, but there is a tiny timing change where
btrfs_dec_nocow_writers() is only called after nocow_one_range() helper
exits.

This timing change is small, and makes error handling easier, thus
should be fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 130 +++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 130f0490b14f..42f67f8a4a33 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1974,6 +1974,71 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
 	mapping_set_error(mapping, error);
 }
 
+static int nocow_one_range(struct btrfs_inode *inode,
+			   struct folio *locked_folio,
+			   struct extent_state **cached,
+			   struct can_nocow_file_extent_args *nocow_args,
+			   u64 file_pos, bool is_prealloc)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 len = nocow_args->file_extent.num_bytes;
+	u64 end = file_pos + len - 1;
+	int ret = 0;
+
+	lock_extent(&inode->io_tree, file_pos, end, cached);
+
+	if (is_prealloc) {
+		struct extent_map *em;
+
+		em = btrfs_create_io_em(inode, file_pos,
+					&nocow_args->file_extent,
+					BTRFS_ORDERED_PREALLOC);
+		if (IS_ERR(em)) {
+			unlock_extent(&inode->io_tree, file_pos,
+				      end, cached);
+			return PTR_ERR(em);
+		}
+		free_extent_map(em);
+	}
+
+	ordered = btrfs_alloc_ordered_extent(inode, file_pos,
+			&nocow_args->file_extent,
+			is_prealloc
+			? (1 << BTRFS_ORDERED_PREALLOC)
+			: (1 << BTRFS_ORDERED_NOCOW));
+	if (IS_ERR(ordered)) {
+		if (is_prealloc) {
+			btrfs_drop_extent_map_range(inode, file_pos,
+						    end, false);
+		}
+		unlock_extent(&inode->io_tree, file_pos,
+			      end, cached);
+		return PTR_ERR(ordered);
+	}
+
+	if (btrfs_is_data_reloc_root(inode->root))
+		/*
+		 * Error handled later, as we must prevent
+		 * extent_clear_unlock_delalloc() in error handler
+		 * from freeing metadata of created ordered extent.
+		 */
+		ret = btrfs_reloc_clone_csums(ordered);
+	btrfs_put_ordered_extent(ordered);
+
+	extent_clear_unlock_delalloc(inode, file_pos, end,
+				     locked_folio, cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_CLEAR_DATA_RESV,
+				     PAGE_UNLOCK | PAGE_SET_ORDERED);
+
+	/*
+	 * btrfs_reloc_clone_csums() error, now we're OK to call error
+	 * handler, as metadata for created ordered extent will only
+	 * be freed by btrfs_finish_ordered_io().
+	 */
+	return ret;
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -2018,15 +2083,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	while (cur_offset <= end) {
 		struct btrfs_block_group *nocow_bg = NULL;
-		struct btrfs_ordered_extent *ordered;
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
 		struct extent_state *cached_state = NULL;
 		u64 extent_end;
-		u64 nocow_end;
 		int extent_type;
-		bool is_prealloc;
 
 		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
 					       cur_offset, 0);
@@ -2160,67 +2222,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		}
 
-		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
-		lock_extent(&inode->io_tree, cur_offset, nocow_end, &cached_state);
-
-		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
-		if (is_prealloc) {
-			struct extent_map *em;
-
-			em = btrfs_create_io_em(inode, cur_offset,
-						&nocow_args.file_extent,
-						BTRFS_ORDERED_PREALLOC);
-			if (IS_ERR(em)) {
-				unlock_extent(&inode->io_tree, cur_offset,
-					      nocow_end, &cached_state);
-				btrfs_dec_nocow_writers(nocow_bg);
-				ret = PTR_ERR(em);
-				goto error;
-			}
-			free_extent_map(em);
-		}
-
-		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
-				&nocow_args.file_extent,
-				is_prealloc
-				? (1 << BTRFS_ORDERED_PREALLOC)
-				: (1 << BTRFS_ORDERED_NOCOW));
+		ret = nocow_one_range(inode, locked_folio, &cached_state,
+				      &nocow_args, cur_offset,
+				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
 		btrfs_dec_nocow_writers(nocow_bg);
-		if (IS_ERR(ordered)) {
-			if (is_prealloc) {
-				btrfs_drop_extent_map_range(inode, cur_offset,
-							    nocow_end, false);
-			}
-			unlock_extent(&inode->io_tree, cur_offset,
-				      nocow_end, &cached_state);
-			ret = PTR_ERR(ordered);
+		if (ret < 0)
 			goto error;
-		}
-
-		if (btrfs_is_data_reloc_root(root))
-			/*
-			 * Error handled later, as we must prevent
-			 * extent_clear_unlock_delalloc() in error handler
-			 * from freeing metadata of created ordered extent.
-			 */
-			ret = btrfs_reloc_clone_csums(ordered);
-		btrfs_put_ordered_extent(ordered);
-
-		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_folio, &cached_state,
-					     EXTENT_LOCKED | EXTENT_DELALLOC |
-					     EXTENT_CLEAR_DATA_RESV,
-					     PAGE_UNLOCK | PAGE_SET_ORDERED);
-
 		cur_offset = extent_end;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, now we're OK to call error
-		 * handler, as metadata for created ordered extent will only
-		 * be freed by btrfs_finish_ordered_io().
-		 */
-		if (ret)
-			goto error;
 	}
 	btrfs_release_path(path);
 
-- 
2.47.1


