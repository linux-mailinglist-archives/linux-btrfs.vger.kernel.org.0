Return-Path: <linux-btrfs+bounces-15385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67CCAFE76D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E25A4FDE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985B2957C1;
	Wed,  9 Jul 2025 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxGk9GGT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3828DF1D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059639; cv=none; b=ZJX/oBpUBT9bHRaSWGXLNun4egtVEI+ful5C0vuhenkLhuBW+P82nONw9uFqw+il63713Os6OhTcTaX3c8qOsbPon2LqupF53PidQk4/2dO6B8/7qHbnExVyr0H7/i9y/b+TmiF7g1u6HwycF27QOIbFypjSwdHzzXSVcbdCdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059639; c=relaxed/simple;
	bh=wIP17b7XvIfy+8Xz5UcbQT5qFNbr+3LlwCG9D2awaUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwinCYYPBloo9vfpCaCRlab5K/Pgrks2KYz5UMu8VY1W/jXF810TWPhbT7B1aipTI6RwJLSOlkdVV9JLI63TvyPDFmzhEBmzo31RS31O0Wp7IGO7WsBuf+hcZvpP0w73ujlF1OoX9fTog+raBGvhkWh/9+c0J58vz63EX4Agrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxGk9GGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA945C19425
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059639;
	bh=wIP17b7XvIfy+8Xz5UcbQT5qFNbr+3LlwCG9D2awaUs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XxGk9GGTVPoXIGnjpU5ey+RMPfc/idYepslfL2ttDMFhhx1oYIPF/i6tIP1oDM+gb
	 H+ymTLm5PINb7goZHz7e4Y2ITulkXVLlmud93QzQy+uo7dWSF2JIdRuNp/krCKsKun
	 gfI0+T/JNXyuHqr/Bw631nmwBWkdCa3aekEUqxiqxkUR/RjapnMhO+WlCSsEpgGPR2
	 VWzb4xvZdq1YXcN3rj/nnwfWZ2r2dsMo8WvMuTejbnPCqKkqfrXXLlSZN/aPvF4fFs
	 E4DkO6bj0KjScDaTRfDzk3T26VYBV7KEacyG7GsPqC+o0nGuYuEUHapNj/u+mgZEW3
	 oPMrD6uKfmP1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
Date: Wed,  9 Jul 2025 12:13:52 +0100
Message-ID: <7964015a07b26aae30e101a56384919bd7934159.1752058855.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752058855.git.fdmanana@suse.com>
References: <cover.1752058855.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have the inode's io_tree already stored in a local variable, so use it
instead of grabbing it again in the call to btrfs_clear_extent_bit().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9ea3b4d47f81..80a828f39bbd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1946,7 +1946,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * clear any delalloc bits within this page range since we have to
 	 * reserve data&meta space before lock_page() (see above comments).
 	 */
-	btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, page_start, end,
+	btrfs_clear_extent_bit(io_tree, page_start, end,
 			       EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			       EXTENT_DEFRAG, &cached_state);
 
-- 
2.47.2


