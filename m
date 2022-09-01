Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34275A985B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiIANUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiIANTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED29DB1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DECFFB826A7
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D51C433C1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038316;
        bh=tAHlKR1FptGVO5XBzeUEtzRGHhRer/B7WPeaM1iY808=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BaTpZSkeGmO6MB9KV0iYXcrnv/aRG7HORLzpY87BgRse0wSw6/vzMYk1Wlkt+2bTE
         1L9p9V2pf0ZUM0/7fBp+nv8HQgCeQBjj385rsmgASJkr13rD6v5ZZwbswQAJD/RVQc
         xgurUmAm8pn0yY77heLrGHvAE3lLxyvupnMEZGtOWnCu5dFVVU/PgeerM5NKVhesTg
         sZzUxvopfNPMq/Q1gIYEGXB5MJfG8h2TYg6So2LVsadEJY3fPVCTThbgVqNVLAAuUC
         aCV7XhGQbvLz7HGydLvZYe9fauQHp2pPCWefToDJz8SNjjeMv+IttY+9Su+VfvhmHq
         W+kiH+xO4vfwg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: remove check for impossible block start for an extent map at fiemap
Date:   Thu,  1 Sep 2022 14:18:23 +0100
Message-Id: <a33ca7029931ae0a076cfe0a151881bd43016472.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
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

During fiemap we are testing if an extent map has a block start with a
value of EXTENT_MAP_LAST_BYTE, but that is never set on an extent map,
and never was according to git history. So remove that useless check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f57a3e91fc2c..ceb7dfe8d6dc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5642,10 +5642,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		if (off >= max)
 			end = 1;
 
-		if (em->block_start == EXTENT_MAP_LAST_BYTE) {
-			end = 1;
-			flags |= FIEMAP_EXTENT_LAST;
-		} else if (em->block_start == EXTENT_MAP_INLINE) {
+		if (em->block_start == EXTENT_MAP_INLINE) {
 			flags |= (FIEMAP_EXTENT_DATA_INLINE |
 				  FIEMAP_EXTENT_NOT_ALIGNED);
 		} else if (em->block_start == EXTENT_MAP_DELALLOC) {
-- 
2.35.1

