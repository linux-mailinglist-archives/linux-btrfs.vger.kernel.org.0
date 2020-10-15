Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5028F879
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbgJOS0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733081AbgJOS0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69CC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so3126859qkf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WH7ddIPVRzM6lb8DWZoKdPbqixctYkFmKQiidg5MXZw=;
        b=Lxz9XRyuMtz0bbp0Y4Ib1UkstuSWrs35WRJpLhHPoeoCn0PgU0tDPNYmim4ZgDfO4c
         Ifzy0HFeJdLPCqIZf0i637O4zR+zIN9+biL72inTIadkeMh6fX7JmplVb6SUEqh3qsqp
         0aOaow3poF7fVPqiF4bnFea+9XyG+owxf+OoI23a2E8V0ffBC7mLpLAlb519M6naQMy9
         vjx3TlHttFYG8/tSPaf9pimUyEJY1Zpn80dMH+lkVSiNzH/xtmq5gDpX+SXIB77vyhmz
         r/J6DhSk+z1Ifu4vuDVuyQK4H5aVBmxtQb+sxQP6pRHUpfy/hxL/z6q1kInQRqyjAy+h
         GEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WH7ddIPVRzM6lb8DWZoKdPbqixctYkFmKQiidg5MXZw=;
        b=n+RjFmKdaSHf2t/AaOT0HoYHT/qXrDgKtNfL4b6k7YE59K8xXAy8kztt5zGhnsbgvS
         Jpi4WuivmP2qrqK47gkrcGvUAKAx/kZJ+vaoG2ZlHFUXcYEfUL/7KEjMFiySy4WkW0rv
         z6pZFXuObRpr6m49UEovZMPs3evM5FQQPGfYtasAMrnxgofusrFGo+fS6Zt4AGs/OS2E
         RD4wBHvTB3bFx2ZYd6uu2LtqjjT4O/6S1SSIWSqTmEvHJRTTWor9hrTkCqzn4kcBlV6I
         7vNMQo74MWaR/6WfjochVdb8vE3jSwtTlQ/t4pGhm+LSLNhR2GCbQxqkPil2hEoBGFKQ
         T8Xg==
X-Gm-Message-State: AOAM530K1l7t0++znKZgwo5Jy5acV18HLV4VJjbjsQ3T0qve2XcY4qya
        XQEcICr/+MElkY38MqrBrh3/NQkZC1Ga59Zb
X-Google-Smtp-Source: ABdhPJz8AHtkoO0hWQhQrooG3ojnww0TgeLJPQNAWQZ6GG/Sy8ZJ+g2m0QtrkH92IWQQA5p/apSa9A==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr128170qkk.2.1602786371830;
        Thu, 15 Oct 2020 11:26:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x21sm1489051qkb.78.2020.10.15.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: only run delayed refs once before committing
Date:   Thu, 15 Oct 2020 14:26:00 -0400
Message-Id: <3579294ec5320be3b7932b8fd4b4a89ed79257db.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
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
index e8e706def41c..e4c7fa5076a7 100644
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
2.24.1

