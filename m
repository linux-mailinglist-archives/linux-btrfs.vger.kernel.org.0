Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09754FF9EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiDMPXP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiDMPXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:23:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82D22524
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F034CB82367
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EADC385AE
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649863250;
        bh=Es8bgnNJXh7LKeV2srT1EjbM8Q/yPusLT5RpQWXBO9c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UAdiPf8hf5FTvBSjx9RG6pYTnU69MT3vwuj1G81+7Pw3Q1kUMBrYFAk/ccJbx+15e
         FOLMRmWMy0/SpMY6NIDI4v6zpXNguwTtXpzDJHm8UHuNqazdVEZySkzUVU0ufBlA3w
         CxxlQTxgFusBmBgMDB3eYQ7qsKi25N5viSzLXIz6dcD3oy6Zfyrv59i3GLCtyi0ish
         Zpl6XrVaiS1+Se0ipiTOusYubz90o0WfFQqHr0+bv2LtENEF/hq5UOTozWENPMs33D
         ZF/1Boiul4RCY3L6HkLRIAehW+QVMGy3tTp6RcMePBHkWYRzh1Mp0saNHy9TPLhU5P
         Wg4Law1WSR5yw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: return block group directly at btrfs_next_block_group()
Date:   Wed, 13 Apr 2022 16:20:42 +0100
Message-Id: <7e0cdb39d85edf363f2841ccc9e02860ca5ca6d0.1649862853.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649862853.git.fdmanana@suse.com>
References: <cover.1649862853.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_next_block_group(), we have this long line with two statements:

  cache = btrfs_lookup_first_block_group(...); return cache;

This makes it a bit harder to read due to two statements on the same
line, so change that to directly return the result of the call to
btrfs_lookup_first_block_group().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2c42ce00b84d..db112a01d711 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -271,7 +271,7 @@ struct btrfs_block_group *btrfs_next_block_group(
 
 		read_unlock(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
-		cache = btrfs_lookup_first_block_group(fs_info, next_bytenr); return cache;
+		return btrfs_lookup_first_block_group(fs_info, next_bytenr);
 	}
 	node = rb_next(&cache->cache_node);
 	btrfs_put_block_group(cache);
-- 
2.35.1

