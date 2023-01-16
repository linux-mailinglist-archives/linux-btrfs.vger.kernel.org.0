Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D066BA92
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjAPJix (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAPJiv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 04:38:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019518B1A;
        Mon, 16 Jan 2023 01:38:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so26856084wrv.7;
        Mon, 16 Jan 2023 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWw0MNuvZ+RLzRl5Ziiy99iE7oykebQAiTZQIyD1oSA=;
        b=SKbUMrPj9TutpM5ihnWS3SGFTRwO3C6CP98KJUdKW2j8jAy32GHFG3YNeE8k/Zoc2B
         hwWCHQwloDbWuOboj9kvCgPiX5650JLr+ikdd/hmwv1DFcxiu4ARzOZxPExNwwELQOcQ
         W9S9kCMos7EDcyDe8qV6OSttQwyia2bjbqgRKEzBZy04wWHlxGV9obHUkY/ahmUGXDbk
         G12qzjEKkBV5XtEEA97SWjlR9q1qydpnRYu6b4BHyAbseO87DiSI0RgjEKfU7wJpl2Ls
         ++EW3G+ICr/pjgUGYXMPK20nFy5S1lRRL8eA9NW6K/liq8Ofce6V+0MhLALnHylJwgsq
         R3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWw0MNuvZ+RLzRl5Ziiy99iE7oykebQAiTZQIyD1oSA=;
        b=T76/s+BKn4okfgSNyKcLtKcAAmV3/y+tC8Ib3HnmAW6TK9j5ajZEF/JWMiVeeZCW2D
         WyH2lyJBEmIis14OpVx+NL/AMu5R0RiKArpxCd0QvtF97IJr+E2oBm2jUACO+/VwW2DL
         /DX96Url0GtM+zX85iYf82XOOCFhyWHfXhH8z21eKSk9avzPWGIa1HfTaPHb8nO3Bmsc
         h7EPBLF5goH0mm+dKd4ypOS5Kl8arHX9YJDwGSIiluFgqEbxLEuwoD2/Ez1iptQ4TIIv
         t4JFskk9cfM+2ebJtPhXenPoxlFMbZ9IWOs3QzHwv2zFDlBeGFYjrW2XVRVh1aHAZJL3
         rZ0Q==
X-Gm-Message-State: AFqh2krJIraTpg+xrFizOwsiyxARyU0pWWLvrWYRvWffPUEk2EKw/SjW
        dkCKaELY74azTUJZzkfklcY=
X-Google-Smtp-Source: AMrXdXtSVduXH27RxMaGcjotyxL/mHnEdbQfMrYxtHykP8whXboc6GFGpWiE8r0kYm2CltUUi3GY+A==
X-Received: by 2002:a5d:4d8d:0:b0:2bd:ca88:d07a with SMTP id b13-20020a5d4d8d000000b002bdca88d07amr11398187wru.33.1673861929599;
        Mon, 16 Jan 2023 01:38:49 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056000081300b002bdc3f5945dsm13551207wrb.89.2023.01.16.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:38:49 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix spelling mistake "geneartion" -> "generation"
Date:   Mon, 16 Jan 2023 09:38:47 +0000
Message-Id: <20230116093847.26275-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a spelling mistake in a btrfs warning message and in a comment.
Fix them both.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/scrub.c        | 2 +-
 fs/btrfs/tree-checker.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 10c26bc8e60e..a5d026041be4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2106,7 +2106,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		sblock->header_error = 1;
 		sblock->generation_error = 1;
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
+		"tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      sblock->logical, sblock->mirror_num,
 			      btrfs_stack_header_generation(h),
 			      sector->generation);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index baad1ed7e111..32cd06f7660e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1144,7 +1144,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	/*
 	 * For legacy root item, the members starting at generation_v2 will be
 	 * all filled with 0.
-	 * And since we allow geneartion_v2 as 0, it will still pass the check.
+	 * And since we allow generation_v2 as 0, it will still pass the check.
 	 */
 	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
 			   btrfs_item_size(leaf, slot));
-- 
2.30.2

