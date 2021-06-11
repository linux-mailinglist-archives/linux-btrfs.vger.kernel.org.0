Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EED3A4365
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhFKN4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKN4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:03 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B4C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e3so2644300qte.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfke/cFq6xaTH29Ge5vwvLHugoZC/ayAJOBSumXUS6w=;
        b=dbKrJOw7l2T7iVLqAXrWa81mhiFCTqVb9o3EzaLBXaF/Yt52XRsGcn5RtqMsbjqbae
         Uxa+BlefIeZjFZgFR5thwqVtYuI0vQtpZtut8bmHGLykrjSgBEADJUxL21BVQ3QjvZtG
         623vyPaED1I1qNs6GvRWw+UaNcIpQYBKdfGINt+1ecafbAPFQrU0sE0PyMJ8954sQ1R6
         IeHKCRxhvoM4n3/TMZShMEwYxYG5N+mGaw1iFQf54khO7hRFGpo70hwX4Q6cHa9Xk6BR
         tOVJSyGNp8TCGNt+ZLdC0VkRA1QXoBQDp2BL9snw98sHMarwDQ/woZ0gwzlZj3EgNxoz
         p4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfke/cFq6xaTH29Ge5vwvLHugoZC/ayAJOBSumXUS6w=;
        b=qm7DNC7VIvTPISCx0r0GKsv2jtPoXTHaK8qQAGjgtlCFgYHO8TIXBql8jZzuTgI/q5
         ov5LxIDBlWF0InyWeg3M57fD3tE37nHJix9PLpKn38eDDQjja1lT8dgxE6eBQS4NNJlN
         Jmuwa/2uOEz2XG8pqW0tDhwJwTACQ3gvmEkn5rbIsPNFjxUuGKlqTPb4do/TDtaFafyA
         QhDLyghdnA+wPRwo9qDhMQuM4sxRyvsGCE1dB61AtEUN0vYdyOurIqAhE9PM3tswDDpR
         IIRz+njD0bQQgWPKAMrT3J4caQaXEb7d+bmkjTHYvG8CUFiplUiwNcb8rB20Znt7Qq9R
         P4mg==
X-Gm-Message-State: AOAM530iEhCUMO4LZCu6n7gtJ99nZaen1zS3qnwxOE19Q57lIyOVX+lV
        125ld9zZ09nV04XvhIRdVuMJtgQLYqor4A==
X-Google-Smtp-Source: ABdhPJzybheumRiqwViRdJ9Ll5j59V4bXtascbt8naBgBI8PWdD4yqWmis3Li7sr5hiwt5UdLEpmdQ==
X-Received: by 2002:a05:622a:15c5:: with SMTP id d5mr4009598qty.77.1623419644852;
        Fri, 11 Jun 2021 06:54:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p21sm4153094qtq.92.2021.06.11.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:54:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org
Subject: [PATCH 2/4] btrfs: wake up async_delalloc_pages waiters after submit
Date:   Fri, 11 Jun 2021 09:53:58 -0400
Message-Id: <d1802ad325a04d3640b85e4c928b91dd9316252c.1623419155.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623419155.git.josef@toxicpanda.com>
References: <cover.1623419155.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use the async_delalloc_pages mechanism to make sure that we've
completed our async work before trying to continue our delalloc
flushing.  The reason for this is we need to see any ordered extents
that were created by our delalloc flushing.  However we're waking up
before we do the submit work, which is before we create the ordered
extents.  This is a pretty wide race window where we could potentially
think there are no ordered extents and thus exit shrink_delalloc
prematurely.  Fix this by waking us up after we've done the work to
create ordered extents.

cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6cb73ff59c7c..c37271df2c6d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1271,11 +1271,6 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 	nr_pages = (async_chunk->end - async_chunk->start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
-	/* atomic_sub_return implies a barrier */
-	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
-	    5 * SZ_1M)
-		cond_wake_up_nomb(&fs_info->async_submit_wait);
-
 	/*
 	 * ->inode could be NULL if async_chunk_start has failed to compress,
 	 * in which case we don't have anything to submit, yet we need to
@@ -1284,6 +1279,11 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 	 */
 	if (async_chunk->inode)
 		submit_compressed_extents(async_chunk);
+
+	/* atomic_sub_return implies a barrier */
+	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
+	    5 * SZ_1M)
+		cond_wake_up_nomb(&fs_info->async_submit_wait);
 }
 
 static noinline void async_cow_free(struct btrfs_work *work)
-- 
2.26.3

