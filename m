Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD23D2CDD61
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbgLCSYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389218AbgLCSYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:36 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D6C08E864
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:27 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so2965656qkc.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMJzoHKSSI7RbPlEuFhavW+kdWjtGbNSGbkUS0XuGdY=;
        b=Yab72AMVo+/9gyMEs9mpcrLeJ2AmstfCviL1II+kFShlU3YRgZ9rL7dDvIaFvilJmy
         nAtvAmF+bhLXa4e83vRKijlL0nvrcDUr6qnZSE9WffiLwyvmKFkuPuYZj86yS6rYnjdx
         ZW6grsa09HNFmFs6A+r/BwCuxQtVrI1N96VCcyLsbkQ4oiVUENhDLIqI8N76t/qquGjB
         94qjyljZrBwMTvr1uBeSexjy4nGIkYomft4gUDMBHQ6F3c0PkUPtZz9FDRXWIfRhmtZI
         X8mh0AIwG94sCT8wDeF4IynvqsJwIZCK5lawrEAcuxfqNKKhN9DzU4sCR5aO1Vkn80jw
         MB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMJzoHKSSI7RbPlEuFhavW+kdWjtGbNSGbkUS0XuGdY=;
        b=XF4Z6ER/mGXFDMl5UIfExXP77YHK9uGFsKfe/O/RIOLQ8QwxYiB0pkRLAwrZbv7tP0
         let2fn3mxaiC9JehKhVSQjMdUrb+xVJCp5rQLRpnmp5nDwtf5SsaZUdRUHdWXFu79Aj+
         u3zcBqXikYwz1CYlvlfpXj4DhgZeQI0AVjEqVsUwUvqi8wxO4K7TY46HcLCZtYNaC+0L
         AcenXAFGdcAoehn/di4xBrMfEYLm7Lgjx9+chfd9Im8gCsXvz9v2Ev4h0ChBAtqK20kP
         +F68JVkCLVhNi6VgbUe5WXq6xDi1D+4OdGleZN6Wf7SNEmyWkq80nqF2I/GDHhDlX9rd
         QGcw==
X-Gm-Message-State: AOAM530xibZqP/s1bIKzRduKUjxUN7MV11Zr25l+Y7qWQ9aQLUzildbh
        SPkyPY9Xa8et36xbE89oJ1SfsuEjQyODOE0z
X-Google-Smtp-Source: ABdhPJw1pURiujLPCFz106LeqVFNA078jeq7Rw8sXSJAhev+500EM+I0w+B2eL5X6INEFrYdma4PbA==
X-Received: by 2002:a37:634d:: with SMTP id x74mr4262719qkb.478.1607019806202;
        Thu, 03 Dec 2020 10:23:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z73sm2199110qkb.112.2020.12.03.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 14/53] btrfs: handle errors from select_reloc_root()
Date:   Thu,  3 Dec 2020 13:22:20 -0500
Message-Id: <c8d933b1efad6e3e8badfb380a5b021ad48e5e00.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
ASSERT(ret != -ENOENT), as this indicates we messed up the backref
walking code, but could indicate corruption so we do not want to have a
BUG_ON() here.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4333ee329290..66515ccc04fe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2027,7 +2027,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			break;
 	}
 	if (!root)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2198,7 +2198,18 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+
+			/*
+			 * This can happen if there's fs corruption, but if we
+			 * have ASSERT()'s on then we're developers and we
+			 * likely made a logic mistake in the backref code, so
+			 * check for this error condition.
+			 */
+			ASSERT(ret != -ENOENT);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2

