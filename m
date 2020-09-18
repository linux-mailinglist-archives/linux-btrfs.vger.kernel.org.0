Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1780626FE99
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgIRNen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRNen (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DBNhcXiXisJ2v9O2OLeEEgnsBC1wVEmDwVWAMLjns8I=;
        b=PduFoUah+Fj83G9uBzJ0WTc2x4nuPrv/t1sANKLpmmgcFXbjAMp+gcC94gi61L6u+6R4cm
        oTRsJ+M6cT2dJWwKn/VWxxobPuh09D8ksDwucOpfJO++T4D66F/wuE8N/vo6ipAkjJb4Ld
        hIOJBvKlrn0LEs39j/hWjshTpjjCitI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D7B8B1E4;
        Fri, 18 Sep 2020 13:35:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/7] btrfs: Call submit_bio_hook directly in submit_one_bio
Date:   Fri, 18 Sep 2020 16:34:35 +0300
Message-Id: <20200918133439.23187-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS has 2 inode types (for the purposes of the code in submit_one_bio)
- ordinary data inodes (including the freespace inode) and the btree
inode. Both of these implement submit_bio_hook so btrfsic_submit_bio can
never be called from submit_one_bio so just remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5e47606f7786..6e976bd86600 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -168,11 +168,8 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	bio->bi_private = NULL;
 
-	if (tree->ops)
-		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
-						 mirror_num, bio_flags);
-	else
-		btrfsic_submit_bio(bio);
+	ret = tree->ops->submit_bio_hook(tree->private_data, bio, mirror_num,
+					 bio_flags);
 
 	return blk_status_to_errno(ret);
 }
-- 
2.17.1

