Return-Path: <linux-btrfs+bounces-6807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A293E32C
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 03:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5108B280DBD
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BC01A2C10;
	Sun, 28 Jul 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfKt60Vd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCA1A2578;
	Sun, 28 Jul 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128163; cv=none; b=lqFJXa1UOyqngxfeeAmqJJdbTgABjcp+NAaXwlXQrmPK/In4MWpg0w3wQENjiqRQcW2tpblu0LXi9wkSVLYihbZVJJNt7euMySSwskkopmxfM/0RT1XUuHJRdJSuzKCM2eVgppzp7pxp/J6KqJnFRsBsdl5V/RFaDWHHyhyR8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128163; c=relaxed/simple;
	bh=T3kT3aF+NaFwrOaCo+7NVvhnR2d0c2j/hp1l5u4t4WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV0Zm3GeCNPXyDywqozSK10eFyfkiz2u0BEBSn27ohA1+dk7HEuE1k1CG1BXQR71S8+lObmo0rTjBDqnULtVpBLZt2VNhwaS+94ntf/PZnwc3tdhYxce5R967xB5wd9TPVMuOrLDbFfq+HAv6fLiwpi3ChLShjGxpeImkHWOPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfKt60Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EE8C32781;
	Sun, 28 Jul 2024 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128162;
	bh=T3kT3aF+NaFwrOaCo+7NVvhnR2d0c2j/hp1l5u4t4WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfKt60VdV+bkps7N3TYPxxGn+ZWco16dYikAKwz1tvZq7reqXzUq8Bsi6ENdBroOI
	 UkvEuleiQLXtnJUXuTErHCw099hBBEbhFjd24l7cvdU3y3vP+kJObYmMXuiJxQY73b
	 +w3DmpcmtuByguatm1PxDIlulMRIlkkeyKGjW4IL2mAe824cmQwPJwVYlV6Asknaqv
	 AMC+QXbDkuv/AFY/fLvwYmJZOUABnqe6nDgJlNeKCz9HmD4aKCA/2mlci0es0X2PZI
	 SmDyaHSP0ryR4hpcUUR+8zvfgOsf3nTvUjt13PavLJxLzZWdyeRr6SI/9hejxBRKJZ
	 dmT5LHeR/GCOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/6] btrfs: fix bitmap leak when loading free space cache on duplicate entry
Date: Sat, 27 Jul 2024 20:55:47 -0400
Message-ID: <20240728005549.1734443-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005549.1734443-1-sashal@kernel.org>
References: <20240728005549.1734443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 320d8dc612660da84c3b70a28658bb38069e5a9a ]

If we failed to link a free space entry because there's already a
conflicting entry for the same offset, we free the free space entry but
we don't free the associated bitmap that we had just allocated before.
Fix that by freeing the bitmap before freeing the entry.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 9161bc4f40649..0004488eeb060 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -829,6 +829,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
-- 
2.43.0


