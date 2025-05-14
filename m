Return-Path: <linux-btrfs+bounces-13997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1EAB68CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BD8177529
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536C270EB2;
	Wed, 14 May 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQNI+cm1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71E270EAB
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218568; cv=none; b=TP/xv8eFzcpLRoOHjVbhcp2DE1LZ23B1fqPORL2kh1bg4xa2lrLSutY8Dy/rpOimHsdvlXjDYZXafupifmdrzAc5g9UQ/CTYUDLCErpGmrLjul7kUHkTzGujmOdK/ssJsqqFcy2QZZuTZ8SwqPlHuZkVMdFf3mxlFgmg3UOPZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218568; c=relaxed/simple;
	bh=/rgzShxNGmNKMiQIV6kKRrXzOb1HVPcb0qbAjXDuNtk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1MVAD5h0q3olHGDxDU8U6ZNWcn0BZyt/VuKehQrnGe2fmSujDBvdbyhUuhq2RJfLsNF5JcSB4GtOI+NTd4EYHSWhcTxAD+f8HaoA63glgD8A23jUA+ak+qnkOimB78WhTQRCPxGMq8/p37SIvFKNuak8PGaUyx/vJfR8rAKgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQNI+cm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F77C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747218568;
	bh=/rgzShxNGmNKMiQIV6kKRrXzOb1HVPcb0qbAjXDuNtk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gQNI+cm1xH3ZB/cEIwClHZowitVzY6j3zGVFf9IO3G5dU8zjc1bD8ZpHwUPntOTfS
	 NF7OFpgUfPxDaSgLp6dtNY+dx0xZnv7hgC+E7xAKLvr/cun9fW9L1jDrGw22uTwMEs
	 /DDaa9uLV0carG/QFcO5I/fNYjhRKs2pz9LIr8NQL2O2813dU1E8JMn+D/57nASeB/
	 Y6/hpeewoOgfJ0AlNd7alKDVAd9yNKwGTSaR5MkzmeDeXL5hju5+b45AZCWgaad1SQ
	 i0j6beLXmxN6pk6Dt5tb+QBfaXHSdpTxQ9ZncupqqgwsZdyTYav3if3SBz1fAET6qL
	 xtsk8m49Ix0ww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix wrong start offset for delalloc space release during mmap write
Date: Wed, 14 May 2025 11:29:20 +0100
Message-Id: <79efbad28a262a6dbe07decd0f49b5a91a167c15.1747217722.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747217722.git.fdmanana@suse.com>
References: <cover.1747217722.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we're doing a mmap write against a folio that has i_size somewhere in
the middle and we have multiple sectors in the folio, we may have to
release excess space previously reserved, for the range going from the
rounded up (to sector size) i_size to the folio's end offset. We are
calculating the right amount to release and passing it to
btrfs_delalloc_release_space(), but we are passing the wrong start offset
of that range - we're passing the folio's start offset instead of the
end offset, plus 1, of the range for which we keep the reservation. This
may result in releasing more space then we should and eventually trigger
an underflow of the data space_info's bytes_may_use counter.

So fix this by passing the start offset as 'end + 1' instead of
'page_start' to btrfs_delalloc_release_space().

Fixes: d0b7da88f640 ("Btrfs: btrfs_page_mkwrite: Reserve space in sectorsized units")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 660a73b6af90..32aad1b02b01 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1918,7 +1918,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, page_start,
+					data_reserved, end + 1,
 					fsize - reserved_space, true);
 		}
 	}
-- 
2.47.2


