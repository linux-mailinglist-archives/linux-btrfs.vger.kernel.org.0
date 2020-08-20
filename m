Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A224C274
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgHTPq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgHTPqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C9FC061344
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so1491463qtm.10
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KGOmKX0jhKrrG/3zP8uN34zDcs2xeB+MvKEuyLLQ3/c=;
        b=uMcUHlJlyVcGXt5usMUPbM0J2oT02gLdOXRD0eg2zFqsXsmNtkzm/9cZW4XwHvtWor
         u8mI5Xf8IMRLwMpDs7oSEPRd7As37pWLlpfAZ6ZyyPycPl7GKNefcZ+tsVY0Z+heAVbE
         2MzcJ8bM8/4OVVeZ5njKKb+mCDCZXimpyBm7u4Y5Ihvh7CwoSVF1JgwvW5Z/zu9mV6PI
         MJ368BPcjDucYWG1zYA/unHI/ARInY1RGCio9B+4fHTdb5iuK/ZIJ1ZIv7eqzSMK2klL
         9YKXfWPVkXiWh2aXWb43HP5G0Q62qdjERWlBOldpEF+LbX+vZMwckLlbzx8s7eXOthoG
         vKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGOmKX0jhKrrG/3zP8uN34zDcs2xeB+MvKEuyLLQ3/c=;
        b=AigzawOPq0ZnKdVr3g+jqXx3HyZkQj3Mcj0DIVHYTHm7EhNb0C4SuHJOH6TjSTYkxk
         uVf3HcC9/M4P+RdHePfaECIjhV91zRDeCrK9Nvo6cVVhyepU6Pnl8EmDn69E5XyFR9pW
         gHIqmz6PZeIV17nGbOxJRVo24b5nY2qMiIzPUyY/TKIQ99WOzzCFLAHxunYbLZDgd1N4
         ozkf+8oPew4LuZiPgliwJv4Jk5A8Uf7ZcNOoItSZrKJcF4vtiOqOMlxU/q7AkNcgWYlu
         oBADNtgy3zjwpwID+iQMz9qPwC0vy6ji1pDvGAjgUfiUUMD4mz4au85w1waiDHciW5xi
         VRBQ==
X-Gm-Message-State: AOAM531CtKSSoW1DfsRcR4yJuIKp9SIZvGLX9XlrIptuWwGesu6Qoll3
        Us+bZ2Gp//EuBfqERwWTNj9faVgQ1ARMoKxo
X-Google-Smtp-Source: ABdhPJyETEwsYXcJEyo2FNkxtfY2jOg36Yg9REAse2bxz2norqUI4Zs97T7zNSMy6fYjCRrKNO0zTA==
X-Received: by 2002:ac8:6901:: with SMTP id e1mr3266772qtr.352.1597938392919;
        Thu, 20 Aug 2020 08:46:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q34sm3512481qtk.32.2020.08.20.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/12] btrfs: use BTRFS_NESTED_NEW_ROOT for double splits
Date:   Thu, 20 Aug 2020 11:46:08 -0400
Message-Id: <656ac6c2b7c5b82ad13c1ce9a6a2f9719b7ed077.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've made this change separate since it requires both of the newly added
NESTED flags and I didn't want to slip it into one of those changes.

If we do a double split of a node we can end up doing a
BTRFS_NESTED_SPLIT on level 0, which throws lockdep off because it
appears as a double lock.  Since we're maxed out on subclasses, use
BTRFS_NESTED_NEW_ROOT if we had to do a double split.  This is OK
because we won't have to do a double split if we had to insert a new
root, and the new root would be at a higher level anyway.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a67d3e28e0fc..e4574ff3ba15 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4250,8 +4250,18 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 	else
 		btrfs_item_key(l, &disk_key, mid);
 
+	/*
+	 * We have to about BTRFS_NESTING_NEW_ROOT here if we've done a double
+	 * split, because we're only allowed to have MAX_LOCKDEP_SUBCLASSES
+	 * subclasses, which is 8 at the time of this patch, and we've maxed it
+	 * out.  In the future we could add a
+	 * BTRFS_NESTING_SPLIT_THE_SPLITTENING if we need to, but for now just
+	 * use BTRFS_NESTING_NEW_ROOT.
+	 */
 	right = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, 0,
-					     l->start, 0, BTRFS_NESTING_SPLIT);
+					     l->start, 0, num_doubles ?
+					     BTRFS_NESTING_NEW_ROOT :
+					     BTRFS_NESTING_SPLIT);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
-- 
2.24.1

