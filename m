Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260D5F1400
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiI3Upu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI3Up0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:26 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB39F3FEF0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k12so3552995qkj.8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=EzFpLpAnOImKIcgB9bCxrZWgeHo2ogJaVdG2CDMrWVk=;
        b=7i8ly+F4d0pZQ5Un39/JxHA02AJW7N8wMLbx2iUvB+0PmUvMxzogFkpLhiwXmjoUSA
         BaUabwXGhDACheEDohAl2Nf5Y9QV0dQE2H5U/9vFXNrCbJ3eHHO/cQR+eWWuoOSo8wYw
         SGznzvQYjlozU2RBqy0tFaaGxAb8M5zzMDYN/vXmt5i3XSwaWh4ml3aLrp5mFnuFHcn0
         cT+5Q/+y7piZTGvXgc4ToAfzu89uPbTuZJEFhMHfxxAZ+f6MzgHWiYGwpGrx3dkC5zgo
         B+Tsk3yKH+o6OoML3JUb2pa2cq+U/1RhGeU4QnymIzF0gKcwtEEWp1AjEYXCACjAOCuk
         yh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EzFpLpAnOImKIcgB9bCxrZWgeHo2ogJaVdG2CDMrWVk=;
        b=Udm0ydO4bZxsSLZt1haRdupOlwuKOkA+afD7WA0GHBhHpFcukb1kpJ7vG1+dYerRdq
         K2KNvQKhsoC4YVU4uDgRicUSjXak3RAWmAx0P5I+wCo5VCkuJty4l3yw0s2UQyFYDbkd
         CWg34rj/BRF7znUYE0TtB78TlfLt6Yfapqj7Qhkq8fqb9XwaqCOPOg+d1izuTJZlzmLj
         CEq/WUZk8odXaI8tWtGMY6O23Yf9Z9sR0YksIeqXfmhFHes4KPQc4rSN7Yqc+7lNrOW2
         JZEOe4BswFG3EGPWuzHyYf9ZIZdAzO/5lyd1ula/pcWjeCN88XaWT2ssUQ1ITFGhY16W
         uHkw==
X-Gm-Message-State: ACrzQf2GJ9naJ72dSHGINh2SXmJ2hmlyQXbkuY1XY+N4LegBDwZRxS3O
        h7y+nQMqjosGx1yo4OjOqwKvT4NldyoDbg==
X-Google-Smtp-Source: AMsMyM7Cmm5JyN92wE8R94YvFhYYl9hnwucHCTvG4X3uGbvz6/AtHcymcNp9kBcC/sotomWj2DKw5A==
X-Received: by 2002:a05:620a:2495:b0:6ce:bbe6:5bb4 with SMTP id i21-20020a05620a249500b006cebbe65bb4mr7493861qkn.674.1664570721643;
        Fri, 30 Sep 2022 13:45:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ay9-20020a05620a178900b006aedb35d8a1sm4045851qkb.74.2022.09.30.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: unlock locked extent area if we have contention
Date:   Fri, 30 Sep 2022 16:45:08 -0400
Message-Id: <d0fe7ff95f90909363bae56e61b89baa14eb19de.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In production we hit the following deadlock

task 1			task 2			task 3
------			------			------
fiemap(file)		falloc(file)		fsync(file)
						  write(0, 1mib)
						  btrfs_commit_transaction()
						    wait_on(!pending_ordered)
			  lock(512mib, 1gib)
			  start_transaction
			    wait_on_transaction

  lock(0, 1gib)
    wait_extent_bit(512mib)

task 4
------
finish_ordered_extent(0, 1mib)
  lock(0, 1mib)
  **DEADLOCK**

This occurs because when task 1 does it's lock, it locks everything from
0-512mib, and then waits for the 512mib chunk to unlock.  task 2 will
never unlock because it's waiting on the transaction commit to happen,
the transaction commit is waiting for the outstanding ordered extents,
and then the ordered extent thread is blocked waiting on the 0-1mib
range to unlock.

To fix this we have to clear anything we've locked so far, wait for the
extent_state that we contended on, and then try to re-lock the entire
range again.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 618275af19c4..83cb0378096f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1641,16 +1641,17 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 	int err;
 	u64 failed_start;
 
-	while (1) {
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			       cached_state, NULL, GFP_NOFS);
+	while (err == -EEXIST) {
+		if (failed_start != start)
+			clear_extent_bit(tree, start, failed_start - 1,
+					 EXTENT_LOCKED, cached_state);
+
+		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
 		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
 				       &failed_start, cached_state, NULL,
 				       GFP_NOFS);
-		if (err == -EEXIST) {
-			wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED);
-			start = failed_start;
-		} else
-			break;
-		WARN_ON(start > end);
 	}
 	return err;
 }
-- 
2.26.3

