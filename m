Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9150C2D2F79
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgLHQZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLHQZc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:32 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF8C0611CA
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id y15so4739855qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OnmUXMW6kDqwsfKiHlT00zEoGulW1fyuMJCTpZgbSj4=;
        b=0/+FZTjZq4HASyjUnCIDZ9bb3AA722ri3TowE+UrbuCfGKClmaxfrTVy0MutT+kJ98
         +N2M27lj7g7gVdVcHQNFwT9WV7ZK4YInFdTUmvogKGKqJMMtgVMlnlrCZCVs9xi5HGcU
         9FVOM2DYOaw/liwtMPoFm/YtmuWy3nHN/dlOdy2jXIX/+VRJtgZ0TEnpCdLOyG+MEgdP
         wJcnulJmQicOCSC7gxVeQREIcZDoslxX4skj15FkvUthS29CHqGFx/2NrRbt5i7Fmvkk
         ToIx6uKvbteV6I1tMIIGc0KlGfVBFrZKnaEXjMauvKFYMH5sBkafDAwHATyyk1colevA
         nMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnmUXMW6kDqwsfKiHlT00zEoGulW1fyuMJCTpZgbSj4=;
        b=VNi3xdoie33hqKitxCX5ooT3y8/H1JBGZu1XHDo2WVMOQxhtaR2z9M7CJl8tQYQe0c
         F3QwLCh39/zzLldxKGfdk88C612kxfd6cXWVH9SddR9AAibiS6v9Tx5S67IDELW80HvD
         q62GQ77XtFEbihwAxBlfsealNyrlcVOJ2P9bGo3TzjZfP0SE+iljuRSR6XfOjIR0bQyK
         y1JaWnAV2NNo6o9DZegB+Ej6GrO3+JiTB/YxtPZY8MiuzvLrpyiVsd7d4rtLQHQdLzq2
         2mLqR3U6mOfxz4MHFk2muNTATm8s33OP2d6/au56HKzUREC+s4ZfO9YljvlId4qS+GY3
         LHPg==
X-Gm-Message-State: AOAM531Ek0hYhBlPNhYf6NrWoyTtyyRYVh9WHpieG37kXHPrUWfFWNr7
        w+yVa8UCSJnx0VrkBcm+Wb2iN1t+2xtf/Ept
X-Google-Smtp-Source: ABdhPJwHUBnvM9A1jz9RK1nUqKQagVL2jcOD2UjJHSvABXgu8DwSla8b1Yjood5ooDjXKBD6F4uJhQ==
X-Received: by 2002:aed:2824:: with SMTP id r33mr17007688qtd.137.1607444669779;
        Tue, 08 Dec 2020 08:24:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j13sm15819804qtc.81.2020.12.08.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 13/52] btrfs: handle errors from select_reloc_root()
Date:   Tue,  8 Dec 2020 11:23:20 -0500
Message-Id: <d89821cca34565e8b1182ecf6a614ee82e6a7142.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently select_reloc_root() doesn't return an error, but followup
patches will make it possible for it to return an error.  We do have
proper error recovery in do_relocation however, so handle the
possibility of select_reloc_root() having an error properly instead of
BUG_ON(!root).  I've also adjusted select_reloc_root() to return
ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
error case easier to deal with.  I've replaced the BUG_ON(!root) with an
ASSERT(0) for this case as it indicates we messed up the backref walking
code, but it could also indicate corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4333ee329290..9a5293efe695 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2026,8 +2026,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		if (!next || next->level <= node->level)
 			break;
 	}
-	if (!root)
-		return NULL;
+	if (!root) {
+		/*
+		 * This can happen if there's fs corruption or if there's a bug
+		 * in the backref lookup code.
+		 */
+		ASSERT(0);
+		return ERR_PTR(-ENOENT);
+	}
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2198,7 +2204,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2

