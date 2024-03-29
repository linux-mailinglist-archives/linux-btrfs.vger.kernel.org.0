Return-Path: <linux-btrfs+bounces-3769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A86891B97
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFC11F258A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EE176556;
	Fri, 29 Mar 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGQY6zPb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36D17653A;
	Fri, 29 Mar 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715739; cv=none; b=nY4kp/RFgzPJXjCM5xtvsqWQjHK2NqJGTx2Y/aIAxuiHtywT1kvd5HTRNswbLikBvVyQoqfKxLJaKO70ZKWFauXes3d1UWsRnMC8YQITASPDNdvQHLE0WM9vUHsr3h6jG/5uIHDgJLurWnkZbKwRmKI9RW7qqLxHmM4YdJ0au1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715739; c=relaxed/simple;
	bh=O3ru5G/M1wtv0DLhsF2kxo4GcuvqQt2dfh+UOJC6UI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHPp+w7dO6qIVx214q3SHsc/7khMwy3ufCTLUIn69qWiRp7K0ovr0H8liXis6yLlUcoTb+/QVKF/MDTfG4cxDcL1p7B829G2L3S/tegkNggCN87wZAp87UEuYWn3vRmIjmQw4mpeNkZwf6YCh0g2T0aIv+1NQ6LI/nkm7V2sCiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGQY6zPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3942C433F1;
	Fri, 29 Mar 2024 12:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715738;
	bh=O3ru5G/M1wtv0DLhsF2kxo4GcuvqQt2dfh+UOJC6UI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGQY6zPbLDBcu/eFq7Ve9CvI1PL02xQHKFIQ0Z1sDAmZKDgSx4G72qjYOc9oLeVOk
	 V91qSM/GTNgYNgbhM1ZgyU3aJ6oJwS4KeO1Kj6LuPYB3Uf+fKDg7WBZibgwHx37WHQ
	 rWD+uL9tSLfDpQfbMf670V0iFPmZ2vORYM391Fy2Y4eZFidUddv8siLws+fXbVtotZ
	 g6ODLqwMR0Y07B9mjjd09KM/d6h9E/4hleTzRhxi8/hlsqZYH2HjUOtKQfP0XGYoWP
	 vEKQD9lYsJcc+Ll+NHqccnJrfblsj/tX89aEYyCgklf0wUCfB18Fu2ds5Rcpvuv6nd
	 vRRFQw3jzEwzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/11] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:35:15 -0400
Message-ID: <20240329123522.3086878-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ecc33e3a3c063..01e9a5afc33bf 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -182,8 +182,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0


