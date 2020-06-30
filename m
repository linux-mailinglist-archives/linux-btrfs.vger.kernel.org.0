Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1E20F69A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbgF3OAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgF3OAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:05 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5453C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c30so14748682qka.10
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNK3PHTWRwKiFmRo4WUgIpd2m4+LI0mQWgvoNTUBZAU=;
        b=FFpl2WEBxbKXZfkczkZhJAnsksngF62PNLRtT8o3rI99pxl0TgXH5DfLXuLj/wYS0a
         JzRH3YiyTB5vduJrorZU0gK8y91ETvP3ZFhMJ1+pkMaGRUdIErx9Gi45zspAbirAMQ8V
         l3qYHVkewNWXNlR6QzP4uRVKaqj0IJhHAc4nEvvnHH/Gg3Sp+WkLTfTYYQLTMNtWDXck
         rF53wjAKdlEfgLWHvRjcC/+7Rmg9x2feLBHoFiwOkcdfW4r4AIjbgZdWQsqFSnZMgjli
         5u+KEIk6a7ex36o/uhhjG56qcpYUDy3qfoJtVszcNK0WKiA7YBq2U3bLZQWw4IUjkbFO
         hWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNK3PHTWRwKiFmRo4WUgIpd2m4+LI0mQWgvoNTUBZAU=;
        b=rGffEGg0R/CUidRdNIUgA66thKfCFFCj18Z0kRf5ZjkX30RFyGfC+kZAIM8nDVm2u/
         cLfmlBcQfLJMEk7ehAAsOlKvBBIPJmXyudEdhQoWqYYjCitLt44f1UMOaNmHXpNx2S8T
         SBhCEkbiBnbSKgpWNEh+H/Q21YuDOimJSXa8Ta9zG4QF915TuZJ221xv87FNMclQo+6c
         7AspaZgH2I+tyMlwz8MyO4UnXpACSNOnBEFrVC24GKEtMJybLB+kaB5GmAcpWEW/255k
         HxmX7YJ5fj28XQ1ZPLL2WiX6HUb28So3TFd72qKgfGYpotd7pME4N0KXu6f5xMIVQGqm
         3TYQ==
X-Gm-Message-State: AOAM532kPMK5ZmXA8NKgVpfyP9e0aT1VkG+4QeRN1D779Uq6wKmgX/Lm
        I7xTIIUISYsiyZ82KbcBuQcvpP0CgY34eQ==
X-Google-Smtp-Source: ABdhPJxxVHvd90pIp9JhFdDVrSyJIMWlYBa4cVeyVBhl0Khwpnt31FPGqJdZRsz3SsXVaZcvj+1z5g==
X-Received: by 2002:ae9:ef04:: with SMTP id d4mr19812518qkg.41.1593525603622;
        Tue, 30 Jun 2020 07:00:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q29sm619037qtc.10.2020.06.30.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Tue, 30 Jun 2020 09:59:16 -0400
Message-Id: <20200630135921.745612-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was an old wart left over from how we previously did data
reservations.  Before we could have people race in and take a
reservation while we were flushing space, so we needed to make sure we
looped a few times before giving up.  Now that we're using the ticketing
infrastructure we don't have to worry about this and can drop the logic
altogether.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b5a007fab743..c88a31210b9a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1075,7 +1075,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -1086,21 +1085,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		}
 		spin_unlock(&space_info->lock);
 	}
-again:
-	while (flush_state < states_nr) {
-		u64 flush_bytes = U64_MAX;
-
-		if (!commit_cycles) {
-			if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
-				flush_state++;
-				continue;
-			}
-			if (states[flush_state] == COMMIT_TRANS)
-				flush_bytes = ticket->bytes;
-		}
 
-		flush_space(fs_info, space_info, flush_bytes,
-			    states[flush_state]);
+	while (flush_state < states_nr) {
+		flush_space(fs_info, space_info, U64_MAX, states[flush_state]);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
@@ -1109,11 +1096,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		spin_unlock(&space_info->lock);
 		flush_state++;
 	}
-	if (commit_cycles) {
-		commit_cycles--;
-		flush_state = 0;
-		goto again;
-	}
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-- 
2.24.1

