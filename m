Return-Path: <linux-btrfs+bounces-14011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD54AB6A5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1688D3ACD5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A9278E7E;
	Wed, 14 May 2025 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjlbxIqR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A055277808
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222725; cv=none; b=Bjkky29FzVzUuyKMKHR4YyAmaVt2Z8T2U0fDJW/1tXMFZZj1zsxKgZUW1GZUn3ZyyMYABzyUdBY9R0F941hwOuQHt76vClkv1CmoKQaheWB/5OM2BK1GZXFUZntccn5kOw1vQImo1OJaZQNjqt6usUfOwReKEv2MzkM1Yqrujao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222725; c=relaxed/simple;
	bh=7GZOROnJ+RVycsGflrFzRL2MUcWkn96qgDzN75x/xMw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4C27Ft/RwFPsH1X9YTSBcW/O5vyS2wmO4AM/t+spNj08FcbMg7LhXAOi9KUpXG6XXFm7Oqoineo3EdXXbfIJaL26WrGsjRv2jX8h++DPBFzuw6vLC42NdmqUXM8XhuaIP2zMPN3j3fIfKEKyg9OLTvapN82LDdIOg0ZLpNcBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjlbxIqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7582FC4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222725;
	bh=7GZOROnJ+RVycsGflrFzRL2MUcWkn96qgDzN75x/xMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bjlbxIqRVmD0LIeu3QhZpXXGR7nFCFz4IzH1Ys0b5BrvD3g3XB3Uq02NFDXFDasOG
	 /yGQpcg09zyaEvwkz9GFtJdcpbjgKpOdIauD2adsp7Ch2jIz2JIM16jdA3+X+5a9xA
	 zoSM8UBstQGcrDHDnnkdLtxEaaDr+/cfpaT+vPjSpyjv8BL86XIrxEGshi3J65xevO
	 ZoJVhkSwcjsoAg8rCIrDALhEuCW8DbDzZAX89pbepWsi8oZMUPj1P0vDCujGcHWkTY
	 UjyMOCsAA/oJZb26ykqj6ZzRloElhLayg3IMSAWONoCTeQudpjUFT01I1/z6LEglMc
	 EBDok9BpgS8uA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: use a single variable to track return value at btrfs_page_mkwrite()
Date: Wed, 14 May 2025 12:38:37 +0100
Message-Id: <b3a84d4894aebd5d3e7097fb7f07892fcf1b2316.1747222631.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747222631.git.fdmanana@suse.com>
References: <cover.1747222631.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have two variables to track return values, ret and ret2, with types
vm_fault_t (an unsigned int type) and int, which makes it a bit confusing
and harder to keep track. So use a single variable, of type int, and under
the 'out' label return vmf_error(ret) in case ret contains an error,
otherwise return VM_FAULT_NOPAGE. This is equivalent to what we had before
and it's simpler.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f6b32f24185c..8ce6f45f45e0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1841,8 +1841,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	unsigned long zero_start;
 	loff_t size;
 	size_t fsize = folio_size(folio);
-	vm_fault_t ret;
-	int ret2;
+	int ret;
 	u64 reserved_space;
 	u64 page_start;
 	u64 page_end;
@@ -1863,21 +1862,14 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * end up waiting indefinitely to get a lock on the page currently
 	 * being processed by btrfs_page_mkwrite() function.
 	 */
-	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
-					    page_start, reserved_space);
-	if (ret2) {
-		ret = vmf_error(ret2);
+	ret = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
+					   page_start, reserved_space);
+	if (ret < 0)
 		goto out_noreserve;
-	}
 
-	ret2 = file_update_time(vmf->vma->vm_file);
-	if (ret2) {
-		ret = vmf_error(ret2);
+	ret = file_update_time(vmf->vma->vm_file);
+	if (ret < 0)
 		goto out;
-	}
-
-	/* Make the VM retry the fault. */
-	ret = VM_FAULT_NOPAGE;
 again:
 	down_read(&BTRFS_I(inode)->i_mmap_lock);
 	folio_lock(folio);
@@ -1891,9 +1883,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	folio_wait_writeback(folio);
 
 	btrfs_lock_extent(io_tree, page_start, page_end, &cached_state);
-	ret2 = set_folio_extent_mapped(folio);
-	if (ret2 < 0) {
-		ret = vmf_error(ret2);
+	ret = set_folio_extent_mapped(folio);
+	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
@@ -1933,11 +1924,10 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
+	ret = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
-	if (ret2) {
+	if (ret < 0) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
-		ret = vmf_error(ret2);
 		goto out_unlock;
 	}
 
@@ -1974,7 +1964,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	extent_changeset_free(data_reserved);
 out_noreserve:
 	sb_end_pagefault(inode->i_sb);
-	return ret;
+
+	if (ret < 0)
+		return vmf_error(ret);
+
+	/* Make the VM retry the fault. */
+	return VM_FAULT_NOPAGE;
 }
 
 static const struct vm_operations_struct btrfs_file_vm_ops = {
-- 
2.47.2


