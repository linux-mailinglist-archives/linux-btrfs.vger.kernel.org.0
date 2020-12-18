Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48432DE9BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733130AbgLRTZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgLRTZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:16 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E38C061285
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:36 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id bd6so1418702qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qojktz18/k706u7aHY0ojrhKydGouSH/+GIdN3/ZCtQ=;
        b=g7iW0wtExlGjn4CFH7vivW34EgLR9ML8x62fmIjBVdFMCYwmMA3offetAvG5ihklM7
         lyfYD2qFBaY+GF0azG81qnIERgZVGMUHc+vN+hTC2r5g8AzwyFbXMrMxA8p6Fq3/z043
         jNvVEkMcPYUBErOMJnf4FULSUEijttiAXDr9PWs077DMK47s4XnjNEfl9wr1haWTRiP8
         qRTcs7Yt2o1WE76hYuIT3jufrYlgPMNIKhQn5UTmnGanXusll08yyC+Wo19GFopkQckH
         wDP3hKqzUnhx96FkfqH14Vd7gunPGrD2iCYBfotW7W2psZFqOKIFvbN2yUqd1jVW2ix5
         04TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qojktz18/k706u7aHY0ojrhKydGouSH/+GIdN3/ZCtQ=;
        b=qYBf1qgdJk1kLsthsDGGPHqusi8uqXbL2mrLQ5RSm+xSkFYkhzGIilVAcK/vONO501
         k8HMzsrLcqhbfdc4CWnGooa0NhYi5xCXIHH9QUqdzNVBLxnOjrvCOfOHcqIrG07pumgA
         XuniIRvw6m2dg4m+xybsp4s2nLK5jR3lgGPEh4tPt6BxuJ0tkfVbQm8WiV/0gkJGC2k/
         k3679NgcSD3AIu+3eCaVtPT6UHZlq5GtYJ7MLjHd0DbOxUQk3bjyTkBtGQNLM5njdiM3
         oAcU7c+QaMdFNbai3YNPLb/5XTvo/uJEE5+ROyPDKPBZ0yn8xgWXt1J3pV0ik5FTPr9/
         2Jtg==
X-Gm-Message-State: AOAM533E69YGza+L5B9+ukCBcC0idu29k+v7rJzfSW3AgLebgRDdzTaq
        vVAgEqlUra1QaVvHsK9UNRnLOGQgGwYQz6HT
X-Google-Smtp-Source: ABdhPJxNBF+M23D9l49nqvFWKDXzj0hPAmS3YGOo3aPr51Xm8qdCSjqO1DiKEzAx4lpQTB84nvCqLA==
X-Received: by 2002:a0c:b990:: with SMTP id v16mr2388329qvf.16.1608319475194;
        Fri, 18 Dec 2020 11:24:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q194sm6224093qka.102.2020.12.18.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 4/8] btrfs: only run delayed refs once before committing
Date:   Fri, 18 Dec 2020 14:24:22 -0500
Message-Id: <09a77271aa482fac97c8cf3e3cb4daf36d183e95.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
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
index ccd37fbe5db1..4776e055f7f9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2062,12 +2062,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
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
2.26.2

