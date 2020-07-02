Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E735212521
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgGBNrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgGBNqy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD125B163;
        Thu,  2 Jul 2020 13:46:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/10] btrfs: raid56: Don't opencode swap()
Date:   Thu,  2 Jul 2020 16:46:46 +0300
Message-Id: <20200702134650.16550-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d89dd3030bba..e9173b6853c1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1861,11 +1861,8 @@ static void __raid_recover_end_io(struct btrfs_raid_bio *rbio)
 			}
 
 			/* make sure our ps and qs are in order */
-			if (faila > failb) {
-				int tmp = failb;
-				failb = faila;
-				faila = tmp;
-			}
+			if (faila > failb)
+				swap(faila, failb);
 
 			/* if the q stripe is failed, do a pstripe reconstruction
 			 * from the xors.
-- 
2.17.1

