Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166602CC720
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbgLBTxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgLBTxN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:13 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434DC094240
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:20 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b9so1535848qtr.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5lapE7qpsjWGx29+FZ7863fV6bSKEyu6jWFWb0w/eaw=;
        b=pIglmT57LIs7b6cHHLT/UpZKL26MrxgxLZjWuSwTQhcdhr5uo+SqxHArobLw8z2eYQ
         35scIghgKaF4IWd+0cr7UkU/U+zuo7nSNlCepuKczcZvVY+loMZs/KX4Cnr1kOJ97pNu
         z2hvX1V6kcskUiGGbjUjfpfP8mVIdve5kvT7FM+l8MFyiVaGLQ4VAfJQIrC9KSBaT2+C
         Gjn0shoedhnGVajT1sohkhwbyTvae8el8BuTYlFgisk4bux9If5B3fg2CWqvk+SLeTfc
         XB9vcmGKzb4HEkcjNvQV6E/KawAe9pxjej9Oe/tGqNgmjLKT/v3zd5TL2EHVe2oZfpkj
         Qi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lapE7qpsjWGx29+FZ7863fV6bSKEyu6jWFWb0w/eaw=;
        b=eeGVPUjGMmsvBakM5dGTHMNQ+xcBlq7vdgEpIggN/Kx/7X88xHpXafWf42vnTwbZ09
         cqSKlEdf/+m6mHZACPi1w7ojd3H28mKp7gcpezcshBI8ug8JAtlvkHWp5JOsjqLYGGzQ
         U2A80lxcnjeVPlDKD6cJWtrXjhCPreAapGR81OW+UGdAAIOgcpboZQjEfGkaDeqidk89
         SsHbJqWiheM9Gp5SOIM7dDN4kvd4/lMABD2ih5ReqZZ9usuYN9McR1j4l3XyfjMm4Ejn
         FhDS2XxSvxyZWxHqYiKJ8OOFxJaRrvrOWVYFSmEEmuVlXTES5PjKWflxTuSk5Ss+JI3i
         +Rmg==
X-Gm-Message-State: AOAM530Zn35DgJG+SkVO7qxFD67b7hhQqSquYcQxwOeoSQVjxFLhCRhM
        r52tKRoQdMoYt8SEHkqNwB01LKgOHUuafw==
X-Google-Smtp-Source: ABdhPJyl0+XSHN2SwWEccX2Mr82GBAfEq2dIn6mrPHWNVp+J2GV9on6xGuBVGtDfmDO19l5m+kfoEw==
X-Received: by 2002:ac8:6c4:: with SMTP id j4mr202966qth.174.1606938739072;
        Wed, 02 Dec 2020 11:52:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e19sm2798640qtp.83.2020.12.02.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 36/54] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Wed,  2 Dec 2020 14:50:54 -0500
Message-Id: <118c78ea8991141e12c404753fa851e055de61ef.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2fcb07bc8450..b872a64de8bb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1234,7 +1234,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

