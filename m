Return-Path: <linux-btrfs+bounces-1009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E68165BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADF11C20C5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D36AAD;
	Mon, 18 Dec 2023 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sEbVv17w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33C613C
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LDrDeV/kHy3r/3w2Doo9aEjmT8I+Ne0frQ9VVRfffHU=; b=sEbVv17weiFVYW4uC3vcXO72Or
	iHe5On6foSxOHr1K/hovLNVbTonQILzJu6+PhenHGz11UfW8oxfgg8EiAE9tuR59DIv4GNU3o/qMj
	4ZxoGgl23nzGnFkZe0eyPIpB/mSzfHM34vItwV3ys/VrDLOMDq6GqZ+YuD6BB2kcLoTfrTDGo94FR
	MtNAek5tEamP5/T+Vd0+OwpnlNBQmcE2cnWoqvVNpuKyr73BETciYKPkaDsRwfrnvM/SjHZ8/eyiC
	Dzfxdh93lmesuCVzgO+bUhg/iwxctdCPIgROztZ89vXZ2XGByZVJ6f6U4m5Qa4uANiQCFQIWaQLPX
	cDrTOTaw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5Zc-0094FV-0u;
	Mon, 18 Dec 2023 04:49:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5/5] btrfs: use the super_block as holder when mounting file systems
Date: Mon, 18 Dec 2023 05:49:33 +0100
Message-Id: <20231218044933.706042-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218044933.706042-1-hch@lst.de>
References: <20231218044933.706042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 62a933b47e03c3..2dfa2274b19387 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1831,7 +1831,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 		mutex_lock(&uuid_mutex);
-		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret)
 			goto error_deactivate;
@@ -1844,7 +1844,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
 			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
+		btrfs_sb(sb)->bdev_holder = sb;
 		ret = btrfs_fill_super(sb, fs_devices, NULL);
 		if (ret)
 			goto error_deactivate;
-- 
2.39.2


