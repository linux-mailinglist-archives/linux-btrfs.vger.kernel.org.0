Return-Path: <linux-btrfs+bounces-6753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1293D90D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE99285C0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3E6F2F8;
	Fri, 26 Jul 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UrmzcRKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E514900B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022612; cv=none; b=S5vCJxdeHvXrh2DtChdXtkbY1fMyYNE3C0siHRG9LRcb7L0+04EBCB8pUfQ2XQ1KALb7IT5No7QNSu8EUAQA4sVjw10yCP2/GDbYuDtbxSxpFNb0I9134dqFutOjz4g8p06yizEd/XitunE87gsc9BdjWQWoXDLdK0/7oblOcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022612; c=relaxed/simple;
	bh=M5FjRmgf3k2EgTXWw6Xz2xBa3uL2QyAioHcdq42KMwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpseBG164EP8dsHY9PGKeLvn08RyRJUX5zhUo34I18pjj3J5KbHtHMgJEhbauNxrXMh2blI3/XnlaGVrg8k3FrIblflZFN3A/aDMORvRaye6kXbCwYNrZLv8nrTwKVHcb95HK3ymkCPA28jjTScu9XLW6ORXc5DsJw+gMP2mJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UrmzcRKA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66599ca3470so396657b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022610; x=1722627410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiGlCVNajVo50PhEvdILpXRpkD3zKnXubK8bhIL4PN0=;
        b=UrmzcRKAh+7xb7cS0dAaR+5YoJZZUiXKEFIvDBYsQAINeHR99bGkWa391MvPk+KlpH
         e4SPz+Kqw67RoDXAkH+JQHztsMu/4wy9vr4D1kA3STb1Qj3XtzhgknmtHtmX1/HTYsJE
         Cl2D9Pz1NW1CqxSZ2ijU3qr4XncRm5hKlda9hM8ZLsjsGLnlLIYXog1L1KxiT0xFFK2I
         8EfX1balRejMU7cB+hjdnnQkh5zqtNBrNj6jVLzxR5NRZp6oW9t2yA9stdlMn9Tovsx4
         4Rw54zPTkZ1WesqRxnUvYn6QudyQtTLzTczRXOF8K/wSsWZyC/ed/xEle1wvjw9N93uq
         VlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022610; x=1722627410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiGlCVNajVo50PhEvdILpXRpkD3zKnXubK8bhIL4PN0=;
        b=GNv1111oJJrpYEvtxoCr5bKx+oV81MmTXb75EqIupF2Ad7VeCR4z4HW28VgJiAv78m
         KNKnWEXYu84jXcDX62PkmH6h0i+H54FEcy2VVIJALejcJCLC8msZkjtcrLZYjqlMYOdR
         sx4dtpUKWZ5N1ANWWARvbkCjop9iYfCyTbVqfOBMbLl76ySgYY3mJsT3w9wdj9kfRe8J
         9v4aqVyk+2ieZzvjUtKj3YGojdlbbnHtKyf88fPU7O0Cf1hptW/DxBS+ac5/Kx9uWfrH
         E0eF+wfyMEdhXgSRqU2/NkTC+wcgv1+uE5Dr0ZxOj+g2MKlywy32YCJkTKlzyCL+rMMr
         +38w==
X-Gm-Message-State: AOJu0YzS3Lg6hF945h3F5w7oZlcMpMZu7CaRv6vwAH7RbMfrMxyM8Tbg
	GfpVJfKOF6l+KpnLu+nqtMHpfzD/LdmESmaid+S8soXYmey8v0D9+n7PigfDuuDPzpIRM3QLd3H
	+
X-Google-Smtp-Source: AGHT+IEh39rjWyNvFe/Gws8ZD1J5phZkO49/PLAp2nncX+x3qAdL8y3smsWB/SLu+nxOW/PFeXCRyA==
X-Received: by 2002:a81:5c04:0:b0:62f:9e2d:3e5d with SMTP id 00721157ae682-67a0a8f2addmr9440207b3.43.1722022609755;
        Fri, 26 Jul 2024 12:36:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bab3242sm9813777b3.109.2024.07.26.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 12/46] btrfs: utilize folio more in btrfs_page_mkwrite
Date: Fri, 26 Jul 2024 15:35:59 -0400
Message-ID: <c6442872bd85295de2d796cd4811db8244440fcb.1722022376.git.josef@toxicpanda.com>
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

We already have a folio that we're using in btrfs_page_mkwrite, update
the rest of the function to use folio everywhere else.  This will make
it easier on Willy when he drops page->index.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 21381de906f6..cac177c5622d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1901,8 +1901,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	reserved_space = PAGE_SIZE;
 
 	sb_start_pagefault(inode->i_sb);
-	page_start = page_offset(page);
-	page_end = page_start + PAGE_SIZE - 1;
+	page_start = folio_pos(folio);
+	page_end = page_start + folio_size(folio) - 1;
 	end = page_end;
 
 	/*
@@ -1930,18 +1930,18 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret = VM_FAULT_NOPAGE;
 again:
 	down_read(&BTRFS_I(inode)->i_mmap_lock);
-	lock_page(page);
+	folio_lock(folio);
 	size = i_size_read(inode);
 
-	if ((page->mapping != inode->i_mapping) ||
+	if ((folio->mapping != inode->i_mapping) ||
 	    (page_start >= size)) {
 		/* Page got truncated out from underneath us. */
 		goto out_unlock;
 	}
-	wait_on_page_writeback(page);
+	folio_wait_writeback(folio);
 
 	lock_extent(io_tree, page_start, page_end, &cached_state);
-	ret2 = set_page_extent_mapped(page);
+	ret2 = set_folio_extent_mapped(folio);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
@@ -1955,14 +1955,14 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, PAGE_SIZE);
 	if (ordered) {
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
-		unlock_page(page);
+		folio_unlock(folio);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
 	}
 
-	if (page->index == ((size - 1) >> PAGE_SHIFT)) {
+	if (folio->index == ((size - 1) >> PAGE_SHIFT)) {
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
 		if (reserved_space < PAGE_SIZE) {
 			end = page_start + reserved_space - 1;
@@ -1992,13 +1992,13 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	/* Page is wholly or partially inside EOF. */
-	if (page_start + PAGE_SIZE > size)
-		zero_start = offset_in_page(size);
+	if (page_start + folio_size(folio) > size)
+		zero_start = offset_in_folio(folio, size);
 	else
 		zero_start = PAGE_SIZE;
 
 	if (zero_start != PAGE_SIZE)
-		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
+		folio_zero_range(folio, zero_start, folio_size(folio) - zero_start);
 
 	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
 	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
@@ -2015,7 +2015,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	return VM_FAULT_LOCKED;
 
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-- 
2.43.0


