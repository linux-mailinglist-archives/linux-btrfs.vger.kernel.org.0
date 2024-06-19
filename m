Return-Path: <linux-btrfs+bounces-5816-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A9190E8F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 13:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657F01F21F92
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D07139D07;
	Wed, 19 Jun 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP1ow4c+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B96136E2C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795211; cv=none; b=WLA8fPBxsbHtF+7J8kSUdZudllRg9O97Qvflxsh1BAq8Cy+bziqlsfOGd7FW0yYEz221jk8Hols5cTZWhOQGziImXtXwTTSP2ORio9jRma5kVchoEL+rzb8KCxItvhJRmLWSzIhd6TMO4bXvMKMNRkCheq57osVGsN5a8KWLGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795211; c=relaxed/simple;
	bh=5KntMGn2AISuksmrgBroZsIxyJJPaaz0bTZ8QzbofOY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyJCrcRjzqIn23xASPTLRDqBfACYRSR+GCJHNm0cfB8JPH2sXPreiDwqBIg5oaiIFXSh2adOY7SuRiSkJP9N9gROuc/kY3GDUWHmcqqr1bnx8C2MOBAOBiequLz8rsWbAiVOA1Sdvvq+bbM8ckJKA8zSQPXdJmiJb4CMz4/HHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP1ow4c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6C1C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 11:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795210;
	bh=5KntMGn2AISuksmrgBroZsIxyJJPaaz0bTZ8QzbofOY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZP1ow4c+1jdbh/7V11bK07Lz4ZtN/qmoL96XdkuLjKagV8zwcbEKA+i4Ida6vHD2O
	 OykvligJ/dE/iXD00nUdd3c5E8ZW6QdgibeDMQHxtL5tVbhQJY56GcCr7LG+iEvwIx
	 yT0h+aejDKP5XaFzKHP1C4Yzq1iDiLBiM7ASNVm1qiCIImL4L5t63z92grG4GLCYP9
	 6L5unwXu31EF+A+1EoVM+yqQCRdokoe+PBz6zou3FF7uAM9n8r6ALcVVxXMXPkAVFo
	 PZXbIFpSAN/NjXcSzfEdv2OT2ekHU3zUsBhFfOfiuOCAtA/yFw42jweQfANO45ALKa
	 zlLg3S+ewIu1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: don't BUG_ON() when 0 reference count at btrfs_lookup_extent_info()
Date: Wed, 19 Jun 2024 12:06:44 +0100
Message-Id: <7ebd3b8d03895dc1d9ad3bcdf12b954453237ccf.1718794792.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718794792.git.fdmanana@suse.com>
References: <cover.1718794792.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of doing a BUG_ON() handle the error by returning -EUCLEAN,
aborting the transaction and logging an error message.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 94dffe6b6252..23a7cac108eb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -164,9 +164,16 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 		num_refs = btrfs_extent_refs(leaf, ei);
+		if (unlikely(num_refs == 0)) {
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+		"unexpected zero reference count for extent item (%llu %u %llu)",
+				  key.objectid, key.type, key.offset);
+			btrfs_abort_transaction(trans, ret);
+			goto out_free;
+		}
 		extent_flags = btrfs_extent_flags(leaf, ei);
 		owner = btrfs_get_extent_owner_root(fs_info, leaf, path->slots[0]);
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -193,10 +200,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto search_again;
 		}
 		spin_lock(&head->lock);
-		if (head->extent_op && head->extent_op->update_flags)
+		if (head->extent_op && head->extent_op->update_flags) {
 			extent_flags |= head->extent_op->flags_to_set;
-		else
-			BUG_ON(num_refs == 0);
+		} else if (unlikely(num_refs == 0)) {
+			spin_unlock(&head->lock);
+			mutex_unlock(&head->mutex);
+			spin_unlock(&delayed_refs->lock);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			  "unexpected zero reference count for extent %llu (%s)",
+				  bytenr, metadata ? "metadata" : "data");
+			btrfs_abort_transaction(trans, ret);
+			goto out_free;
+		}
 
 		num_refs += head->ref_mod;
 		spin_unlock(&head->lock);
-- 
2.43.0


