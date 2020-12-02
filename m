Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D57D2CC716
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbgLBTw6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbgLBTw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:58 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E69C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i199so2465770qke.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g/wWVdIbnRmYMsQJuVGsztVWuNetm0N60OpFYh3nQdc=;
        b=ATdOMHngf4LyJO4rjE9nFqTs1cPgyKAOOITCJoRAnsbuoVukwzAN/ECC258Ty6Ib4u
         /vhFp6eR9NwTwKqo7WLaOp2xGj1N/45Pi5nQAq//FUhK/JXqhtdp58KbCRDrgqe3mOBI
         kxaK9LQwOKVb5d9ggfFwDzT5o20+kAR0ZdRax+4SKhYkod5OaYg7CzLuPlR8/qajDEtZ
         +wjSrFlz8MjPaZLvWQAq8+tenjJWKNGrhmSbAaywl07gXlQt0uedHQEm5sFOgXESUO0k
         gp+6Cz7Itniml3HQ/wec6CxZMSLL04xnN+DpCYAV2DWhcTmaJ0rvPuIVHOrdfkW9kXUf
         uxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/wWVdIbnRmYMsQJuVGsztVWuNetm0N60OpFYh3nQdc=;
        b=ZEcgNjogXXv4RREKW1RhYDX2vWCuNvMWjiB5s3EYZMfAB1pAl8xRlq+MXiLK7JzxXf
         2P0Z/VeqFJ5DqYa2hqTMIuso3yzgeOJHVx2lDjNggoqX7jOzRGgh+xJO7Dfd55KrEc9e
         1qsg+BSGm8NS/TDcCutSNImuTd79oyVmndsx9UAoHUzQzga3STnj8UI2VI1MmtoBjOyT
         xJHTr9QCaIAiFGjQadYoZr79ftGCWd5dg9NytKu97ZNxWf8fOBE8vyZi4CJK4sAwacar
         /u68GrbAN3eqgE6KIMIFHvVlpCYiU1oDa46qY2ko5JufG6XmdDhiOtveJR4HiNYYBo9r
         JEtw==
X-Gm-Message-State: AOAM533XYQofBq9dYzoqxbcwqPuNrsrBhNxwjb84mwVdzWUxW4GzPVOU
        wIsZSddTot3L7tQe4Lcb2///+ULuCQJBZg==
X-Google-Smtp-Source: ABdhPJxdSOuJMCctQwEYEhYsuiXDcRDNJxEJm2klOEdHEHpW6FhQfkoVxIc01fMGrB3RTxIvokpGig==
X-Received: by 2002:a05:620a:347:: with SMTP id t7mr3763845qkm.164.1606938723253;
        Wed, 02 Dec 2020 11:52:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm2715856qko.29.2020.12.02.11.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 27/54] btrfs: do not panic in __add_reloc_root
Date:   Wed,  2 Dec 2020 14:50:45 -0500
Message-Id: <2bef28c4b030b238ebfd8a143f4ba08524b9312d.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index e9d445899818..7993a34a46ca 100644
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

