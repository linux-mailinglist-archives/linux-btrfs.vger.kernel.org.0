Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE62908E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410444AbgJPPwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410441AbgJPPwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079CC061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:45 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t6so1283024qvz.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFOCDEykp0SPZgn5GU2NA0oO+g5NSlh3fUMr1bqdQRA=;
        b=bN9d7DuOhIJzAQhziBG7YSFZFIFN0mJyeM92PkN1+cy6MglkbzFdjJ8NwyE5FPnl0p
         1QzMLSWj2c5xZ0o6KGuzGYEGqD4a+1PGWkTdLsyQIY8FyVvRJHLalVRF8gDU6bckU2xb
         g+vKGpUTBJvUKo+GCurrfu8KIHHqm4yW0W3Npi7VIqs0RNiLXLGjuHbOTsqMEhj5zkeN
         P0JzeyNIKpdIm2ZyQ3lgULvtFoFzBK618xvt7vGfef2Hvl2gq7pPnosGFcNgw+RfT3rT
         gfRcKqn/rBQ3sFk5j2e2Xgg6la8whVa7wVt9R7pAoA8oVntm7BAnqoAdgReHzjyrVmS4
         NrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFOCDEykp0SPZgn5GU2NA0oO+g5NSlh3fUMr1bqdQRA=;
        b=uSDpAuHWr8+iwRgshEUweb5Y2ZyNjxkTkiimuYZcbGwimbBaDib2EvNGLVyOi6ffHb
         VgfIV9f/k2lj2zCpad6KJiju2JUhOHRekQ6/ZF/aExeg7mdZcCIIw7zpOBZw7GgoUAs5
         zLjl2mTy06H/57gZIZK7zyr2E6pqZaaZ7VgVOuS0ypu0fFFhs67bIcS4AvhFNsZEGc8F
         v8ArSRVcP/XYligGDlvw8neFxZP05Zzw5P37y7ZtrsXmBKhuN9AiJJ+Xai+CHNPl1vYI
         b2I7v1wjuZW7pZgYoXv1x9DpwNqvgn5gQ9z4yCD6qw8+fB9oPX8q31nTMtawz1KR49eQ
         ZAYA==
X-Gm-Message-State: AOAM532956OWJ6mupL3x31xLEu7TkXcP+ew4guQLEiDOBEqA4gGraPd+
        8rWO4Si8YlPLpD0SGIHBiy+P7ZjOel63AC8J
X-Google-Smtp-Source: ABdhPJx/sQRYnLDHz+KPz7bymL2Y2s1+reZeo3INu/ViPjprK0E1t+0ey+G+iKiIcpJzns4nIR1HCA==
X-Received: by 2002:a0c:cb02:: with SMTP id o2mr2445390qvk.8.1602863564466;
        Fri, 16 Oct 2020 08:52:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m25sm999645qki.105.2020.10.16.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 4/6] btrfs: only run delayed refs once before committing
Date:   Fri, 16 Oct 2020 11:52:33 -0400
Message-Id: <9838ea6ddbab7464104e49cc4c0c193d0bb94fe2.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We try to pre-flush the delayed refs when committing, because we want to
do as little work as possible in the critical section of the transaction
commit.

However doing this twice can lead to very long transaction commit delays
as other threads are allowed to continue to generate more delayed refs,
which potentially delays the commit by multiple minutes in very extreme
cases.

So simply stick to one pre-flush, and then continue the rest of the
transaction commit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/transaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f73f3c7aeda2..1b6fef512121 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2061,12 +2061,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	btrfs_create_pending_block_groups(trans);
 
-	ret = btrfs_run_delayed_refs(trans, 0);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
-
 	if (!test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &cur_trans->flags)) {
 		int run_it = 0;
 
-- 
2.24.1

