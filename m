Return-Path: <linux-btrfs+bounces-459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158D7FFEC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1240B20E48
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925661FB7;
	Thu, 30 Nov 2023 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AyP9XADR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF51197
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 14:56:22 -0800 (PST)
Received: from ds.suse.cz (unknown [10.100.12.205])
	by smtp-out1.suse.de (Postfix) with ESMTP id 66E4621BA8;
	Thu, 30 Nov 2023 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701384981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzOfQJwpCXV8qtyBz19VkWWrtEytSek5CToDqjEZoYU=;
	b=AyP9XADRFNSyjokd7Dt6+wS86HqBe0HFq8a7W7FNj843//5IqTuHXIBvPd6LTqe3FGFbP6
	+Dwn/Ii99J+b8JHXG4FCdXqApMETE8h2TXDNuevtB4NtUtRihgO29JUlRL+eFnMroGOHI0
	NpW6EhTZ3REt7CdhNRsDsSZ/XKtzq8o=
Received: by ds.suse.cz (Postfix, from userid 10065)
	id A1EA6DA86C; Thu, 30 Nov 2023 23:49:08 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: drop radix-tree preload from btrfs_get_or_create_delayed_node()
Date: Thu, 30 Nov 2023 23:49:08 +0100
Message-ID: <b2e1e88e405ef7e0fbaf9e9aa667c95265f0aa68.1701384168.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701384168.git.dsterba@suse.com>
References: <cover.1701384168.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.62
X-Spamd-Result: default: False [0.62 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-0.68)[-0.677];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_COUNT_ZERO(0.00)[0];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.00)[43.74%]

This is preparatory work for conversion of delayed_nodes_tree to xarray.
The preload interface has no equivalent in xarray API. It has a benefit
of an early allocation outside of a spin lock with less strict GFP
flags.

Without that we rely on GFP_ATOMIC that is set initially for the
structure. In order to bring back the less strict flags we'd need to
convert the btrfs_root::inode_lock to a mutex but this a more
significant change and should be done separately later.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 91159dd7355b..c9c4a53048a1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -134,23 +134,17 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 	/* cached in the btrfs inode and can be accessed */
 	refcount_set(&node->refs, 2);
 
-	ret = radix_tree_preload(GFP_NOFS);
-	if (ret) {
-		kmem_cache_free(delayed_node_cache, node);
-		return ERR_PTR(ret);
-	}
-
 	spin_lock(&root->inode_lock);
 	ret = radix_tree_insert(&root->delayed_nodes_tree, ino, node);
-	if (ret == -EEXIST) {
+	if (ret < 0) {
 		spin_unlock(&root->inode_lock);
 		kmem_cache_free(delayed_node_cache, node);
-		radix_tree_preload_end();
-		goto again;
+		if (ret == -EEXIST)
+			goto again;
+		return ERR_PTR(ret);
 	}
 	btrfs_inode->delayed_node = node;
 	spin_unlock(&root->inode_lock);
-	radix_tree_preload_end();
 
 	return node;
 }
-- 
2.42.1


