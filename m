Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D67A20F68E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgF3N7y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgF3N7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:52 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5560C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so4362989qvb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOl3r3XCtXoWmA1dQ3UTMbZ8Zu77pCaRE4U/fVaboV8=;
        b=mrZ/oxuBp7wq8wbDoDfGRnZqdPL5vr9apnjPXOHqLvqI3F5WoVKrrcAXgkR/JK7jTA
         d4P0XoNG4w3kHgdK5wRZT7tbM6xAIf1NwWljqOz8uSg5NOH8MFNSlxpHTwbrwakDgrvv
         8mnubPI/0xgcj5DBmu05H/C2a+woKK1o+1YZbt/u3dmgiRmKqX+4HUfmWYlVVEzsGpbl
         4W1vvYmZ5YXI0cfqvhaQlBRF4FX0Ml14+90G+nSc1wHLWxrFSgW7mEX8/qoavVJqpIuc
         U+yurnhxczrIXoLuBN54zsipw9kLji9VhtuhLhKspUg8H2otpWvc0LGwXO1Tk0PBQqMi
         yAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOl3r3XCtXoWmA1dQ3UTMbZ8Zu77pCaRE4U/fVaboV8=;
        b=b6ub7VpJrouqKYJWnu/0Vu/dS6bC95/UbM9gQLU1jy5tAHA8aIFuLv7p+9SfLzg193
         hYPdDfUJ8u+GusIXQHitCfA7jjRciGf4eGsjepQ8WHBTHH2+MxXOeCEL/sPRm5okyasL
         CuSBmja+ddyBRUynU7FLIeAa45jVuldeQPB5TCPDJB9r2efv/m0/vTsl/ZpjHOY8UYhD
         bF3RFdG5+QK2/g9pT78O2i+ROpkoiZLGWNmiU2XOhvHoMBIG68ipitZCabfenqpZ2gxA
         QcdO7oOLscNe8W9huP5Oalwhs48VQD+PzDUrO5Qxi7aPSg5xt1PkVd2aisq/4Em8jnFQ
         oLVQ==
X-Gm-Message-State: AOAM530ECNaFRJlLZAwJ7NjMCH5Bb//al/EKED7Tvp1Xa9aWNp2LlAc2
        HwE58p33esudgU/8ebaisOhITaPrrm0YlQ==
X-Google-Smtp-Source: ABdhPJzogDRCtJVvXsa4TR0q5rCqcURZ+Z+7pm7RHwibcP7obFkrl0BYCokRCe0wme0WdemEIUX+Cg==
X-Received: by 2002:a0c:f0c8:: with SMTP id d8mr20499884qvl.217.1593525591552;
        Tue, 30 Jun 2020 06:59:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n28sm3316812qtf.8.2020.06.30.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/23] btrfs: add flushing states for handling data reservations
Date:   Tue, 30 Jun 2020 09:59:10 -0400
Message-Id: <20200630135921.745612-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation until we can't anymore.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for normal inodes.  Since both will
start with allocating chunks until the space info is full there is no
need to add this as a flush state, this will be handled specially.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 ++
 fs/btrfs/space-info.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 93cd1ff878cb..efa72a204b91 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2569,6 +2569,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0b6566a3da61..e041b1d58e28 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1018,6 +1018,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1

