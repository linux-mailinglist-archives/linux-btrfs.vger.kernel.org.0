Return-Path: <linux-btrfs+bounces-1297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C88826832
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 07:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4F28171D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0C8C09;
	Mon,  8 Jan 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fL6j4JWJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fL6j4JWJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B318BE7;
	Mon,  8 Jan 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6728021E00;
	Mon,  8 Jan 2024 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704696291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UBEPq0JzXbQTnUIktIrcP8JKtCGy/nkyw+wBbfHe0pE=;
	b=fL6j4JWJIQIT1e5R64S01dziStipDfH071FJ+x5yv5K20CAFMYZrKW0VZhZS5AEjWOaVsC
	Oyu44lIkR24TNM066xChi3VnwvFU01/k9DBCedvIlf/WPyEHP5hRXvZiMUtQhFPwo+kHjU
	AdGQfrk15TlN4zegpr6shuHiRoJLrfk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704696291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UBEPq0JzXbQTnUIktIrcP8JKtCGy/nkyw+wBbfHe0pE=;
	b=fL6j4JWJIQIT1e5R64S01dziStipDfH071FJ+x5yv5K20CAFMYZrKW0VZhZS5AEjWOaVsC
	Oyu44lIkR24TNM066xChi3VnwvFU01/k9DBCedvIlf/WPyEHP5hRXvZiMUtQhFPwo+kHjU
	AdGQfrk15TlN4zegpr6shuHiRoJLrfk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B72EA1392C;
	Mon,  8 Jan 2024 06:44:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id viucFOGZm2VtYQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 08 Jan 2024 06:44:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH RFC] btrfs: zlib: fix and simplify the inline extent decompression
Date: Mon,  8 Jan 2024 17:14:30 +1030
Message-ID: <2e26a781a22009a8b499325736b689ec3f4cae43.1704695963.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6728021E00
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fL6j4JWJ
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]

[BUG]

If we have a 4K filesystem with an inlined compressed extent created
like this:

	item 4 key (257 INODE_ITEM 0) itemoff 15863 itemsize 160
		generation 8 transid 8 size 4096 nbytes 4096
		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 5 key (257 INODE_REF 256) itemoff 15839 itemsize 24
		index 2 namelen 14 name: source_inlined
	item 6 key (257 EXTENT_DATA 0) itemoff 15770 itemsize 69
		generation 8 type 0 (inline)
		inline extent data size 48 ram_bytes 4096 compression 1 (zlib)

Which has an inline compressed extent at file offset 0, and its
decompressed size is 4K, allowing us to reflink that 4K range to another
location (which will not be compressed).

If we do such reflink on a subpage system, it would fail like this:

 # xfs_io -f -c "reflink /mnt/btrfs/source_inlined 0 60k 4k" /mnt/btrfs/dest
 XFS_IOC_CLONE_RANGE: Input/output error

And even lead to a data reservation warning.

[CAUSE]
In zlib_decompress(), we didn't treat @start_byte as just a page offset,
but also use it as an indicator on whether we should switch our output
buffer.

In reality, for subpage cases, even @start_byte is not zero, we should
never switch input/output buffer, since the whole input/output buffer
should not exceed one sector.

Thus the decompression should always finish in just one go, never to
switch the input/output buffer.

[FIX]
The fix involves several modification:

- Rename @start_byte to @dest_pgoff to properly express its meaning

- Add extra ASSERT() inside btrfs_decompress() to make sure the
  input/output size is correct

- Use Z_FINISH flag to make sure the decompression happens in one go

- Remove all the loop needed to switch input/output buffer

- Use correct destination offset inside the destination page

After the fix, even on 64K page sized aarch64, above reflink can still
work as expected:

 # xfs_io -f -c "reflink /mnt/btrfs/source_inlined 0 60k 4k" /mnt/btrfs/dest
 linked 4096/4096 bytes at offset 61440

And result a correct file layout:

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
 fs/btrfs/compression.c | 23 +++++++++-----
 fs/btrfs/super.h       |  3 ++
 fs/btrfs/zlib.c        | 68 ++++++++++++------------------------------
 3 files changed, 38 insertions(+), 56 deletions(-)

---
REASON FOR RFC:
This is patch is just the first step to fix all 3 compression code for
subpage.

The fix itself should be fine, but the test case is hard to create:

- No inlined compression creation support for subpage btrfs
  For now, although compression is enabled for subpage btrfs, it has a
  large limit, the range must be page aligned.

  Furthermore, no inline extent can be created on subpage btrfs, due to
  other limits.

  Thus we can not create the needed inline extent to trigger the problem
  just using subpage btrfs.

- No dumped image support for fstests (?)
  I'm not sure if fstests support uploading any binary.
  If not, there is no way to verify the fix reliably.

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 3d8fc2ad0f42..9cf7d38dc66c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -141,16 +141,16 @@ static int compression_decompress_bio(struct list_head *ws,
 }
 
 static int compression_decompress(int type, struct list_head *ws,
-               const u8 *data_in, struct page *dest_page,
-               unsigned long start_byte, size_t srclen, size_t destlen)
+		const u8 *data_in, struct page *dest_page,
+		unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
 	switch (type) {
 	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_page,
-						start_byte, srclen, destlen);
+						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
-						start_byte, srclen, destlen);
+						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_page,
-						start_byte, srclen, destlen);
+						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_NONE:
 	default:
 		/*
@@ -1037,14 +1037,23 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
  * start_byte tells us the offset into the compressed data we're interested in
  */
 int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
-		     unsigned long start_byte, size_t srclen, size_t destlen)
+		     unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
 	struct list_head *workspace;
+	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
 
+	/*
+	 * The full destination page range should not exceed the page size.
+	 * And the @destlen should not exceed sectorsize, as this is only called for
+	 * inline file extents, which should not exceed sectorsize.
+	 */
+	ASSERT(dest_pgoff + destlen <= PAGE_SIZE && destlen <= sectorsize);
+
 	workspace = get_workspace(type, 0);
 	ret = compression_decompress(type, workspace, data_in, dest_page,
-				     start_byte, srclen, destlen);
+				     dest_pgoff, srclen, destlen);
 	put_workspace(type, workspace);
 
 	return ret;
diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
index f18253ca280d..0dc3dd713cbb 100644
--- a/fs/btrfs/super.h
+++ b/fs/btrfs/super.h
@@ -3,6 +3,9 @@
 #ifndef BTRFS_SUPER_H
 #define BTRFS_SUPER_H
 
+#include <linux/fs.h>
+#include "fs.h"
+
 bool btrfs_check_options(struct btrfs_fs_info *info, unsigned long *mount_opt,
 			 unsigned long flags);
 int btrfs_sync_fs(struct super_block *sb, int wait);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 36cf1f0e338e..7a0a74303e13 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -354,18 +354,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	int ret = 0;
 	int wbits = MAX_WBITS;
-	unsigned long bytes_left;
-	unsigned long total_out = 0;
-	unsigned long pg_offset = 0;
-
-	destlen = min_t(unsigned long, destlen, PAGE_SIZE);
-	bytes_left = destlen;
+	unsigned long to_copy;
 
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = srclen;
@@ -390,49 +385,25 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 		return -EIO;
 	}
 
-	while (bytes_left > 0) {
-		unsigned long buf_start;
-		unsigned long buf_offset;
-		unsigned long bytes;
+	/*
+	 * Everything (in/out buf) should be at most one sector, there should
+	 * be no need to switch any input/output buffer.
+	 */
+	ret = zlib_inflate(&workspace->strm, Z_FINISH);
+	to_copy = min(workspace->strm.total_out, destlen);
+	if (ret != Z_STREAM_END)
+		goto out;
 
-		ret = zlib_inflate(&workspace->strm, Z_NO_FLUSH);
-		if (ret != Z_OK && ret != Z_STREAM_END)
-			break;
+	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
 
-		buf_start = total_out;
-		total_out = workspace->strm.total_out;
-
-		if (total_out == buf_start) {
-			ret = -EIO;
-			break;
-		}
-
-		if (total_out <= start_byte)
-			goto next;
-
-		if (total_out > start_byte && buf_start < start_byte)
-			buf_offset = start_byte - buf_start;
-		else
-			buf_offset = 0;
-
-		bytes = min(PAGE_SIZE - pg_offset,
-			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
-		bytes = min(bytes, bytes_left);
-
-		memcpy_to_page(dest_page, pg_offset,
-			       workspace->buf + buf_offset, bytes);
-
-		pg_offset += bytes;
-		bytes_left -= bytes;
-next:
-		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = workspace->buf_size;
-	}
-
-	if (ret != Z_STREAM_END && bytes_left != 0)
+out:
+	if (unlikely(to_copy != destlen)) {
+		pr_warn_ratelimited("BTRFS: infalte failed, decompressed=%lu expected=%lu\n",
+					to_copy, destlen);
 		ret = -EIO;
-	else
+	} else {
 		ret = 0;
+	}
 
 	zlib_inflateEnd(&workspace->strm);
 
@@ -441,9 +412,8 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	 * expected.  btrfs_get_block is responsible for zeroing from the
 	 * end of the inline extent (destlen) to the end of the page
 	 */
-	if (pg_offset < destlen) {
-		memzero_page(dest_page, pg_offset, destlen - pg_offset);
-	}
+	if (unlikely(to_copy < destlen))
+		memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
 	return ret;
 }
 
-- 
2.43.0


