Return-Path: <linux-btrfs+bounces-18956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50983C592F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C44565338
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C7135F8DE;
	Thu, 13 Nov 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a027Cd7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE035F8DD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053009; cv=none; b=jZY8OrlGUQbQMu5WFlDBVBVSxDxuYSBi1rlzEsHCnEdOUyPeOXnpGnKuyrJ9UpCZFORedjXI+v9FJ0HgPjtGsMjMkPgMhyio4FufGmTrs95/iu+n+L7ba7V/WzE6qHJEkzuOzEWRlgDYXcrURPANb1zJn0vlk4MQm/IlGGlY+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053009; c=relaxed/simple;
	bh=i5cq5HuYhsTfuSZttT4sFkHb5MKmxHmaBx/tYRZ3TAg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK+tvICwr3fgql065meyM8GmI13RceEH1Vm17djA8EDg7VW5jBoZKeuBXLhm3GFQQxtXNYBmNKHbQ/LEU9Avj32tbgGKmkHWUXNkhGwtCgjLZuuctDKNxoK+gZLMo1RgVUnvtzxMwjmCNXK3DdCgvdlfmikgy08hzQJOaUNK7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a027Cd7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F8C4CEF5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053009;
	bh=i5cq5HuYhsTfuSZttT4sFkHb5MKmxHmaBx/tYRZ3TAg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a027Cd7Qe3n59pKNYNBqO9jTNcLMU4iGLZMI5NAgSarJFHVMfp9wxYk/CVS9Tdqav
	 SOUwFpWeNlNobady038/s4Zp5GZu7PJBS9r5lIawLsef95TzjAZUG023h8Q5YyJyEv
	 ih59ety3IZvzPRfIb1cq4q34H49xZaWBOJzYS+JB1zNeEcvSlUKWMvUaA2LX5dZeW0
	 RgbrPCUG5l17dAjthReELYGIsBHmsyRIRkXncPo4RP7gZnOhcwRgGq78yQyv7oZyhf
	 LEhYOZwP5A/riK3fQ0QH4kEOk7FEv0AqByyPye6ZeuUwPoZDWfHgAq3jNGDky6yVFZ
	 VIRFEz1NhBSIg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: always use right leaf variable in __push_leaf_left()
Date: Thu, 13 Nov 2025 16:56:37 +0000
Message-ID: <b48ed2c801f78d0fc7d42a7941a737cdb20d8e1b.1763052647.git.fdmanana@suse.com>
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

The 'right' variable points to path->nodes[0] and path->nodes[0] is never
changed, but some places use 'right' while others refer to path->nodes[0].
Update all sites to use 'right' as not only it's shorter it's also easier
to reason since it means the right leaf and avoids any confusion with the
sibling left leaf.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7265dd661cde..57b7d09d85cc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3428,8 +3428,8 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] < push_items) {
 		path->slots[0] += old_left_nritems;
-		btrfs_tree_unlock(path->nodes[0]);
-		free_extent_buffer(path->nodes[0]);
+		btrfs_tree_unlock(right);
+		free_extent_buffer(right);
 		path->nodes[0] = left;
 		path->slots[1] -= 1;
 	} else {
-- 
2.47.2


