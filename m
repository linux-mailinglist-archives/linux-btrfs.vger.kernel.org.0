Return-Path: <linux-btrfs+bounces-12921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC6A8232B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 13:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE458C2844
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A525D914;
	Wed,  9 Apr 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VADsk5bG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880392459FB
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197080; cv=none; b=XqC4afwlhPp8+4AcCQ5ZpPgLRXKkx2hoTTbAL+MId2PevQ1fBFZU56vJs1gC2r5Pg8bv00PFvFpXX7nirAq3yRxqLMR28jK2z4aw3pjPjqGL/5svVtEdOHrZcN1Aovf8L3jtwi1Pa8AAdpQOi/oP3jHN4C1eZqUTHfh2lbTW2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197080; c=relaxed/simple;
	bh=3yBk5j2jmcFupr1DlYIbVyPzdJrjZ2HBCPnVGLiBnjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDdF4+ybGaatJk2i2WEF7Hh6WavVyGG6SUZhoxFAp/PwcrbU2gL5PuxDRR3SP1T+SYCcvWmKQI3JJ1mOHEflG6ExcJkBBqIn/DOKyndtBeb6H1WsABV5VW8DnC1f3Y7Z+BDgcl6rrA05h17R4U5GTBRFvbPl2assWUFFTmMJKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VADsk5bG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XPzLIbjXbNJfCmvIzk66ns2FJABNWuZU41BU4RxFuFU=; b=VADsk5bGCBT66zqXqzuOvzHypf
	dyTOcIypbYxOdGljj3IizUM9ah09q0K5CoDLJmUmf1peHEMVunb6n/4wKHB/jUEgQNDNCLPVfr6Gn
	DUuntlJFj+HaKFSAfzjMzsnUGsvKtJvYhD48n58jj2a/mYSwvs16KiCcWRkO8wM6NaP8d9u0BPsLx
	EixZv2eVPuW+FwmaTh59C4UsdHaHPMNQatbRwwXvzDKDMz+0mmuzZ45lk2n3+oekQ7hO0oqu3b8jX
	LmpFYyZ2yc4LzNOTMDoIqVIULRV90slSDQg6j/FVy+PisYBXCs/KFDbzGiZ6uCoVaE26Ghw0mRLyC
	QcUeuTdQ==;
Received: from 2a02-8389-2341-5b80-08b8-afb4-7bb0-fe1c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8b8:afb4:7bb0:fe1c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TKv-00000006x53-2syv;
	Wed, 09 Apr 2025 11:11:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: use bvec_kmap_local in btrfs_decompress_buf2page
Date: Wed,  9 Apr 2025 13:10:42 +0200
Message-ID: <20250409111055.3640328-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409111055.3640328-1-hch@lst.de>
References: <20250409111055.3640328-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This removes the last direct poke into bvec internals in btrfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e7f8ee5d48a4..9d0996c8370d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1182,6 +1182,7 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		u32 copy_start;
 		/* Offset inside the full decompressed extent */
 		u32 bvec_offset;
+		void *kaddr;
 
 		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
 		/*
@@ -1204,10 +1205,12 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		 * @buf + @buf_len.
 		 */
 		ASSERT(copy_start - decompressed < buf_len);
-		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
-			       buf + copy_start - decompressed, copy_len);
-		cur_offset += copy_len;
 
+		kaddr = bvec_kmap_local(&bvec);
+		memcpy(kaddr, buf + copy_start - decompressed, copy_len);
+		kunmap_local(kaddr);
+
+		cur_offset += copy_len;
 		bio_advance(orig_bio, copy_len);
 		/* Finished the bio */
 		if (!orig_bio->bi_iter.bi_size)
-- 
2.47.2


