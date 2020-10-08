Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496AF2873FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgJHMYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 08:24:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbgJHMYe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Oct 2020 08:24:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602159873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJ4Qa7nORCLQdmS1s8yYxpavd4g/7zE6ogFfHLiX/0A=;
        b=oipXAsc1bY1ZtDQOOQ53yhr/+fX0zpMpvbl2NN6oK4zorAPWp8hTiBK5+pDwh5cvRUWtA+
        anRgqAkOP7goW8E6V/FGkIAthvkspABg/1J6CwJMjaqClVqFgns4y2mee9qf3lEGYX99Kf
        rjZwsuMlaNk68LTgQ0eQmHqM9LAcLoU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 368EFAFDB;
        Thu,  8 Oct 2020 12:24:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: Record delta directly in transaction_kthread
Date:   Thu,  8 Oct 2020 15:24:29 +0300
Message-Id: <20201008122430.93433-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008122430.93433-1-nborisov@suse.com>
References: <20201008122430.93433-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rename 'now' to 'delta' and store there the delta between transaction
start time and current time. This is in preparation for optimising the
sleep logic in the next patch. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b9fbbf66ccee..c5d3e7f75066 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1715,7 +1715,7 @@ static int transaction_kthread(void *arg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_transaction *cur;
 	u64 transid;
-	time64_t now;
+	time64_t delta;
 	unsigned long delay;
 	bool cannot_commit;
 
@@ -1731,9 +1731,9 @@ static int transaction_kthread(void *arg)
 			goto sleep;
 		}
 
-		now = ktime_get_seconds();
+		delta = ktime_get_seconds() - cur->start_time;
 		if (cur->state < TRANS_STATE_COMMIT_START &&
-		    (now - cur->start_time < fs_info->commit_interval)) {
+		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
 			delay = msecs_to_jiffies(5000);
 			goto sleep;
-- 
2.17.1

