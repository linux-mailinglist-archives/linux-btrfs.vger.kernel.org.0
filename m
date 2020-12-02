Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04112CC70E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgLBTwm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbgLBTwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:41 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844BC061A4A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:30 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 4so1311168qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8u9JJvwVSWXKq5SNRk+RtSu99n9c36WBAL7BSJcEBPw=;
        b=girCkqbK4CVgFgs3QehVR1mbB8kuVs3C59mN9FqJ+selBeGbvoAZOKtxE14mc9AaFv
         V6sWKD+HsflvdGevcTMKPmi9jMK8aKutTXFbO/dl5yIqRkWqI8NZOOXq/nsB0P7quDU9
         dKBBQMOoQlD1wYJB89mLkC2xPi8aPLsL2b+zLYFL/s+eNydFE6/pTORdX2X9EWadnzWn
         1tGV4KBSGt9OC1BEPhkPvhoOFlK4pL6s4Q0rnGpez0n+aQiNnTivbHG2Bimucuee1nyg
         uNSQB3SJ+RWVhOZrrZczR42aTElQr0qE5OoUeoU+Lg5oKhLurYSGaUpwaEyuzkZT4c09
         k/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8u9JJvwVSWXKq5SNRk+RtSu99n9c36WBAL7BSJcEBPw=;
        b=HyPZrJeN/EBbhQ0BpnoZg08AVlPcgazPASSEapW2n8ZEAE0kjgDt+7vkfJUQdssgB2
         8GFtjbnWgKsj4may1xqy9Y9/JYoBFrceNgVPGFsRuyc0s4ZkBy8oQAWLg85R3UIH186M
         f6Sit5et/FB88J7wJiInJR8Q6fHA2zXN35/AWzQLM1pUxeizRCta3XxVaWy0vFHZX4JG
         Q+6CkggLccImYyBCSa4S48msVx2hCn66tdICx/AR6hTLyeWqhIfFkl6sNRJLahOUpZWr
         5pJ7Ph+16baMkwtm7XYbP1tM/W6ImfqMh3L9UYrfEJwqEvxoXxwjPws6SZPKGxLjwFzr
         8s8A==
X-Gm-Message-State: AOAM532hnvSmmmo0Y2WuDisz6yoyjhshO0/QhwNRRb5VNqcPeDeQ9lc+
        ZZd2UKQtXXXocNeLswbDPRHX6hYvZSXijg==
X-Google-Smtp-Source: ABdhPJyNZAncNUHX9KaShAO8r5VJZ7cg52uimxYx9EqYkpjMhtxQ/836ZEPVSTVeZ5Dfy+oFQB0z+A==
X-Received: by 2002:ad4:524b:: with SMTP id s11mr4456896qvq.3.1606938689724;
        Wed, 02 Dec 2020 11:51:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z26sm2713794qki.40.2020.12.02.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 09/54] btrfs: don't clear ret in btrfs_start_dirty_block_groups
Date:   Wed,  2 Dec 2020 14:50:27 -0500
Message-Id: <89d8fc9f58723113f0f6685d67480541044839d3.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to update a block group item in the loop we'll break, however
we'll do btrfs_run_delayed_refs and lose our error value in ret, and
thus not clean up properly.  Fix this by only running the delayed refs
if there was no failure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..0886e81e5540 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2669,7 +2669,8 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	 * Go through delayed refs for all the stuff we've just kicked off
 	 * and then loop back (just once)
 	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
+	if (!ret)
+		ret = btrfs_run_delayed_refs(trans, 0);
 	if (!ret && loops == 0) {
 		loops++;
 		spin_lock(&cur_trans->dirty_bgs_lock);
-- 
2.26.2

