Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EEB2D12C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLGN7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:18 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA98C08E85E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:13 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f14so837436qto.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMJzoHKSSI7RbPlEuFhavW+kdWjtGbNSGbkUS0XuGdY=;
        b=ymN1e7V5FdU3qT6wxeiLleyoKR4uTZsCzql5TNvIyhtFcFrqgnTXUyyoN+FgP8YMbV
         Tvai2DWOchSWRdtclwIMqrR2KV+YuunfpABC0G5Af8Dho+37mrNIO2uNdKT+YqteiR8k
         voQGc62E6BJiAXcgUzIad3ScWMZIVkTgZb2DYsk4p2E9vcLB+IJi6CHGp1F88YaqGsP1
         mLkW2mxRDytXJ1P+qb35plyxEbx/ihKS+HXp/7uVJy9/HWb49XRjgimVkikjyHUdzFv+
         Jl+Sj9XtJ49TrEyBaYl8i30TsCx0fa8Lu2LsV2Ies9BwA+xYfqWZsfOHlju4x8M3zjFb
         VUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMJzoHKSSI7RbPlEuFhavW+kdWjtGbNSGbkUS0XuGdY=;
        b=ddIfzvYdywugK8x/11P6SApM6F/vJtzEzg5Qzy5VRLUAEFQZeIWzxGTUtQ4XV4WlFK
         MMc2/rqpEgRzU5Vhp8xw8bvGqVpDjvn7lvsJkZCZKWvCn8uIjTlkKau4tc5C+YRM6RYi
         ZRZWWVXLwmd6gFLcoSQ/JGZO6TX6HxImuRIGQ4nfh5DRdx/9+oRsDwk3g052qYnyaJ5+
         cWnp8AK06gGPZ6ZWc2QSE6sV8p8WzpFDRUnEodHBnyiJRtXP/PSNHSXsx618PWUMzGw2
         /TuH1QbGJgZycsuDr329+/7rR271owl6aAa+LsVLVTqoHZ+ROsM0FA7HOn/RhkZ0lsQq
         Mb1g==
X-Gm-Message-State: AOAM533AHsnNLXeI93t9EUVHvI8VNalTWfuZL630omu+GAaAEYNCVRQT
        vt1ZAQnvSOTJQ8Pqr26Uz0Gbjo/ZhJVK4wcd
X-Google-Smtp-Source: ABdhPJzBn+iUiJu+r3VPt1ISkRPZXn7zMB/3dmF0bAuVLFA7JIUbtRse5TKLblbJQeyq6HktTmZaRw==
X-Received: by 2002:ac8:6910:: with SMTP id e16mr1465462qtr.329.1607349492781;
        Mon, 07 Dec 2020 05:58:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o5sm1645733qti.47.2020.12.07.05.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 13/52] btrfs: handle errors from select_reloc_root()
Date:   Mon,  7 Dec 2020 08:57:05 -0500
Message-Id: <5daa486a9ce06876bdef92a50f1a11d4eee9da67.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

