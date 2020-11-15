Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587802B32B9
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Nov 2020 07:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKOGjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Nov 2020 01:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgKOGjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Nov 2020 01:39:32 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC9C0613D1;
        Sat, 14 Nov 2020 22:39:30 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r9so2331610pjl.5;
        Sat, 14 Nov 2020 22:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tlFXBTFcYkPa84QBqoC1ru6zN2P/DQwrQTwyiFFdexA=;
        b=F20TrEo/nLSlrT6wylg/JZzgqjkXxwbzyvXyQaBf9ELIlTVRPEjnCQrlTq0BMXI1Zn
         vAOmH1lHKhYfhUQVYiFlb6lN5XwirBNUSED9xjuGdKOr0i/fUJyGn4zDAJKs+HAuP0FM
         Ph9wlPusORVnoCJBXQFtl+TLW5yp3GTCrVQGQ9QAk7gr/dPMRG/XFYp4rydMKY9ZbA75
         PHeSYrAqP8qjcog1qIchYiAOSE93ok6ojuNoygUsqG/zaoWLaz4jue55i9NUMmcR6Xtl
         jF1WiTMcggOFHr+/Uu2CkZT/rDriPnRe2UdBGNaJw0k2qJGEOinIMQSkhvzDFGNyqvR5
         FuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tlFXBTFcYkPa84QBqoC1ru6zN2P/DQwrQTwyiFFdexA=;
        b=VaTxhyaUpzc8XM4mA75xLV/cNlW/g88bMKIDYwDDdWRnr6gdnKTl/6lgeN+iF7uX5A
         LgapDp7NBlNS8GyUGKFTjNSzespLPSRABnVGalfwJX3iEVRr+FvM7EYGVpHUkxWC5mA9
         VMuozOa4vPakMHG1GZzFqFRzOP+nyEc8+fv5eBCb22NwLWIPFSThQZg/YWlmDxOMbq/P
         hU45BMTQ/jlKMrNi/5GLxSWVpr29ns5s0PbnBV7EAWj2ckhlChsCg4FoFjTcMTS9iQ8I
         UwltJ/E4cyAm4YgLn4h1TTlql384aDsJJaG24SZgdX1WeXNfJmQwkB7YnyQPhKJ4ddZW
         sr4w==
X-Gm-Message-State: AOAM531OwHw+pGK282PGEPcGIAvVFnqsala1rlP3rUu1p7sx9Yfw0IbV
        eKtNDuL6tExEoboy9ARrfA==
X-Google-Smtp-Source: ABdhPJwwhVoZ/OBIloqRKcYiB4dt8ojq6wF1xEGyXG5lbG6Fubn8EWRKzrmN0e0ZkABqUuCcWCrMUg==
X-Received: by 2002:a17:902:b209:b029:d8:e821:d61a with SMTP id t9-20020a170902b209b02900d8e821d61amr1649464plr.58.1605422370115;
        Sat, 14 Nov 2020 22:39:30 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id k8sm12830580pgi.39.2020.11.14.22.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2020 22:39:29 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] btrfs: remove the useless value assignment in block_rsv_release_bytes
Date:   Sun, 15 Nov 2020 14:39:23 +0800
Message-Id: <1605422363-14947-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The variable qgroup_to_release is overwritten by the following if/else
statement before it is used, so this assignment is useless. Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/btrfs/block-rsv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index bc920afe23bf..8638327069b7 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -109,10 +109,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	u64 ret;
 
 	spin_lock(&block_rsv->lock);
-	if (num_bytes == (u64)-1) {
+	if (num_bytes == (u64)-1)
 		num_bytes = block_rsv->size;
-		qgroup_to_release = block_rsv->qgroup_rsv_size;
-	}
 	block_rsv->size -= num_bytes;
 	if (block_rsv->reserved >= block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
-- 
2.20.0

