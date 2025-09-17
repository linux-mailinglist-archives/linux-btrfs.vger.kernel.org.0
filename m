Return-Path: <linux-btrfs+bounces-16883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D391CB7E07E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E871582AA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8CE23AE9A;
	Wed, 17 Sep 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtROpEI3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F33054FF
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095569; cv=none; b=EXS7H1xfOXw+oStl/YP8z2vaPSlbY7/AlkgpPbESEtEynvqVgnUVAy4hYDrK7d/ddvZS+PXFfYV4oJReLSH7T/sSfzHQDoMMAxcRkhF3pGMClyAVgApY9lwO/Ju2YGNmR9kLeBaatxpnxj6QxbK+knjtaLrCQYZaXvf5GCw5uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095569; c=relaxed/simple;
	bh=a0vpaluK+CQ4GX+A91a7WOLZeYb2jE/8ZZoaC5h+36M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXdtUjdWyvXl2Z8qPkqgGxamWhU8IxYMCXLTVIAXmDRZbhusoyvMdgx/YwZZw1IkOa2lPcrQmaR42sLIdiM9CjKroZ6bAtst9EytsUd0t/YfNaGKVneNj6+0XZi6qX0S7iRjR1NBcWis8P+zUW7h5K5n6KQOWKo8ZyVOSh5jKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtROpEI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173FBC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095569;
	bh=a0vpaluK+CQ4GX+A91a7WOLZeYb2jE/8ZZoaC5h+36M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OtROpEI3LtttAwj0HhAETq9SQPgNO8/52JfzxVXB1zyCtGOWe/nU00YuI86lALXTj
	 mtSk/iWR0L5Ci5aHjBBP9JqnCJinVOQMsGIMrZJFtolrntbgv9YCPu9/XTexpNvkIN
	 GWNzMa1IViLK3lCIH+Ab6eoJ+FOspobpbFoGOAbyAjOYzKUW12t3ZeZcAGgnO/6hER
	 ZT6Ee4rH44RZ6QGE+ahe/0qI9RS36hQE/4zDQiW/zjCCfAer/vgNPAjZNtmrZHbzzk
	 WlpvbJ8HfUKk3Tc2xuLenBlrKCiAu32vhaHsS2x+7/jkuNJG4CgD8sPXfV4T+BbGEj
	 16Et1s5koQzJA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: mark as unlikely not uptodate extent buffer checks when navigating btrees
Date: Wed, 17 Sep 2025 08:52:41 +0100
Message-ID: <f7486f5ced7df5ec5a7d9e088fbe3f6a9260e02d.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We expect that after attempting to read an extent buffer we had no errors
therefore the extent buffer is up to date, so mark the checks for a not up
to date extent buffer as unlikely and allow the compiler to pontentially
generate better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6f9465d4ce54..f6d2a4a4b9eb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -844,7 +844,7 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
 			     &check);
 	if (IS_ERR(eb))
 		return eb;
-	if (!extent_buffer_uptodate(eb)) {
+	if (unlikely(!extent_buffer_uptodate(eb))) {
 		free_extent_buffer(eb);
 		return ERR_PTR(-EIO);
 	}
@@ -1571,7 +1571,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 * and give up so that our caller doesn't loop forever
 	 * on our EAGAINs.
 	 */
-	if (!extent_buffer_uptodate(tmp)) {
+	if (unlikely(!extent_buffer_uptodate(tmp))) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1752,7 +1752,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 	 * The root may have failed to write out at some point, and thus is no
 	 * longer valid, return an error in this case.
 	 */
-	if (!extent_buffer_uptodate(b)) {
+	if (unlikely(!extent_buffer_uptodate(b))) {
 		if (root_lock)
 			btrfs_tree_unlock_rw(b, root_lock);
 		free_extent_buffer(b);
@@ -2260,7 +2260,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 again:
 	b = btrfs_get_old_root(root, time_seq);
-	if (!b) {
+	if (unlikely(!b)) {
 		ret = -EIO;
 		goto done;
 	}
-- 
2.47.2


