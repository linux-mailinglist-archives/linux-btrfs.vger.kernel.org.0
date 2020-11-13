Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C944E2B2042
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgKMQYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKMQYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:19 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:18 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id r12so4817215qvq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v9SV+mr1RR6BjkhAkpX2eUTA7plHAlPPKZcXCN+3E4c=;
        b=eThIU+wL0AiP49U6aeyjVW3w61KBpnJAyxtRcdqd1UPmMEVf2UQPnJNk5CAHfyKo5s
         CAVZAVJMIKacLyz+GVf1m1CV46QGxim9K6UVHHhDDuMPmp2WLHUcIRJSz6Qps3UVd3V+
         Y8GZvRcwl3X3Zl69NTlbIytj5w4r/pbJV3VOjVg4ETlzjYKE00POZRc1dcaWw9qBMDV1
         embqOTaoUVasg2n18SRhrvJtWuzeu1vp6cDJvpGtCYljYsPQgOU/FzL2kSnVyoVJeQSa
         zpF14+vtbVFx5aoemWPme5oFxD2GZUVgLm5QO0Ub5hyYCX1Mw1Terc1A4vRotMMVJ6FM
         XDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9SV+mr1RR6BjkhAkpX2eUTA7plHAlPPKZcXCN+3E4c=;
        b=B4ElOUbY/0pO5l5FDvd7wG7NGulDWlAE2tZ8K5dIi70MAl9bFGLWncgSEPtiDP22fx
         lxdHQDXqannTkqhMIqpPf6tVXuQW6FJPQP1b4z6q9HfVKEr1ZrSr63MiRUbv4nW4grHZ
         l8IfgkUvg1y9M6AdEzmXLrE35M28N1FNQYh1ZPX9Zr6ukngvVDW45M1YQaAGCoknc1DB
         KG8bls77sa51F1CQ8SGhPx3EXwFTyRYFP4g/ENg1p2bKfByX4gux85l70zU8x9GZNnfz
         RyYgzJuDxGmxfSEha7wbgZNET88RoUPGSUIR8zXTWMXRFADFAs5bwvHMjxQ2H5vcmnVo
         0EuQ==
X-Gm-Message-State: AOAM531o1EFpo7asX/Zx/ST2HFLSIWeVSQZ4OQcrVACq1tBYKSaDgIWU
        ngd473Pg37j//V8Qz5uzZFXzCGFC3kpT1A==
X-Google-Smtp-Source: ABdhPJwb6hImNn6R6M64WbOokLLeeovV1CpdGrE8YeQgWaE7JDxIqPHrng2CCaMotCxUTexgT07hOg==
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr2982550qvb.13.1605284652167;
        Fri, 13 Nov 2020 08:24:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k31sm6737683qtd.40.2020.11.13.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/42] btrfs: do not panic in __add_reloc_root
Date:   Fri, 13 Nov 2020 11:23:10 -0500
Message-Id: <8b14e9986f6c889008debd7e0c60821168aaef46.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  This shouldn't happen
generally so leave an ASSERT() for this case, but return an error
instead of panicing in the normal user case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6f7bbbd76102..63f42aa43fa3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -637,10 +637,12 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	rb_node = rb_simple_insert(&rc->reloc_root_tree.rb_root,
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
+	ASSERT(rb_node == NULL);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
-- 
2.26.2

