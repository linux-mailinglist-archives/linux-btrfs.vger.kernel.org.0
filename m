Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7207152C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 03:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjE3BCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 21:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3BCm (ORCPT
        <rfc822;Linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 21:02:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A529D
        for <Linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 18:02:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b01d912924so29997275ad.1
        for <Linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685408560; x=1688000560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ha9TC87QJe2YtLMi41G7ciPSeHB8zDGXZdFeNRNDHY=;
        b=d2fDdbjw5rKDjAIECyNPPLN4HHxSL5pvZ9XxmPBQLu8w4CzQy4QR7KqcyYBWbmTqce
         xG9DqYDzVg0+DIcHc7Is8Wo2FXfq9+ibVkCIwGfb3L5h3JfTJ81ixuxO5mC3r1o4YPy3
         m+Py9ja8Ha8O0rVri5vLse96vHUMNAnLYmgw+UosEOmizseymt4vWEj74K1Nwf6i9X/s
         sLWd/Djaqj/ziooFJtMnjukwz0R+YZ1Y5hLG5OFYjPUEqHrWAzlazzRpNiFVvsVGNby6
         8mNcmNEplq0FAubBo3gXfrRc9jl5ppIOG7MSgqssHm0iH/x2V+PnZzQlUYxqfjNrM9z0
         tpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685408560; x=1688000560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ha9TC87QJe2YtLMi41G7ciPSeHB8zDGXZdFeNRNDHY=;
        b=gkhgvCwS9uiToAYr/UjBTkyx2/yX5LsM0nmHgd2B6oQOb3CL16INYxFNn9IXn2uRDS
         V8CUZ2a1I62SQchMen52KYitvFEfoBBJhu+MFgJWtzVGnEWRJKsIk4Q49Snv0fRwo8Ka
         N0T5QlNgqWK2upI9Hl/M2KVP8fRpuQJRyuZztaGM9zX6HsVvoFTrcVElI4NU8DzlBm7g
         GiTLFc4ODuRF3AMosb9uShYWwxabf/fYgawaSUmoTyoTWetGvL41TNXwqcGHRiq5hsnF
         r5xlQw81O/Wqi3wyt5z1q8kg0ZFNSRlLphap3y19G9CD+CIjHlPO3P0sBT/6k6MhdC2L
         ERyA==
X-Gm-Message-State: AC+VfDxtUKOdk836uKlp7x6rLVYMAfRqxKYgNXeSmOx2ih8P2E1Ic9ip
        eT3aXfHxJtQ6uVa2U4UVtLgJPZSYtAI=
X-Google-Smtp-Source: ACHHUZ5WDYHuZnxW8P702rlbjfpSBjojJJMEbrzNzj0r0XKWg4kU09cppvvJ9lc2KRpUvfdvCDchww==
X-Received: by 2002:a17:902:8307:b0:1ae:5914:cbec with SMTP id bd7-20020a170902830700b001ae5914cbecmr710554plb.10.1685408560031;
        Mon, 29 May 2023 18:02:40 -0700 (PDT)
Received: from flip-desktop (97-113-131-190.tukw.qwest.net. [97.113.131.190])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001ab09f5ca61sm8879809plf.55.2023.05.29.18.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 18:02:39 -0700 (PDT)
Date:   Mon, 29 May 2023 18:02:38 -0700
From:   Phillip Duncan <turtlekernelsanders@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tests: fix formatting in btrfs-tests
Message-ID: <ZHVLLpTHRvifOIHP@flip-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

checkpatch.pl had a couple of formatting suggestions:
- #38: Don't use multiple blank lines
- #42: Missing a blank line after declarations
- #282: Alignment should match open parenthesis

Fixed these format suggestions, checkpatch.pl is a little cleaner now.

Signed-off-by: Phillip Duncan <turtlekernelsanders@gmail.com>
---
 fs/btrfs/tests/btrfs-tests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index ca09cf9afce8..1653456560c2 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -35,10 +35,10 @@ static const struct super_operations btrfs_test_super_ops = {
 	.destroy_inode	= btrfs_test_destroy_inode,
 };
 
-
 static int btrfs_test_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = init_pseudo(fc, BTRFS_TEST_MAGIC);
+
 	if (!ctx)
 		return -ENOMEM;
 	ctx->ops = &btrfs_test_super_ops;
@@ -278,8 +278,7 @@ int btrfs_run_sanity_tests(void)
 			ret = btrfs_test_free_space_cache(sectorsize, nodesize);
 			if (ret)
 				goto out;
-			ret = btrfs_test_extent_buffer_operations(sectorsize,
-				nodesize);
+			ret = btrfs_test_extent_buffer_operations(sectorsize, nodesize);
 			if (ret)
 				goto out;
 			ret = btrfs_test_extent_io(sectorsize, nodesize);
-- 
2.34.1

