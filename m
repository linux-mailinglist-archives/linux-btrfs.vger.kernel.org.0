Return-Path: <linux-btrfs+bounces-1887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31F8401FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7849CB2144D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF755E41;
	Mon, 29 Jan 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="shzRcZ9L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="shzRcZ9L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31655787
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521595; cv=none; b=GxcBbzTeNCDKFn/SIFUR/kcHpqwXNdNqCp1qRrxOuI4BKzwj4ac7kWVEUtQBTewMsaINMPn0aSZ7sqMU4G4T3Du+vhBygMy1zm4NgbiychpGUpRupoOgDHj8h+fm6zu5As4pXh0ZnLANE8eroYWUITg9yWsjD31Q4BCFPRr0BrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521595; c=relaxed/simple;
	bh=0CUg3U9G3ogkYBwcKnbW5Jra82Nsgh+eEpFuLYgMbZ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhR9uKzJKoeIlySSuWObRmpCVdoPbW0TyaXiUySnLEjoVTimi866h7l6XUV/BIEyd1fqPV2gCK2xK4SBidM6jpeeMQf9ZAWhbgvcE5Up+AYJT18UckVAZfhIWFF0A6gNq4IvnsWZecEBmcPcZ6/aJY6/YQCvlv4gcQFN/MkNHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=shzRcZ9L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=shzRcZ9L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A44A21C3D
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+wLpdnwUeiodW05G7j+fYUPE3ybA4OF/G2EWXqDku4=;
	b=shzRcZ9LJNtConBw8gkA5ps0ud/p0chEKfiuG7+MLjnqtCmErAE/YkRLHjHvAT2kBnXNj6
	ZbpUhWOQfQNRZ4bGVvxn/XDyeeFq2vuz/JVTiWGywcppQTucWBlprABVsRuxk4Fo6MV61j
	ZnABRwhChnMmdlW77qrg07RiP6oagUA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706521591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+wLpdnwUeiodW05G7j+fYUPE3ybA4OF/G2EWXqDku4=;
	b=shzRcZ9LJNtConBw8gkA5ps0ud/p0chEKfiuG7+MLjnqtCmErAE/YkRLHjHvAT2kBnXNj6
	ZbpUhWOQfQNRZ4bGVvxn/XDyeeFq2vuz/JVTiWGywcppQTucWBlprABVsRuxk4Fo6MV61j
	ZnABRwhChnMmdlW77qrg07RiP6oagUA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA3AD13911
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MG1TI/Zzt2W/RwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 09:46:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: compression: add error handling for missed page cache
Date: Mon, 29 Jan 2024 20:16:06 +1030
Message-ID: <5a13a9bb2ca544e3a109d191088651569d26b0a2.1706521511.git.wqu@suse.com>
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
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

For all the supported compression algorithms, the compression path would
always need to grab the page cache, then do the compression.

Normally we would get a page reference without any problem, since the
write path should have already locked the pages in the write range.
Just for the sake of error handling, we should handle the page cache
miss case.

This patch adds a common wrapper, btrfs_compress_find_get_page(),
which calls find_get_page(), and do the error handling along with an
error message with an ASSERT().

Callers inside compression path would only need to call
btrfs_compress_find_get_page(), and error out if it returned any error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/compression.h |  3 +++
 fs/btrfs/lzo.c         |  5 +++--
 fs/btrfs/zlib.c        | 14 ++++++++++----
 fs/btrfs/zstd.c        |  9 +++++++--
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 488089acd49f..165ed35b4f9f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -974,6 +974,32 @@ static unsigned int btrfs_compress_set_level(int type, unsigned level)
 	return level;
 }
 
+/* A wrapper around find_get_page(), with extra error message. */
+int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
+				 struct page **in_page_ret)
+{
+	struct page *in_page;
+
+	/*
+	 * The compressed write path should have the page locked already,
+	 * thus we only need to grab one reference of the page cache.
+	 */
+	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+	if (unlikely(!in_page)) {
+		struct btrfs_inode *binode = BTRFS_I(mapping->host);
+		struct btrfs_fs_info *fs_info = binode->root->fs_info;
+
+		btrfs_crit(fs_info,
+		"failed to get page cache, root %lld ino %llu file offset %llu",
+			   binode->root->root_key.objectid, btrfs_ino(binode),
+			   start);
+		ASSERT(0);
+		return -ENOENT;
+	}
+	*in_page_ret = in_page;
+	return 0;
+}
+
 /*
  * Given an address space and start and length, compress the bytes into @pages
  * that are allocated on demand.
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index afd7e50d073d..427a0c2cd5cc 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -143,6 +143,9 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
 int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
 
+int btrfs_compress_find_get_page(struct address_space *mapping, u64 start,
+				 struct page **in_page_ret);
+
 int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		u64 start, struct page **pages, unsigned long *out_pages,
 		unsigned long *total_in, unsigned long *total_out);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index e43bc0fdc74e..fe7e08a4199c 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -244,8 +244,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 		/* Get the input page first */
 		if (!page_in) {
-			page_in = find_get_page(mapping, cur_in >> PAGE_SHIFT);
-			ASSERT(page_in);
+			ret =  btrfs_compress_find_get_page(mapping, cur_in, &page_in);
+			if (ret < 0)
+				goto out;
 		}
 
 		/* Compress at most one sector of data each time */
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8da66ea699e8..171c40712516 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -151,9 +151,12 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 					if (data_in) {
 						kunmap_local(data_in);
 						put_page(in_page);
+						data_in = NULL;
 					}
-					in_page = find_get_page(mapping,
-								start >> PAGE_SHIFT);
+					ret = btrfs_compress_find_get_page(mapping,
+							start, &in_page);
+					if (ret < 0)
+						goto out;
 					data_in = kmap_local_page(in_page);
 					copy_page(workspace->buf + i * PAGE_SIZE,
 						  data_in);
@@ -164,9 +167,12 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				if (data_in) {
 					kunmap_local(data_in);
 					put_page(in_page);
+					data_in = NULL;
 				}
-				in_page = find_get_page(mapping,
-							start >> PAGE_SHIFT);
+				ret = btrfs_compress_find_get_page(mapping,
+						start, &in_page);
+				if (ret < 0)
+					goto out;
 				data_in = kmap_local_page(in_page);
 				start += PAGE_SIZE;
 				workspace->strm.next_in = data_in;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 4cba8176b074..88674771b4e6 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -404,7 +404,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 	}
 
 	/* map in the first page of input data */
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+	ret = btrfs_compress_find_get_page(mapping, start, &in_page);
+	if (ret < 0)
+		goto out;
 	workspace->in_buf.src = kmap_local_page(in_page);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
@@ -477,10 +479,13 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
 			tot_in += PAGE_SIZE;
 			kunmap_local(workspace->in_buf.src);
+			workspace->in_buf.src = NULL;
 			put_page(in_page);
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
-			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+			ret = btrfs_compress_find_get_page(mapping, start, &in_page);
+			if (ret < 0)
+				goto out;
 			workspace->in_buf.src = kmap_local_page(in_page);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
-- 
2.43.0


