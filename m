Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19B82908E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410450AbgJPPwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408908AbgJPPwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE0C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x20so2306715qkn.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ouKQo3AOYSkuqXsuiFtAv/KiWiTVfNs27TuAPcn78Ao=;
        b=mnR+NR8yHczEOFfa7vWtaODH/GkhKhu1rxc/KPdHU3DJL8U155KNE+BzziJYHJD55f
         qlllJiJizykOTqWwup7eQ+1KndaDwJeftnjf1yTpdX42JkCxgUdihAdUZR5GtU9gc8Wg
         I6ELqPAFvMDlSEgBsq5SaS185Koit5H18bPJaxU22wz3x2ht3EsjcDItj8IySJIlrzV2
         5JlKr6SrFFK+9cfRbjIFmto1/zL85e338GiVGjnRYL400Slbz9bxHyCF7J2bwYGFKBk+
         A0bzU899Hx9wM63Hx5jPTLQc5CPF/o+f5uS/4scBCCtp0rA9ne+xfpa3vz6cpD34TBxf
         dx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouKQo3AOYSkuqXsuiFtAv/KiWiTVfNs27TuAPcn78Ao=;
        b=Gq87cwnC7hYu5a0qcuJgtgFLkKgkmTnOQNekr/+ytm/DJVl+kkLV21jiwXE2UhpfNj
         RK5UVS5cISTyZKBGmihslP4ps4EDzJaAKVzxRqKHfuLjHAMYX/rTFStK2gSAe7DAN4Yx
         DD+ZUlkeppwk+9dR6y8DTKB0iUljCP81P5Zb6HGL9XnGcOaOLWmEOAzGCwmkDU+9y3zD
         xCEh9hahYDA8FAf/zkOGAzsvqWSvXTheTdnLm3P7T1QphzcCth2vSQNgofssdvhnapHQ
         LptwLxjwPT59F+rfyg5Ro/3e6klJdOqCkfSODqluET+Ib0P9Ii8MC9Ri6mtBAoeSomJ1
         S6Bg==
X-Gm-Message-State: AOAM533zGr/y2NCIGrIUOHr4kg6oCUboX+PgpsKS7qh/IQZ4pKCnrtAd
        up7sxOlGdT3F2MgznwDhKxRI7oJhItHvBfAJ
X-Google-Smtp-Source: ABdhPJzuAu5Grfuu8TpKZ/xNDGAGwWvLRRc5kvyOmVmqYs6NrwuHxijZVQiusEZ6inh4hDmBzI+FOQ==
X-Received: by 2002:a37:b985:: with SMTP id j127mr4410072qkf.282.1602863567910;
        Fri, 16 Oct 2020 08:52:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z66sm1017597qkb.50.2020.10.16.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 6/6] btrfs: run delayed refs less often in commit_cowonly_roots
Date:   Fri, 16 Oct 2020 11:52:35 -0400
Message-Id: <dd5a84ddc9582a6723d2c4c90980376b04dc4d37.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602863482.git.josef@toxicpanda.com>
References: <cover.1602863482.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We love running delayed refs in commit_cowonly_roots, but it is a bit
excessive.  I was seeing cases of running 3 or 4 refs a few times in a
row during this time.  Instead simply update all of the roots first,
then run delayed refs, then handle the empty block groups case, and then
if we have any more dirty roots do the whole thing again.  This allows
us to be much more efficient with our delayed ref running, as we can
batch a few more operations at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 93006da039a3..cefdd0dc4c20 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1188,10 +1188,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1209,10 +1205,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1227,15 +1219,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
-		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-		if (ret)
-			return ret;
 	}
 
+	/* Now flush any delayed refs generated by updating all of the roots. */
+	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	if (ret)
+		return ret;
+
 	while (!list_empty(dirty_bgs) || !list_empty(io_bgs)) {
 		ret = btrfs_write_dirty_block_groups(trans);
 		if (ret)
 			return ret;
+
+		/*
+		 * We're writing the dirty block groups, which could generate
+		 * delayed refs, which could generate more dirty block groups,
+		 * so we want to keep this flushing in this loop to make sure
+		 * everything gets run.
+		 */
 		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 		if (ret)
 			return ret;
-- 
2.24.1

