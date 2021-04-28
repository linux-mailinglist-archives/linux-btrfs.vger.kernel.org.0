Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0834036DE80
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbhD1Rkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhD1Rji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF731C0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:53 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h3so30412543qve.13
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/A9DqPHUROVRO+mHvLHokSiw4oLb8UUfubXeGPKsepQ=;
        b=k5r0aVlKnpF2F8R4vMXswh/dBpvZLlcn79H7lVrwWgpGIq9oVJV6vw4TGUYGTIRukP
         e7S9KqZglBxRw6ps9hRE+ubT/BoCiNGVHDi/RL/RMU69k5/t0Lbt/EkLvrX6ufE7qoXu
         c0n03d86jcI1E2AMJwM/1qZ90p3k+AgFW57tugdXen2GUkd0nLg7MVh7cdIe4A0gfOLs
         aROKxZDAw5bY8M2GaDSb5672xLU7Nj9sw0C+6iFCmUAvu4Rch0o2W05xwBdI7Oh3WYcV
         fqqnzWqACI3LbE/UXr/dJFBswQDnj+jLtppmv5zkUDupGXrG7iXqG7kfAey/pjXAtc64
         ZIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/A9DqPHUROVRO+mHvLHokSiw4oLb8UUfubXeGPKsepQ=;
        b=AWV2Ljz2b4l+cYEqPTRuuwRuZDpcR71y0PGo8Km6OINv3L60DDAQC8+KZEHvnCb3sG
         kNxqAM9SjvmcQo3iGWKhKdWnYLTBGRKahnQK63Txe2avk7e9M222dJjDBkALJO4CoEgi
         QBtiaB2lJJeNnJSEZN+c3HZgnLO3QWa0dW6JAXjlBLcFB+MRLDo3uAfIA1+kImk2oLXn
         5k9IEVMeCnlHNBnfdmM3Bpivi/c7af5/hlexOZ1rhiGdSahc/bpFxOHLAuwPkjAxsVmW
         2/eq63ijYAZ55LIiQBX09D12Lk5bZCTDGmQ6/Iy+/pshkW0DmAhf9yP2Q+FcqPz6Wwwo
         oeHw==
X-Gm-Message-State: AOAM531lW833UG0i40Ig3dBAfQSpFPWcH/gENbfR2OpxURgyplvOgRH6
        sG9d84cbLx73+HsrQYXz15o8dvUTFk1LpA==
X-Google-Smtp-Source: ABdhPJxbhh3lszSzWi3gHfEXGqJ4xtNy/FQ8wwdyQ3aHH/220oWLb0Ycr9ibMhKC+MFE0NZUbS4msQ==
X-Received: by 2002:ad4:5889:: with SMTP id dz9mr3344012qvb.12.1619631532662;
        Wed, 28 Apr 2021 10:38:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm328369qkj.4.2021.04.28.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] btrfs: only clamp the first time we have to start flushing
Date:   Wed, 28 Apr 2021 13:38:43 -0400
Message-Id: <03064e17bc0075187aed6330aceb77524aeadc3b.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were clamping the threshold for preemptive reclaim any time we added
a ticket to wait on, which if we have a lot of threads means we'd
essentially max out the clamp the first time we start to flush.  Instead
of doing this, simply do it every time we have to start flushing, this
will make us ramp up gradually instead of going to max clamping as soon
as we start needing to do flushing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c9a5e003bcfa..33edab17af0d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1561,6 +1561,15 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		    flush == BTRFS_RESERVE_FLUSH_DATA) {
 			list_add_tail(&ticket.list, &space_info->tickets);
 			if (!space_info->flush) {
+				/*
+				 * We were forced to add a reserve ticket, so
+				 * our preemptive flushing is unable to keep
+				 * up.  Clamp down on the threshold for the
+				 * preemptive flushing in order to keep up with
+				 * the workload.
+				 */
+				maybe_clamp_preempt(fs_info, space_info);
+
 				space_info->flush = 1;
 				trace_btrfs_trigger_flush(fs_info,
 							  space_info->flags,
@@ -1572,14 +1581,6 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			list_add_tail(&ticket.list,
 				      &space_info->priority_tickets);
 		}
-
-		/*
-		 * We were forced to add a reserve ticket, so our preemptive
-		 * flushing is unable to keep up.  Clamp down on the threshold
-		 * for the preemptive flushing in order to keep up with the
-		 * workload.
-		 */
-		maybe_clamp_preempt(fs_info, space_info);
 	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
 		used += orig_bytes;
 		/*
-- 
2.26.3

