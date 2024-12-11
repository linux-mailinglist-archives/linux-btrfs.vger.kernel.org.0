Return-Path: <linux-btrfs+bounces-10234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38A9ECF12
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F82C283EE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B31D63CA;
	Wed, 11 Dec 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb/g5Nrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102D1D618A
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928819; cv=none; b=uEJQSSs945Gp9o2nWlcZcJE4QKTwmYQAprv1GGSa4AxgyjYfj9BQpo4Q3gQuj6F+z9bOODWixPDS5JkZ+Z2L7mwaKrbxOAhoH4esL8s419KWJsnDE5p0Lq1UoboeZvjWWCLgx6r3e9aJD8cCPOaA3ADiSYm8QEWTZUVsLSXpILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928819; c=relaxed/simple;
	bh=CYBRkDsmtANHN4WgojWQVkSyw2QTe/htm/IKqRNm99I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjQMOc2LCYyi4cc22CP5L5QM0ybm+9QK1a1pp53/rqwKidol29ttXWUKJxCndwolcCFKmwoW0Ieb3cERDhvIpALboc27MY2mBLItCTFgQ7a27FSsjPKSd7wGALDwWkxassh4Df3l+MJzXaLUWOKcPZ4zr+y9OgunUiuDkHEMRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb/g5Nrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D6C4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928818;
	bh=CYBRkDsmtANHN4WgojWQVkSyw2QTe/htm/IKqRNm99I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mb/g5Nrzr89QiysN7xgYQpT6uIMXsNVbo6FpYUfjPklYEqwxYIMkOaoaXymfz1KRs
	 MU4MLqHCS4Wvj22h8pzO+3nSa5CE10iqhGStO7UHYSC/PH/LVkK5X62h+h7X+2hYe8
	 K8t3sSUYxZD8nkJbDw81WG2aOAZ8X/EC8HnfYjrp0sTRXPhLEJWO363Fm0wQFDDsXs
	 bzcuWCS6+xBZvhRvNge5/AebQJg5SREHbTC6CEgxg4OiN2Ze170h191VlewyFI6IU6
	 mAoMcL+VfdEpQM33JiIxBlPmpJxMhMa08VjKLdfjwkgetezNbEOZojA3e3vRdRCAut
	 UBDKfsOEMYcZA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/11] btrfs: avoid redundant call to get inline ref type at check_committed_ref()
Date: Wed, 11 Dec 2024 14:53:24 +0000
Message-Id: <f0eb6f32a8506023a889bc0e034806e4952910b3.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At check_committed_ref() we are calling btrfs_get_extent_inline_ref_type()
twice, once before we check if have an inline extent owner ref (for simple
qgroups) and then once again sometime after that check. This second call
is redundant when we have simple quotas disabled or we found an inline ref
that is not of the owner ref type. So avoid this second call unless we
have simple quotas enabled and found an owner ref, saving a function call
that does inline ref validation again.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e81f4615ccdf..00e137c48a9b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2352,6 +2352,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
 		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
 		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
+		type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	}
 
 	/* If extent item has more than 1 inline ref then it's shared */
@@ -2359,7 +2360,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 		goto out;
 
 	/* If this extent has SHARED_DATA_REF then it's shared */
-	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
 		goto out;
 
-- 
2.45.2


