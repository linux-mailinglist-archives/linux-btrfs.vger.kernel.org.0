Return-Path: <linux-btrfs+bounces-9408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A219C3738
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 04:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BACB209B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF414C59C;
	Mon, 11 Nov 2024 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nwaa/XNX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nwaa/XNX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F014A4DD
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297577; cv=none; b=m1cSVDJxCa9Dd6n9fvw6YU74/4qZdT/bupa4QQgck12rUM17YBf0g0qy96u0njffomzGXFjeoTwCRxFLGu6udbY0X2oxDncnpzpYUpygaYp+uNuqzDjVjJAGoy7c9CSQzB1LYsIQen2a288UXEVzByQHyR4aK/RcLyseYpEqjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297577; c=relaxed/simple;
	bh=dWLZ5gxwBuW2/gjDMt7WUy7wHRGZXIKbxEMqlau9YLg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+oCjuX7j65AAOYnHrupD1G6Oc2IwABu3K/dtSoALHudrHXRe0Uoh4cRUMs7J703BKZEy4N7GdM3v7JCKQkgQkLBsbADj28k1mBvyMkdyJIHtpPYJoEmwYdIA2cNgpFPGSOdnGMYm7UoZ8aYWiAgefb9u4z4rHJLZMgDDm9othk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nwaa/XNX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nwaa/XNX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 346071F38F
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GToqli9dudWvgzuwXPqesWYC1RVoePMg4Nws7YPfRt4=;
	b=nwaa/XNXq+89lW+jfHSATo1rjyenC9vFzXbvTIA3CtcvSKswtIvyvgDg8uBtqK2onwz3ja
	3ltX1nkPrNDAqWmEtc1oL/rEy1Vq+uY7GV3ceRKDCBw/4+6DELmQZhXZ7FL7ntx7fh0nus
	WLYvApMZ/3JyHWjHi8mkn6E3bC+aXNg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GToqli9dudWvgzuwXPqesWYC1RVoePMg4Nws7YPfRt4=;
	b=nwaa/XNXq+89lW+jfHSATo1rjyenC9vFzXbvTIA3CtcvSKswtIvyvgDg8uBtqK2onwz3ja
	3ltX1nkPrNDAqWmEtc1oL/rEy1Vq+uY7GV3ceRKDCBw/4+6DELmQZhXZ7FL7ntx7fh0nus
	WLYvApMZ/3JyHWjHi8mkn6E3bC+aXNg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 646EC13967
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OALQCSOBMWcbJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()
Date: Mon, 11 Nov 2024 14:29:09 +1030
Message-ID: <d933e0d375e4e36cb8b946cbcc5ef59c4bb6fad8.1731297381.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731297381.git.wqu@suse.com>
References: <cover.1731297381.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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

Inside btrfs_buffered_write() we have an out-of-loop cleanup, which is
only affecting the following call sites:

- balance_dirty_pages_ratelimited_flags() failure
- prepare_one_folio() failure
- lock_and_cleanup_extent_if_need() failure
- btrfs_dirty_folio() failure

This patch extracts the out-of-loop cleanup into a helper,
buffered_write_release() so that above call sites can call that helper
before break, and remove the out-of-loop cleanup.

This allows us to:

- Remove @release_bytes completely
  Now every call site can directly use @pos, @write_bytes (or @copied)
  at the cleanup helper.

- Move @only_release_metadata into the loop

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 51 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5fba2e44c630..5bfa040d3856 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1087,6 +1087,27 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 	return 0;
 }
 
+static void buffered_write_release(struct btrfs_inode *binode,
+		struct extent_changeset *data_reserved, u64 pos, u64 len,
+		bool only_release_metadata)
+{
+	const u32 sectorsize = binode->root->fs_info->sectorsize;
+	u64 aligned_start;
+	u64 aligned_len;
+
+	if (!len)
+		return;
+	aligned_start = round_down(pos, sectorsize);
+	aligned_len = round_up(pos + len, sectorsize) - aligned_start;
+
+	if (only_release_metadata) {
+		btrfs_check_nocow_unlock(binode);
+		btrfs_delalloc_release_metadata(binode, aligned_len, true);
+	} else {
+		btrfs_delalloc_release_space(binode, data_reserved, pos, len, true);
+	}
+}
+
 ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
@@ -1094,7 +1115,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_changeset *data_reserved = NULL;
-	u64 release_bytes = 0;
 	u64 lockstart;
 	u64 lockend;
 	size_t num_written = 0;
@@ -1103,7 +1123,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
-	bool only_release_metadata = false;
 	const u32 sectorsize = fs_info->sectorsize;
 
 	if (nowait)
@@ -1131,6 +1150,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		struct folio *folio = NULL;
 		int extents_locked;
 		bool force_page_uptodate = false;
+		bool only_release_metadata = false;
 
 		/*
 		 * Fault pages before locking them in prepare_one_folio()
@@ -1145,8 +1165,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		only_release_metadata = false;
-
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
 						  &data_reserved, pos,
@@ -1194,11 +1212,12 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		release_bytes = reserve_bytes;
 again:
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+			buffered_write_release(BTRFS_I(inode), data_reserved,
+					       pos, write_bytes, only_release_metadata);
 			break;
 		}
 
@@ -1207,6 +1226,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
+			buffered_write_release(BTRFS_I(inode), data_reserved,
+					       pos, write_bytes, only_release_metadata);
 			break;
 		}
 
@@ -1219,6 +1240,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
+			buffered_write_release(BTRFS_I(inode), data_reserved,
+					       pos, write_bytes, only_release_metadata);
 			ret = extents_locked;
 			break;
 		}
@@ -1263,8 +1286,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			}
 		}
 
-		release_bytes = dirty_bytes;
-
 		ret = btrfs_dirty_folio(BTRFS_I(inode), folio, pos, copied,
 					&cached_state, only_release_metadata);
 
@@ -1284,10 +1305,11 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
 			btrfs_drop_folio(fs_info, folio, pos, copied);
+			buffered_write_release(BTRFS_I(inode), data_reserved,
+					       pos, copied, only_release_metadata);
 			break;
 		}
 
-		release_bytes = 0;
 		if (only_release_metadata)
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
@@ -1299,19 +1321,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		num_written += copied;
 	}
 
-	if (release_bytes) {
-		if (only_release_metadata) {
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved,
-					round_down(pos, fs_info->sectorsize),
-					release_bytes, true);
-		}
-	}
-
 	extent_changeset_free(data_reserved);
 	if (num_written > 0) {
 		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
-- 
2.47.0


