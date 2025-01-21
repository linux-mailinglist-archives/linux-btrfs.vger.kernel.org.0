Return-Path: <linux-btrfs+bounces-11021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF431A1770E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 06:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE637A1C98
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 05:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B821A23A0;
	Tue, 21 Jan 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HaibMuDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD435186294
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737438065; cv=none; b=baP+2W68SNQa3asJm0hOQ3hk5PWKnTXaCZRHZjWYTNDzmRKNtyYkqVHZoM+/wnPlh639+9HZVuBorvAJp/T2/7tU06tdR+PFyVFOmVykbcHS0UpCOUq2qy3wH2OtvVWP0yFYztX4OA9sxnsr4syNFiUJ5Yrx2d6kY6J1kGDAyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737438065; c=relaxed/simple;
	bh=bVKzp9UGXAJvT4IXG0yNb/kHMgtC+yIt7QkWJ7W7tEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBO8fgEXhcRhEAWYIEgMSWrIys8fBwuP5358GIbPh1X/pvvVzaWNnjLPT5p9mXx221Ha2Pd8q9J87fuHxIMNE8w2T7ZaqchZPcdOiRLE6YNBgECcoorOFgliYrV/rY1iW248EtZe9rpTs45ELXn9OMMK7KHDIGU684+1ZFCKw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HaibMuDc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dBiht7URlz1pwg21nXRwLAazt0Ui2d3L7bf5BCZRPHY=; b=HaibMuDcdDSyr1kr7bp8QigcCn
	wZTXmAa2w8alTrmjMbEODXNUEXRBzXsxLIHHp5Uyz3OYaCbZYvOnkmVXRQhbnNgrlpqepPCxS6Gn6
	MPLbDDJrruLRisaL6wzxb9A4MtyiabOnzFNN4zzbsLEdnDreqkf92APpAC7GWsyPjdhH4HJ2FfzF5
	vp5dxT4XZywuh3+erKVsV6fe0SyJ07fVea+SCZqfaxx3Hnb260g+ISNrzcn2EHuBSwJcNIh+7xZvN
	HiiTTpMAgAN1r9NmWOK8y6sWrDR6a9d2I88M0nsWjcTouNsvnxCtN2uQ7wg8aiN3sj9mh0HloM6OG
	zJ34vr9g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ta70T-0000000GoqH-0Dy5;
	Tue, 21 Jan 2025 05:40:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
Date: Tue, 21 Jan 2025 05:40:51 +0000
Message-ID: <20250121054054.4008049-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121054054.4008049-1-willy@infradead.org>
References: <20250121054054.4008049-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is meaningless to shift a byte count by folio_shift().  The folio index
is in units of PAGE_SIZE, not folio_size().  We can use folio_contains()
to make this work for arbitrary-order folios, so remove the assertion
that the folios are of order 0.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 289ecb8ce217..c9b0ee841501 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -523,8 +523,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		u64 end;
 		u32 len;
 
-		/* For now only order 0 folios are supported for data. */
-		ASSERT(folio_order(folio) == 0);
 		btrfs_debug(fs_info,
 			"%s: bi_sector=%llu, err=%d, mirror=%u",
 			__func__, bio->bi_iter.bi_sector, bio->bi_status,
@@ -552,7 +550,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
-			pgoff_t end_index = i_size >> folio_shift(folio);
 
 			/*
 			 * Zero out the remaining part if this range straddles
@@ -563,7 +560,8 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 			 *
 			 * NOTE: i_size is exclusive while end is inclusive.
 			 */
-			if (folio_index(folio) == end_index && i_size <= end) {
+			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
+			    i_size <= end) {
 				u32 zero_start = max(offset_in_folio(folio, i_size),
 						     offset_in_folio(folio, start));
 				u32 zero_len = offset_in_folio(folio, end) + 1 -
@@ -956,7 +954,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		return ret;
 	}
 
-	if (folio->index == last_byte >> folio_shift(folio)) {
+	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
 		size_t zero_offset = offset_in_folio(folio, last_byte);
 
 		if (zero_offset) {
-- 
2.45.2


