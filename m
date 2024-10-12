Return-Path: <linux-btrfs+bounces-8877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372299B377
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 13:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5F31F2260B
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E069195F28;
	Sat, 12 Oct 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAmt6qd4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EF1940B9;
	Sat, 12 Oct 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732393; cv=none; b=SZHObJleq5AAFskkyoXbxA54Re7AsLvyFS6IOQSpI+SjtGbBe1oKd6C13ueNEhd8YWG8PbRAxoBkHcBWVIU0jLBcYVey8U6GXpEZTI487SSpTpMY2ttVuSyl9SOUURm5yS2BVzhr/C3punO0+jY1fMJARVyyBOtcXJ9HgZJOx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732393; c=relaxed/simple;
	bh=pzE5UPu+JslCqtq81Lgg6eO7m6KS0Izz5dmoiSNCmss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqwWd8xM5PVCWAB/P9uTYHPtD/b1RzZb0dyNOJlf6h+HSmdJcr5gH3YdhvUwXG88DTlR6BJbGZTH3E91DDYGBQ7CbHdpozHQ9MBb08bWvJ25dofglJX0t9DhtApHkeV35MTSNGX2/Toxa9QZEg+oKV/fjXlXMcii4UHsuRkLBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAmt6qd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA378C4CEC6;
	Sat, 12 Oct 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732392;
	bh=pzE5UPu+JslCqtq81Lgg6eO7m6KS0Izz5dmoiSNCmss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAmt6qd4DFcIZmtFJBKnANfWYHWbJCRaARkvSa2cckMlpUiTW1hZwm1uyPk02r0kP
	 y4TnRVmmf0i5H2qYKDBj+D5eN3hFCM7m2R26/9ba0O0WyzUG4gfbNxFre1nBkOe11l
	 02IZmIGZE22BkBwHqmljn0EKQwUUpE2R75bTGgnzPHbu/73MTrH6jmZp7bbBz6wI9s
	 5L6GVh5n2iHB4dSY4z2gxUdY+XDS+z3++uJeYA9wcMt7E1WcJTUYLvXxfc1NgP90cw
	 Pd2CZ9ozzVnvgcdNh8kCgET3kGXlOL0Sb+WF2vbaGYLuQMPrfMeX1gP1Y1jpdKfV4j
	 6MLFuR4KnOxZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/16] btrfs: also add stripe entries for NOCOW writes
Date: Sat, 12 Oct 2024 07:26:02 -0400
Message-ID: <20241012112619.1762860-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 97f9782276fc9cb0de37a5eecb82204e48a5a612 ]

NOCOW writes do not generate stripe_extent entries in the RAID stripe
tree, as the RAID stripe-tree feature initially was designed with a
zoned filesystem in mind and on a zoned filesystem, we do not allow NOCOW
writes. But the RAID stripe-tree feature is independent from the zoned
feature, so we must also do NOCOW writes for RAID stripe-tree filesystems.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1b6564ab68f0..48149c2e68954 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3087,6 +3087,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		ret = btrfs_update_inode_fallback(trans, inode);
 		if (ret) /* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
+
+		ret = btrfs_insert_raid_extent(trans, ordered_extent);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+
 		goto out;
 	}
 
-- 
2.43.0


