Return-Path: <linux-btrfs+bounces-20169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66151CF9524
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F1F305E87A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF4324719;
	Tue,  6 Jan 2026 16:21:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BB2DA75C
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716478; cv=none; b=ckx8k0IhxXLPVP42ATFOgLakyaNmTKolcQQEpAxGkNyhlGd9IS8f9s2xX8+SWOqfJsZwe4IWrdnmuVBGqXPz2Mot71W85X6/zNoPrKj1Q+yMP8rjRog8tg2DN1ZdFh2Mvop4wI4900IS43yjRrCn5A9PuJqCEDd6z0DH6KFNaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716478; c=relaxed/simple;
	bh=vyPcDzMAeM+1WdwYPDRmQ2Wzmgh9uKmwbUccue70EXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGzBYiSx8H+08J2KKsZmDXQv5i4KZvUjXLmKUZiQMds3KCF24XtVBD4pNarM+BxSFzRCC5vOpS23BkEVd5ee6/Wy+WfhBfhm3lcZQkDMNuEPX2XWnuciPZU94Vu74RK9wDkvs77D3I/D5ux9/qoSS/tcvL0Bdcot+ZbDc6hmU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A699C33691;
	Tue,  6 Jan 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04E03EA63;
	Tue,  6 Jan 2026 16:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ga0gJ2w2XWm2WQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/12] btrfs: lzo: inline read/write length helpers
Date: Tue,  6 Jan 2026 17:20:29 +0100
Message-ID: <e8787af6e45b54f2e2dd2eb86ea44883d23e4e76.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A699C33691
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The LZO_LEN read/write helpers are supposed to be trivial and we're
duplicating the put/get unaligned helpers so use them directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/lzo.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 4758f66da449c0..e2eeee708c7f90 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -106,22 +106,6 @@ struct list_head *lzo_alloc_workspace(struct btrfs_fs_info *fs_info)
 	return ERR_PTR(-ENOMEM);
 }
 
-static inline void write_compress_length(char *buf, size_t len)
-{
-	__le32 dlen;
-
-	dlen = cpu_to_le32(len);
-	memcpy(buf, &dlen, LZO_LEN);
-}
-
-static inline size_t read_compress_length(const char *buf)
-{
-	__le32 dlen;
-
-	memcpy(&dlen, buf, LZO_LEN);
-	return le32_to_cpu(dlen);
-}
-
 /*
  * Will do:
  *
@@ -165,7 +149,7 @@ static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
 	}
 
 	kaddr = kmap_local_folio(cur_folio, offset_in_folio(cur_folio, *cur_out));
-	write_compress_length(kaddr, compressed_size);
+	put_unaligned_le32(compressed_size, kaddr);
 	*cur_out += LZO_LEN;
 
 	orig_out = *cur_out;
@@ -297,7 +281,7 @@ int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 	/* Store the size of all chunks of compressed data */
 	sizes_ptr = kmap_local_folio(folios[0], 0);
-	write_compress_length(sizes_ptr, cur_out);
+	put_unaligned_le32(cur_out, sizes_ptr);
 	kunmap_local(sizes_ptr);
 
 	ret = 0;
@@ -352,7 +336,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	u32 cur_out = 0;
 
 	kaddr = kmap_local_folio(cb->compressed_folios[0], 0);
-	len_in = read_compress_length(kaddr);
+	len_in = get_unaligned_le32(kaddr);
 	kunmap_local(kaddr);
 	cur_in += LZO_LEN;
 
@@ -391,7 +375,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		cur_folio = cb->compressed_folios[cur_in >> min_folio_shift];
 		ASSERT(cur_folio);
 		kaddr = kmap_local_folio(cur_folio, 0);
-		seg_len = read_compress_length(kaddr + offset_in_folio(cur_folio, cur_in));
+		seg_len = get_unaligned_le32(kaddr + offset_in_folio(cur_folio, cur_in));
 		kunmap_local(kaddr);
 		cur_in += LZO_LEN;
 
@@ -461,12 +445,12 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	if (unlikely(srclen < LZO_LEN || srclen > max_segment_len + LZO_LEN * 2))
 		return -EUCLEAN;
 
-	in_len = read_compress_length(data_in);
+	in_len = get_unaligned_le32(data_in);
 	if (unlikely(in_len != srclen))
 		return -EUCLEAN;
 	data_in += LZO_LEN;
 
-	in_len = read_compress_length(data_in);
+	in_len = get_unaligned_le32(data_in);
 	if (unlikely(in_len != srclen - LZO_LEN * 2)) {
 		ret = -EUCLEAN;
 		goto out;
-- 
2.51.1


