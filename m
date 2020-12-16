Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C464E2DC4A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgLPQui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgLPQui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:38 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFEC061282
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:47 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d14so22473954qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fwEdq8DUXBp6WdRinlQz1Q/HCzm/olXUBoqqxfXlrZg=;
        b=zLkqhE//XR5j1oGQwrMx1V5IbsMYyuM9/QqCtbHhNJnVEDiOsa6qy8b2PbPNLPXvLP
         OfGYhOCjMzb/cnlyrhTG9TwizDU+lmFjKRKy2PxlXKc8YpPacXDFg7rjkfquZUBbKSQr
         UC7pVjfdGns5cQrHNX99P9v82NSvzrBVitX6lps7a1DWSbXWxcRaBacvogTP2IthVHZ7
         T/FGGcjQOWGzRz7aXJdnZy2AaUpr96ErtZut3m5PNQxZBrddwYN6bsEHomgcOAJdQB4V
         4PbIaBZJu3tx8UXGax95p/+mXm04jXBxNOwfe2e0Hu3WNVBJExUg5QLGNarOLR0v+NLj
         89Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwEdq8DUXBp6WdRinlQz1Q/HCzm/olXUBoqqxfXlrZg=;
        b=qM7yOzm2aEF2o+pIs35EHFVIzrBmKFZ+QOjSTyMQJMnGEPJHvQPajwnEUBFYDbyRfz
         PJ6px5JbSK1krQFqmx5eC7UC3GlpvlMmm1DdIw1mUBP1LtvrAFrChZTega/rc6s8gTTn
         YZXur5Pu2umYYPlfvTIsMKS5NPXI4ToZ2K5zF0GPXY0lMf9HfuOTsEw7vIdXiNGIxRw8
         dSSJ+tH14I/r0PltdoLVRNZ8t4rIqFpmI1Dw4d2r8qbWyYmMFscypmRe72EHTjV6wsU1
         h/2XyupHDYROrhRiwSdWnvC3mIRcjI5udZxA1ySftND08pECvBpKWnPT0YKty4O+JWvB
         ty1w==
X-Gm-Message-State: AOAM533KE3Xq4H1Q3iyggo4cSSrKn80NgCmkQIuaOw3/iT3LuSanncs6
        FCX3BNkg8DAFiSNgHd56yK5bDwBQ//hF0hbm
X-Google-Smtp-Source: ABdhPJyNx17XEljBqU1K3t9hW2AktmU+7tababkraG/uVt5C6BxFxaZdDSyCJNuFvP5+FYXRM+3XtQ==
X-Received: by 2002:a37:8c42:: with SMTP id o63mr44307368qkd.12.1608137386661;
        Wed, 16 Dec 2020 08:49:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f134sm1457272qke.23.2020.12.16.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/6] btrfs: run delayed refs less often in commit_cowonly_roots
Date:   Wed, 16 Dec 2020 11:49:33 -0500
Message-Id: <6130299d16abcd5d0e0aeb51bad2ff32e41deb25.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
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
 fs/btrfs/transaction.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 349e42300d2d..51c5c2f6e064 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1687,12 +1687,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 	/*
 	 * Do special qgroup accounting for snapshot, as we do some qgroup
 	 * snapshot hack to do fast snapshot.
@@ -1740,12 +1734,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 fail:
 	pending->error = ret;
 dir_item_existed:
-- 
2.26.2

