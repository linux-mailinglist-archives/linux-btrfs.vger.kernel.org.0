Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8546E83A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjDSVZP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjDSVY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:59 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CD693F4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u37so614942qtc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939468; x=1684531468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG7Dbkejip9+x4XlvwyLfvoLHh2Gff9UKUY/juBnKik=;
        b=FSOWDo3jD5kbkKqWHwGnj5nzFAh7SMVaYWlICaoHHtScyZTyTAsRfWAD16aG6AueYF
         G4xTacND379sU6abvLB+T1PjEDI2tY1oCkQ4xISAiWXK4pIZ8bqBV8Wcl1jL50A6KVyc
         z0MJ/n9Ne9ZHovhP29GCg8gHDq8NTJvSWZzvbQscxY2OKIPZrq6wCMGKngJVZG5tr3iH
         QtHDHMxQCaDiZaJGSlQjHSJ4hVvyFzhwrYN4S6SBlPfRbww82pF7sdQM6AlvD+Ej3tyf
         T0GqHP4xj9X/B4adlQ+4eHshmXCs4RTcrtDvLoyexZQkfz/8yerb9v8tIiRBh9wprtOd
         wlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939468; x=1684531468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG7Dbkejip9+x4XlvwyLfvoLHh2Gff9UKUY/juBnKik=;
        b=aAyAR5wMIf5VQp4AM7UB/Ru79nTEZnt1OhHiNRC9zj3R1mDCz6PmVsN5dMLuhzwuSj
         B0mepzQU9mOrGcccI3keRafW8PrEM3VPMSRKBlZnwkY3/iJPJPtDDngaUwgbmmpOAizF
         Lwe0a5yNZfIoXokxFzKOXmffLmMlaBfWOctMnQugtb4zjPacVHA6fQt24mf2lYzkHuYW
         YSCHeB7GRTIef/9KJy14sPT3ZDfMpy0XD9nPP8+8Kum/67KFKcSieAK7PFHxHGYD72pg
         FvyBrO9AB9jHoLxj7atUfEYRHqHOlrqHlPsno751Us/ZE2TWPyEU2Nd7+7GwLYGPYRl8
         Ykyw==
X-Gm-Message-State: AAQBX9f2GY+ZI9MBvcSPWhsl/G2hmq9iB4N4yalXUv+lcjYGX1q07GoB
        HP2hIEYyECj3FvWgKZCG/E1f5NxxvfGSeuieb46WYw==
X-Google-Smtp-Source: AKy350Yvx/v5Ma7FOIwS7CtVlhseVZetsx150euQ/2rMqx6sqQi/Lh5QcapbnSduToAbuoHDr+fG7w==
X-Received: by 2002:ac8:7d52:0:b0:3e3:8bbc:d152 with SMTP id h18-20020ac87d52000000b003e38bbcd152mr8071341qtb.66.1681939467642;
        Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fu36-20020a05622a5da400b003ec4b2ca4f8sm42122qtb.35.2023.04.19.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/18] btrfs-progs: update arguments of find_extent_buffer
Date:   Wed, 19 Apr 2023 17:24:02 -0400
Message-Id: <919bf2d763a0caaaceaf00e0fc82b9ca3ca60b8d.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel we only take a bytenr for this as the extent buffer cache
is indexed on bytenr.  Since we're passing in the btrfs_fs_info we can
simply use the ->nodesize for the blocksize, and drop the blocksize
argument completely.  This brings us into parity with the kernel, which
will allow the syncing of ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c   | 2 +-
 kernel-shared/extent_io.c | 7 ++++---
 kernel-shared/extent_io.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 688b1c8e..3b3188da 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -228,7 +228,7 @@ static int csum_tree_block(struct btrfs_fs_info *fs_info,
 struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
 					    u64 bytenr, u32 blocksize)
 {
-	return find_extent_buffer(fs_info, bytenr, blocksize);
+	return find_extent_buffer(fs_info, bytenr);
 }
 
 struct extent_buffer* btrfs_find_create_tree_block(
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 992b5f35..d6705e37 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -210,14 +210,15 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 }
 
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
-					 u64 bytenr, u32 blocksize)
+					 u64 bytenr)
 {
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
-	cache = lookup_cache_extent(&fs_info->extent_cache, bytenr, blocksize);
+	cache = lookup_cache_extent(&fs_info->extent_cache, bytenr,
+				    fs_info->nodesize);
 	if (cache && cache->start == bytenr &&
-	    cache->size == blocksize) {
+	    cache->size == fs_info->nodesize) {
 		eb = container_of(cache, struct extent_buffer, cache_node);
 		list_move_tail(&eb->lru, &fs_info->lru);
 		eb->refs++;
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index e4da3c57..b4c2ac97 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -94,7 +94,7 @@ static inline int extent_buffer_uptodate(struct extent_buffer *eb)
 }
 
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
-					 u64 bytenr, u32 blocksize);
+					 u64 bytenr);
 struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
-- 
2.40.0

