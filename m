Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B5A2873FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgJHMYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 08:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgJHMYd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Oct 2020 08:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602159872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/XxDsYAK0whX3TXMX+rzVeOIsPDL9xUGfNx4EeShKY=;
        b=nfQipQ7bCVxHdXuWvaQl/9eVpD3UwyU6sijXIz/cPZlOjiyoOwdTCd4R2zGnsHGMkEdEqj
        AwDpmRufdSuc+7TWzE23hqRRfUNuz10pWNSZhmnq/WhXI461ZvkUQMLY29ymVnUYPa70q6
        AG5oevBe1qhUPjRg9jtJ1ymcLw1hRGI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B55F2AF2A;
        Thu,  8 Oct 2020 12:24:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/4] btrfs: Use helpers to convert from seconds to jiffies in transaction_kthread
Date:   Thu,  8 Oct 2020 15:24:27 +0300
Message-Id: <20201008122430.93433-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008122430.93433-1-nborisov@suse.com>
References: <20201008122430.93433-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel provides easy to understand helpers to convert from human
understandable units to the kernel-friendly 'jiffies'. So let's use
those to make the code easier to understand. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 764001609a15..77b52b724733 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1721,7 +1721,7 @@ static int transaction_kthread(void *arg)
 
 	do {
 		cannot_commit = false;
-		delay = HZ * fs_info->commit_interval;
+		delay = msecs_to_jiffies(fs_info->commit_interval * 1000);
 		mutex_lock(&fs_info->transaction_kthread_mutex);
 
 		spin_lock(&fs_info->trans_lock);
@@ -1736,7 +1736,7 @@ static int transaction_kthread(void *arg)
 		    (now < cur->start_time ||
 		     now - cur->start_time < fs_info->commit_interval)) {
 			spin_unlock(&fs_info->trans_lock);
-			delay = HZ * 5;
+			delay = msecs_to_jiffies(5000);
 			goto sleep;
 		}
 		transid = cur->transid;
-- 
2.17.1

