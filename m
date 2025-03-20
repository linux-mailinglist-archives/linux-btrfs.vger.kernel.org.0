Return-Path: <linux-btrfs+bounces-12449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA021A69F63
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 06:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4768A4718
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 05:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2A1EB5EA;
	Thu, 20 Mar 2025 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pucRse94";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pucRse94"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7061EB1BA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448889; cv=none; b=lb0L3yuCsY4e3wNYVG9rd2O6KlA339B2iYXcID117gIMqQkovgOG/Xju51XKAFKPshnx8zQ0+u2otRd8NfRYho1LDCX2CyJje1cOSF6ZND2TOf5MFEz2EFYvGzTE5MwcXw3vf8HdTP9Z9IYoVHmuxfwo2HeLvxo/y9Rt1WKTkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448889; c=relaxed/simple;
	bh=DGEdHI0VR52t33fbRJrvEa8Tw5VqVMtKR803T+hNaOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM51paQN3b0WkDNwpuftWVSRapmCPRCqcsCFRI29b9lYseau21AQpv/UkoqYtrVs1WB5q13IDSeOTEg1XKs6My6OEqrxxCCO4PFai0ILtK8t2paRRKyd/fVT3j7u0xbJpNPeIrp4ZAGuwDXJZ/TVhNjViZ5yAeOWXwpOnMyx5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pucRse94; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pucRse94; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7EF721AFB
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWFfwUfOG6EfQyTcc+IL/xs+GLS0x/bsyVFBzbEzEKE=;
	b=pucRse94748lG6/6MX7ekajyMW5pxkXu2kbbpWJIPy8sWW2yOaOHqu9Rf2eEHwLZD3IQhj
	2Pkw/pzSuafKfNm7VEDuL+glnZRSIm06hlThXkMnMLdDCLoxvtKfE6gaH92/sg0WguRWIQ
	/WdCQU/tkt5mWTwApRjKFToFhekBGkc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWFfwUfOG6EfQyTcc+IL/xs+GLS0x/bsyVFBzbEzEKE=;
	b=pucRse94748lG6/6MX7ekajyMW5pxkXu2kbbpWJIPy8sWW2yOaOHqu9Rf2eEHwLZD3IQhj
	2Pkw/pzSuafKfNm7VEDuL+glnZRSIm06hlThXkMnMLdDCLoxvtKfE6gaH92/sg0WguRWIQ
	/WdCQU/tkt5mWTwApRjKFToFhekBGkc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5925138A5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDVgJOmo22fcMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: cleanup the reserved space inside the loop of btrfs_buffered_write()
Date: Thu, 20 Mar 2025 16:04:09 +1030
Message-ID: <b0bd320dba85d72a34a4f7e5ba6b6c42caedbe41.1742443383.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742443383.git.wqu@suse.com>
References: <cover.1742443383.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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

Inside the main loop of btrfs_buffered_write(), if something wrong
happened, there is a out-of-loop cleanup path to release the reserved
space.

This behavior saves some code lines, but makes it much harder to read,
as we need to check release_bytes to make sure when we need to do the
cleanup.

Extract the cleanup part into a helper, release_reserved_space(), to do
the cleanup inside the main loop, so that we can move @release_bytes
inside the loop.

This will make later refactor of the main loop much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index b7eb1f0164bb..f68846c14ed5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1074,6 +1074,27 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 	return 0;
 }
 
+static void release_space(struct btrfs_inode *inode,
+			  struct extent_changeset *data_reserved,
+			  u64 start, u64 len,
+			  bool only_release_metadata)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	if (!len)
+		return;
+
+	if (only_release_metadata) {
+		btrfs_check_nocow_unlock(inode);
+		btrfs_delalloc_release_metadata(inode, len, true);
+	} else {
+		btrfs_delalloc_release_space(inode,
+				data_reserved,
+				round_down(start, fs_info->sectorsize),
+				len, true);
+	}
+}
+
 ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
@@ -1081,7 +1102,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_changeset *data_reserved = NULL;
-	u64 release_bytes = 0;
 	u64 lockstart;
 	u64 lockend;
 	size_t num_written = 0;
@@ -1090,7 +1110,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
-	bool only_release_metadata = false;
 
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1125,7 +1144,9 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		size_t dirty_sectors;
 		size_t num_sectors;
 		struct folio *folio = NULL;
+		u64 release_bytes = 0;
 		int extents_locked;
+		bool only_release_metadata = false;
 
 		/*
 		 * Fault pages before locking them in prepare_one_folio()
@@ -1136,7 +1157,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		only_release_metadata = false;
 		sector_offset = pos & (fs_info->sectorsize - 1);
 
 		extent_changeset_release(data_reserved);
@@ -1191,6 +1211,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
+			release_space(BTRFS_I(inode), data_reserved,
+				      pos, release_bytes, only_release_metadata);
 			break;
 		}
 
@@ -1198,6 +1220,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
+			release_space(BTRFS_I(inode), data_reserved,
+				      pos, release_bytes, only_release_metadata);
 			break;
 		}
 
@@ -1210,6 +1234,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
+			release_space(BTRFS_I(inode), data_reserved,
+				      pos, release_bytes, only_release_metadata);
 			ret = extents_locked;
 			break;
 		}
@@ -1277,6 +1303,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
 		if (ret) {
 			btrfs_drop_folio(fs_info, folio, pos, copied);
+			release_space(BTRFS_I(inode), data_reserved,
+				      pos, release_bytes, only_release_metadata);
 			break;
 		}
 
@@ -1292,19 +1320,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
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
2.49.0


