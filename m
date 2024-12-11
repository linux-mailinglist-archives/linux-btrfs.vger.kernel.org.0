Return-Path: <linux-btrfs+bounces-10246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9C9ECF50
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34262821AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A231A2557;
	Wed, 11 Dec 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX6WLlLr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5E1C5CC7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929519; cv=none; b=rB7VMdJQ7no0XqFG0VmVmz/PDFfTIUSsBELk00gWHq1u4lqWXFQ+JfOX9W6hHk8Fs0kRkxyW1ThgOtgNIz3yqNnZDZoLoa34Mzju73TzBOqFIKyHdQDqccV/Y6dB9EWUOF/bMa3Dkie1wAqEe7Ir3LdV/0qsZFCIY1dgqUKS7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929519; c=relaxed/simple;
	bh=CYBRkDsmtANHN4WgojWQVkSyw2QTe/htm/IKqRNm99I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSV65cVa3/XTAAM01Icx4UpmpqNwY8NaWlOcqcGyI8qEf7yZMMGrMJqxdLX7T7wwyps43dD9Blec+howzmkqceuuxl6/mV8W1PgCvxnagyiMm3oYm7DUI/XjNPbZmJrjamMl1dQCB0pm5BNUTChq+bh+BqpLTaWsWVB5Ir8m59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX6WLlLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB9CC4CED2
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929519;
	bh=CYBRkDsmtANHN4WgojWQVkSyw2QTe/htm/IKqRNm99I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iX6WLlLrR+B7cEqCnBrBlEKXze+cDASWDT6swuiDznKM/WyPE7BxxchSIiROdwimQ
	 8E2KmSfMx8Xgg2GD6iQ+uIbguiAKMOoTXOXvnZ5Rxl3OuhQDU0wdntV1C49LZxaYRc
	 1O41oDzGsApVduIIuXdI3ph9C1aTQdZNa3uk1IS/7PCVmeM4BNqAJlC8qsacgTwv3o
	 cLpMWKJzp6F23aB3lrHcU1yfREe0ZZm5MCfLTvhvZ81lpQcKDRafnTXYZUvvuzugLU
	 TSeFHAc8pa8q2BKoJuzIk7ofK8bvj1XIyRQsImmEu5Vmn7DD1og/j1u2vO7mmiXXeq
	 lohmaQY0hQqvg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/11] btrfs: avoid redundant call to get inline ref type at check_committed_ref()
Date: Wed, 11 Dec 2024 15:05:04 +0000
Message-Id: <f0eb6f32a8506023a889bc0e034806e4952910b3.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
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


