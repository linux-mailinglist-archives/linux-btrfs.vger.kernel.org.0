Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA43944CA2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhKJULT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhKJULS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB4C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:30 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t83so1287740qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4Za6Zx6pzs4LZJ9oVu7oC/LEF8ehl/2IA3oUjX4wLWY=;
        b=PC8zjbm1PgR9cku/524H2/jenr0PRf2g1nv/7aJwYyipKLvxD/cP8jrtRfuWUCJhno
         zkZadURyVEW2KMflTcHbSUxESpCyCpYsVgC78L5pLIVWqKj5xqr0qQwp2q2/gAGN/zk2
         qL4gkfsNSpMurCZlKnUJjyyAw4Z6y5xTY/N/nQzUxMwuRdNVhWIHWbeSvYAphgcWmerX
         jBRhtNJed8NbOQsWMTegKw4Zcv9wZrs2a1eEZeadZrrxqFAMU+WRldmIIbz3OJHuPooX
         kNIL6ebIfZAT4t4W5/Y67JPi2LqtWpomZ5vtF4MlvNzajz5sQtrP1cOUv0E6JukB8JaX
         pG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Za6Zx6pzs4LZJ9oVu7oC/LEF8ehl/2IA3oUjX4wLWY=;
        b=3ArQTf0lJa/hynZYyWmynBeImmnOvoXN9sHVOXSFl6z5Qt5tte+TyoPQF0DCmef5Ms
         xzoPGp3uhxHNk3dlEcwCQEou+lGGKE//NnoE5Nq606GHXYM3aO9rFSt/Uk1Ode1IJS0M
         j1VwdP1YsPm9rIu07cR7VNHTk6PePPSKDWi+fOvFiBnHJY2eFHmPy3aTzqb9EBcGybBQ
         Xg8lIPEzhX8aMB2/wFF1J8fHuxoUG2lqtlFZap80G0qnzYMD3KkS5qsamULMn1r4zVvj
         YXZ9fX0IcD3Dc9gi7zT0nvBNkbOU/kbqEHWdIw/b+HH4FW7UpHu/D27vgLqNiW+nl+cn
         m01g==
X-Gm-Message-State: AOAM531PlnJBl7oae/anM2aNChXNSiAJizUmn5cqOm9ugngc/urPtrdA
        mSEMQLRKM/hAHENx0Ev1Q0FYeq7iz1yY2w==
X-Google-Smtp-Source: ABdhPJzlzorwUGJJojumIZmeNwHbrq7/Uyc0v6LlqjvpyGLnR2Y7j+6TIArU5+OHwT1q8Pxv1rbahg==
X-Received: by 2002:a05:620a:284b:: with SMTP id h11mr1703383qkp.90.1636574909439;
        Wed, 10 Nov 2021 12:08:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n3sm425053qkp.112.2021.11.10.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/13] btrfs-progs: mark reloc roots as used
Date:   Wed, 10 Nov 2021 15:08:04 -0500
Message-Id: <387d40d20c05df14d442282213e850d590d8e7c2.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
causes problems because these blocks are in use, and we use this helper
to determine if the block accounting is correct with extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index e30fd8e8..176665bb 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -87,10 +87,6 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 			btrfs_item_key_to_cpu(eb, &key, i);
 			if (key.type != BTRFS_ROOT_ITEM_KEY)
 				continue;
-			/* Skip the extent root and reloc roots */
-			if (key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
-			    key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
-				continue;
 			is_extent_root =
 				key.objectid == BTRFS_EXTENT_TREE_OBJECTID;
 			/* If pin, skip the extent root */
-- 
2.26.3

