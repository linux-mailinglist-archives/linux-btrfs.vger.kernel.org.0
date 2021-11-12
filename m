Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4144E081
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 03:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhKLCwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 21:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLCws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 21:52:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4E7C061766;
        Thu, 11 Nov 2021 18:49:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so7311968plf.4;
        Thu, 11 Nov 2021 18:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBQs7fu+H8AhiV4259K+BvetOv7yqdM5oNTRoi6ACrs=;
        b=B5LePBIa4sFcc8s+Aixlq31jU7zs28gM15aVJSPAyGeYiOrILqDsA0JTEnoozIfTIw
         NxdYpRe0ZM0Mbl5z2cd9K2FLNn27t0XDSPpJ5oapztnHOVpnUWgokzPw9x5Jfv+Agb94
         sls3VpkkhYI4Rp7RlqHhR1Yai0kpm/07F/IHXsPazWy4OBP8Bq436/4QyuIEaYeTFnGa
         lgryecKmB5cHtw45vV+G6sXC5NJyuVBzl8LVmWzoWzI3q9Eh5yHaIQQ/i/+fVPrUEVvr
         k8jELj0KmXEWGWZGimro8CEbtIrnfuwE9aOXg/2K6ibcp7xcuaYTdMjndijcnhWhzBG6
         3Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBQs7fu+H8AhiV4259K+BvetOv7yqdM5oNTRoi6ACrs=;
        b=KXauKpkFpIBD1sF151fevYfVJ/VUdGZiTsucYm/GUpVINLIJ95g7GGKoT8JIz5tCtO
         MJjj2v9A1JBXTYzBXhFOgUzKP8JYsgQxmIhk2ZISxbAg08dXnBNmZxFegalPogOgBhkK
         pRHsDrnAfaJrlgHJF1OpHVkxd6z2J3zGcZd7TnJz/aAiAFMpt7fvXmwtvPM8B9x12fIF
         7X4ZmsGCo3HW/YHyJVqHSymRBu4OuJs67ivIvSYGpBzCX1U8bMT2bTILhWujLyQra99w
         lG0fN1i4Eyv/qjVWTIcsbeXgmOKVgzdviNhtIjdbpTukZGODW1KAvZt7WLJeMlJ72yDs
         b9bg==
X-Gm-Message-State: AOAM533c2vsFZI+HcISS1/7ryDIcwVVjAqHoKGpuGUiiKUBEXOi07k+L
        b3GTJnEgbp8vMcBQF9cmP2A=
X-Google-Smtp-Source: ABdhPJx/qFQ/l4obeAdyLnDxa3K9tn6GsbP0tvKrDCLEaylWtAkAK5M2JcYz3JFsbjGigGvPxhp2UA==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr32199824pjb.87.1636685398206;
        Thu, 11 Nov 2021 18:49:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id fw21sm9165995pjb.25.2021.11.11.18.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 18:49:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] fs:btrfs: remove unneeded variable
Date:   Fri, 12 Nov 2021 02:49:50 +0000
Message-Id: <20211112024950.5098-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccicheck REVIEW:
./fs/btrfs/extent_map.c:299:5-8 REVIEW Unneeded variable

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 fs/btrfs/extent_map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 5a36add21305..1dcb5486ccb6 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -296,7 +296,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		       u64 gen)
 {
-	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
 
@@ -328,7 +327,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
-	return ret;
+	return 0;
 
 }
 
-- 
2.25.1

