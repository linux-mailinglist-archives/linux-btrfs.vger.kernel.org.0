Return-Path: <linux-btrfs+bounces-11076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EFA1C8FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3A6166674
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jan 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F3183CD9;
	Sun, 26 Jan 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TReILKhi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F71AAA10;
	Sun, 26 Jan 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902976; cv=none; b=gmIGY9ohmLWRFGO7zTYIjiKN8/MlxOuKIKcaxiGineHnUWl/2FyDBtVV0D8LzqH8xGHwEHCVtX1/pSb7whAhBRYN17Y97hnLhQ3TVg2GBa9QffH7EXeYqvGLjWSMR2yJZe6U9D9WQcWz3pNkaEWGv3uup3cLxrOsgvEJrEip8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902976; c=relaxed/simple;
	bh=ymdRAv+MkBFBUHahHjbRKVaIhnFI9LiYBcxnFb6W+28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTU1ayUCaFWajv6qjLia4FHiULMi7OLq8ELQOOH2HdvGVE0sluHUerLKf1GXrUDqUrJgyjmU99O4h1GEoEaaO/ejH+TO39cARPtQD6M0HBjjKtnu5a43F7qs54uxuXlJCuZ21PWh6Zt8vTjQeKgW1yGfBHdggT3b5hp1kjq0KiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TReILKhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B971EC4CED3;
	Sun, 26 Jan 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902975;
	bh=ymdRAv+MkBFBUHahHjbRKVaIhnFI9LiYBcxnFb6W+28=;
	h=From:To:Cc:Subject:Date:From;
	b=TReILKhiIcVpBZURFp39AJB1Nd4Qp6F6hjPx019BOKu2HVX9lI+D4KaDPMbUl/wvk
	 ke70xrBYDvgJBp8KOoaoJVZ+wyKpjmuf1ug7N52asfAu7HgjXjFP3n9gojtqBO1VZA
	 dJ2uwJnhXHwtyVS1wtcTyRTGtkZX5qsbw6LwLmc3dwd+2+H6PK1W0O6Ub4o3bj/LOb
	 mAwUG92Ady+Qp1k1Z16tbOgAxx3L51Tjv+/6xmP7yUCTTunwKPe/Cbx4AtzR7yVQ4T
	 Gwup8bkUXypM7BuNxIFWZeqkpw33zbTpL5id8rVvse2YRG3QPMk/Ua+W4TMvR9YSyi
	 efz3UxVl6Exqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Sun, 26 Jan 2025 09:49:33 -0500
Message-Id: <20250126144933.925681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 6a4730b325aaa48f7a5d5ba97aff0a955e2d9cec ]

This BUG_ON is meant to catch backref cache problems, but these can
arise from either bugs in the backref cache or corruption in the extent
tree.  Fix it to be a proper error.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 89ad7e12c08bb..062154c6a65f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4789,8 +4789,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(!first_cow && level == 0);
 
 		node = rc->backref_cache.path[level];
-		BUG_ON(node->bytenr != buf->start &&
-		       node->new_bytenr != buf->start);
+
+		/*
+		 * If node->bytenr != buf->start and node->new_bytenr !=
+		 * buf->start then we've got the wrong backref node for what we
+		 * expected to see here and the cache is incorrect.
+		 */
+		if (unlikely(node->bytenr != buf->start && node->new_bytenr != buf->start)) {
+			btrfs_err(fs_info,
+"bytenr %llu was found but our backref cache was expecting %llu or %llu",
+				  buf->start, node->bytenr, node->new_bytenr);
+			return -EUCLEAN;
+		}
 
 		drop_node_buffer(node);
 		extent_buffer_get(cow);
-- 
2.39.5


