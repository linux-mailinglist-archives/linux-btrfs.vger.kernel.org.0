Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4D3ACE80
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhFRPUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhFRPUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 11:20:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB03C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g19so847608qvx.12
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jun 2021 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pa7WqzlkGj1GJHxzQHfvUnK6wJsL28bK7prt2qLcuMg=;
        b=BOtZ2IIoz95MPAI+7OeUuQvY0+TPRHtosqF8cdsHdKkl1vuoXpnXev79OMt1yVrxp2
         m+efQu4Hmpk4I6v5JjWm5zsFXud5h6VCq12WYpA2aiAg3WzzNwBHbvR7M5M7qPM1jzYt
         PUjNzRaNGoBvlMQUQj9spUB3oUScQf1bRK5zTkrhrSrCOkFUDP5CX1FwBAJgxV76mTMN
         5ZatnuQRyo8B9DHHAq/6ViDh5SYLVc3aR+gTIUhqJobyP2shsxOXa+IaJreVvWHgIutq
         h4d9yhb7UGlWG+RybVlItb/6Q3O7FsmJUwjm3hV1gWYpq1/F8BCjI/2U6St5wrL9n6YE
         vM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pa7WqzlkGj1GJHxzQHfvUnK6wJsL28bK7prt2qLcuMg=;
        b=G3XM6bUfx7FUmRihaoNGKJX3JCk8UVBI64y02jwexj71XnsbQOo8qb9/ONix/7ntut
         u5Zzi7zbj9bekDV8+e1h42bfMByltHBBpIbUALvnmObL3pZGFWTtRnl7VqXeeyUILzzH
         NAm227H9rRHWn+ElXSfJkJT7uyECwY18rbE0JVzUsudEuBfjWCajItHeKfn7Lx8dT6s1
         +wH8p71/8wifDbqKLl7ZP4x3Of3CGlWvklSOJXcVMJOe1uccp/keEuetfv+zmDu6yOpH
         UeLsKxLVGMcj6Ata1R46u++3neMgjJ+XSSaV9HrWMOmyWcEJ9oJMC9Mvl3G1xnHnjLKg
         f7fA==
X-Gm-Message-State: AOAM533hRnqrTQTwY8XQmzARhE5Acvys2Zrfdtt5LO7anF4R7Wbcflcg
        4eELtQD+vcssFPhtzevGATEQabqQQYoy2Q==
X-Google-Smtp-Source: ABdhPJzyplAdfMRLn7Yd8UViO3Xh/NFDzM8BhHaI9wKfXz2lDmHXIi7Re5rkFHiW+VkZKBJrqe2APg==
X-Received: by 2002:ad4:514a:: with SMTP id g10mr6338210qvq.28.1624029517068;
        Fri, 18 Jun 2021 08:18:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 85sm4226150qko.14.2021.06.18.08.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 08:18:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: remove FLUSH_DELAYED_REFS from data enospc flushing
Date:   Fri, 18 Jun 2021 11:18:30 -0400
Message-Id: <acd6cd59ff60acde8ca7f1d1b032319b69831280.1624029337.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624029337.git.josef@toxicpanda.com>
References: <cover.1624029337.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we unconditionally commit the transaction now we no longer need to
run the delayed refs to make sure our total_bytes_pinned value is
uptodate, we can simply commit the transaction.  Remove this stage from
the data flushing list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 441a1b94806b..5645f9667d90 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1137,16 +1137,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
  *   immediately re-usable, it comes in the form of a delayed ref, which must be
  *   run and then the transaction must be committed.
  *
- * FLUSH_DELAYED_REFS
- *   The above two cases generate delayed refs that will affect
- *   ->total_bytes_pinned.  However this counter can be inconsistent with
- *   reality if there are outstanding delayed refs.  This is because we adjust
- *   the counter based solely on the current set of delayed refs and disregard
- *   any on-disk state which might include more refs.  So for example, if we
- *   have an extent with 2 references, but we only drop 1, we'll see that there
- *   is a negative delayed ref count for the extent and assume that the space
- *   will be freed, and thus increase ->total_bytes_pinned.
- *
  * COMMIT_TRANS
  *   This is where we reclaim all of the pinned space generated by running the
  *   iputs.
@@ -1159,7 +1149,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_FULL,
 	RUN_DELAYED_IPUTS,
-	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 	ALLOC_CHUNK_FORCE,
 };
-- 
2.26.3

