Return-Path: <linux-btrfs+bounces-14010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4AAB6A52
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4791E1B62DEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F25278E5A;
	Wed, 14 May 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFAkq0rJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26443278761
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222724; cv=none; b=MEagZCbkN6FmTg6UKCMpGAvxFDb2/mOwQx2kQq3cplaZVsNS/BZUO6poF8QCBmo/HWsIQ5lCc3NTWS92qEAvaGiRFn/bEE7iYKbvv+tuOebt5/KTO+LShXLh2TXXnbUOd6k8indPWH1qKmPsedXuukSMGaj71KkmrNIP/Y6FWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222724; c=relaxed/simple;
	bh=VNdd2O/APT3r4eppnmoweMSymLFheqlU/lsMklBN7FQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGufbRsosDieXy0PtuNToXa7sE09HUYER6/Y92bbko5lKSuAKe3/Q1OPFtqDC9XLSIwv4O2f/ZiGcydIkaDFYJsq9fS/u3P12aJnMPyq6JfTZAYO96vWUm0T03wjmFb9qzqJf6WT1aO4d04yFlDaw8MwypiM28M2Kn3AhY6N4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFAkq0rJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F921C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222724;
	bh=VNdd2O/APT3r4eppnmoweMSymLFheqlU/lsMklBN7FQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YFAkq0rJfWarI2ffMSq11HNP9CHFqp+mQ+n8h4Gy6HosaAJSwh74rI73RdUA30H3B
	 61xOReI1dWyAnBqJIjo4CjMHkF7UkkABkX2ukYNGP0RiMChwFvgAA0ik/hymIsfqBT
	 EyZvpPQ1wrl49FPMRWrbJ6dNhcW9EYeLjz3catXHsGPqyQxq063+14qi2zeUxg8VuG
	 TRNpzJUQJVNLCQLMWkguNOseLHN7H7IaQvCiCn1oRBUfPK5KNpTUiuaEa/lqkWu5BN
	 bqff9p6DfcD8AgTkTqao86M5fzz3tRmDchMhbRU9C+BNNfBYwEovQTUmQ79mOF+8ko
	 rAWBg3aZII3uQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: don't return VM_FAULT_SIGBUS on failure to set delalloc for mmap write
Date: Wed, 14 May 2025 12:38:36 +0100
Message-Id: <1d26d64ba145f0bd53608c40c0fcd90d0f92b41d.1747222631.git.fdmanana@suse.com>
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

If the call to btrfs_set_extent_delalloc() fails we are always returning
VM_FAULT_SIGBUS, which is odd since the error means "bad access" and the
most likely cause for btrfs_set_extent_delalloc() is -ENOMEM, which should
be translated to VM_FAULT_OOM.

Instead of returning VM_FAULT_SIGBUS return vmf_error(ret2), which gives
us a more appropriate return value, and we use that everywhere else too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9ecb9f3bd057..f6b32f24185c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1937,7 +1937,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 					&cached_state);
 	if (ret2) {
 		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
-		ret = VM_FAULT_SIGBUS;
+		ret = vmf_error(ret2);
 		goto out_unlock;
 	}
 
-- 
2.47.2


