Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8145A985A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiIANUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiIANTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA0CD1
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1575E6190C
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0139CC433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038317;
        bh=c57M7vTwaiMkTTDy9VeuFU7sYHK5a6GFz3ODaUfQrA4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RyVDJ7ZwKr40KsWolauuWIQc4UsYlSpWGvrNrRs2iiZBk1j/IAxcGw4OCpW28PHRI
         QWoG7JaZYsE294h5YeR7gKKMAzv1pnomY0EzZZfYRwkn1dZQ4iJatwUQSXMwURUcHB
         j+FT8R53Hwx+MpBa0xO0NqGZo5EFgWCcPtxkTgXxzlwaoD9WO5+Eg/UituHtcMa4fU
         l3alC7YFwGboaXyHRkSCVwKjEH1g/mp/t3HXC/Cps58Nr2iglhQ78tKhOvDfS3w6xY
         GFrXAcGYF4Y97A+C5iYFuVQ3g6ptsNT2A8EBNoimUkYQy2cXW6Uweh/zX6k7PasA3x
         +tvGQLxOu3Q3A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: remove zero length check when entering fiemap
Date:   Thu,  1 Sep 2022 14:18:24 +0100
Message-Id: <4d19dc86c76af6e7ca8577e7d3fdf5a319a7357d.1662022922.git.fdmanana@suse.com>
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

There's no point to check for a 0 length at extent_fiemap(), as before
calling it, we called fiemap_prep() at btrfs_fiemap(), which already
checks for a zero length and returns the same -EINVAL error. So remove
the pointless check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ceb7dfe8d6dc..6e2143b6fba3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5526,9 +5526,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	u64 em_len = 0;
 	u64 em_end = 0;
 
-	if (len == 0)
-		return -EINVAL;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.35.1

