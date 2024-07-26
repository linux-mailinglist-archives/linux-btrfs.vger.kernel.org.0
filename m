Return-Path: <linux-btrfs+bounces-6780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A193D928
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701E2B2483E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA6154454;
	Fri, 26 Jul 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SHXgqMwC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495D153838
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022640; cv=none; b=u0ymVWyyA80XaWvl11z2bVcvWj75CJtoRVcV1kbCoQ+D/z82QDVUf/SgvdDxjR+5oWAZvcGHwW6e5Y4qNAkkCBR6oNFXOI1SD6OkpYfu+U7zNA82Qk8U6auTaupLvSu6xaeN/1gyUzKAlLVzWxadXlEbURvDzu+N5M2aQjSW+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022640; c=relaxed/simple;
	bh=k84zTJHIwABe7nGZiPGCQt82uE4pZfm59ER8wNDn2hQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiWyJCCvKDUg4FKXFAcH3r7Og2ksxWXQZwDrgNTQSV6vkqKRgRWbk/udBmDr2uRiXn3K/q+LR5nXggEn3GeSR/2wnl74sq/v+Q4fcrg/2q+ttlzZDI2ScYGeP3+Bsi2KjjmAlsAXGlyUhOCKS61V4H6BMOPQCZot6pxHlipsfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SHXgqMwC; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-65cd720cee2so436157b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022638; x=1722627438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acbllnNOdxbMXw+1G8ypfc7FDsBR+vgEoqqabjqdQ5M=;
        b=SHXgqMwC5SByVxLVtUci2vAjrvreApnLLMzpbh6DDLv2we3v7ywTDJOBCSKtZS+Nn1
         YEzOTOmGTFxjOE/lTjdH5N5ZCb5npDfzFo+sAiLjA9ldsERzKoEqrqH/cEfmSseB/l4A
         eUUM2az2HR3xbzykrQeRUGdIW92ZrFXNjGMRPsjetCegdm6FqFr+apjK4hoHF00z01Mn
         HvPYOs82LeRdNd+BcCwe8qPtZUEmg/xZX8qCVnh5Lb6UEayTHwVtFz1F04b80noTO9gV
         G+GamybeJBS1n4aJO3jK5qzoy7V6L+zZyMYf2H6dcprlTPzJP+eJec16TOFhk+FNbVC4
         H9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022638; x=1722627438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acbllnNOdxbMXw+1G8ypfc7FDsBR+vgEoqqabjqdQ5M=;
        b=R/4g7uYleIwo6FNUx9ECdezzxQJ8VrKQwRbmWL7ferx3ddxbKqArqANY/wmWGlcyAn
         FQpjhzBs3rvvEFR4GX+VJwRer0h5zJh0SQxnMS087h3h17ukIhXQBwpCP74OiOEdq7yL
         LCwX1VUmsZ/sfhOQ0Pai43RZvMOcWIxAjLQAK4IAeulc/s9FxtDdh07ObfpHfb+nI8C5
         S0UzSQgkqVqfHNneyBDNHa/TTX14uQS9CK+qxg3TIdvsiy7DEdNv4hlJZmdzwi8Tgo4q
         1QNty/MXIKn58ZGW1Ctv8ljBSIsQuYRhMmr8ThwpJtCOVlFFpK3Ta2Ka4Wn862ggPNFB
         lkIw==
X-Gm-Message-State: AOJu0Yw9tkJGnrIm45AqHsIaZgQpsS8P8pvefvhYcaDUErMhWgXOJNdd
	qdXANJjZXdIXOIVK1Lx+V0UUA+OCF/z8M42777I/t90sUgJ/bu+AxM9tBXbhbuXPKtB8Qo/S8+p
	8
X-Google-Smtp-Source: AGHT+IHkb9Ad/985KaAuBD3jBj3QoHJCDBKR3ZHrFGZfby/sjzZ//85/WBZl0utt72OGgdxbz+v2pQ==
X-Received: by 2002:a0d:f386:0:b0:61b:df5:7876 with SMTP id 00721157ae682-67a05c8bb3bmr10149637b3.6.1722022638296;
        Fri, 26 Jul 2024 12:37:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44ded1sm9814537b3.145.2024.07.26.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 39/46] btrfs: convert read_inline_extent to use a folio
Date: Fri, 26 Jul 2024 15:36:26 -0400
Message-ID: <4c5e26539f6f1d4f60ced23deb6f8818556de15e.1722022377.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using a page, use a folio instead, take a folio as an
argument, and update the callers appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 560575a5de03..45835074aa6f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6746,30 +6746,30 @@ static noinline int uncompress_inline(struct btrfs_path *path,
 }
 
 static int read_inline_extent(struct btrfs_inode *inode, struct btrfs_path *path,
-			      struct page *page)
+			      struct folio *folio)
 {
 	struct btrfs_file_extent_item *fi;
 	void *kaddr;
 	size_t copy_size;
 
-	if (!page || PageUptodate(page))
+	if (!folio || folio_test_uptodate(folio))
 		return 0;
 
-	ASSERT(page_offset(page) == 0);
+	ASSERT(folio_pos(folio) == 0);
 
 	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_file_extent_item);
 	if (btrfs_file_extent_compression(path->nodes[0], fi) != BTRFS_COMPRESS_NONE)
-		return uncompress_inline(path, page_folio(page), fi);
+		return uncompress_inline(path, folio, fi);
 
 	copy_size = min_t(u64, PAGE_SIZE,
 			  btrfs_file_extent_ram_bytes(path->nodes[0], fi));
-	kaddr = kmap_local_page(page);
+	kaddr = kmap_local_folio(folio, 0);
 	read_extent_buffer(path->nodes[0], kaddr,
 			   btrfs_file_extent_inline_start(fi), copy_size);
 	kunmap_local(kaddr);
 	if (copy_size < PAGE_SIZE)
-		memzero_page(page, copy_size, PAGE_SIZE - copy_size);
+		folio_zero_range(folio, copy_size, PAGE_SIZE - copy_size);
 	return 0;
 }
 
@@ -6944,7 +6944,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		ASSERT(em->disk_bytenr == EXTENT_MAP_INLINE);
 		ASSERT(em->len == fs_info->sectorsize);
 
-		ret = read_inline_extent(inode, path, page);
+		ret = read_inline_extent(inode, path, page_folio(page));
 		if (ret < 0)
 			goto out;
 		goto insert;
-- 
2.43.0


