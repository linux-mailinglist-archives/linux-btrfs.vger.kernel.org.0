Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE02D12D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLGN7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgLGN7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:36 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE8C08E862
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:21 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g19so6506380qvy.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=v6u+BO+uRLDsrDrP5lB1VKICrYm2LN5jAiXSnC1DgwO5i5tXn4cUhPnlBAOncppZAB
         dqeNz8iJxzz9eJYrQ8sQLPZ2vOWcwNffm/cbm+oaxsKP27tbkI0DSSPNupQSeXFXRnl9
         /KEOgDgtFS+84Q6c1SvuVj+GHZ3n46lsJa5CSDbdNbJAAhonCHiPWRSOsje1ttN/KOKG
         R12sueabZonf8s/plg+88UsTdZ67SJoSbrjqWUfEq+beYzCnKs5e4fO3MYFlFTCQ2mZX
         i9BVnqNqjrn/HxHTKGbD8BgLdJu3bFI/n87d9ZxDY/DZYu93YyVL6DZe6pRR6iXNuMF7
         rSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=uGA8LVIUDzXwo3/vwtxuWUe5KQYYVhn1i/g1FUrWQU+Fq+lxTNRgcQqHyIM2l4ifhn
         3ghGkn6hkP5c5k3R7B0FNKFaxEbZejAr91Od5mZ0vN3uxka2EopMldLNGwZQJLwS59nZ
         ElvT2Zn5h56tdZ+WprrHKKOVhO12kFuCyI5b6X1L2x1EUFhVraQn7OE+eqlmYs1YpWUm
         UdTGOcdXE8s5r+aGFn24xP4t05f8yEsEPmxoCVcpAP9ysyo8QgfuGKoxjq1c/bHLzM69
         TaD9M9VpF2rRJy1w32DEE7tPrJXUCW3K59+19UQkJQeWUfEW3Wl0bzhcN2FQOQBXSgD/
         ADGA==
X-Gm-Message-State: AOAM533fEzQaeL90QMQp7Vgj22UXdjNTcHGHfXkBF+zbFI1fStUeRtC2
        cCBBUfiKU5aQBKkdXjUdZkrzO5pyWn0jYFmJ
X-Google-Smtp-Source: ABdhPJzbcsRjXa+kky3+CedkY4/nPec6FimFjaplJrWa3byvjvTFGStHF6t5az0e9OQUXHl1tbaOTw==
X-Received: by 2002:a0c:b799:: with SMTP id l25mr21265266qve.25.1607349500235;
        Mon, 07 Dec 2020 05:58:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m190sm6397978qkd.54.2020.12.07.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 17/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Mon,  7 Dec 2020 08:57:09 -0500
Message-Id: <1fdf1c5a0baf77a4210fd50a76dd22e327154b1e.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..2f8bb8405ac6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8897,8 +8897,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

