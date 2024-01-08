Return-Path: <linux-btrfs+bounces-1304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A09826A43
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 10:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE0282BA4
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE9EAE6;
	Mon,  8 Jan 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ghl2W2e1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ghl2W2e1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C011CAF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0A461F799
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra0N412ELeFeEAucFGBVYlwtaVxuvLSr5kMYmXA7Lf0=;
	b=ghl2W2e1FLcMrDA22GyB2owN/3CIX6EeDQEAmjvl5vIv0B1z9U7Fym8BWL6F56h9LkcSNc
	elssdyiGKM0hWJg/FIgUHdo1bsubzRULcEWJn2EPqeBPKaCld/fp8kxBY9hsHDcdMgJ8MG
	XK5j092KJbMxW7qIVqQkUNXnflQhZ9A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra0N412ELeFeEAucFGBVYlwtaVxuvLSr5kMYmXA7Lf0=;
	b=ghl2W2e1FLcMrDA22GyB2owN/3CIX6EeDQEAmjvl5vIv0B1z9U7Fym8BWL6F56h9LkcSNc
	elssdyiGKM0hWJg/FIgUHdo1bsubzRULcEWJn2EPqeBPKaCld/fp8kxBY9hsHDcdMgJ8MG
	XK5j092KJbMxW7qIVqQkUNXnflQhZ9A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A78AC13496
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDGOFLS7m2UxCwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 09:09:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: lzo: fix and simplify the inline extent decompression
Date: Mon,  8 Jan 2024 19:38:45 +1030
Message-ID: <5c985e26b07a40a934801a00af0656a848bcaebe.1704704328.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704704328.git.wqu@suse.com>
References: <cover.1704704328.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.70

[BUG]
If we have a filesystem with 4k sectorsize, and an inlined compressed
extent created like this:

	item 4 key (257 INODE_ITEM 0) itemoff 15863 itemsize 160
		generation 8 transid 8 size 4096 nbytes 4096
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 5 key (257 INODE_REF 256) itemoff 15839 itemsize 24
		index 2 namelen 14 name: source_inlined
	item 6 key (257 EXTENT_DATA 0) itemoff 15770 itemsize 69
		generation 8 type 0 (inline)
		inline extent data size 48 ram_bytes 4096 compression 2 (lzo)

Then trying to reflink that extent in an aarch64 system with 64K page
size, the reflink would just fail:

  # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
  XFS_IOC_CLONE_RANGE: Input/output error

[CAUSE]
In zlib_decompress(), we didn't treat @start_byte as just a page offset,
but also use it as an indicator on whether we should error out, without
any proper explanation (this is from the very beginning of btrfs).

In reality, for subpage cases, although @start_byte can be non-zero,
we should never switch input/output buffer nor error out, since the whole
input/output buffer should never exceed one sector.
(The above assumption is only not true if we're going to support
multi-page sectorsize)

Thus the current code using @start_byte as a condition to switch
input/output buffer or finish the decompression is completely incorrect.

[FIX]
The fix involves several modification:

- Rename @start_byte to @dest_pgoff to properly express its meaning

- Use @sectorsize other than PAGE_SIZE to properly initialize the
  output buffer size

- Use correct destination offset inside the destination page

- Use memcpy_to_page() to copy the contents to the destination page

- Use memzero_page() to zero out the tailing part

- Consider early end as an error

After the fix, even on 64K page sized aarch64, above reflink now
works as expected:

  # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
  linked 4096/4096 bytes at offset 61440

And results the correct file layout:

	item 9 key (258 INODE_ITEM 0) itemoff 15542 itemsize 160
		generation 10 transid 10 size 65536 nbytes 4096
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 10 key (258 INODE_REF 256) itemoff 15528 itemsize 14
		index 3 namelen 4 name: dest
	item 11 key (258 XATTR_ITEM 3817753667) itemoff 15445 itemsize 83
		location key (0 UNKNOWN.0 0) type XATTR
		transid 10 data_len 37 name_len 16
		name: security.selinux
		data unconfined_u:object_r:unlabeled_t:s0
	item 12 key (258 EXTENT_DATA 61440) itemoff 15392 itemsize 53
		generation 10 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/lzo.c         | 34 +++++++++-------------------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2b4dfb1b010c..afd7e50d073d 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -159,7 +159,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 struct list_head *lzo_alloc_workspace(unsigned int level);
 void lzo_free_workspace(struct list_head *ws);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 1131d5a29d61..e43bc0fdc74e 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -425,16 +425,16 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
 	size_t in_len;
 	size_t out_len;
 	size_t max_segment_len = WORKSPACE_BUF_LENGTH;
 	int ret = 0;
-	char *kaddr;
-	unsigned long bytes;
 
 	if (srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2)
 		return -EUCLEAN;
@@ -451,7 +451,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	}
 	data_in += LZO_LEN;
 
-	out_len = PAGE_SIZE;
+	out_len = sectorsize;
 	ret = lzo1x_decompress_safe(data_in, in_len, workspace->buf, &out_len);
 	if (ret != LZO_E_OK) {
 		pr_warn("BTRFS: decompress failed!\n");
@@ -459,29 +459,13 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 		goto out;
 	}
 
-	if (out_len < start_byte) {
+	ASSERT(out_len <= sectorsize);
+	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, out_len);
+	/* Early end, considered as an error. */
+	if (unlikely(out_len < destlen)) {
 		ret = -EIO;
-		goto out;
+		memzero_page(dest_page, dest_pgoff + out_len, destlen - out_len);
 	}
-
-	/*
-	 * the caller is already checking against PAGE_SIZE, but lets
-	 * move this check closer to the memcpy/memset
-	 */
-	destlen = min_t(unsigned long, destlen, PAGE_SIZE);
-	bytes = min_t(unsigned long, destlen, out_len - start_byte);
-
-	kaddr = kmap_local_page(dest_page);
-	memcpy(kaddr, workspace->buf + start_byte, bytes);
-
-	/*
-	 * btrfs_getblock is doing a zero on the tail of the page too,
-	 * but this will cover anything missing from the decompressed
-	 * data.
-	 */
-	if (bytes < destlen)
-		memset(kaddr+bytes, 0, destlen-bytes);
-	kunmap_local(kaddr);
 out:
 	return ret;
 }
-- 
2.43.0


