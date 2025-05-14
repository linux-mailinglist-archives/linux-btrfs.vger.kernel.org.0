Return-Path: <linux-btrfs+bounces-14009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB2AB6A59
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CAD3AEE90
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0372278172;
	Wed, 14 May 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu8bGAlV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313BB277819
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222723; cv=none; b=jnins2E0cB/QnhE1yKJlBDsiEjUBONYk9UbCToDv699qqu92/lSoa59610yc1bcVnYxY6kteGPgSveoE/Xfs7fzkLnvmpjOgyN2eUtkmeMFS7p7SvZgNFA1Bq98bfwNTIAI1ZP7qhDep9REbCWigbdK5jiM6mOoJvsRVez1XQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222723; c=relaxed/simple;
	bh=zflnvGb29j+/wRQZClxRm4bUikoDBuy5W3lIHUeU8V4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBuEOuV136xZ+iRkrATADuv0XyQoBaloaP1Yfjx2+trPfDNAVdw0LkaGS2GG8/RG0cWwXvKLh0wMrH8rOnqMcuKZVg/4wOPcXOHTV4nEHIBGCWtUzZtGHqugwKdzu/773w92M1RF0dm127VhCkzoEvpP7Ax05qrNXdUN/msheRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu8bGAlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A4C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222723;
	bh=zflnvGb29j+/wRQZClxRm4bUikoDBuy5W3lIHUeU8V4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Xu8bGAlVm+6okWccRsAKQtWstEssIZF2zAuNjKN2zOgs8QyrjP/SRaq1mXnU4n8Ai
	 RSaKvtbbKSNBw9SOXl65KqafKVs66hRz/iHq/fhpaAqaxFfHdnJtLlyBVwKXwLsV59
	 Gcu6KHFxQHWS0yc8n4ZiNYhjhzpr3hCjTeiXZ2lFU53JEy9jzwfqSMq4G0LIuX0FWq
	 gksMZCae6nwGQGuQkvRC+iTYHFW13qpxTgaiLhF9v3tzX/Gk6VLrzJE4Sgnr8Mdky4
	 MKze2MIknKFZZqzXN5EEnj0wo9IM/t6DcBoN/uHSgxz7s0AZVEs+j237a8HLhhZ4UK
	 VcyoGBr1O6koA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: simplify early error checking in btrfs_page_mkwrite()
Date: Wed, 14 May 2025 12:38:35 +0100
Message-Id: <401500c0e0108d519a4b5b5910c8678723885ed1.1747222631.git.fdmanana@suse.com>
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

We have this entangled error checks early at btrfs_page_mkwrite():

1) Try to reserve delalloc space by calling btrfs_delalloc_reserve_space()
   and storing the return value in the ret2 variable;

2) If the reservation succeed, call file_update_time() and store the
   return value in ret2 and also set the local variable 'reserved' to
   true (1);

3) Then do an error check on ret2 to see if any of the previous calls
   failed and if so, jump either to the 'out' label or to the
   'out_noreserve' label, depending on whether 'reserved' is true or
   not.

This is unnecessarily complex. Instead change this to a simpler and
more straighforward approach:

1) Call btrfs_delalloc_reserve_space(), if that returns an error jump to
   the 'out_noreserve' label;

2) The call file_update_time() and if that returns an error jump to the
   'out' label.

Like this there's less nested if statements, no need to use a local
variable to track if space was reserved and if statements are used only
to check errors.

Also move the call to extent_changeset_free() out of the 'out_noreserve'
label and under the 'out' label  since the changeset is allocated only if
the call to reserve delalloc space succeeded.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a2b1fc536fdd..9ecb9f3bd057 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1843,7 +1843,6 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	size_t fsize = folio_size(folio);
 	vm_fault_t ret;
 	int ret2;
-	int reserved = 0;
 	u64 reserved_space;
 	u64 page_start;
 	u64 page_end;
@@ -1866,17 +1865,17 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
 					    page_start, reserved_space);
-	if (!ret2) {
-		ret2 = file_update_time(vmf->vma->vm_file);
-		reserved = 1;
-	}
 	if (ret2) {
 		ret = vmf_error(ret2);
-		if (reserved)
-			goto out;
 		goto out_noreserve;
 	}
 
+	ret2 = file_update_time(vmf->vma->vm_file);
+	if (ret2) {
+		ret = vmf_error(ret2);
+		goto out;
+	}
+
 	/* Make the VM retry the fault. */
 	ret = VM_FAULT_NOPAGE;
 again:
@@ -1972,9 +1971,9 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
 				     reserved_space, true);
+	extent_changeset_free(data_reserved);
 out_noreserve:
 	sb_end_pagefault(inode->i_sb);
-	extent_changeset_free(data_reserved);
 	return ret;
 }
 
-- 
2.47.2


