Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C562B204D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKMQYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgKMQYi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46382C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:38 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 3so7068708qtx.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3CLPYoj/Rh88WsiItq425tcUPoe/07gd5OnfR2mS41U=;
        b=jhEXBuNytQejAv7ucmE+7t3h0/J0Rm08mAMXB0k3g4pnA5aEmcRUaYBvtVY8C3W1Xs
         /i8/WxjXF1Ra4M3/7ED3Akssfkz7dCnvktSAGSnIlAiFqxHSr9V0oQt8ixEiKjo+ixAf
         Tb2/mpB6TedK69zf4lQUO0yVL2iCqBj+xcq3pG/g1wDv9ZK6px/KFoJaM/jmXcsx6r5I
         pkRA9+jxYKeLUeol22/Mj1Cajo+j4H293VmhrcliSnrkxjinUEGxj3vvvsa3H6M1Nsl7
         JDE/T8udiLuz2CqHPQAE0W6ZH2KmYiYxplwYkA9TlcWsu9oC6YeKAH34lF9hksGEb6VR
         K4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CLPYoj/Rh88WsiItq425tcUPoe/07gd5OnfR2mS41U=;
        b=Cc3zqGhNORoOyIw1DtuUkmiYzvsnm3HGmvvDBmH5BWKjh34U0F3Wb8e+UwlZ8Fpl0n
         mFqFSwl13WxytM6gJR3YhFzEKkbHptP/2rvecMxsXz4ffkELRUW0GFO41gmbdkOgoKd+
         VaUNjCAv8gL6YJkOumDSfL9GKGk9RkoqYQ03HnGoUDJ7NXOdljA5qTE4IMLynJKz4h7W
         XVMTv/KP+2obNgbccUZPrlYnoMKSem3WJerTj36O3xHUFLjo5/PWSzdCX5tIg95E0TuQ
         O2PyxI+VNxwdhlf2HGg0pphWIB5OV04fW9h52mmc5diELN4X6VR33pIIVDwuM6KwnSMD
         4vsw==
X-Gm-Message-State: AOAM533Y7GivLS9wQAXFZlSteUIqtGOcHi2Yf12yzvPpq3t7Tgb94OqH
        wuYC+iGYwQl1nuWf2/4IaiMnHd2TpQsghg==
X-Google-Smtp-Source: ABdhPJxs6NbqjMcTRH8GJyl0is/bFWf3InnSopFOq3ifcw/K70YPnRDxv/MFJBSyVZJRvFIY6x8HYQ==
X-Received: by 2002:ac8:24c2:: with SMTP id t2mr2736279qtt.295.1605284672248;
        Fri, 13 Nov 2020 08:24:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k31sm6738261qtd.40.2020.11.13.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 31/42] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Fri, 13 Nov 2020 11:23:21 -0500
Message-Id: <ca2bf7ae567e8ca53907cecc2140c4a3a254f381.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3e788b1249d3..7c7dda11f2aa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

