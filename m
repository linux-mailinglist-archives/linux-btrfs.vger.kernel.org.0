Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2922DE9BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgLRTZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgLRTZP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29CC061282
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a6so2077370qtw.6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=J4qjYcgyqIYaCEOX/C8ZKkt0O0f+iB3JOEsH4bcNc4PdLDbScBVNx2CDuZqrwMmA4A
         wM9v+3ezAH8B5fE8FmtXoG4sj6ykYasKFbHHVG2xcwJI3/wHhIsFVuRWxVbGoc9/XH5N
         G/+w6SLrpw9wiiPcjtIsR3MgRnr+ACImPOFKjm6wJFNvdcukQ/8LO/7RRGNfmD/v3kfx
         DduBABt1MV0YQvq4gcrdZbfs4GnYBjzE8NJYTbyeev2/EJ9EJIBFNC2JB9L/rhJoSUWb
         /KmWrChubNMmYj3AcuD0XA78wj0NxAQDeCiMeTIdwZ2VXcJIrVNfwxlIVB4O+CGN/vMS
         dIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=H7kwB+tQm8eUejWkmyYWtxORWKTd7Ov1U4RMayzw8SgXaDYQ+eI3/DV6tMtn8+vVlC
         S/xsVemJuETO9+9yKl9exBuD8vT2SWs78v+xgJpghU+dbkeUKgEjYLfFfkdUWypV/uEZ
         t7dMfWll0C5LSqOqc/57Sqau5xDRX6iXwXQUj9/9I+rdQhwWKqe8JIM66R5ZKGKBj3mT
         r2kQWfd7I1GIB8HEiSSXn8xTaFkYedP6KrQ6dYpZk28EoUR2TVNGiEd+BNE79eJdn7qz
         X1gpQbM0HbGiCeTchOjmjyW+i8K78Nq76dCFx6NksoUm9j00sfbIsAFOISYAfa6T+NLD
         mRnQ==
X-Gm-Message-State: AOAM531DHCIQeINtMcjuawLq1kHplpYC1yPpXD7ht6lN4Lt9KW0EDiI+
        DqC1ZcMk7FN6rJfDKYWRNu8SkMQ8AbMp7Nvx
X-Google-Smtp-Source: ABdhPJzwPO1Coo2WCGitBw6TZkGZ7Z/p4/SwTdx2c234Dcn1ybV9tk+8ayD1wNbBmsaGOiNUFgkJtA==
X-Received: by 2002:ac8:47da:: with SMTP id d26mr5396685qtr.4.1608319473526;
        Fri, 18 Dec 2020 11:24:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d25sm6174632qkl.97.2020.12.18.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v5 3/8] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Fri, 18 Dec 2020 14:24:21 -0500
Message-Id: <1beb0dccc468e2190062281005f2616bda623924.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously our delayed ref running used the total number of items as the
items to run.  However we changed that to number of heads to run with
the delayed_refs_rsv, as generally we want to run all of the operations
for one bytenr.

But with btrfs_run_delayed_refs(trans, 0) we set our count to 2x the
number of items that we have.  This is generally fine, but if we have
some operation generation loads of delayed refs while we're doing this
pre-flushing in the transaction commit, we'll just spin forever doing
delayed refs.

Fix this to simply pick the number of delayed refs we currently have,
that way we do not end up doing a lot of extra work that's being
generated in other threads.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d79b8369e6aa..b6d774803a2c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2160,7 +2160,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (count == 0)
-		count = atomic_read(&delayed_refs->num_entries) * 2;
+		count = delayed_refs->num_heads_ready;
 
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
-- 
2.26.2

