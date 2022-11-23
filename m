Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC97636D4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKWWi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKWWiF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:05 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A03183BF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:03 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z6so136700qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubDtugAzgVt+qDmaQID8NTQFYmvWYfBQI4KbjPebtwY=;
        b=JW5Y8mbO3+lAAS1eghGv/nofv2wtGrWKTt0m1WZObXyZGTFk0mwF7kP0aRlKD37fVh
         P+WCEn0/JW4TbSkv0ByGMiJL9fYZbzfU8m/6sHTH5hdNrLqYkm68ev6Hqv+Qd/5hyQms
         edD1jX55xp9C4xgeaspCTQshyIVqVvCn2jSjwebZpA8+2YajzobmJNNbBmdzlbU21o4k
         v8vNzzienrt1xxLTA3gdxrVhbQg/v+1XclkkXJDavTB31Q7FVHKlWPayqzrqh2DgMF3c
         lC1fE5S46qJWPL3kYQTKwb8tG1rYDdbpqnOF7pEAORzIvi7+vMKhfF/GkiVAfNwuV8I2
         RlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubDtugAzgVt+qDmaQID8NTQFYmvWYfBQI4KbjPebtwY=;
        b=bqeReEuML7imVj2XaEBN/AKp2H378x5nJwcQvMyiTZhr3FNuQlVDOZZmZzdV/rZWXY
         nScS4OyMrcrQQK9BlDw04qUPRyKXDJoL7VkcZOPA0W4zSNSsurBr00wkd6hyvFivlfH5
         EVghC/J5gzEc+GnMNQ1RVE05iwTfoQPMhDjau+WRcskP+7JfswNxfbO2L7z1lDTYwhG4
         XJwjGR1KqeZrR/zvHSm8YtUnPK9PhL963ly/C8scBbbRxiISzp4E19v2uvxon4a9j81X
         gIfmdgxexx9yss5Axb+kuO2Hnr0E2a8nJ2McxshQj8GSDZixPJQOg3353vcB7oVGco/f
         qpUg==
X-Gm-Message-State: ANoB5pk+Vibza76wp4PffS1ZvyUI4PvyFNsjkQNyE9xXmlLUojMNY7pP
        HEflQ4WGXgD4j+EqbOZJ/nxJ5aTFPvhRKw==
X-Google-Smtp-Source: AA0mqf79XUAxNPEAq2X/Tix6cCAMfddzIoyWfMbk9CV4o6pkIcnezjEUeUTRnyM1zhahSo1DEqA0xg==
X-Received: by 2002:a05:622a:50a7:b0:39c:eb15:b6df with SMTP id fp39-20020a05622a50a700b0039ceb15b6dfmr28370150qtb.518.1669243082773;
        Wed, 23 Nov 2022 14:38:02 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y18-20020a05620a25d200b006e16dcf99c8sm12975119qko.71.2022.11.23.14.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 18/29] btrfs-progs: delete state_private code
Date:   Wed, 23 Nov 2022 17:37:26 -0500
Message-Id: <1a7227721b908e879cde8563edd4bbb0349ac4cf.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used to store random private things into extent_states, but we
haven't done this for a while and there are no users of this code,
simply delete it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 42 ---------------------------------------
 kernel-shared/extent_io.h |  2 --
 2 files changed, 44 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 492857b0..baaf7234 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -591,48 +591,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-int set_state_private(struct extent_io_tree *tree, u64 start, u64 private)
-{
-	struct cache_extent *node;
-	struct extent_state *state;
-	int ret = 0;
-
-	node = search_cache_extent(&tree->state, start);
-	if (!node) {
-		ret = -ENOENT;
-		goto out;
-	}
-	state = container_of(node, struct extent_state, cache_node);
-	if (state->start != start) {
-		ret = -ENOENT;
-		goto out;
-	}
-	state->xprivate = private;
-out:
-	return ret;
-}
-
-int get_state_private(struct extent_io_tree *tree, u64 start, u64 *private)
-{
-	struct cache_extent *node;
-	struct extent_state *state;
-	int ret = 0;
-
-	node = search_cache_extent(&tree->state, start);
-	if (!node) {
-		ret = -ENOENT;
-		goto out;
-	}
-	state = container_of(node, struct extent_state, cache_node);
-	if (state->start != start) {
-		ret = -ENOENT;
-		goto out;
-	}
-	*private = state->xprivate;
-out:
-	return ret;
-}
-
 static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
 						   u64 bytenr, u32 blocksize)
 {
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 1c7dbc51..4529919a 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -127,8 +127,6 @@ static inline int extent_buffer_uptodate(struct extent_buffer *eb)
 	return 0;
 }
 
-int set_state_private(struct extent_io_tree *tree, u64 start, u64 xprivate);
-int get_state_private(struct extent_io_tree *tree, u64 start, u64 *xprivate);
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize);
 struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
-- 
2.26.3

