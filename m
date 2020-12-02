Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12592CC722
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbgLBTxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgLBTxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:17 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0283C09424B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:29 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so1996972qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H9OyfFhjnh7teDrQrhXaWI0lpgeZDH5GlDP9+X7faiw=;
        b=s5DDJHNA8EN4jr3IPPN7rdpdSIwqFopZ3ANXZg67gwtePAUopSU5dQbkVwYHBtNhk+
         0+Nu780WhGnfvmlcGWZfiRM02BrIIyKIC70k7UfXXMrp/WhtoJQS02uJoGuchBJ8PTfF
         y/e4+HaBIeRZYNQ4iCLScQWX0ibbjBmfx+pD73oHHtlnc9yTjODnxIwpg75LwpKtGByB
         XqQer8Iy/kdMiK+Ig/xeztxf1Q5Mbq3d0m9RXLGtDNMAr+Z2QPgtSuG1cXCOcNDPs/gz
         8CvmQS/MT5sd9IWR02bjcu5NEk2F1f4OTwkaqWmd9XKgVO1hl/g6C0w6RlU1AegWd1nB
         5JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9OyfFhjnh7teDrQrhXaWI0lpgeZDH5GlDP9+X7faiw=;
        b=RhTl2lKf+NvO0Mqzx86se9KPXrLFj4WU6FOnHVTE18HQ9Qpo/e+leI5X5E97NWS/WC
         LlJHdOl21ptY528uB3U0J95W+hlAy57lgVV1h8kIXboibQEpzGJn6BD4LrNqYQpZ0qz2
         kanU+eh4KwV3ZHtnmSviYQ9PgPdQ2l/czhO6fFS2HInyRmKqD+MBSZCMVHwil0w/kVr2
         /++IWnp1z8zFGHXSNjV6OjXwzXXCnQiecIa9oqpYGYIShCr6g/ql721qyHt206Gf3ySu
         yCVvwXNgDL1eKrSMBHWvwEynNplVMgtclQAutqNkwEvfASYavmltNSgHoOKze1VAzwE1
         vu7w==
X-Gm-Message-State: AOAM530nd/00GuZgC8L8VFJji1M9lR/ulZ+ZIgvsUzqdfaWEOFTSLCk+
        yVJP15nFzFRnpbYWIiLWxUaAuFYskpbV4w==
X-Google-Smtp-Source: ABdhPJznHln7V3lG610Vgkl9VIJJ9Wj7/Y5LRXaWjeWl2degYt17sO//s1OlDwGSskLnd2dtX9A4tQ==
X-Received: by 2002:ac8:71d5:: with SMTP id i21mr4287330qtp.4.1606938748531;
        Wed, 02 Dec 2020 11:52:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm2927682qko.135.2020.12.02.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 41/54] btrfs: handle extent reference errors in do_relocation
Date:   Wed,  2 Dec 2020 14:50:59 -0500
Message-Id: <fe755664856dd75359962c132d7398b0e69a3f22.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef33b89e352e..3159f6517588 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2433,10 +2433,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto next;
+			}
+			btrfs_drop_subtree(trans, root, eb, upper->eb);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

