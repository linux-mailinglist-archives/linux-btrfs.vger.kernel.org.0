Return-Path: <linux-btrfs+bounces-9499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0459C4F57
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC3B21CC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78720B1F0;
	Tue, 12 Nov 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iy5PWj5v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eDJGoZic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2420ADDE
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396247; cv=none; b=Rwab2HF9QWh6Yw/RZyMU5XFq4naRciTxEHRTj7y7Csu0j3+FpnyOoMd8wyCe8qS1SX+wfHaqT3kGZXUFxkPmo68YhFaRd/SgdSr0KRsCipqEWud2oQ5sY8zJXBBYNGkUgyibkk9S2zZryO85xk3xdhPb+rFzazs84DQVvVtlZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396247; c=relaxed/simple;
	bh=GKDItO47bD5859QTQ8j/hkMcWWLayMq9tvTQcnYprhQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzBh0fiuGTccqZdXZCwf6jNYr45//h5UJZZl3nFjUeYjrC80CzzHodcrmcnJxpm28kvEtYHX/IeBMCsEh/lA9k4ONbItBxVdQkBtVkBjuiJdoe4zLgMS0S2jsKp37Yox1DFx3bqqUU8MOb4KEiUpn1mQR+B6LrSGlq65Aq6kaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iy5PWj5v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eDJGoZic; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F149F1F451
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7H5tJlcuHK7IxsDzKWwew7qgHRqe9JGEefz+mUziyk=;
	b=iy5PWj5vbazNh3aVmGFGJgyyG9s8W4y00FOLqQ8UAKDk0Mv60SbBUVE7XlfLB4ESo3YTHw
	J8iId5a5spcHbB+rWtKEAtt7hh3UgFDgnEvPXPuur1lYoFBZWIgHQ8fbQDzU0Ie1m6yFmq
	l+bpCRDl30zpnmXW7G0CKfYepyM+iGM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eDJGoZic
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731396243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7H5tJlcuHK7IxsDzKWwew7qgHRqe9JGEefz+mUziyk=;
	b=eDJGoZic7j1IF4W3OzQhsssHqae6ah+pKnEB6br+OtrM4SzwrWDjrjZE36TEaYvOKexv+0
	4XFRfvnVuzBAMNVjJrV8ZVeXD5RQH20VYiIIK3+D7qUKXggbjOeYXOCzODXg70V4QWjslY
	AQBszzy6NK4FUwkD+IneaiUeTGWpBi4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32E4F13721
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HIVOZICM2esdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:24:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()
Date: Tue, 12 Nov 2024 17:53:37 +1030
Message-ID: <05e341dfada9ea89ad578e9d42e5dc495f4556a2.1731396107.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731396107.git.wqu@suse.com>
References: <cover.1731396107.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F149F1F451
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Thus making later migration to iomap a little easier.

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


