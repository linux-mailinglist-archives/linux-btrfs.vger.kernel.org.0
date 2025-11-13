Return-Path: <linux-btrfs+bounces-18951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B5C593CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F434EB818
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22835E543;
	Thu, 13 Nov 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMU6MADL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B835B12F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053005; cv=none; b=jYntcfhbXwSbPfb6uD2WqzT5Oh/kJZLO2iIkhs8fQ/aLVH16WdcgsKxqrjY2LUWKcvQxpKEMe3moHBQDwT56SAz3hDoWcu8Gopc0jABBKoyS0eiTav+u8oaDk4YsOLKx4+WhRvaByIO5t1274uHJmVM114Qe0HtzfNbotsI6Hi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053005; c=relaxed/simple;
	bh=hcHOfqQ5zCRaU9Xd6BJauun76ASFxcqBdFoB2nrspW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFmGqoheRhd8nZ23NuX8zzIjG8gWgNW3+8ii0CNT0H72EBZw3glJzEQwRJ1BYaKsDTTnJddqMtXcnJWeG30isiANx4UNIonWwM2XvKh2qZcm92dXzpLUuxD0auT3rXRZCVFid6JBMk9k/eyjPUWvDdJ0GuhH5bgpZWLF0UXJ4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMU6MADL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19354C19422
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053004;
	bh=hcHOfqQ5zCRaU9Xd6BJauun76ASFxcqBdFoB2nrspW8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DMU6MADLWVp0FX8v8d5K8qniWt5iq7tL5EtNUTrUbmjzB1s3cnl7ZFeYhMyyZ1fKB
	 XM4B+dXtjhEpCXnvdTQ/2thshUjtFzfBinCjLIsjptFfSaLlmzDkhnqPjBG7q7oxhz
	 I8QNYuqPhHXn/w9vUYSkRacbRDhxGGLO/H1Fa087x3C3KSt6MqzN4Tcv01JTaxQDE/
	 jwmSlPOpTIFYpxvJ7JNBv4fox3dNuLa6wFfQ4ry+T28lqROyE0RU1H2tc8GjDjTWSo
	 HbgnQoNcTC9wdTKhXtIV7ABB1q11Dww3ldfdB3ddq1RO4rQ8CyI9xm+nMZRda77U8O
	 aZpSKUZaNSZEA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: fix leaf leak in an error path in btrfs_del_items()
Date: Thu, 13 Nov 2025 16:56:32 +0000
Message-ID: <ac7dcb7e8f4afe86b88904e6b130795235501e44.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If the call to btrfs_del_leaf() fails we return without decrementing the
extra ref we took on the leaf, therefore leaking it. Fix this by ensuring
we drop the ref count before returning the error.

Fixes: 751a27615dda ("btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f6a9b6bbf78b..614aa4b56571 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4562,9 +4562,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			if (btrfs_header_nritems(leaf) == 0) {
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
+				free_extent_buffer(leaf);
 				if (ret < 0)
 					return ret;
-				free_extent_buffer(leaf);
 				ret = 0;
 			} else {
 				/* if we're still in the path, make sure
-- 
2.47.2


