Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F83F3457
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHTTMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhHTTMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5FC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id ay33so426248qkb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E39NJkVoX77icZxvOWA3SIiLRZoqd0Z49yMAWMLhmg0=;
        b=I9gO0uVtC5JurSYBX2SxJGK+KJpIz0DTLCMvTJF2KQvyZm7Mj+WDGDu7WL9AYvZhOe
         1VP35XaIOtHSKFty49sYx/c0VbHZ2TiyDwG98J/lvNbnO3UaUsXsSVl/3rA8peCRc9j4
         mMiY23XrJ+5H2nkt45xxhR0BjYXA1vGR1tLXSWIxvjpdRX85pW7yHszDpMCB41JmBBwc
         ww4Mzdp4j8ArXLCgKUOQCUZLH79QsdJExiOZn7SMMjPQnh1bhntj17fh99LNW6oDfcrB
         YQY6q4X7Rpdf59xcZEvVucMOHVrjm5+QYJUVC57e0rKXGNsp23rdzdCYM6FKZkv23Akj
         f9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E39NJkVoX77icZxvOWA3SIiLRZoqd0Z49yMAWMLhmg0=;
        b=ZvlA9dN+YNPMDPUZS41WFhpaH6VdRXKRqt//8RS8Xm+L3062iCj4uRPY3XgTGzJ41X
         EpXQ/AAi2kKUY17e5tzNf9HW1QGg1V/vZmgDegJWjOd/sm4u8MsycrBV0j2Jxj73jHLQ
         h6hLPsLzz4CuTFw7N/FcBOmCbeN5DNJ9AynH3gg83xOz0k/f7qy2eXIQI9cyhPFX5hYU
         9cphGhK1IhUr2AH+VbKb57kjnjskVKToR0YVgWozEtGSr5qlZvnUQN502hTjGPt/+XHI
         sU073LO2QBX55WySt4PoiTPlZIxMN5mnVnNVDmTQK5PpelG2LQlQcD9hz+qfuOWwL+oP
         Uokg==
X-Gm-Message-State: AOAM533lywA7e1jvC/1ezdCXQyZr1LajUD10iiJq0t3FRf/GaPTYQ2zR
        gej5blRtrve7YiY7CLTm4n1Q9r67YYBxSA==
X-Google-Smtp-Source: ABdhPJxWZmGd/nG11nhmRLKqTlXs7ERXPVGq2/YXjljlKsnhKoiIwy2jxuofudQX/qBfblFU8lMz5A==
X-Received: by 2002:a37:803:: with SMTP id 3mr10424579qki.127.1629486721992;
        Fri, 20 Aug 2021 12:12:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j10sm2864941qta.85.2021.08.20.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs-progs: use blocks_nr to determine the super used bytes
Date:   Fri, 20 Aug 2021 15:11:50 -0400
Message-Id: <1d73b314e14e03f4fe7a70475822f534fd5914e4.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were setting the superblock's used bytes to a static number.  However
the number of blocks we have to write has the correct used size, so just
add up the total number of blocks we're allocating as we determine their
offsets.  This value will be used later which is why I'm calculating it
this way instead of doing the math to set the bytes_super specifically.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index e9ff529a..8902d39e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -162,6 +162,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u64 ref_root;
 	u32 array_size;
 	u32 item_size;
+	u64 total_used = 0;
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
@@ -207,6 +208,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		if (blk == MKFS_SUPER_BLOCK)
 			continue;
 		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
+		total_used += cfg->nodesize;
 	}
 
 	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
@@ -216,7 +218,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_root(&super, cfg->blocks[MKFS_ROOT_TREE]);
 	btrfs_set_super_chunk_root(&super, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_super_total_bytes(&super, num_bytes);
-	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
+	btrfs_set_super_bytes_used(&super, total_used);
 	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
-- 
2.26.3

