Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52412A469A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgKCNca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbgKCNca (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIpf6DBdd+mocufU/gfzgTZpllu4tbr6/Nb8M64ZJnE=;
        b=Tc782h4JWdTYIh7cfzZqbShP87VyWkRMWn8oBkjWxtuMIQu3pYAhLQPCfhCfnSWA70nAW5
        vTCM6k71W5Ti5paylQi2HfH292mGSa81/TRE2SLopIJHDqtErYUEPc2AaKjY9ALMmV1jqc
        QhaZIEfsdMP5bl0o/kltFFvINn3ccXc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F4106ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 26/32] btrfs: scrub: remove the @force parameter of scrub_pages()
Date:   Tue,  3 Nov 2020 21:31:02 +0800
Message-Id: <20201103133108.148112-27-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The @force parameter for scrub_pages() is to indicate whether we want to
force bio submission.

Currently it's only used for super block scrub, and it can be easily
determined by the @flags.

So remove the parameter to make the parameter a little shorter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 42d1d5258e83..7e6ed0b79006 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -236,7 +236,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage);
 static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
-		       u64 gen, int mirror_num, u8 *csum, int force,
+		       u64 gen, int mirror_num, u8 *csum,
 		       u64 physical_for_dev_replace);
 static void scrub_bio_end_io(struct bio *bio);
 static void scrub_bio_end_io_worker(struct btrfs_work *work);
@@ -2150,12 +2150,16 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 
 static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		       u64 physical, struct btrfs_device *dev, u64 flags,
-		       u64 gen, int mirror_num, u8 *csum, int force,
+		       u64 gen, int mirror_num, u8 *csum,
 		       u64 physical_for_dev_replace)
 {
 	struct scrub_block *sblock;
+	bool force_submit = false;
 	int index;
 
+	if (flags & BTRFS_EXTENT_FLAG_SUPER)
+		force_submit = true;
+
 	sblock = kzalloc(sizeof(*sblock), GFP_KERNEL);
 	if (!sblock) {
 		spin_lock(&sctx->stat_lock);
@@ -2229,7 +2233,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 			}
 		}
 
-		if (force)
+		if (force_submit)
 			scrub_submit(sctx);
 	}
 
@@ -2441,7 +2445,7 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
 				++sctx->stat.no_csum;
 		}
 		ret = scrub_pages(sctx, logical, l, physical, dev, flags, gen,
-				  mirror_num, have_csum ? csum : NULL, 0,
+				  mirror_num, have_csum ? csum : NULL,
 				  physical_for_dev_replace);
 		if (ret)
 			return ret;
@@ -3710,7 +3714,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-				  NULL, 1, bytenr);
+				  NULL, bytenr);
 		if (ret)
 			return ret;
 	}
-- 
2.29.2

