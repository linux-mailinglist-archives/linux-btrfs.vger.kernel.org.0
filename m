Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3443B6622
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 17:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhF1PyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhF1Pxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 11:53:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB9C0610CB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 08:37:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q16so6346358qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=CTDsJBOx33O2tuFAdgQsI/EtrnEzunsFEIdFsYojutOEjh2+OzAdplMUR06kaFJuK2
         VxBDixEpcgJE4g4S+xK9Jb25HMjnaAauMONt8E7UEzhnxgCvCJoUIU/vcWma+okLVX/K
         ChJdhYOEcggz/c8hrn9nDf+EYO2quwpwM75F7imbZgacbE+/Cvqjg3bOXewyEyVWSMGa
         nmcV1dBa8aZoJmVW1KAiJQnbRjmw9wRVwdaSxbvjdEQm9OZHT6tJ/LP0DMfMmw0uF0mT
         03zXbgtBNFh7d5LO7thdYRYQL3aGB5q7XNN+cdy6UP2aqoAIS2QIv06baaCNdjvZo8nt
         pCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9+9p3DkUHErCibT+iydqnILLuZw6VNnyzs7xEbrTYU=;
        b=SDdXmoaR4h40SdMwKGzcGACkdPveRgEZ/AsGd+caUbrmC+D4BPrG8Xre7K5xX1Sck5
         aAsgVOptN5EXWTet1TGVaBeUI9V+8J0oRuLoSFTU3R5BcZmPBd9fs7vgfG2an3Kz1ZJA
         JSAhKKj20F66cSbJtma2VZao7N5dsX8Demi5TKhF2GAnyEQoQ8FI/U4ZeeO4v+u0RHoF
         Jt9N95guUjKh1AFj4ymzmax/at6lnNzIaXtZlCuyO8JPVLbLChwhS1/x9pjNGmcF5HQS
         r/BAp/hzwHU8fZegXKcfDJzAUNXbqwQthQmCxMzu8W7/WVUPgB/APk0cb/KpPVQhkN9n
         Wsrw==
X-Gm-Message-State: AOAM533gqAxnhvVca8+V3qOs9ff2kuLNTDj+fsFshIRvE0Ut8JBkcANc
        QiY64Fm6y04piQM6Z8I9YiMLoLOGewql2A==
X-Google-Smtp-Source: ABdhPJwvURi+iMeOOEowwvjthidaHJRskqoPaLhOTcwdp21f4puUIcWhM0j1yniVAluwznL/28YYAQ==
X-Received: by 2002:a05:620a:e09:: with SMTP id y9mr25464294qkm.359.1624894634324;
        Mon, 28 Jun 2021 08:37:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t9sm2293098qto.68.2021.06.28.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:37:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/6] btrfs: enable a tracepoint when we fail tickets
Date:   Mon, 28 Jun 2021 11:37:06 -0400
Message-Id: <196e7895350732ab509b4003427c95fce89b0d9c.1624894102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624894102.git.josef@toxicpanda.com>
References: <cover.1624894102.git.josef@toxicpanda.com>
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

