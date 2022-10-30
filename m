Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228A6128E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Oct 2022 08:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ3HnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ3HnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 03:43:08 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Oct 2022 00:43:07 PDT
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 210BBDFE
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Oct 2022 00:43:07 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id p2qvo95G2PMmap2qvoyNMf; Sun, 30 Oct 2022 08:35:30 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 30 Oct 2022 08:35:30 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Fix a memory allocation failure test
Date:   Sun, 30 Oct 2022 08:35:28 +0100
Message-Id: <34dff6b621770b1f8078ce6c715b61c5908e1ad1.1667115312.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

'dip' is tested instead of 'dip->csums'.
Fix it.

Fixes: 642c5d34da53 ("btrfs: allocate the btrfs_dio_private as part of the iomap dio bio")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 966cc050cdbb..3bbd2dc6282f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8078,7 +8078,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 		 */
 		status = BLK_STS_RESOURCE;
 		dip->csums = kcalloc(nr_sectors, fs_info->csum_size, GFP_NOFS);
-		if (!dip)
+		if (!dip->csums)
 			goto out_err;
 
 		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
-- 
2.34.1

