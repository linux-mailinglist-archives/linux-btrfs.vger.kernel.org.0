Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728F21239C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgGBMoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:44:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMoM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F35A0C87E;
        Thu,  2 Jul 2020 12:44:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/8] btrfs: Remove needless ASSERT
Date:   Thu,  2 Jul 2020 15:23:33 +0300
Message-Id: <20200702122335.9117-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

compressed_bio::orig_bio is always set in btrfs_submit_compressed_read
before any bio submission is performed. Since that function is always
called with a valid bio it renders the ASSERT unnecessary.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c2d5ca583dbf..db80c3fa6c08 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -244,7 +244,6 @@ static void end_compressed_bio_read(struct bio *bio)
 	 * Record the correct mirror_num in cb->orig_bio so that
 	 * read-repair can work properly.
 	 */
-	ASSERT(btrfs_io_bio(cb->orig_bio));
 	btrfs_io_bio(cb->orig_bio)->mirror_num = mirror;
 	cb->mirror_num = mirror;
 
-- 
2.17.1

