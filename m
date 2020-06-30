Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98020F687
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgF3N7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbgF3N7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A1C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so18620533qko.7
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTMh1XdIBMBbevjWIsHmClI1dbdzDP2/JU+FBcW3VOM=;
        b=shv+V0iaGC2PXnKdKrvjgXPQt0ZWEtp0bSFG+f8nz4uq27JwIL5Ahcye+zPSdYcNet
         RQHqu/X29xiZRwH2DblBqdzexO6OdVUmzbUmaNidvHgeUKB2RnX+10mbz5hzv4N76ncU
         TLm32ZjeEjgFa3RVQl4ZrqrRVt5Sh3qEjJvGYpROleBmkqR35czbwdbsP5QLUbL59TpP
         z7snoAuZK0xXiq4OlIr+JRgrz7AZ73DMDjZGxXK5oQl0CJ8AyU+LPvXAJ+EC2hEs44N0
         B+HVdFAHz0DwaVbsbDG0V+sV7hxWQ62SQXzOTzh1hw08pEAivo7Lkh7C5nUi3H7wu2H4
         i3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTMh1XdIBMBbevjWIsHmClI1dbdzDP2/JU+FBcW3VOM=;
        b=jcKx2h0JxzVC8qQ4Q8xhNR66g/544A9hkPTvyeVLZxC+4cKCrzVAnFb9+/SdA0khil
         5Wb+pA/B+peJirHgSl7TLT2uIMbWoUsCfb53R6PlGmOR4ULy8FFADXKaJ+J/47jphJBR
         3pJ6uciKN8nkXnM/D2ge7yTKsp+YTkyG69k5aAFzo60HK5dJGzCyavQknlFDk2aj1uYb
         v05CnjVwIrPyi0wcPnHYlVVjQLhqod7cy2IXa2DleRD45xjM0J7DXEQTNGKKAHa3MzwI
         A1/R7wfzXaCuCubKeA9Oxff4L8IT6SjxkNO6N2oFxZzfYEPbylKWZjTBNhdAKkiHpdtM
         gkLw==
X-Gm-Message-State: AOAM533Z6gLf5sK3APmMyNz65qbqtylZEpMAZT7PGJThd3bYgFlE5eAI
        gGKSHn3cFxIPdvZ+Rc3WVBV0gPL4LV58Lg==
X-Google-Smtp-Source: ABdhPJwN9PYrFX8S3cntJW+vZnBqvp0DXs5HxwXUQ7+XRYzQ8A72ZkxUAMYlKtM3eQi65e+gFmObNw==
X-Received: by 2002:a37:a444:: with SMTP id n65mr19418517qke.289.1593525577338;
        Tue, 30 Jun 2020 06:59:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u22sm3274156qtb.23.2020.06.30.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Tue, 30 Jun 2020 09:59:04 -0400
Message-Id: <20200630135921.745612-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 09b796a081dd..7b04cf4eeff3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3090,6 +3090,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

