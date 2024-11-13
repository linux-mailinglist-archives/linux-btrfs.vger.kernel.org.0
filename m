Return-Path: <linux-btrfs+bounces-9579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8569C6ACD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4151F23AC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262C18BBB4;
	Wed, 13 Nov 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s6Zeu+KJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DF18B498;
	Wed, 13 Nov 2024 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487556; cv=none; b=jZI1byiQJYxQzIsZ4yVRBe53y5bnSjko3sFUOlNUaB9Dy6yflnwC4BNzh0py3Su9dLsIejYSZ6WucPuuNhPMh3LgJqYc66hyOYEyBKfKCtOQSpB9tLveKQiBAnp9M2cML+uOE1+SrLKLjvR6YZlycHPrGmv7I9ggsUv9f1Nhr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487556; c=relaxed/simple;
	bh=Tu66ZdbR6J/RBKHVye29oDMkLb/iCCS1kjlWKJzupy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3v6XPAfl8SBTq5+gGNwEKNdVCNyH0S2CbAVrnrd6WiI1hwnN0VroWozJ/tjx9IX7DnHck/NVDHC89cyO0/BtQrOdVzC8r6F/SaxMHm7CmIx5ojAtTUHu+T9XMd5cYHaWTUXnXJkHZp9RafyIvqu/fG0k++B6243hIxDERhyR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s6Zeu+KJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3z11XRgpBhaUZOan9SVXKNw2s+5Kf8NBvlOmodPPK9E=; b=s6Zeu+KJ6dSLbb4vZFaN6LvOKg
	53X/av3y5eTj6Wz+9JyzWyA7VEB4pA1t7uCJLdXgbQHBXUeT2BqiexWZZ+1l8rnGwPzKBwW2hrT9H
	wk6I7/RyqgS8WeZt8neEBPNdFBWF9wwTMxljULiTZwpYjUzJcb/flZJP3do1ZNPYyL473RimZqJBy
	ad5x7Hr6yQn3Dx+tcOxARM4WH+wzFbFm470BzXefDGMdLKyhll6ckyknJ6QTA9jS/dlHhgcZwNw0R
	1xp7LCXlGhuuolpM8cf5scrbn8mLTPkPR77mbLh619xSFFp1YIA3auefiIHgxy+5/HB4PmvIbz/xy
	ew2OJZbw==;
Received: from 2a02-8389-2341-5b80-9e61-c6cf-2f07-a796.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9e61:c6cf:2f07:a796] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tB90a-000000068hM-21VN;
	Wed, 13 Nov 2024 08:45:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: validate queue limits
Date: Wed, 13 Nov 2024 09:45:36 +0100
Message-ID: <20241113084541.34315-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113084541.34315-1-hch@lst.de>
References: <20241113084541.34315-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Call blk_validate_limits on the queue limits used for zone append
splitting so that calculated values get filled in and any stacking
conflicts get cought.

Without this there isn't a max_zone_append_sectors limits as of commit
559218d43ec9 ("block: pre-calculate max_zone_append_sectors").

Fixes: 559218d43ec9 ("block: pre-calculate max_zone_append_sectors")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 46b9386957e6..64cdae31d348 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -711,6 +711,12 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 			blk_stack_limits(lim, bdev_limits(device->bdev), 0);
 	}
 
+	ret = blk_validate_limits(lim);
+	if (ret) {
+		btrfs_err(fs_info, "zoned: failed to validate queue limits");
+		return ret;
+	}
+
 	/*
 	 * stripe_size is always aligned to BTRFS_STRIPE_LEN in
 	 * btrfs_create_chunk(). Since we want stripe_len == zone_size,
-- 
2.45.2


