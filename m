Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94614469E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhKEUoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhKEUoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:44:00 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E2C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:20 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u25so8068633qve.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VqlW8Ff7L0gtbA1t8/6orQznL1yuBGiq9DS1EvM7OV4=;
        b=rrzm5vCZDjiEXy9mvLmEpPhHgVkR1Z2fVz3BA/K9oYza4Yc7obQ9JB0E9scqMzfpWy
         k88waPZvhWGaGi2TAwib2PYZYalBozTLAHDQJEIEnvYHU2P/SvpqFTPq9sofOwcV3xqx
         NQW2tqi6TcS192oa5/WZiswapY6U90ZEluq3+e/SH65OrAEs0Cqc6YWSpZAMJCjZAusj
         yWXRM5ILgJxXZUax/2NxTgY1GwDqpes+YwrF4tB3M3gTsBWQDdR/4gqJQBOv+xnfK2lU
         mpaYFLMG6hWbnkDyTLUu9mmn4TCW3RCT6CI05jjWuxhYmSWUQaHNhumYvmU32lHynFIK
         gSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqlW8Ff7L0gtbA1t8/6orQznL1yuBGiq9DS1EvM7OV4=;
        b=zo4SkPFdlIlbxybH9mca3JYpa4QTkyXc94elqd5QpBiVyImsfPi6MxkXqRLixk7/gl
         QTMzbNL6opP3Rotsd5NP8Niax6IFXaIUcwWkWImrNNgWWh+PId8+orB+gnCLLOBQbNhX
         hcpjcirvgFlbyGYpKdxRL868pPCNu1zy4IkwNNjNiyhY4JStCTb91c1Wqye2gThJ+EBC
         S8ds+5vNQkPqlOtME5o5MkeGI56ZuzTRICo+AEGeDVxEA5/sQMP2+s5sE3ltDhAgY+qb
         c7I4Oj0BUDKMN7jSP549m5L9zd1nFxcbpwq7TWly+GfwKxUG171Q6yOKQ8Di37JOZEZZ
         bB2g==
X-Gm-Message-State: AOAM532ix1esH0In5yeWgwCYWAWKiEvyRhqFEx9B8Q8iWx7Od85rav0l
        5wioqb/orcX/bEOZ9JGU/UPJN7Kb2CNCzQ==
X-Google-Smtp-Source: ABdhPJxoKPxzPlRz8uHR+OodS5PLsLobq2HqSmVvkNECjVEf+2tRtefgEcAhTgGYl9++xYE06kUWCw==
X-Received: by 2002:ad4:5c6c:: with SMTP id i12mr33581965qvh.42.1636144879380;
        Fri, 05 Nov 2021 13:41:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o20sm6288485qkp.100.2021.11.05.13.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/22] btrfs-progs: check: don't do the root item check for extent tree v2
Date:   Fri,  5 Nov 2021 16:40:48 -0400
Message-Id: <9a358c6ff608f81db52e8f2aa674b753cf711df6.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the current set of changes we could probably do this check, but it
would involve changing the code quite a bit, and in the future we're not
going to track the metadata in the extent tree at all.  Since this check
was for a very old kernel just skip it for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index c28fa2f3..0bd87685 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10065,6 +10065,9 @@ static int repair_root_items(void)
 	int bad_roots = 0;
 	int need_trans = 0;
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	btrfs_init_path(&path);
 
 	ret = build_roots_info_cache();
-- 
2.26.3

