Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20222DE9C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgLRTZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgLRTZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2382EC0611CA
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so3046374qkm.8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzKcet6/7BG+1mcDeE25qoGayKzDTo3vyDgXLzyM8PE=;
        b=s/hIjwQIx9nb9RkLYY9GItL8Q4M7NMalNrjBOlU+9nQ3sjYI3Cu2iBqW4mPnu+No9j
         ruPcwsXniu3SArJx1srOrVD6rzHvhHobi/A/QmRsrCdJYLCyogUYgQ2fqkz1OTaLzHK5
         chY01llWvekvP/BCY6RkYuWlQmnYiKy3c2N61IIy1AXdM407xQ2ctLiEW+0mqkEiB9aA
         45eJlhgFVKeN3lEqjAi1pvnN0YoYzvk5eVOZW30IkUeF00bHrTiAAUg+e2JfOCiDdC/9
         BxrHKGIzwoG+ei11LK8uZnKkPnkXoadiWTdgVFPMQasBMFNszAMdWQfrXbU3iU1EKZUN
         5xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzKcet6/7BG+1mcDeE25qoGayKzDTo3vyDgXLzyM8PE=;
        b=ajd7NrkeZ4+tbdOiYxZeqtsotl3yv519OnxD+jAYB6RuifVN4JnoLm8xJ6qMANAofU
         3f0++grEi8XH+Q7UMP+drf8ywsgPwVwLBJZmTZwt858q+P0ywI2aVlJiODOzQbX9voyp
         kVrdALPUmBVjQaQ+obgaU5iCulkbKh/xqL0n6AfnxqVLcEFv2aXxwQcUeZPmbjng2DpD
         ux2gi+LUiV2lfXBDtpLtwT620Xd5ZqBBGBnsawG55MlLpT9tWQ4hiq07uyL468L4HBXc
         hVQrsl+BtR3rZSUf8tt5ZzE31MYuDG7eI87E7YuFzCYSNBEdWVZUiyAslNnZ6ysfBRL4
         vHvA==
X-Gm-Message-State: AOAM533lTiQ1ZbXlhz42dcD2fj1Y5eMNEewz8STAqH1Z1QAI3qpYegMq
        D71tfCTn7n0kMXLvhkfvHFU5kX5WUT8xyu67
X-Google-Smtp-Source: ABdhPJw4lDICKfy5iYkD1Gpv3BgdY+Num6xBLX8tdkSuVt+kYQ7e6zY+RYl4CQW0dkOCajuSSJGaxQ==
X-Received: by 2002:a37:7f02:: with SMTP id a2mr6259258qkd.356.1608319481990;
        Fri, 18 Dec 2020 11:24:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z133sm6664502qka.20.2020.12.18.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 8/8] btrfs: run delayed refs less often in commit_cowonly_roots
Date:   Fri, 18 Dec 2020 14:24:26 -0500
Message-Id: <b777e31c0b1dbdfb30597e27ff00608651f0aa83.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b3c9da5833db..8a6b38c01277 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1227,10 +1227,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1248,10 +1244,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1266,15 +1258,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
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
2.26.2

