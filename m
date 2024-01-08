Return-Path: <linux-btrfs+bounces-1305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0A826A44
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 10:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BF4282B8A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F7E111BD;
	Mon,  8 Jan 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ARbSHq6O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ARbSHq6O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50285D2FF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7935D21DB8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe4tnTmO24QA6K1L74V6yqSdclR3I2CpbGAuPO3lbTM=;
	b=ARbSHq6OGyJB3VS4+mgOHGAsQBK/ucO0rJWCGcAh6RN5PKLdjI2hIRQcb97u4cJaXQKbmZ
	9TAR9vV/Yq8fqpvYkaCt5Wchzut7XjVOjPlDzn2sDdDxgx9BRSza5s0imB82Fsn/jWyWBo
	O+EAmceCaE3iT6PnaZyaaLBfGUF+X5c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704704951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe4tnTmO24QA6K1L74V6yqSdclR3I2CpbGAuPO3lbTM=;
	b=ARbSHq6OGyJB3VS4+mgOHGAsQBK/ucO0rJWCGcAh6RN5PKLdjI2hIRQcb97u4cJaXQKbmZ
	9TAR9vV/Yq8fqpvYkaCt5Wchzut7XjVOjPlDzn2sDdDxgx9BRSza5s0imB82Fsn/jWyWBo
	O+EAmceCaE3iT6PnaZyaaLBfGUF+X5c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6346113496
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 09:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCPKA7a7m2UxCwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Jan 2024 09:09:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: zstd: fix and simplify the inline extent decompression
Date: Mon,  8 Jan 2024 19:38:46 +1030
Message-ID: <0e4ae269b3fd0caf99964c16c98bdd67dbab7150.1704704328.git.wqu@suse.com>
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
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ARbSHq6O
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 7935D21DB8
X-Spam-Flag: NO

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
		inline extent data size 48 ram_bytes 4096 compression 3 (zstd)

Then trying to reflink that extent in an aarch64 system with 64K page
size, the reflink would just fail:

  # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
  XFS_IOC_CLONE_RANGE: Input/output error

[CAUSE]
In zstd_decompress(), we didn't treat @start_byte as just a page offset,
but also use it as an indicator on whether we should error out, without
any proper explanation (this is copied from other decompression code).

In reality, for subpage cases, although @start_byte can be non-zero,
we should never switch input/output buffer nor error out, since the whole
input/output buffer should never exceed one sector, thus we should not
need to do any buffer switch.

Thus the current code using @start_byte as a condition to switch
input/output buffer or finish the decompression is completely incorrect.

[FIX]
The fix involves several modification:

- Rename @start_byte to @dest_pgoff to properly express its meaning

- Use @sectorsize other than PAGE_SIZE to properly initialize the
  output buffer size

- Use correct destination offset inside the destination page

- Simplify the main loop
  Since the input/output buffer should never switch, we only need one
  zstd_decompress_stream() call.

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
 fs/btrfs/zstd.c        | 74 +++++++++++++-----------------------------
 2 files changed, 23 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index afd7e50d073d..97fe3ebf11a2 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -169,7 +169,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 void zstd_init_workspace_manager(void);
 void zstd_cleanup_workspace_manager(void);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0d66db8bc1d4..812e3bd43889 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -20,6 +20,7 @@
 #include "misc.h"
 #include "compression.h"
 #include "ctree.h"
+#include "super.h"
 
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
 #define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
@@ -618,80 +619,49 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int zstd_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long start_byte, size_t srclen,
+		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct btrfs_fs_info *fs_info = btrfs_sb(dest_page->mapping->host->i_sb);
+	const u32 sectorsize = fs_info->sectorsize;
 	zstd_dstream *stream;
 	int ret = 0;
-	size_t ret2;
-	unsigned long total_out = 0;
-	unsigned long pg_offset = 0;
+	unsigned long to_copy = 0;
 
 	stream = zstd_init_dstream(
 			ZSTD_BTRFS_MAX_INPUT, workspace->mem, workspace->size);
 	if (!stream) {
 		pr_warn("BTRFS: zstd_init_dstream failed\n");
-		ret = -EIO;
 		goto finish;
 	}
 
-	destlen = min_t(size_t, destlen, PAGE_SIZE);
-
 	workspace->in_buf.src = data_in;
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = srclen;
 
 	workspace->out_buf.dst = workspace->buf;
 	workspace->out_buf.pos = 0;
-	workspace->out_buf.size = PAGE_SIZE;
+	workspace->out_buf.size = sectorsize;
 
-	ret2 = 1;
-	while (pg_offset < destlen
-	       && workspace->in_buf.pos < workspace->in_buf.size) {
-		unsigned long buf_start;
-		unsigned long buf_offset;
-		unsigned long bytes;
-
-		/* Check if the frame is over and we still need more input */
-		if (ret2 == 0) {
-			pr_debug("BTRFS: zstd_decompress_stream ended early\n");
-			ret = -EIO;
-			goto finish;
-		}
-		ret2 = zstd_decompress_stream(stream, &workspace->out_buf,
-				&workspace->in_buf);
-		if (zstd_is_error(ret2)) {
-			pr_debug("BTRFS: zstd_decompress_stream returned %d\n",
-					zstd_get_error_code(ret2));
-			ret = -EIO;
-			goto finish;
-		}
-
-		buf_start = total_out;
-		total_out += workspace->out_buf.pos;
-		workspace->out_buf.pos = 0;
-
-		if (total_out <= start_byte)
-			continue;
-
-		if (total_out > start_byte && buf_start < start_byte)
-			buf_offset = start_byte - buf_start;
-		else
-			buf_offset = 0;
-
-		bytes = min_t(unsigned long, destlen - pg_offset,
-				workspace->out_buf.size - buf_offset);
-
-		memcpy_to_page(dest_page, pg_offset,
-			       workspace->out_buf.dst + buf_offset, bytes);
-
-		pg_offset += bytes;
+	/*
+	 * Since both input and output buffer should not exceed one sector,
+	 * One call should end the decompression.
+	 */
+	ret = zstd_decompress_stream(stream, &workspace->out_buf, &workspace->in_buf);
+	if (zstd_is_error(ret)) {
+		pr_warn_ratelimited("BTRFS: zstd_decompress_stream return %d\n",
+				    zstd_get_error_code(ret));
+		goto finish;
 	}
-	ret = 0;
+	to_copy = workspace->out_buf.pos;
+	memcpy_to_page(dest_page, dest_pgoff + to_copy, workspace->out_buf.dst,
+		       to_copy);
 finish:
-	if (pg_offset < destlen) {
-		memzero_page(dest_page, pg_offset, destlen - pg_offset);
+	/* Error or early end. */
+	if (to_copy < destlen) {
+		ret = -EIO;
+		memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
 	}
 	return ret;
 }
-- 
2.43.0


