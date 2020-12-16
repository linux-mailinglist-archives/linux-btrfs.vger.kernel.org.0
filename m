Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C12DC43F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLPQ2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgLPQ2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:49 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6282C0619E1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:01 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 4so11588781qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cc6c3zhNeg5+5Kz0Fi9vo893I9mz5REcSDVo1P5BB9A=;
        b=PJqIYvDzgEJFIyyoxVcg2wkCndKBM6VM7pXxJv53+PW1wcuybLjJ6Q7vrx7GXWMTlE
         WR90r+nNMwHVCvbYI/6rOwkmXP11apOe16qmLh2MNNSSs2CO9aKauBu/OxsutUsPKuau
         1h65WvOlpjj+KVEgO0kPx6pjPhQfzM0G5jbtrWK+I2srj7spm4a6qFUOj5Bn1pBLsY8R
         GPXZdKnqaXoxUD2potXLaQO/mnDGAAPjO5lz/ydqQXtX5Miv3xMIVuk9YAPvGdoLk5eQ
         ZWGQxwzi6B3FM6jXklqXOmP+b3Wy/v0vkgDOHB+WYb/8TbnV4yWruQ7qEFAqX25UmM/L
         iEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cc6c3zhNeg5+5Kz0Fi9vo893I9mz5REcSDVo1P5BB9A=;
        b=DU1TQFaui39/Gxj8JXvPlZ7eGDKAKeEGkzCri8DqrAq67dXh40MpDe2iNhmj+0FMId
         HK+W9tVJWCOeKB31H+PVtwzzZ39EYIGoQnVvSADfeQ//EzCH9S+Ayo3ewr08M3BIeauD
         mX3vksjWJzDSd5rRYOwEcpi7Krab65hprG+qNRtc0OGNuK4aQuJsQKC1dDlEw6uEx+Ns
         rbNwcDpHTvT7ZnNrnGrj5o0dUj/706a9uhoCn1Vb18l8uNLBVP8mkfDp6exY6UHcNKsO
         xm+NjcQBLMBA+o8S3wUIXRURLQHkQF2SmRYGEI7bXbe0ikA/YxzS9y8RbS1G0fD6kVXb
         u0yQ==
X-Gm-Message-State: AOAM530ypn6L7wOljV+2E5+mR5BgbH42AghAJiXMkxRPIxAcprrsCEFJ
        8gqmyGt8NeO52cfqw911HbUyeZRDTnTAVcir
X-Google-Smtp-Source: ABdhPJz9YFwPBjfxLpte5HNdd5l/69PLv5MEs/87vZUSIcUFMmo0/WW1zNYyCiSKvpnDXzflsruFEQ==
X-Received: by 2002:a0c:dc11:: with SMTP id s17mr28998460qvk.19.1608136080781;
        Wed, 16 Dec 2020 08:28:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s30sm1256432qte.44.2020.12.16.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:28:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 37/38] btrfs: do proper error handling in merge_reloc_roots
Date:   Wed, 16 Dec 2020 11:26:53 -0500
Message-Id: <9af73ba5d4672c235ce5c4ae5033c026e3f57a73.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove these and handle
the error condition properly, ASSERT()'ing for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3f71fbb5ea18..44743d1fe414 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1960,8 +1960,29 @@ void merge_reloc_roots(struct reloc_control *rc)
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			if (IS_ERR(root)) {
+				/*
+				 * For recovery we read the fs roots on mount,
+				 * and if we didn't find the root then we marked
+				 * the reloc root as a garbage root.  For normal
+				 * relocation obviously the root should exist in
+				 * memory.  However there's no reason we can't
+				 * handle the error properly here just in case.
+				 */
+				ASSERT(0);
+				ret = PTR_ERR(root);
+				goto out;
+			}
+			if (root->reloc_root != reloc_root) {
+				/*
+				 * This is actually impossible without something
+				 * going really wrong (like weird race condition
+				 * or cosmic rays).
+				 */
+				ASSERT(0);
+				ret = -EINVAL;
+				goto out;
+			}
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

