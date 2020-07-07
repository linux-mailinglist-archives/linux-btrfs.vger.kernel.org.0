Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730B92172BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgGGPna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53719C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id a14so19013590qvq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VikI5MVVaTSxTXtFs/088Kv1GEt/DSUSVPLJNrvdXhc=;
        b=z0uzSsmWenHIe5xVwZEvfDEWnUTAuDY9tEbF2HiS4Q8wQWLGLGZyDfPB6bh0pF2VQE
         3kEHKwa+tODPaxwcQn/3wTI+5Loa8nPh8OY3SZiASRdN+ZecgDDlpFuBOwF1/SXCAuUy
         AZz98TmdvnpEYPnUcI07wW0dQoPgMC/CZy7WPpePAP4aF++45xU0NbwuCvDHdNq8Tnrf
         oRvaf96V4fVKGejEFJuxEpgVoSEqgu/E3fEIiBMgVVx7QPVswI5dQyJ2QkFieGWtuMDu
         CFqaxcao7eXWfRU2vBtIi3FC9cDM8d9pf6V+ClcFvwhBoKblIoDknLXXltNppYAH+BfR
         lJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VikI5MVVaTSxTXtFs/088Kv1GEt/DSUSVPLJNrvdXhc=;
        b=llkClpRha/lvNEj9eGnI4uu0/TcBHD7gVVlXWYZ5XpJzNkBCJBf/3mswj8vyqd09rm
         TYiB61w0psR7EBoYXrcZqadMV0ETP8dDeQrwx2ARqg/kDTCZGmV/Tcs5OJg4OyCo0lTl
         qcnhXWoIH4uW7hzJ0gVPB2t3KKSC03A21bV1QBjadIhkdyIHJ5dWzdg8TG1vaKEAYk0P
         QtNf3U0YvoItkTkZzzFBhHCusLucC3Da23iakbul2MLpPNDjxXKcKfJaus/dHWr455u9
         N3YtHQlWtrPtybzCznUB+HIq+cE5duUclKfzFPvR+lrgUII0ln+6k6WHZGScJk6VVCIh
         3Wyg==
X-Gm-Message-State: AOAM5333CWJ/KIuorZKZ67Y4NLNBobagBTN/dx/JrxP4xTTXCAiARhpg
        fUZBvZDSzf7JMkzcld5683LO2CEkFY1AEw==
X-Google-Smtp-Source: ABdhPJzk5JjV4BYHaTg8dFiuwC0ymyS2ZmruQqarVgDE2g4+emhBiGxGVogEfiYhrvto9b4OePsh/Q==
X-Received: by 2002:ad4:4672:: with SMTP id z18mr53962616qvv.104.1594136608166;
        Tue, 07 Jul 2020 08:43:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p186sm24374454qkf.33.2020.07.07.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Tue,  7 Jul 2020 11:42:43 -0400
Message-Id: <20200707154246.52844-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before we were waiting on iputs after we committed the transaction, but
this doesn't really make much sense.  We want to reclaim any space we
may have in order to be more likely to commit the transaction, due to
pinned space being added by running the delayed iputs.  Fix this by
making delayed iputs run before committing the transaction.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8df0110bd97a..5a555f20ca20 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1022,8 +1022,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

