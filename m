Return-Path: <linux-btrfs+bounces-10571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1669F6BFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4686C188F283
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD751FBCAD;
	Wed, 18 Dec 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTHNod+2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337E1FBC94
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541627; cv=none; b=JLoctL7Ha8d6j1JHgAb754LtK7eUmmaA3UQGOquJ+DVd2wSVh6PxdJQVRhXoyG7ktW/0JCx0Li5yKRdOL01wOKf3qXHBS5Zr11nFZQMUvbiLAAAq4nunpcn5X+0vt9BiXocgFqg8jND7x6dQ4k9C58PRe3BV0pN7S6dGdLtCQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541627; c=relaxed/simple;
	bh=DZQr1AA3c7qYor4LhCmgUYx78zwq8C4hDfmWym5aeuc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8+VYPG42GjhPKnFOpnx2VYJZk4k3OJAzpKCLMXliTgnJhIjsst47//ud+kKxcQngMznBOKS7tSH7h6zp20yhCoAwQg9Bu9cNJ1Ng0SZrqE8zeTBxonPVwbDqoaHMjQgV2CJ1q6v33Yh5OoMeq74SvkC/ym0Qb8fHCPfSsT4SDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTHNod+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B169C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541626;
	bh=DZQr1AA3c7qYor4LhCmgUYx78zwq8C4hDfmWym5aeuc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PTHNod+2UK7kx4yJUZiZxgvwUFg7pObiOxn4Tbu1Po5L7/15/gwv432Cu7Lk5bvvF
	 v0vO7VdXDKA8rR58xDrmw1/qJ2PgzS0xGNkO/40ptcOfnFyc+brj42BwShOxVrQZhB
	 wiul0zu1MbD0PAI5TV1hVAsUlkx7IIXrdpTtn4imLEtzDg7xDLuBMPDmq38LVbnfBF
	 LiSVPXi6wwk4p4wY2NpUE00sZPgOtG7v2DSt6RiUgkqryBkCKozJ9Fd9vNKkQkS+26
	 BdMsQRDYwF7cHTJF0uLVe6klhOJrwdcE01Dhgo2fbpOegetgTesXeZjCpvT9+OzbMa
	 +n2eSYg+/PL4Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/20] btrfs: raid-stripe-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:42 +0000
Message-Id: <391f3310c893ee95f6aeba758365e24d71b87302.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The call to btrfs_mark_buffer_dirty() at update_raid_extent_item() is not
necessary as we have a path setup for writing with btrfs_search_slot()
having a 'cow' argument set to 1.

This just makes the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 45b823a0913a..0bf3c032d9dc 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -169,7 +169,6 @@ static int update_raid_extent_item(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer(leaf, stripe_extent, btrfs_item_ptr_offset(leaf, slot),
 			    item_size);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
 	return ret;
-- 
2.45.2


