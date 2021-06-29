Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1830D3B73A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhF2OB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhF2OB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 10:01:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313C7C061768
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g3so11868277qth.11
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=bGKWxbPYJooGpEobmKjOr2YirWVM4n0aMrkaE4Lb6UR+moWowxKut7DBR8/i4rnDNx
         HCn0221xyUjqQjoX7hpCkG2PJqURYDrlk3BV5KHKaSFmBqGJC+hsPjrDSMVCOw3Vt9WY
         T4YnQYJaFw26WmABTL6UdUqNoZG6xYJ3xcrPzd9Vxf5W9sJ1PKZvEznLAIWHB9Dz7cp3
         tZrUBzDTy2DRXu82pez7ik3A1BgCDvfBFm3wJ8o+US7sSWR2YZRTLTUeTuh9YJcx9nWo
         k+BmQQw4XxkZdHxl+QeuGmyazgFds6R+WhlWHq/0twrKdgbabdqYpPCuycClaQd9p0Le
         b4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=bfeWrOqFsTA7JUIZA9cq0u4tb1/UxovUsFdwmo+modfZ3xER69h/zQe3fu+1GUf69j
         fW0cKrU7OA5OUqM5t0T6Q6zscI8OzfNxhgdT8cjMHWRdRtK1AVJZ+hoVps9nX9uk30eA
         yOV/FpBY/oZToBcERAjbJiu6DLolYSb7UG4X3n86+dlMK1cEGh4QCY93IUQqE1j8S7Hb
         s9VLt9RlNSRrbAYLr0/Z4DgsgYoUa4NkNjKivNdF/R1ZaATBy+/RkyqtkRQphHW1HR27
         IyVJllt01V0ab/4KSC9ewOs57eKeO2yZSmOhvORU9bPndESX0Ho3JB7p3nkPsNs1LYWF
         n7eA==
X-Gm-Message-State: AOAM5319gFDtBL4UooH8Wgfo1LhlNNiwLrnqXpdQTcIuUeJCMx8fc/IW
        opqwWPTO0sY2HqqmlU6NtxzxCkb2TM+cPw==
X-Google-Smtp-Source: ABdhPJyASv4gh5GHQYK0u1rZ7RfJV7UwQ3QSHEOdHtTxbtbrlU+WlVBoJ7EoSjVE4y9Z9xfC8nFvbA==
X-Received: by 2002:a05:622a:11cd:: with SMTP id n13mr26919751qtk.233.1624975167940;
        Tue, 29 Jun 2021 06:59:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v20sm5861554qto.89.2021.06.29.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/8] btrfs: enable a tracepoint when we fail tickets
Date:   Tue, 29 Jun 2021 09:59:17 -0400
Message-Id: <196e7895350732ab509b4003427c95fce89b0d9c.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When debugging early enospc problems it was useful to have a tracepoint
where we failed all tickets so I could check the state of the enospc
counters at failure time to validate my fixes.  This adds the tracpoint
so you can easily get that information.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 2 ++
 include/trace/events/btrfs.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 392997376a1c..af161eb808a2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -825,6 +825,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 
+	trace_btrfs_fail_all_tickets(fs_info, space_info);
+
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
 		__btrfs_dump_space_info(fs_info, space_info);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c7237317a8b9..3d81ba8c37b9 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2098,6 +2098,12 @@ DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
 	TP_ARGS(fs_info, sinfo)
 );
 
+DEFINE_EVENT(btrfs_dump_space_info, btrfs_fail_all_tickets,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo),
+	TP_ARGS(fs_info, sinfo)
+);
+
 TRACE_EVENT(btrfs_reserve_ticket,
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
 		 u64 start_ns, int flush, int error),
-- 
2.26.3

