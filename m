Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F75F1404
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiI3UqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiI3Upq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:46 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C87A7AC24
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h28so3575019qka.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=oDIpCjg0R3IcaGHoYtYkNSX3XXpl4yZhWMuI1w/RpF8=;
        b=rmmOLUDbHKhZ+AN8MXHuuCQw5vJHtWcRjpHpUEyOvdA21HtG/ZyKO5Gjac97EiGm1D
         LGeR3M09KZ6ckZZxu6hLXlOIzkDcnk2FIBBXqxfe0KakGgf4SeN69qakhLDeEb9PDWmQ
         FQKk4SCpaDZ4IRa72G0akEASBxZteyKPz7u9qpsle5C6oDCJDGSePZlTpUmoldHEKARc
         /JGCT6AgSyQY4zest025IfH/r4sa7L1C8qbLW2WPs3vgsnluy3ylLziIx/zGlqiGxTQQ
         MXIL9otvwLte9uIWG4FjavftIRi8E10uPJOQIcgf2A5e2jnRWQsExelk79W83n2mbMys
         u8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oDIpCjg0R3IcaGHoYtYkNSX3XXpl4yZhWMuI1w/RpF8=;
        b=qOCvkhPC5oD7uF2OjlOctIGhfbziWkna7/R4pvoWTTB5OUmikFdKtrxySbPAKEZ5Uv
         /hmRum+uOVm/a8oNyyiN2pQUZwH2y7e1JzHHiApc/lRMTm2Bdpg5SQoVYqSQGVT9LJNP
         /i79eaDxPZWKyRlRFIzDbgoEHK54MLNNJ7QJ148gFtrctEwYWmjUbNkKVXDok8nQYYmG
         y3E3dmnjNZk8WzooCCFARoXklXlxWSP1pkpCKjzdiy/TLWaDctAyEyHQZfjHtgO2Dta7
         /gxtCF9c2607QMvJEN37m7PA8DbYV3sEalWsvrXAYWtwB8zGa4G5yPWJvpGBXrqbNuZq
         +KfA==
X-Gm-Message-State: ACrzQf2kA5cbqawooeQZ/RrueGbOiIUxjWFpqzK3CYeGGpISf9o3T/PL
        KhJ7zybrXwURHszMREkNIF9hA/xzVlKOEQ==
X-Google-Smtp-Source: AMsMyM7BboWa55QVFFlL6h6uUjCFjHz4Ob7AFS2DTX3i1X+gG/tpF+7owiGEX3Uk1XRN882L5Nagyg==
X-Received: by 2002:a05:620a:294a:b0:6ce:9944:f65a with SMTP id n10-20020a05620a294a00b006ce9944f65amr7543854qkp.434.1664570740787;
        Fri, 30 Sep 2022 13:45:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a404400b006cddf59a600sm3679001qko.34.2022.09.30.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: add cached_state to read_extent_buffer_subpage
Date:   Fri, 30 Sep 2022 16:45:13 -0400
Message-Id: <fd80c1000cdb518fd117becde7b0c6d0983c3fa8.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
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

We don't use a cached state here at all, which generally makes sense as
async reads are going to unlock at endio time.  However for blocking
reads we will call wait_extent_bit() for our range.  Since the
lock_extent() stuff will return the cached_state for the start of the
range this is a helpful optimization to have for this case, we'll have
the exact state we want to wait on.  Add a cached state here and simply
throw it away if we're a non-blocking read, otherwise we'll get a small
improvement by eliminating some tree searches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 21b437f4e36e..c1021e9ca079 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4952,6 +4952,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
+	struct extent_state *cached_state = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.mirror_num = mirror_num,
 	};
@@ -4963,10 +4964,11 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 
 	if (wait == WAIT_NONE) {
 		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-				     NULL))
+				     &cached_state))
 			return -EAGAIN;
 	} else {
-		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1, NULL);
+		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
+				  &cached_state);
 		if (ret < 0)
 			return ret;
 	}
@@ -4976,7 +4978,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	    PageUptodate(page) ||
 	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1, NULL);
+		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
+			      &cached_state);
 		return ret;
 	}
 
@@ -5001,11 +5004,13 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		atomic_dec(&eb->io_pages);
 	}
 	submit_one_bio(&bio_ctrl);
-	if (ret || wait != WAIT_COMPLETE)
+	if (ret || wait != WAIT_COMPLETE) {
+		free_extent_state(cached_state);
 		return ret;
+	}
 
 	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
-			EXTENT_LOCKED, NULL);
+			EXTENT_LOCKED, &cached_state);
 	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		ret = -EIO;
 	return ret;
-- 
2.26.3

