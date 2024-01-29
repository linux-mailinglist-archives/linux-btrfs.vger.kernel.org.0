Return-Path: <linux-btrfs+bounces-1889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D808401FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD601284E6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E8F55E74;
	Mon, 29 Jan 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H0txIqaI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bhEjZpwf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E755C1B
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521597; cv=none; b=OQa61WEd94EZGYgUFVtDYKu411IChBn+rvFDHDLOcIkrDEUV2jX+o3fGXcGT3jl5GoQ49Gq2vVUB1qp4PbEKzt+n7JVwhnM3MuOKEQWS0CXL00mRzQxaWSiOK2ppi3Jf4br68WktVdQWO8OiGguai9QpcIylCF/AmVC1Y81s6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521597; c=relaxed/simple;
	bh=CuRDPeNbl/MonYu0HsMdvIx/57XtBeTdrxFPYXoDwFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kthyyhrI2bj0383hwalQN4QHEEhX2l0ORkYBg8PUF09scrXgAg137jbcMOlCD4CSjodir00nIgbeGYAr2azW2QbySDnINWLOZCHKFfCbj4KKsrDIm8kmfdQKJ8K1H2NUU4ks/o3zzypVdgQ6uT0J3/dLMzyni4jtDskUVK8H7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H0txIqaI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bhEjZpwf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E933621C5E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaVGzLICDv/eRaqPAln1NRampoW95STMMlLLsg82RDY=;
	b=H0txIqaIZONghuOX4IptyjoTT3XVukja3IDDfwy3GgfXAniHCDCmR8NFfxjprp7hJalJ6P
	j5Rj5aJIs7BwqRNGM+DzVbq6gZRmfCyx4uwH224CHwvDpMT3uDp5FwUgtNhgXIyIknsANR
	fOw1leUuv80jZQ3Dnt8JImi9SKomRX8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaVGzLICDv/eRaqPAln1NRampoW95STMMlLLsg82RDY=;
	b=bhEjZpwfdrkXx7qUR6jd2zyClGZ/gLqVw1lh0BB7NfCRJX+rcD8vLnlH8Q+3l8td/+iV3x
	Cfe8X9KDOp20O+B8z9g0umWKhd4eamgwF5J0HU4U7s6NR6sn9rF8okKVOz4gQl10AENDCm
	h3eeh9/2SPPHddsxQ/007+UFv3DbRUY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3263913911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CN/FOfhzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: make insert_inline_extent() to accept one page directly
Date: Mon, 29 Jan 2024 20:16:08 +1030
Message-ID: <25054a001f14e9461f80638814831b8a487a2b2a.1706521511.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706521511.git.wqu@suse.com>
References: <cover.1706521511.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bhEjZpwf
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: E933621C5E
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Since our inline extent can not accept anything larger than a sector,
there is really no need to pass all the compressed pages to
insert_inline_extent().

And just in case, expand the ASSERT()s to make sure we only try inline
with compressed size no larger than sectorsize.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f057a0a147ac..daf13f45fccd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -512,12 +512,13 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode, bool extent_inserted,
 				size_t size, size_t compressed_size,
 				int compress_type,
-				struct page **compressed_pages,
+				struct page *compressed_page,
 				bool update_i_size)
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct page *page = NULL;
+	const u32 sectorsize = trans->fs_info->sectorsize;
 	char *kaddr;
 	unsigned long ptr;
 	struct btrfs_file_extent_item *ei;
@@ -525,10 +526,23 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	size_t cur_size = size;
 	u64 i_size;
 
-	ASSERT((compressed_size > 0 && compressed_pages) ||
-	       (compressed_size == 0 && !compressed_pages));
+	/*
+	 * The decompressed size must still be no larger than a sector.
+	 * Under heavy race, we can have size == 0 passed in, but that
+	 * shouldn't be a big deal and we can continue the insertion.
+	 */
+	ASSERT(size <= sectorsize);
 
-	if (compressed_size && compressed_pages)
+	/*
+	 * The compressed size also need to be no larger than a sector.
+	 * That's also why we only need one page as the parameter.
+	 */
+	if (compressed_page)
+		ASSERT(compressed_size <= sectorsize);
+	else
+		ASSERT(compressed_size == 0);
+
+	if (compressed_size && compressed_page)
 		cur_size = compressed_size;
 
 	if (!extent_inserted) {
@@ -556,21 +570,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	ptr = btrfs_file_extent_inline_start(ei);
 
 	if (compress_type != BTRFS_COMPRESS_NONE) {
-		struct page *cpage;
-		int i = 0;
-		while (compressed_size > 0) {
-			cpage = compressed_pages[i];
-			cur_size = min_t(unsigned long, compressed_size,
-				       PAGE_SIZE);
+		kaddr = kmap_local_page(compressed_page);
+		write_extent_buffer(leaf, kaddr, ptr, compressed_size);
+		kunmap_local(kaddr);
 
-			kaddr = kmap_local_page(cpage);
-			write_extent_buffer(leaf, kaddr, ptr, cur_size);
-			kunmap_local(kaddr);
-
-			i++;
-			ptr += cur_size;
-			compressed_size -= cur_size;
-		}
 		btrfs_set_file_extent_compression(leaf, ei,
 						  compress_type);
 	} else {
@@ -620,7 +623,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 					  size_t compressed_size,
 					  int compress_type,
-					  struct page **compressed_pages,
+					  struct page *compressed_page,
 					  bool update_i_size)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
@@ -668,7 +671,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 
 	ret = insert_inline_extent(trans, path, inode, drop_args.extent_inserted,
 				   size, compressed_size, compress_type,
-				   compressed_pages, update_i_size);
+				   compressed_page, update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -975,7 +978,7 @@ static void compress_file_range(struct btrfs_work *work)
 		} else {
 			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
-						    compress_type, pages,
+						    compress_type, pages[0],
 						    false);
 		}
 		if (ret <= 0) {
@@ -10385,7 +10388,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start == 0 && encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0) {
 		ret = cow_file_range_inline(inode, encoded->len, orig_count,
-					    compression, pages, true);
+					    compression, pages[0], true);
 		if (ret <= 0) {
 			if (ret == 0)
 				ret = orig_count;
-- 
2.43.0


