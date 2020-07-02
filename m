Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F321251A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgGBNq4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgGBNqy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:46:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CD18AE24;
        Thu,  2 Jul 2020 13:46:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/10] btrfs: raid56: Remove out label in __raid56_parity_recover
Date:   Thu,  2 Jul 2020 16:46:44 +0300
Message-Id: <20200702134650.16550-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702134650.16550-1-nborisov@suse.com>
References: <20200702134650.16550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a7ae4d8a47ce..d9415a22617b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2093,7 +2093,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		 */
 		if (atomic_read(&rbio->error) <= rbio->bbio->max_errors) {
 			__raid_recover_end_io(rbio);
-			goto out;
+			return 0;
 		} else {
 			goto cleanup;
 		}
@@ -2113,7 +2113,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 
 		submit_bio(bio);
 	}
-out:
+
 	return 0;
 
 cleanup:
-- 
2.17.1

