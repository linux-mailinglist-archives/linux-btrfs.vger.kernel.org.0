Return-Path: <linux-btrfs+bounces-1890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC5840200
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9041C216F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDE5644C;
	Mon, 29 Jan 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GT07i2oP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GT07i2oP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A755E4E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521598; cv=none; b=V2c83x4CSCb2bhCsZfXTip9iGmxPRUaYhKBjQSqt2+eGo52teeywcPN38Z+9Cwumlq6xQDalES3bcaBIFgqLnCtMUvc9YOidspMnsFJYw3PKRk98Z7RCDCncIwaBYw8x/JBoMwwwHImS/0PoB80PFE8bZcTn8F8yArtosYmdKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521598; c=relaxed/simple;
	bh=NqGBmsYz9JynOY0kztXWbBdv/XerD4ihRBtxTgVd/dA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF0ip+tGKMJ8iK+sQ1lkQ+oP4sMF8+pJRGP7FkKvxf6s9HQwCZJi3FRjcefse5r/JBBgnm7lni1Y7cq8MJ1U/eAzxQ2S1EW+mMvaZtiHBgFnaCdNocfPcS0Tj61IFVXItqpmi1TMF7ep1FBTAYzAbWh20fi7JxcLPWwFDOzT+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GT07i2oP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GT07i2oP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26D2A21CC6
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNaeK0F4ylDdeJZFAuoXJ+xs/Atm8migsRg0gL2/SGo=;
	b=GT07i2oPQjjBNvmXKJO5goXzXARS3w6fUR8K1GeszmJINIZ5tx2ZjSWrbzgGY4gjBtJxcI
	hIDYEVHN6Yyx7iwhkOSAcS2D1l2eS2mdPNX8Q2gOhJIBhLyh2k9Io8XbaeihXaiMHzU0pR
	UBf5yZbEDi08cMD7gnfBGR3MstMni60=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNaeK0F4ylDdeJZFAuoXJ+xs/Atm8migsRg0gL2/SGo=;
	b=GT07i2oPQjjBNvmXKJO5goXzXARS3w6fUR8K1GeszmJINIZ5tx2ZjSWrbzgGY4gjBtJxcI
	hIDYEVHN6Yyx7iwhkOSAcS2D1l2eS2mdPNX8Q2gOhJIBhLyh2k9Io8XbaeihXaiMHzU0pR
	UBf5yZbEDi08cMD7gnfBGR3MstMni60=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6668A13911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cNTdCvpzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: migrate insert_inline_extent() to folio interfaces
Date: Mon, 29 Jan 2024 20:16:09 +1030
Message-ID: <7aca7d41961d9985f954180436d789e9abe219d7.1706521511.git.wqu@suse.com>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GT07i2oP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.16%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 26D2A21CC6
X-Spam-Flag: NO

Since insert_inline_extent() now only accepts a single page, it's much
easier to convert it to use folio interfaces.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index daf13f45fccd..abeb78de8a15 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -512,7 +512,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode, bool extent_inserted,
 				size_t size, size_t compressed_size,
 				int compress_type,
-				struct page *compressed_page,
+				struct folio *compressed_folio,
 				bool update_i_size)
 {
 	struct btrfs_root *root = inode->root;
@@ -537,12 +537,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * The compressed size also need to be no larger than a sector.
 	 * That's also why we only need one page as the parameter.
 	 */
-	if (compressed_page)
+	if (compressed_folio)
 		ASSERT(compressed_size <= sectorsize);
 	else
 		ASSERT(compressed_size == 0);
 
-	if (compressed_size && compressed_page)
+	if (compressed_size && compressed_folio)
 		cur_size = compressed_size;
 
 	if (!extent_inserted) {
@@ -570,7 +570,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	ptr = btrfs_file_extent_inline_start(ei);
 
 	if (compress_type != BTRFS_COMPRESS_NONE) {
-		kaddr = kmap_local_page(compressed_page);
+		kaddr = kmap_local_folio(compressed_folio, 0);
 		write_extent_buffer(leaf, kaddr, ptr, compressed_size);
 		kunmap_local(kaddr);
 
@@ -623,7 +623,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 					  size_t compressed_size,
 					  int compress_type,
-					  struct page *compressed_page,
+					  struct folio *compressed_folio,
 					  bool update_i_size)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
@@ -671,7 +671,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 
 	ret = insert_inline_extent(trans, path, inode, drop_args.extent_inserted,
 				   size, compressed_size, compress_type,
-				   compressed_page, update_i_size);
+				   compressed_folio, update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -978,7 +978,8 @@ static void compress_file_range(struct btrfs_work *work)
 		} else {
 			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
-						    compress_type, pages[0],
+						    compress_type,
+						    page_folio(pages[0]),
 						    false);
 		}
 		if (ret <= 0) {
@@ -10388,7 +10389,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start == 0 && encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0) {
 		ret = cow_file_range_inline(inode, encoded->len, orig_count,
-					    compression, pages[0], true);
+					    compression, page_folio(pages[0]),
+					    true);
 		if (ret <= 0) {
 			if (ret == 0)
 				ret = orig_count;
-- 
2.43.0


