Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56612CDD89
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502070AbgLCSZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502057AbgLCSZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:22 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60922C061A54
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:27 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id i199so3029248qke.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2dgo5VKxvO7MT8rF1dWKo0CbNIFb8U4flevq67sGNY=;
        b=YPVEozrs1XlZRE55MtqQGiTzB76PuTfUKRPF1eGy1VYpEtzvJVWUXrskHh6rb/OCE7
         AQEtTjh5zym2j0F2LLzu+fLPLLYXkt6t5ROSANjrKiydj8OzG+q2S6G4lekvX5cWlJW8
         KTCzotbVoBmwBrAMZXoq5Z1zXs8PQTQk1EiEyEzDM/ZCvGTosBmo4Cl2YQW9XXdTolxl
         zb277gae0DsmMvGtcttGj3Keuj1ieIsLGZTqeBsxDGimGkvBgHipQPeO3oUOEwVW6ls3
         9DwwAAe05WK1gmxZARsDDslvLrGKQQcTKfhN3buXKcbeL4CiWYoBsIKatWwoBnUkx3IH
         a9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2dgo5VKxvO7MT8rF1dWKo0CbNIFb8U4flevq67sGNY=;
        b=V5G9TuIq5UKbmO6Dr4YdRDQfvMnw1tbAXg5Q2yIXGucRN9IiHV/dRjQ1IRFpDHs6p0
         z6Bilbzse+1k8Ntb+Hyi2fwPyN4ekFYEzWo+B/udeXPwao6R4uj7N3S4q2rOM53ed19I
         Vzb5IFjD3e0VzoQlw13e90oGHG3zHuT1f1yPP3m4GyKtgVCD23BFaHNPU6EJj68IMkcR
         1NrUprdbC/5sEc0C+fhg5Pql9Z0MMRZLyZbBGS/B+XQXaMdyr9bByT0QcjRzCA/qzj+M
         VEy/RfFN34T0d+vI5lBvTdzsq+3HfQjKN1CrlGnmab/JYwW7SQsftNHL7KnZDxkXZiBa
         Yo9g==
X-Gm-Message-State: AOAM533T5M5MnGKSxCq9XssqfMT2GAFs/Giw270x1LhdGijqW0zipmZ4
        pEjS73XgqDZGvPCvj4pcNoIFjEvkudLZpZp5
X-Google-Smtp-Source: ABdhPJz+2xWFwgkonn2H7rL4nvJZRM8jF7J17RySlq3FJwZF1k28l/g+fhXItKuXkRK69t3mP2L3hA==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr4181849qkb.124.1607019866306;
        Thu, 03 Dec 2020 10:24:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i84sm1965161qke.33.2020.12.03.10.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 49/53] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Thu,  3 Dec 2020 13:22:55 -0500
Message-Id: <01a5d8703c24eb1b4364792b630b09ddd6ec7b6d.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 737fc5902901..38002f47e962 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3431,8 +3431,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3591,7 +3590,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

