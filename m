Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068CC3F3459
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhHTTMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhHTTMm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8FC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id ay33so426311qkb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tMfV38eV/it+FglvzpiOOjeV+ZflshZt7CzKbZSqAk4=;
        b=KGHel75R/lThZswyZLx4KPdIYcYeHnpf/PbcHokndTGl14MHl/SzPtwckp2zVzREWu
         T8JpHDpM2gX1Yhyv+U6TRmEo/EGm1yEZN6ZGM/xMvHI8lndjkQWSIiJEk5y6frGwZlhL
         B5W2JYeUMUR75X5NpCNJQ2Bru5oUhBH1BKWkBCIOChuHhhmwRrBSxeDYpCarWVwRuW/1
         DRAS/AEY4FvURvTS6tM7YeOeBcGg7Sushh3H6btOrX+SJ5IReBaaDpBZ06Aqon+Su4CJ
         Et7raSuvMOC7ArJFoQKf4dqCNIA8KotLO5I39D5Wr71DBQu950ezU/M7sdmWT7ySoewq
         nNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMfV38eV/it+FglvzpiOOjeV+ZflshZt7CzKbZSqAk4=;
        b=ufwWKp2lpfArKal2UxuCgvYB2rbBHCUABy6hHRXWchc7Zn249V3oWlOB89eaP+hRB2
         A2KuKqKYYV9QeNMe6v8oa3g72zGGfqu/XJsgs5/uBkyHZQmGASoiMEes1XB/ZQboZHFB
         4vhdlpSzw4ERKCSYe44+aefrajcJiWmbsuFYmbEfa5WXag7uBsH3N+/Z4I2HqAIkXydU
         9u0hKXO36KCrJLtO2TSztT9epzTFjW55Qgf/HBVmbqudKqf0yFFm+vNmes76pRD4+ZUC
         +6aS+Vco1vRS8iopb/9znsyewoqOYtkOOCMfW2F/Xl5UDMk1u5+aZsZQAg1k9wlXwvVn
         ZrRQ==
X-Gm-Message-State: AOAM531D9OzrFH+PwVwYYbrLOuDE5eOk5ZOoJjhY8oCzEjb2QwrZmjYX
        12gev0yF6Qqhd8o/asftceUOVQ5nmRFRXQ==
X-Google-Smtp-Source: ABdhPJwvJLzYpfzNCpmjLJMZZt0izASI8fHxgNAg/kSOLntAcXQJGmqzBx/4XoHy9Vj9SfZwWrpmyw==
X-Received: by 2002:a05:620a:d4d:: with SMTP id o13mr10311459qkl.466.1629486723308;
        Fri, 20 Aug 2021 12:12:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm3584561qke.24.2021.08.20.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/9] btrfs-progs: allocate blocks from the start of the temp system chunk
Date:   Fri, 20 Aug 2021 15:11:51 -0400
Message-Id: <2677d6c2568dcdc4eef9ef89e6d0a8d0a45960a8.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During mkfs we skip allocating a block for the super block, however
because we're using the blocks array iterator to determine the offset of
our block we're leaving a hole at the beginning of the temporary chunk.
This isn't a problem per-se, but I'm going to start generating the free
space tree at make_btrfs() time and having this hole makes the free
space tree creation slightly more complicated.

Instead keep track of which block we're on so that we start from the
actual offset of the system chunk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 8902d39e..0e747301 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -153,6 +153,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	u8 *ptr;
 	int i;
+	int cnt;
 	int ret;
 	int blocks_nr = ARRAY_SIZE(extent_tree_v1_blocks);
 	int blk;
@@ -203,11 +204,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	uuid_generate(chunk_tree_uuid);
 
 	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
-	for (i = 0; i < blocks_nr; i++) {
+	for (cnt = 0, i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
 		if (blk == MKFS_SUPER_BLOCK)
 			continue;
-		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
+		cfg->blocks[blk] = system_group_offset + cfg->nodesize * cnt++;
 		total_used += cfg->nodesize;
 	}
 
-- 
2.26.3

