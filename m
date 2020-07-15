Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA46E220A9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgGOLCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 07:02:20 -0400
Received: from [195.135.220.15] ([195.135.220.15]:48504 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGOLCU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 07:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06659B0B7;
        Wed, 15 Jul 2020 11:02:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH RESEND] btrfs: raid56: Remove out label in __raid56_parity_recover
Date:   Wed, 15 Jul 2020 14:02:17 +0300
Message-Id: <20200715110217.19698-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no cleanup that occurs so we can simply return 0 directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 61ff77392357..255490f42b5d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2083,7 +2083,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
 		 */
 		if (atomic_read(&rbio->error) <= rbio->bbio->max_errors) {
 			__raid_recover_end_io(rbio);
-			goto out;
+			return 0;
 		} else {
 			goto cleanup;
 		}
@@ -2103,7 +2103,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)

 		submit_bio(bio);
 	}
-out:
+
 	return 0;

 cleanup:
--
2.17.1

