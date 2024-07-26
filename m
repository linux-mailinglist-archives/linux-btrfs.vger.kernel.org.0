Return-Path: <linux-btrfs+bounces-6761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B828A93D915
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6A11C22B64
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046CB14A095;
	Fri, 26 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xSyQVFC0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7983149E1D
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022621; cv=none; b=dVp3GH2iZcyHSWBVSVN5rx062bFVP3HLiaK/ogj1W/8+b094gMEGxErOuFPe47wZs04Ae/0XW1GzazuDFDKYIv9EJf/nmnqF9A9klj+h8xXdtpIncu1+d9J03+rA3JipYIe+gkQHA8H1CETTSMraK+kQKV5DcGN+LYx5/wcLk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022621; c=relaxed/simple;
	bh=AJB5p7TdKPMaVdU2ixa45kQchnsiFFTQWnJ0dYHmx10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3GICcJkCtw0w1q3LhBGkMk2NYU7sYkXIZ0xQ3MMxNd+Oh+w2+meUqnazyPD7Romz8IQs9RCyBGKooZA2vR9YbxAx7OWA/THtuY7N3hZtQRQA2vS9vUWJ/NDgdMudLEMO9mdRQ/YuMlnrbau1z/kRdZJ/6yBFI4nPGvSg4PTzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xSyQVFC0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0878971aa9so41128276.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022618; x=1722627418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoRWBdvdZDUCSVjXxsglCj49tecBfXtcCNEA/2zgHrQ=;
        b=xSyQVFC0TJYLwAlW9KjlKkrK+LmtiGWJ+wZPqfCnzuZ54rxHBASMf2id+9DcFRg85l
         2YF83OQvSuGDDfrpCo8PU8C9FkEhhaCuq8KDIH+kDvfF743uY5RBZKz2dMY7VYCqtvap
         HV5ARh2iB6Y8lr+b7GOERKHDe0n4ueeCSpslNSZhDBmqiC4oJ/Z4J/G2LZwQhMGUcwPm
         Zw0r72p1K3HgFjPYMV5U+RwrJ52sFlIy17dRri/9pq7uIUacLGU6L6bJ2po8SiHp3uhH
         wHOfPld0c1JVnr1KgbTkYnBADu00om3R/T5gDqeWhXksLgtSGeNgd8e7B/yEfRJfHgS4
         236A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022618; x=1722627418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoRWBdvdZDUCSVjXxsglCj49tecBfXtcCNEA/2zgHrQ=;
        b=G5jpFRdzwvIAxDrYEcn1te5KKAG1l/mi3JJfay/EQCy85ICxa5dJM2QQ+sFAfkRq7+
         tiQoLhMn5wCk83JMwNIl2gwQ8DMmuovTbXCJvkOtehdGhi5JhvL0FkGqUkbCbqjHteRp
         Bsd9ZT4Tn5/6rbonZHAjErzZto+4JM7/SjX/KufWYYtuL5C5HUJdrrOSCrFsEoNK3ARr
         RuzOkhqczcQC22qtFgYY5y4JKAaRa/IbSJaUqfknZx7Lk2FqV4bSP+mO4Kkn4aKG0sMf
         3QX6mriM5vdjNVG/oWtv0uzd9wlfw4Ay7Ockl2tW52RKM+RZHqq3hOXBPbSlaThTe6uX
         eJaw==
X-Gm-Message-State: AOJu0YxCgRzp7qQJdbwzVU9wpXp6/Ge9TG5V8Zb7Qooq19UgWrvIppPg
	1zKlFGge8EoVnnWZkiXPRKVrqFKkDx2cHPJMsgGpeDR8Y8Z1dQ/xs9n73Tklu4VMTLUj0BK1G2h
	F
X-Google-Smtp-Source: AGHT+IGRKFwPT7phblKB5c2eyoJTVNV1y2uMtBVDTfJOsBbeckc7uOgZcrpYC7TgnybjNRj4ANJcZQ==
X-Received: by 2002:a25:5f0b:0:b0:e03:a923:8720 with SMTP id 3f1490d57ef6-e0b5520ba8amr667441276.0.1722022618456;
        Fri, 26 Jul 2024 12:36:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a28d442sm841094276.38.2024.07.26.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 20/46] btrfs: convert __process_pages_contig to take a folio
Date: Fri, 26 Jul 2024 15:36:07 -0400
Message-ID: <2c0a83b7d29e5ee81fb2861b29fc0016907b2c88.1722022376.git.josef@toxicpanda.com>
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

This operates mostly on folios, update it to take a folio for the locked
folio instead of the page, rename from __process_pages_contig =>
__process_folios_contig.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46d26f54e9d4..d49f3adf7d86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -187,9 +187,9 @@ static void process_one_page(struct btrfs_fs_info *fs_info,
 		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
-static void __process_pages_contig(struct address_space *mapping,
-				   const struct page *locked_page, u64 start, u64 end,
-				   unsigned long page_ops)
+static void __process_folios_contig(struct address_space *mapping,
+				    const struct folio *locked_folio, u64 start,
+				    u64 end, unsigned long page_ops)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
 	pgoff_t start_index = start >> PAGE_SHIFT;
@@ -207,8 +207,9 @@ static void __process_pages_contig(struct address_space *mapping,
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			process_one_page(fs_info, &folio->page, locked_page,
-					 page_ops, start, end);
+			process_one_page(fs_info, &folio->page,
+					 &locked_folio->page, page_ops, start,
+					 end);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -226,8 +227,8 @@ static noinline void __unlock_for_delalloc(const struct inode *inode,
 	if (index == locked_folio->index && end_index == index)
 		return;
 
-	__process_pages_contig(inode->i_mapping, &locked_folio->page, start,
-			       end, PAGE_UNLOCK);
+	__process_folios_contig(inode->i_mapping, locked_folio, start, end,
+				PAGE_UNLOCK);
 }
 
 static noinline int lock_delalloc_folios(struct inode *inode,
@@ -401,8 +402,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, cached);
 
-	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
-			       start, end, page_ops);
+	__process_folios_contig(inode->vfs_inode.i_mapping,
+				page_folio(locked_page), start, end, page_ops);
 }
 
 static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
-- 
2.43.0


