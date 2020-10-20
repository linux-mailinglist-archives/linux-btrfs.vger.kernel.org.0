Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B591D293865
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403832AbgJTJoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 05:44:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730725AbgJTJoU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 05:44:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603187059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfAVNFOlpEWveN4eLqjps/ADdN6V3aeVUAhWql3CXlk=;
        b=DSWNYYwregBftGnbZ4qoo7D/HEIwvGhAyE/ni37wt+IYJXcG+LvpB5A1/5cN2eFi5euC4t
        8rt/54Mywhr2s+kdiiCEmEYzVsyUB71e8aKnAdaS/YeIo7AvOBmFkUgw8CV3Fh3aUIwk+f
        gr5S3ywaf43Sh9DWitlPjsQk1WGB2eA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FABBB025;
        Tue, 20 Oct 2020 09:44:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Be smarter when sleeping in transaction_kthread
Date:   Tue, 20 Oct 2020 12:44:17 +0300
Message-Id: <20201020094417.738267-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016142047.GS6756@twin.jikos.cz>
References: <20201016142047.GS6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If transaction_kthread is woken up before
btrfs_fs_info::commit_interval seconds have elapsed it will sleep for a
fixed period of 5 seconds. This is not a problem per-se but is not
accuaret, instead the code should sleep for an interval which guarantees
on next wakeup commit_interval would have passed. Since time tracking is
not precise substract 1 second from delta to ensure the delay we end up waiting
will be longer than than the wake up period.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

This one survived my testing and debugging confirmed that sometimes delta can
indeed be 0 so utilising min is the right thing to do.

 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b7deb3e9dd9e..2632b5833f64 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1735,7 +1735,8 @@ static int transaction_kthread(void *arg)
 		if (cur->state < TRANS_STATE_COMMIT_START &&
 		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
-			delay = msecs_to_jiffies(5000);
+			delay -= msecs_to_jiffies((delta-1) * 1000);
+			delay = min(delay, msecs_to_jiffies(fs_info->commit_interval * 1000));
 			goto sleep;
 		}
 		transid = cur->transid;
--
2.25.1

